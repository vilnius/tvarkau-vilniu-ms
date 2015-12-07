package lt.vilnius.tvarkau.token

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping('/token')
class TokenController {

    @RequestMapping
    TokenResource acquireToken() {
        new TokenResource(token: UUID.randomUUID())
    }

}
