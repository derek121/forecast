-record(forecast, {
  latitude,
  longitude,
  timezone,
  offset,
  currently, % data_point
  minutely,  % data_block
  hourly,    % data_block
  daily,     % data_block
  alerts,
  flags
}).

-record(data_point, {
  time,
  summary,
  icon,
  sunrise_time,
  sunset_time,
  moon_phase,
  nearest_storm_distance,
  nearest_storm_bearing,
  precip_intensity,
  precip_intensity_max,
  precip_intensity_max_time,
  precip_probability,
  precip_type,
  precip_accumulation,
  temperature,
  temperature_min,
  temperature_min_time,
  temperature_max,
  temperature_max_time,
  apparent_temperature,
  apparent_temperature_min,
  apparent_temperature_min_time,
  apparent_temperature_max,
  apparent_temperature_max_time,
  dew_point,
  wind_speed,
  wind_bearing,
  cloud_cover,
  humidity,
  pressure,
  visibility,
  ozone
}).

-record(data_block, {
  summary,
  icon,
  data % List of data_point
}).

-record(alert, {
  title,
  expires,
  description,
  uri
}).

-record(flags, {
  darksky_unavailable,
  darksky_stations,
  datapoint_stations,
  isd_stations,
  lamp_stations,
  metar_stations,
  metno_license,
  sources,
  units
}).


