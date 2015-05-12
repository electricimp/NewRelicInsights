# New Relic Insights

This library wraps the [New Relic Insights](http://newrelic.com/insights) API. New Relic Insights allow you to quickly and easily track, analyze and create real time dashboards around event-based data.

**To add this library to your project, add** `#require "NewRelicInsights.class.nut:1.0.0"` **to the top of your agent code**

## Usage

### Constructor

To instantiate a new Insights object, you will your account number and your Insights API key. An optional third parameter can be supplied to indicate the platform (`electricimp` will be used if no platform is specified). 

```squirrel
insights <- NewRelicInsights(accountNumber, apiKey)
```

### Class Methods

### sendEvent(*eventType*, *data*, [*callback*])

The **sendEvent** sends a new event to the Insights engine. If a callback is supplied (this is optional) the request will be made asyncronously, and the callback will be executed upon completion. If no callback is supplied, the request will be made syncronously, and the method will return a table with two keys: *err* and *data*. Examples of both can be seen below:

```squirrel
// Asyncronous request

device.on("temp", function(data) {
    local insightsData = {
        ts = data.timestamp,
        temp = data.temperature
    }

    // Send asyncronously
    
    insights.sendEvent("temperature", tempData, function(err, result) {
        // if there was an issue
        
        if (err != null) 
        {
            server.error(err)
            return
        }

        // Otherwise, log success
        
        server.log("Success")
    })
})
```

```squirrel
// Syncronous request

device.on("temp", function(data) {
    local insightData = { 
        ts = data.timestamp,
        temp = data.temperature
    }

    // Send syncronously
    
    local result = insights.sendEvent("temperature", insightsData)
    
    // if there was an issue
    
    if (result.err) 
    {
        server.error(result.err)
        return
    }

    // Otherwise, log success
    
    server.log("Success")
})
```

## License

The New Relic Insights library is licensed under the [MIT License](./LICENSE).
