package lt.vilnius.tvarkau

import lt.vilnius.tvarkau.issue.IssueController
import lt.vilnius.tvarkau.device.DeviceController
import lt.vilnius.tvarkau.user.UserController
import spark.Spark

class App {
    static void main(String[] args) {
        Spark.port(8080)
        Spark.after(Config.defaultContentTypeFilter())
        new DeviceController()
        new UserController()
        new IssueController()

        Spark.exception(Exception, Config.rootExceptionHandler())
        Spark.get('/*', Config.route404())
    }
}
