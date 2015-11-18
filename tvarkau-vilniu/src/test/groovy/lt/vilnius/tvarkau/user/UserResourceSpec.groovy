package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.Application
import lt.vilnius.tvarkau.test.MockMvcSpecification
import org.springframework.boot.test.SpringApplicationContextLoader
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.context.web.WebAppConfiguration

import static org.springframework.http.HttpStatus.FORBIDDEN
import static org.springframework.http.HttpStatus.OK
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get

@ContextConfiguration(loader = SpringApplicationContextLoader, classes = [Application])
@WebAppConfiguration
class UserResourceSpec extends MockMvcSpecification {

    def 'anonymous user should be able to acquire a token'() {
        when:
            def response = mvc get('/user/token')
        then:
            response.status() == OK
            response.json().token
    }

    def 'authenticated user should not be able to acquire a token'() {
        when:
            String token = mvc(get('/user/token')).json().token
        and:
            def response = mvc get('/user/token').header('X-Auth-Token', token)
        then:
            response.status() == FORBIDDEN
    }

    def 'tokens should be unique'() {
        when:
            def token1 = mvc(get('/user/token')).json().token
            def token2 = mvc(get('/user/token')).json().token
        then:
            token1 && token2
            token1 != token2
    }

    def 'user profile should be secured'() {
        when:
            def response = mvc(get('/user'))
        then:
            response.status() == FORBIDDEN
    }

    def 'user should be able to access his profile'() {
        given:
            String token = mvc(get('/user/token')).json().token
        when:
            def response = mvc get('/user').header('X-Auth-Token', token)
        then:
            response.status() == OK
            response.json().token == token
    }

}
