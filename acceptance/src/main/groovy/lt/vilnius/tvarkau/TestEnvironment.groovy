package lt.vilnius.tvarkau;

import groovy.transform.CompileStatic

@CompileStatic
class TestEnvironment {

    static final String BASE_URL
    private static final Properties PROPERTIES

    static {
        PROPERTIES = new Properties()
        PROPERTIES.load(TestEnvironment.getResourceAsStream('/test.properties'))

        def appHost = System.getenv('APP_HOST') ?: PROPERTIES.getProperty('app.host')
        def appPort = System.getenv('APP_TCP_8080') ?: PROPERTIES.getProperty('app.port')

        BASE_URL = "${PROPERTIES.getProperty('app.protocol')}://${appHost}:${appPort}"
    }

    static String testProperty(String key) {
        return PROPERTIES.getProperty(key)
    }

}
