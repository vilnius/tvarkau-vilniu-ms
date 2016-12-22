package lt.vilnius.commons.hypermedia

import com.google.gson.Gson
import groovy.json.JsonSlurper
import spock.lang.Specification

class ResourceSpec extends Specification {

    def 'supports links'() {
        given:
            def resource = new TestResource()
        when:
            resource.linkTo(new Link().rel('something').href('/somewhere'))
        then:
            resource.links.something
            resource.links.something.href == '/somewhere'
    }

    def 'serializes per HAL spec'() {
        given:
            def resource = new TestResource()
        when:
            resource.linkTo(new Link().rel('something').href('/somewhere'))
            String resourceJson = new Gson().toJson(resource)
            Map parsedJson = new JsonSlurper().parseText(resourceJson) as Map
        then:
            parsedJson._links
            parsedJson._links.something.rel == 'something'
            parsedJson._links.something.href == '/somewhere'
    }
}
