package lt.vilnius.tvarkau

import lt.vilnius.tvarkau.issue.IssueController
import lt.vilnius.tvarkau.token.TokenController
import lt.vilnius.tvarkau.user.UserController
import spark.Spark

class App {
    static void main(String[] args) {
        Spark.port(8080)
        Spark.after(Config.defaultContentTypeFilter())
        new TokenController()
        new UserController()
        new IssueController()
        Spark.get('/*', Config.route404())
    }
}
