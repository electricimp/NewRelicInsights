#New Relic Insights
This library wraps the [New Relic Insights](http://newrelic.com/insights) API. New Relic Insights allow you to quickly and easily track, analyze, and create real time dashboards around event based data.

## constructor(accountNumber, apiKey, [platform])
To create a new Insights object, you will your Account # and your Insights API key. An optional third parameter can be supplied to indicate the platform ('electricimp' will be used if no platform is specified). 

```
insights <- NewRelicInsights(accountNumber, apiKey);
```

## insights.sendEvent(eventType, data, [callback])
The **sendEvent** sends a new event to the Insights engine. If a callback is supplied, the request will be made asyncronously, and the callback will be executed upon completion. If no callback is supplied, the request will be made syncronously, and the method will return an object with two fields: err, and data. Examples of both can be seen below:

```
// Asyncronous Request
device.on("temp", function(data) {
    local insightsData = {
        ts = data.timestamp,
        temp = data.temperature
    };

    // send asyncronously
    insights.sendEvent("temperature", tempData, function(err, result) {
        // if there was an issue:
        if (err != null) {
            server.error(err);
            return;
        }

        // otherwise, log success
        server.log("Success");
    });
});
```

```
// Syncronous Request:
device.on("temp", function(data) {
    local insightData = { 
        ts = data.timestamp,
        temp = data.temperature
    };

    // send syncronously
    local result = insights.sendEvent("temperature", insightsData);
    // if there was an issue
    if (result.err) {
        server.error(result.err);
        return;
    }

    // otherwise, log success
    server.log("Success");
});
```

#License
The New Relic Insights library is licensed under the [MIT License](./LICENSE).
