package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.Application
import lt.vilnius.tvarkau.test.MockMvcSpecification
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ContextConfiguration

import static org.springframework.http.HttpStatus.*
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post

@ContextConfiguration
@SpringBootTest(classes = Application)
class UserResourceSpec extends MockMvcSpecification {

    def 'should allow to create one user with a token'() {
        given:
            String token = acquireToken()
        expect:
            createUser(token).status == CREATED
            createUser(token).status == CONFLICT
    }

    def 'should validate token for user creation'() {
        expect:
            createUser('batman-token').status == BAD_REQUEST
    }

    def 'user profile should be secured'() {
        when:
            def response = mvcWithoutAuth get("/users/$currentUserId")
        then:
            response.status == FORBIDDEN
    }

    def 'user should be able to access his profile'() {
        when:
            def response = mvc get("/users/$currentUserId")
        then:
            response.status == OK
            response.json().token == currentToken
    }

    private String acquireToken() {
        mvcWithoutAuth(get('/token')).json().token
    }

    @SuppressWarnings("UnnecessaryQualifiedReference")
    private MockMvcSpecification.ResponseOps createUser(String token) {
        mvcWithoutAuth post('/users').content(""" { "token": "$token" } """)
    }

}
