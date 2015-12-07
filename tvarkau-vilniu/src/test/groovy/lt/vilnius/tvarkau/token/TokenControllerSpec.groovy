package lt.vilnius.tvarkau.token

import lt.vilnius.tvarkau.Application
import lt.vilnius.tvarkau.test.MockMvcSpecification
import org.springframework.boot.test.SpringApplicationContextLoader
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.context.web.WebAppConfiguration

import static org.springframework.http.HttpStatus.OK
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get

@ContextConfiguration(loader = SpringApplicationContextLoader, classes = [Application])
@WebAppConfiguration
class TokenControllerSpec extends MockMvcSpecification {

    def 'anonymous user should be able to acquire a token'() {
        when:
            def response = mvcWithoutAuth get('/token')
        then:
            response.status == OK
            response.json().token
    }

    def 'tokens should be unique'() {
        when:
            def token1 = mvcWithoutAuth(get('/token')).json().token
            def token2 = mvcWithoutAuth(get('/token')).json().token
        then:
            token1 && token2
            token1 != token2
    }
}
