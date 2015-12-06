package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.token.TokenResource
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.hateoas.ExposesResourceFor
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

import static org.springframework.http.ResponseEntity.created
import static org.springframework.web.bind.annotation.RequestMethod.GET
import static org.springframework.web.bind.annotation.RequestMethod.POST

@RestController
@ExposesResourceFor(User)
@RequestMapping(path = '/users')
class UserController {

    private final UserService userService
    private final UserResourceAssembler resourceAssembler

    @Autowired
    UserController(UserService userService, UserResourceAssembler resourceAssembler) {
        this.userService = userService
        this.resourceAssembler = resourceAssembler
    }

    @RequestMapping(method = POST)
    ResponseEntity createUser(@RequestBody TokenResource tokenResource) {
        URI uri = userService.create(tokenResource.token)
                .with(resourceAssembler.&toResource)
                .getLink('self').href.toURI()

        return created(uri).build()
    }

    @RequestMapping(method = GET, path = '/{id}')
    GetUserProfileResponse getUserProfile(@AuthenticationPrincipal AuthenticatedUser user) {
        new GetUserProfileResponse(token: user.token)
    }

}
