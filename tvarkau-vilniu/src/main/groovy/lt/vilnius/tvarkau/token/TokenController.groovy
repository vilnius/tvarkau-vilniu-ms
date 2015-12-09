package lt.vilnius.tvarkau.token

import io.swagger.annotations.Api
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

import static org.springframework.web.bind.annotation.RequestMethod.GET

@Api(description = "Token resources")
@RestController
@RequestMapping('/token')
class TokenController {

    @RequestMapping(method = GET)
    TokenResource acquireToken() {
        new TokenResource(token: UUID.randomUUID())
    }

}
