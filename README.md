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

3> forecast:get({{lat, 42}, {long, -11}}).                                   
```

### Using From Your Own Project
* Add `forecast` to `applications` in your `.app.src` file
* Add URL for the repo in the `deps` in your rebar.config. For example, `{forecast, ".*", {git, "https://github.com/derek121/forecast.git"}}`
* Ensure `FORECAST_API_KEY` is set in your environment
* Build with relx and then running will start `forecast`, after which calls may be made
* Optionally load record def. Example:
  * `rr("lib/forecast-0.0.1/include/forecast.hrl").`

