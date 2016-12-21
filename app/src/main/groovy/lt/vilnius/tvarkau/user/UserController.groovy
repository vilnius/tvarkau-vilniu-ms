package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import static spark.Spark.get
import static spark.Spark.post

class UserController {

    UserController() {
        post('/users', this.&createUser)
        get('/users/:userId', this.&userProfile, Config.JSON)
    }

    void createUser(Request req, Response res) {
        res.body('')
        res.status(201)
    }

    GetUserProfileResponse userProfile(Request req, Response res) {
        new GetUserProfileResponse(token: UUID.randomUUID())
    }

}
