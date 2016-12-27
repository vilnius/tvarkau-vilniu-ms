package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import java.time.LocalDate

import static spark.Spark.get
import static spark.Spark.put

class UserController {

    UserController() {
        put('/user', this.&updateUserProfile, Config.JSON)
        get('/user', this.&showUserProfile, Config.JSON)
    }

    UserInfoResource updateUserProfile(Request req, Response res) {
        def userInfo = Config.GSON.fromJson(req.body(), UserInfoResource)
        return userInfo
    }

    UserInfoResource showUserProfile(Request req, Response res) {
        new UserInfoResource(
            fullName: 'foo',
            phoneNumber: '860000000',
            dateOfBirth: LocalDate.of(1977, 01, 01)
        )
    }

}
