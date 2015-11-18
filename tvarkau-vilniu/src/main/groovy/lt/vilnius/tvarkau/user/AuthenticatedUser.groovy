package lt.vilnius.tvarkau.user

import org.springframework.security.core.GrantedAuthority

class AuthenticatedUser extends org.springframework.security.core.userdetails.User {

    User user

    AuthenticatedUser(User user, Collection<? extends GrantedAuthority> authorities) {
        super(user.token.toString(), '', authorities)
        this.user = user
    }

    UUID getToken() {
        user.token
    }

    @Override
    boolean isEnabled() {
        user.enabled
    }
}
