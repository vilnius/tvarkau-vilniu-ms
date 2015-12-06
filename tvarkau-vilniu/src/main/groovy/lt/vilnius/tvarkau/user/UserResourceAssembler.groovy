package lt.vilnius.tvarkau.user

import org.springframework.hateoas.mvc.ResourceAssemblerSupport
import org.springframework.stereotype.Component

@Component
class UserResourceAssembler extends ResourceAssemblerSupport<User, UserProfileResource> {

    UserResourceAssembler() {
        super(UserController, UserProfileResource)
    }

    @Override
    UserProfileResource toResource(User entity) {
        createResourceWithId(entity.id, entity).with {
            token = entity.token
            it
        }
    }
}
