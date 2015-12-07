package lt.vilnius.tvarkau.infra.security

import groovy.transform.PackageScope
import lt.vilnius.tvarkau.user.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter

import static org.springframework.http.HttpMethod.GET
import static org.springframework.http.HttpMethod.POST
import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS

@Configuration
@PackageScope
class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    UserService userService

    @Autowired
    CustomUserDetailsService customUserDetailsService

    @Override
    protected void configure(AuthenticationManagerBuilder authBuilder) throws Exception {
        authBuilder
                .authenticationProvider(new TokenAuthProvider(userDetailsService: customUserDetailsService))
                .userDetailsService(customUserDetailsService)
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .sessionManagement().sessionCreationPolicy(STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(GET, '/token').anonymous()
                .antMatchers(POST, '/users').anonymous()
                .anyRequest().authenticated()
                .and()
                .addFilterBefore(new TokenAuthFilter(), BasicAuthenticationFilter)
    }
}
