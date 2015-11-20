package lt.vilnius.tvarkau.infra.security

import groovy.transform.PackageScope
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.core.Authentication
import org.springframework.security.core.AuthenticationException

@PackageScope
class TokenAuthProvider implements AuthenticationProvider {

    CustomUserDetailsService userDetailsService

    @Override
    Authentication authenticate(Authentication authentication) throws AuthenticationException {
        (authentication as SpringSecurityToken).token
                .with(userDetailsService.&findUser)
                .map(SpringSecurityToken.&authenticated)
                .orElseThrow { new BadCredentialsException('Bad credentials') }
    }

    @Override
    boolean supports(Class<?> authentication) {
        authentication in SpringSecurityToken
    }

}
