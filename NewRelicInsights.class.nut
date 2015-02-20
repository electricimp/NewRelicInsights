// Copyright (c) 2015 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

class NewRelicInsights {
    static _baseUrl = "https://insights-collector.newrelic.com/v1/accounts/";
    _account = null;
    _apiKey = null;
    _platform = null;
    
    _sendHeaders = null;
    
    constructor(account, apiKey, platform = "electricimp") {
        this._account = account;
        this._apiKey = apiKey;
        this._platform = platform;
        
        this._sendHeaders = {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-Insert-Key": _apiKey
        };
    }
    
    function sendEvent(eventType, eventData, cb = null) {
        // add metadata fields
        if (!("eventType" in eventData)) eventData["eventType"] <- eventType;
        if (!("platform" in eventData)) eventData["platform"] <- _platform;
        
        local url = _baseUrl + _account + "/events";
        local data = http.jsonencode(eventData);
        local req = http.post(url, _sendHeaders, data);
        
        if(cb != null) {
            req.sendasync(function(resp) {
                local err = null;
                local data = null;
                if(resp.statuscode != 200) err = http.jsondecode(resp.body);
                else data = http.jsondecode(resp.body);
                cb(err, data);
            });
        } else {
            local returnData = { err = null, data = null };
            local resp = req.sendsync();
            if (resp.statuscode != 200) returnData.err = http.jsondecode(resp.body);
            else returnData.data = http.jsondecode(resp.body);
            
            return returnData;
        }
    }
}
    
