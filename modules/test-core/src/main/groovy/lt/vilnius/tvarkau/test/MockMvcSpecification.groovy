package lt.vilnius.tvarkau.test

import groovy.json.JsonSlurper
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.mock.web.MockHttpServletResponse
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder
import org.springframework.test.web.servlet.setup.MockMvcBuilders
import org.springframework.web.context.WebApplicationContext
import spock.lang.Specification

import static org.springframework.http.MediaType.APPLICATION_JSON
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post

class MockMvcSpecification extends Specification {

    @Autowired
    WebApplicationContext context

    protected MockMvc mockMvc
    protected String currentToken
    protected String currentUserId

    def setup() {
        mockMvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build()

        currentToken = mockMvc.perform(get('/token').contentType(APPLICATION_JSON))
                .andReturn().response
                .with(MockMvcSpecification.&slurp)
                .token
        assert currentToken

        currentUserId = mockMvc.perform(post('/users').contentType(APPLICATION_JSON).content("""{ "token": "$currentToken" }"""))
                .andReturn().response
                .getHeader('Location')
                .split('/users/')
                .last()
        assert currentUserId
    }


    protected ResponseOps mvc(MockHttpServletRequestBuilder requestBuilder, boolean authenticated = true) {
        if (authenticated) {
            requestBuilder.header('X-Auth', currentToken)
        }

        requestBuilder.contentType(APPLICATION_JSON)

        MockHttpServletResponse response = mockMvc.perform(requestBuilder).andReturn().response
        Map json = slurp response

        return [
                getStatus : { HttpStatus.valueOf(response.status) },
                getDetails: { response },
                json      : { json }
        ] as ResponseOps
    }

    protected Closure<ResponseOps> mvcWithoutAuth = this.&mvc.rcurry(false)

    private static Map slurp(MockHttpServletResponse response) {
        (response.contentAsString ?: '{}').with { new JsonSlurper().parseText(it) as Map }
    }

    interface ResponseOps {
        HttpStatus getStatus()
        MockHttpServletResponse getDetails()
        Map json()
    }

}
