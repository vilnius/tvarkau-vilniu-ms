package lt.vilnius.tvarkau.device

import com.mashape.unirest.http.Unirest
import spock.lang.Specification

import static lt.vilnius.tvarkau.test.TestEnvironment.apiUrl

class DeviceControllerSpec extends Specification {

    def 'register device'() {
        when:
            def response = Unirest.put(apiUrl('/device'))
                .response().json
            String registeredUuid = response.uuid
        then:
            registeredUuid

        when:
            response = Unirest.put(apiUrl('/device'))
                .header('x-device-uuid', registeredUuid)
                .response().json
        then:
            response.uuid == registeredUuid
    }

    def 'invalid uuid'() {
        given:
            def response = Unirest.put(apiUrl('/device'))
                .header('x-device-uuid', '122')
                .response()
        expect:
            response.status != 200
    }
}
