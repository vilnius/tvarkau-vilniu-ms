package lt.vilnius.tvarkau.user

import org.springframework.hateoas.mvc.ResourceAssemblerSupport
import org.springframework.stereotype.Component

@Component
class UserResourceAssembler extends ResourceAssemblerSupport<User, UserResource> {

    UserResourceAssembler() {
        super(UserController, UserResource)
    }

    @Override
    UserResource toResource(User entity) {
        createResourceWithId(entity.id, entity).with {
            token = entity.token
            it
        }
    }
}
