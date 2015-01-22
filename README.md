# forecast

Erlang API for the [forecast.io](https://developer.forecast.io/) weather service.

## Use
`FORECAST_API_KEY` comes from upfront free registration at forecast.io and must be set in the environment

```
$ export FORECAST_API_KEY=...
```

### Using From the Shell
```
$ make
$ make run
...
 
% Optionally load record def
1> rr("include/forecast.hrl").

2> forecast:start().

3> forecast:get({{lat, 60.173324}, {long, 24.941025}}).                                   
```

### Using From Your Own Project
* Add `forecast` to `applications` in your `.app.src` file
* Add URL for the repo in the `deps` in your rebar.config. For example, `{forecast, ".*", {git, "https://github.com/derek121/forecast.git"}}`
* Ensure `FORECAST_API_KEY` is set in your environment
* Run:
  * Building with relx and then running will start `forecast`, after which calls may be made
  * Otherwise, calling `forecast:start/0` will start `forecast`, after which calls may be made
* Optionally load record def. Example:
  * `rr("lib/forecast-0.0.1/include/forecast.hrl").`

## Example
```
forecast $ make run
...
1> forecast:start().
{ok,[inets,asn1,public_key,ssl,jiffy,forecast]}
2> rr("include/forecast.hrl").
[alert,data_block,data_point,flags,forecast]
3> forecast:get({{lat, 60.173324}, {long, 24.941025}}).
#forecast{latitude = 60.173324,longitude = 24.941025,
          timezone = <<"Europe/Helsinki">>,offset = 2,
          currently = #data_point{time = 1421939091,
                                  summary = <<"Overcast">>,icon = <<"cloudy">>,
                                  sunrise_time = undefined,sunset_time = undefined,
                                  moon_phase = undefined,nearest_storm_distance = undefined,
                                  nearest_storm_bearing = undefined,precip_intensity = 0,
                                  precip_intensity_max = undefined,
                                  precip_intensity_max_time = undefined,
                                  precip_probability = 0,precip_type = undefined,
                                  precip_accumulation = undefined,temperature = 20.62,
                                  temperature_min = undefined,
                                  temperature_min_time = undefined,
                                  temperature_max = undefined,
                                  temperature_max_time = undefined,
                                  apparent_temperature = 8.41,
                                  apparent_temperature_min = undefined,
                                  apparent_temperature_min_time = undefined,...},
          minutely = #data_block{summary = undefined,icon = undefined,
                                 data = undefined},
          hourly = #data_block{summary = <<"Light snow (under 1 in.) starting later this evening.">>,
                               icon = <<"snow">>,
                               data = [#data_point{time = 1421938800,
                                                   summary = <<"Overcast">>,icon = <<"cloudy">>,
                                                   sunrise_time = undefined,sunset_time = undefined,
                                                   moon_phase = undefined,nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0,
                                                   precip_intensity_max = undefined,
                                                   precip_intensity_max_time = undefined,
                                                   precip_probability = 0,precip_type = undefined,
                                                   precip_accumulation = undefined,temperature = 20.29,...},
                                       #data_point{time = 1421942400,summary = <<"Overcast">>,
                                                   icon = <<"cloudy">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0,
                                                   precip_intensity_max = undefined,
                                                   precip_intensity_max_time = undefined,
                                                   precip_probability = 0,precip_type = undefined,
                                                   precip_accumulation = undefined,...},
                                       #data_point{time = 1421946000,summary = <<"Overcast">>,
                                                   icon = <<"cloudy">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0,
                                                   precip_intensity_max = undefined,
                                                   precip_intensity_max_time = undefined,
                                                   precip_probability = 0,precip_type = undefined,...},
                                       #data_point{time = 1421949600,summary = <<"Overcast">>,
                                                   icon = <<"cloudy">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0,
                                                   precip_intensity_max = undefined,
                                                   precip_intensity_max_time = undefined,
                                                   precip_probability = 0,...},
                                       #data_point{time = 1421953200,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0.0037,
                                                   precip_intensity_max = undefined,
                                                   precip_intensity_max_time = undefined,...},
                                       #data_point{time = 1421956800,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0.0042,
                                                   precip_intensity_max = undefined,...},
                                       #data_point{time = 1421960400,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,precip_intensity = 0.0046,...},
                                       #data_point{time = 1421964000,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,
                                                   nearest_storm_bearing = undefined,...},
                                       #data_point{time = 1421967600,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,
                                                   nearest_storm_distance = undefined,...},
                                       #data_point{time = 1421971200,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,moon_phase = undefined,...},
                                       #data_point{time = 1421974800,summary = <<"Light Snow">>,
                                                   icon = <<"snow">>,sunrise_time = undefined,
                                                   sunset_time = undefined,...},
                                       #data_point{time = 1421978400,summary = <<"Light Sn"...>>,
                                                   icon = <<"snow">>,sunrise_time = undefined,...},
                                       #data_point{time = 1421982000,summary = <<"Ligh"...>>,
                                                   icon = <<...>>,...},
                                       #data_point{time = 1421985600,summary = <<...>>,...},
                                       #data_point{time = 1421989200,...},
                                       #data_point{...},
                                       {...}|...]},
          daily = #data_block{summary = <<76,105,103,104,116,32,115,
                                          110,111,119,32,40,50,226,
                                          128,147,53,32,...>>,
                              icon = <<"snow">>,
                              data = [#data_point{time = 1421877600,
                                                  summary = <<"Light snow (under 1 in.) until afternoon, starti"...>>,
                                                  icon = <<"snow">>,sunrise_time = 1421909941,
                                                  sunset_time = 1421935597,moon_phase = 0.07,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0.0028,
                                                  precip_intensity_max = 0.0051,
                                                  precip_intensity_max_time = 1421920800,
                                                  precip_probability = 0.53,precip_type = <<"snow">>,
                                                  precip_accumulation = 0.971,...},
                                      #data_point{time = 1421964000,
                                                  summary = <<"Light snow (under 1 in.) in the morning and "...>>,
                                                  icon = <<"snow">>,sunrise_time = 1421996224,
                                                  sunset_time = 1422022147,moon_phase = 0.11,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0.0041,
                                                  precip_intensity_max = 0.008,
                                                  precip_intensity_max_time = 1422032400,
                                                  precip_probability = 0.5,precip_type = <<...>>,...},
                                      #data_point{time = 1422050400,
                                                  summary = <<"Mostly cloudy throughout the day.">>,
                                                  icon = <<"partly-cloudy-day">>,sunrise_time = 1422082504,
                                                  sunset_time = 1422108699,moon_phase = 0.14,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0.0008,
                                                  precip_intensity_max = 0.0039,
                                                  precip_intensity_max_time = 1422050400,
                                                  precip_probability = 0.07,...},
                                      #data_point{time = 1422136800,
                                                  summary = <<"Mostly cloudy until evening.">>,
                                                  icon = <<"partly-cloudy-day">>,sunrise_time = 1422168781,
                                                  sunset_time = 1422195252,moon_phase = 0.18,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0,
                                                  precip_intensity_max = 0,
                                                  precip_intensity_max_time = undefined,...},
                                      #data_point{time = 1422223200,
                                                  summary = <<"Breezy throughout the day and fl"...>>,
                                                  icon = <<"snow">>,sunrise_time = 1422255055,
                                                  sunset_time = 1422281806,moon_phase = 0.22,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0.0008,
                                                  precip_intensity_max = 0.0019,...},
                                      #data_point{time = 1422309600,
                                                  summary = <<"Light snow (under 1 in.) and"...>>,
                                                  icon = <<"snow">>,sunrise_time = 1422341327,
                                                  sunset_time = 1422368361,moon_phase = 0.25,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,precip_intensity = 0.0031,...},
                                      #data_point{time = 1422396000,
                                                  summary = <<"Light snow (under 1 in.)"...>>,
                                                  icon = <<"snow">>,sunrise_time = 1422427597,
                                                  sunset_time = 1422454917,moon_phase = 0.29,
                                                  nearest_storm_distance = undefined,
                                                  nearest_storm_bearing = undefined,...},
                                      #data_point{time = 1422482400,
                                                  summary = <<"Light snow (under 1 "...>>,icon = <<"snow">>,
                                                  sunrise_time = 1422513864,sunset_time = 1422541474,
                                                  moon_phase = 0.33,nearest_storm_distance = undefined,...}]},
          alerts = [],
          flags = #flags{darksky_unavailable = undefined,
                         darksky_stations = undefined,datapoint_stations = undefined,
                         isd_stations = [<<"027950-99999">>,<<"029750-99999">>,
                                         <<"029780-99999">>,<<"029860-99999">>,<<"029880-99999">>],
                         lamp_stations = undefined,metar_stations = undefined,
                         metno_license = <<"Based on data from the Norwegian Meteoro"...>>,
                         sources = [<<"isd">>,<<"madis">>,<<"metno_ce">>,
                                    <<"metno_ne">>,<<"fnmoc">>,<<"cmc">>,<<"gfs">>],
                         units = <<"us">>}}

```