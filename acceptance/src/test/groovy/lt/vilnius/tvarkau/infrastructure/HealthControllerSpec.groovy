package lt.vilnius.tvarkau.infrastructure

import lt.vilnius.tvarkau.test.TestEnvironment
import spock.lang.Specification

class HealthControllerSpec extends Specification {

    def 'healthcheck returns OK'() {
        expect:
            new URL(TestEnvironment.BASE_URL + '/health').text.contains 'OK'
    }
}
