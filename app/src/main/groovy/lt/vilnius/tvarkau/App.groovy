package lt.vilnius.tvarkau

import groovy.util.logging.Slf4j
import lt.vilnius.tvarkau.device.DeviceController
import lt.vilnius.tvarkau.issue.IssueController
import lt.vilnius.tvarkau.support.DataSourceSupport
import lt.vilnius.tvarkau.user.UserController
import spark.Spark

@Slf4j
class App {

    static void main(String[] args) {
        configure()
        startWebServer()
    }

    private static DataSourceSupport configure() {
        new DataSourceSupport()
    }

    private static void startWebServer() {
        Spark.port(8080)
        Spark.after(Config.defaultContentTypeFilter())
        new DeviceController()
        new UserController()
        new IssueController()

        Spark.exception(Exception, Config.rootExceptionHandler())
        Spark.get('/*', Config.route404())
    }
}
