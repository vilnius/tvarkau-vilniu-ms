package lt.vilnius.tvarkau.user

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

import static org.springframework.web.bind.annotation.RequestMethod.GET

@RestController(value = '/user')
class UserResource {

    @RequestMapping(method = GET, path = '/user/token')
    AcquireTokenResponse acquireToken() {
        new AcquireTokenResponse(token: UUID.randomUUID())
    }

}
