package lt.vilnius.tvarkau.infra.security

import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.filter.GenericFilterBean

import javax.servlet.FilterChain
import javax.servlet.ServletException
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletRequest

import static lt.vilnius.tvarkau.common.UUIDUtils.maybeUUID

class TokenAuthFilter extends GenericFilterBean {

    @Override
    void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String tokenHeader = (request as HttpServletRequest).getHeader 'X-Auth-Token'
        Optional<UUID> token = maybeUUID(tokenHeader)

        token.ifPresent {
            SecurityContextHolder.context.authentication = SpringSecurityToken.preAuth(it)
        }

        chain.doFilter(request, response)
    }

}
