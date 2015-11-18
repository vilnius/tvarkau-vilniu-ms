package lt.vilnius.tvarkau.infra.security

import lt.vilnius.tvarkau.user.AuthenticatedUser
import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.AuthorityUtils

import static org.springframework.security.core.authority.AuthorityUtils.NO_AUTHORITIES

class SpringSecurityToken extends AbstractAuthenticationToken {

    UUID token
    AuthenticatedUser user

    static SpringSecurityToken preAuth(UUID token) {
        new SpringSecurityToken(token, null, NO_AUTHORITIES)
    }

    static SpringSecurityToken authenticated(AuthenticatedUser user) {
        new SpringSecurityToken(user.token, user, AuthorityUtils.createAuthorityList('USER'))
    }

    private SpringSecurityToken(UUID token = null, AuthenticatedUser user = null, Collection<? extends GrantedAuthority> authorities) {
        super(authorities)
        this.token = token
        this.user = user
        this.authenticated = user != null
    }

    @Override
    Object getCredentials() {
        return null
    }

    @Override
    Object getPrincipal() {
        return user
    }

}
