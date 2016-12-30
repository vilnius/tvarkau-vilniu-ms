package lt.vilnius.tvarkau

import groovy.util.logging.Slf4j
import lt.vilnius.tvarkau.device.DeviceController
import lt.vilnius.tvarkau.infra.RootExceptionHandler
import lt.vilnius.tvarkau.issue.IssueController
import lt.vilnius.tvarkau.support.db.DatabaseSupport
import lt.vilnius.tvarkau.support.db.LiquibaseSupport
import lt.vilnius.tvarkau.user.UserController
import spark.Spark

@Slf4j
class App {

    static void main(String[] args) {
        printBanner()
        configure()
        startWebServer()
    }

    private static void printBanner() {
        App.getResourceAsStream('/banner.txt').eachLine { println it }
    }

    private static void configure() {
        new DatabaseSupport()
        LiquibaseSupport.run()
    }

    private static void startWebServer() {
        Spark.port(8080)
        Spark.after(Config.defaultContentTypeFilter())
        new DeviceController()
        new UserController()
        new IssueController()

        Spark.exception(Exception, new RootExceptionHandler())
        Spark.get('/*', Config.route404())
    }
}
