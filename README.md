# forecast

Erlang API for the [forecast.io](https://developer.forecast.io/) weather service.

## Using Within the Project

```
% KEY comes from upfront free registration at forecast.io
application:set_env(forecast, api_key, KEY).

% Optionally load record def
rr("include/forecast.hrl").

forecast:start().

forecast:get({{lat, 42}, {long, -11}}).                                   
```

## Using From Your Own Project
* Add `forecast` to `applications` in your `.app.src` file
* Add URL for the repo in the `deps` in your rebar.config. For example, `{forecast, ".*", {git, "https://github.com/derek121/forecast.git"}}`
* Add `forecast`/`api_key` to your config, analagous to the `application:set_env/3 call above
* Building with relx and then running will start `forecast`, after which calls may be made


