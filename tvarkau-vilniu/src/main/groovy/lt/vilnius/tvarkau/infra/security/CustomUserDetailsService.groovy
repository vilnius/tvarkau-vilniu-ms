package lt.vilnius.tvarkau.infra.security

import groovy.transform.PackageScope
import lt.vilnius.tvarkau.user.AuthenticatedUser
import lt.vilnius.tvarkau.user.User
import lt.vilnius.tvarkau.user.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.authority.AuthorityUtils
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Component

import static lt.vilnius.tvarkau.common.UUIDUtils.maybeUUID

@Component
@PackageScope
class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService

    @Autowired
    CustomUserDetailsService(UserService userService) {
        this.userService = userService
    }

    @Override
    UserDetails loadUserByUsername(String tokenString) throws UsernameNotFoundException {
        maybeUUID(tokenString)
                .flatMap(this.&findUser)
                .orElseThrow { new UsernameNotFoundException('User not found') }
    }

    Optional<AuthenticatedUser> findUser(UUID token) {
        userService.findByToken(token)
                .map(this.&toAuthenticatedUser)
    }

    private static AuthenticatedUser toAuthenticatedUser(User user) {
        new AuthenticatedUser(user, AuthorityUtils.createAuthorityList('USER'))
    }
}