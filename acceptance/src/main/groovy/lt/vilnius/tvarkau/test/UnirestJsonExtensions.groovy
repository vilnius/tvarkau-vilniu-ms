package lt.vilnius.tvarkau.test

import com.mashape.unirest.request.HttpRequestWithBody
import groovy.json.JsonSlurper

class UnirestJsonExtensions {

    static FluentResponse response(HttpRequestWithBody self) {
        def response = self.asString()
        return new FluentResponse(
            status: response.status,
            json: new JsonSlurper().parseText(self.asString().body) as Map
        )
    }
}
