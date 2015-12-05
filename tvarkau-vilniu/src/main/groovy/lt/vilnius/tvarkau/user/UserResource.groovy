package lt.vilnius.tvarkau.user

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

import static org.springframework.web.bind.annotation.RequestMethod.GET

@RestController
@RequestMapping(path = '/user')
class UserResource {

    private final UserService userService

    @Autowired
    UserResource(UserService userService) {
        this.userService = userService
    }

    @RequestMapping(method = GET, path = '/token')
    AcquireTokenResponse acquireToken() {
        def token = userService.create().token
        new AcquireTokenResponse(token: token)
    }

    @RequestMapping(method = GET)
    GetUserProfileResponse getUserProfile(@AuthenticationPrincipal AuthenticatedUser user) {
        new GetUserProfileResponse(token: user.token)
    }

}
