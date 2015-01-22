-module(forecast).

-export([start/0]).
-export([get/1]).

%%% Obtain weather data from https://developer.forecast.io/docs/v2

%%% To avoid the following error from get/0 call in get_sample/1:
%%% "ambiguous call of overridden pre R14 auto-imported BIF get/1"
-compile({no_auto_import,[get/1]}).

-include("forecast.hrl").

-define(APP, ?MODULE).

-define(API_KEY, "FORECAST_API_KEY").

%%% Response
-define(LATITUDE,                      <<"latitude">>).
-define(LONGITUDE,                     <<"longitude">>).
-define(TIMEZONE,                      <<"timezone">>).
-define(OFFSET,                        <<"offset">>).
-define(CURRENTLY,                     <<"currently">>).
-define(MINUTELY,                      <<"minutely">>).
-define(HOURLY,                        <<"hourly">>).
-define(DAILY,                         <<"daily">>).
-define(ALERTS,                        <<"alerts">>).
-define(FLAGS,                         <<"flags">>).

%%% Data Point
-define(TIME,                          <<"time">>).
-define(SUMMARY,                       <<"summary">>).
-define(ICON,                          <<"icon">>).
-define(SUNRISE_TIME,                  <<"sunriseTime">>).
-define(SUNSET_TIME,                   <<"sunsetTime">>).
-define(MOON_PHASE,                    <<"moonPhase">>).
-define(NEAREST_STORM_DISTANCE,        <<"nearestStormDistance">>).
-define(NEAREST_STORM_BEARING,         <<"nearestStormBearing">>).
-define(PRECIP_INTENSITY,              <<"precipIntensity">>).
-define(PRECIP_INTENSITY_MAX,          <<"precipIntensityMax">>).
-define(PRECIP_INTENSITY_MAX_TIME,     <<"precipIntensityMaxTime">>).
-define(PRECIP_PROBABILITY,            <<"precipProbability">>).
-define(PRECIP_TYPE,                   <<"precipType">>).
-define(PRECIP_ACCUMULATION,           <<"precipAccumulation">>).
-define(TEMPERATURE,                   <<"temperature">>).
-define(TEMPERATURE_MIN,               <<"temperatureMin">>).
-define(TEMPERATURE_MIN_TIME,          <<"temperatureMinTime">>).
-define(TEMPERATURE_MAX,               <<"temperatureMax">>).
-define(TEMPERATURE_MAX_TIME,          <<"temperatureMaxTime">>).
-define(APPARENT_TEMPERATURE,          <<"apparentTemperature">>).
-define(APPARENT_TEMPERATURE_MIN,      <<"apparentTemperatureMin">>).
-define(APPARENT_TEMPERATURE_MIN_TIME, <<"apparentTemperatureMinTime">>).
-define(APPARENT_TEMPERATURE_MAX,      <<"apparentTemperatureMax">>).
-define(APPARENT_TEMPERATURE_MAX_TIME, <<"apparentTemperatureMaxTime">>).
-define(DEW_POINT,                     <<"dewPoint">>).
-define(WIND_SPEED,                    <<"windSpeed">>).
-define(WIND_BEARING,                  <<"windBearing">>).
-define(CLOUD_COVER,                   <<"cloudCover">>).
-define(HUMIDITY,                      <<"humidity">>).
-define(PRESSURE,                      <<"pressure">>).
-define(VISIBILITY,                    <<"visibility">>).
-define(OZONE,                         <<"ozone">>).

%%% Data Block
-define(DATA,                          <<"data">>).

%%% Alerts
-define(TITLE,                         <<"title">>).
-define(EXPIRES,                       <<"expires">>).
-define(DESCRIPTION,                   <<"description">>).
-define(URI,                           <<"uri">>).

%%% Flags
-define(DARKSKY_UNAVAILABLE,           <<"darksky-unavailable">>).
-define(DARKSKY_STATIONS,              <<"darksky-stations">>).
-define(DATAPOINT_STATIONS,            <<"datapoint-stations">>).
-define(ISD_STATIONS,                  <<"isd-stations">>).
-define(LAMP_STATIONS,                 <<"lamp-stations">>).
-define(METAR_STATIONS,                <<"metar-stations">>).
-define(METNO_LICENSE,                 <<"metno-license">>).
-define(SOURCES,                       <<"sources">>).
-define(UNITS,                         <<"units">>).


%%% Must call start/0 if using via repl (vs. programmatically in an app
%%% with real start scripts, such as from relx)
start() ->
  application:ensure_all_started(?APP).

get(Coords={{lat, _Lat}, {long, _Long}}) ->
  Body = fetch_data(Coords),
  M = jiffy:decode(Body, [return_maps]),

  Currently = maps:get(?CURRENTLY, M, empty),
  Minutely  = maps:get(?MINUTELY,  M, empty),
  Hourly    = maps:get(?HOURLY,    M, empty),
  Daily     = maps:get(?DAILY,     M, empty),
  Alerts    = maps:get(?ALERTS,    M, []),
  Flags     = maps:get(?FLAGS,     M, empty),

  #forecast{
    latitude  = get_value(?LATITUDE,  M),
    longitude = get_value(?LONGITUDE, M),
    timezone  = get_value(?TIMEZONE,  M),
    offset    = get_value(?OFFSET,    M),

    currently = create_data_point(Currently),
    minutely  = create_data_block(Minutely),
    hourly    = create_data_block(Hourly),
    daily     = create_data_block(Daily),
    alerts    = [create_alert(A) || A <- Alerts],
    flags     = create_flags(Flags)
  }.

fetch_data(Coords) ->
  Response = httpc:request(create_req_url(Coords)),
  {ok, {{_HttpVersion, 200, _Phrase}, _Headers, Body}} = Response,
  Body.

create_req_url({{lat, Lat}, {long, Long}}) ->
  ApiKey = os:getenv(?API_KEY),

  "https://api.forecast.io/forecast/" ++ 
  ApiKey ++ "/" ++
  number_to_list(Lat) ++ "," ++
  number_to_list(Long).

number_to_list(Val) when erlang:is_integer(Val) ->
  erlang:integer_to_list(Val);
number_to_list(Val) when erlang:is_float(Val) ->
  erlang:float_to_list(Val, [{decimals, 6}, compact]);
number_to_list(Val) when erlang:is_list(Val) ->
  Val.

get_value(Key, M) ->
  maps:get(Key, M, undefined).

create_data_point(empty) ->
  #data_point{};
create_data_point(M) ->
  #data_point{
    time                          = get_value(?TIME, M),
    summary                       = get_value(?SUMMARY, M),
    icon                          = get_value(?ICON, M),
    sunrise_time                  = get_value(?SUNRISE_TIME, M),
    sunset_time                   = get_value(?SUNSET_TIME, M),
    moon_phase                    = get_value(?MOON_PHASE, M),
    nearest_storm_distance        = get_value(?NEAREST_STORM_DISTANCE, M),
    nearest_storm_bearing         = get_value(?NEAREST_STORM_BEARING, M),
    precip_intensity              = get_value(?PRECIP_INTENSITY, M),
    precip_intensity_max          = get_value(?PRECIP_INTENSITY_MAX, M),
    precip_intensity_max_time     = get_value(?PRECIP_INTENSITY_MAX_TIME, M),
    precip_probability            = get_value(?PRECIP_PROBABILITY, M),
    precip_type                   = get_value(?PRECIP_TYPE, M),
    precip_accumulation           = get_value(?PRECIP_ACCUMULATION, M),
    temperature                   = get_value(?TEMPERATURE, M),
    temperature_min               = get_value(?TEMPERATURE_MIN, M),
    temperature_min_time          = get_value(?TEMPERATURE_MIN_TIME, M),
    temperature_max               = get_value(?TEMPERATURE_MAX, M),
    temperature_max_time          = get_value(?TEMPERATURE_MAX_TIME, M),
    apparent_temperature          = get_value(?APPARENT_TEMPERATURE, M),
    apparent_temperature_min      = get_value(?APPARENT_TEMPERATURE_MIN, M),
    apparent_temperature_min_time = get_value(?APPARENT_TEMPERATURE_MIN_TIME, M),
    apparent_temperature_max      = get_value(?APPARENT_TEMPERATURE_MAX, M),
    apparent_temperature_max_time = get_value(?APPARENT_TEMPERATURE_MAX_TIME, M),
    dew_point                     = get_value(?DEW_POINT, M),
    wind_speed                    = get_value(?WIND_SPEED, M),
    wind_bearing                  = get_value(?WIND_BEARING, M),
    cloud_cover                   = get_value(?CLOUD_COVER, M),
    humidity                      = get_value(?HUMIDITY, M),
    pressure                      = get_value(?PRESSURE, M),
    visibility                    = get_value(?VISIBILITY, M),
    ozone                         = get_value(?OZONE, M)
  }.

create_data_block(empty) ->
  #data_block{};
create_data_block(Block) ->
  %% List of data point maps
  L = get_value(?DATA, Block),
  Data = [create_data_point(M) || M <- L],

  #data_block{
    summary = get_value(?SUMMARY, Block),
    icon    = get_value(?ICON,    Block),
    data    = Data
  }.

create_alert(Alert) ->
  #alert{
    title       = get_value(?TITLE,       Alert),
    expires     = get_value(?EXPIRES,     Alert),
    description = get_value(?DESCRIPTION, Alert),
    uri         = get_value(?URI,         Alert)
  }.

create_flags(empty) ->
  #flags{};
create_flags(Flags) ->
  #flags{
    darksky_unavailable = get_value(?DARKSKY_UNAVAILABLE, Flags),
    darksky_stations    = get_value(?DARKSKY_STATIONS,    Flags),
    datapoint_stations  = get_value(?DATAPOINT_STATIONS,  Flags),
    isd_stations        = get_value(?ISD_STATIONS,        Flags),
    lamp_stations       = get_value(?LAMP_STATIONS,       Flags),
    metar_stations      = get_value(?METAR_STATIONS,      Flags),
    metno_license       = get_value(?METNO_LICENSE,       Flags),
    sources             = get_value(?SOURCES,             Flags),
    units               = get_value(?UNITS,               Flags)
  }.

