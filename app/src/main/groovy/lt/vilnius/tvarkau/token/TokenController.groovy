package lt.vilnius.tvarkau.token

import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import static spark.Spark.get

class TokenController {

    TokenController() {
        get('/token', this.&getToken, Config.JSON)
    }

    TokenResource getToken(Request req, Response res) {
        new TokenResource(token: UUID.randomUUID())
    }

}
