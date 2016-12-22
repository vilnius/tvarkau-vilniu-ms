package lt.vilnius.tvarkau.token

import lt.vilnius.tvarkau.Application
import lt.vilnius.tvarkau.test.MockMvcSpecification
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ContextConfiguration

import static org.springframework.http.HttpStatus.OK
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get

@ContextConfiguration
@SpringBootTest(classes = Application)
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
