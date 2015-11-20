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

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity

class MockMvcSpecification extends Specification {

    @Autowired
    WebApplicationContext context

    protected MockMvc mockMvc

    def setup() {
        mockMvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build()
    }

    protected ResponseOps mvc(MockHttpServletRequestBuilder requestBuilder) {
        MockHttpServletResponse response = mockMvc.perform(requestBuilder).andReturn().response
        Map json = slurp response
        return [
                getStatus: { HttpStatus.valueOf(response.status) },
                json     : { json }
        ] as ResponseOps
    }

    private static Map slurp(MockHttpServletResponse response) {
        (response.contentAsString ?: '{}').with { new JsonSlurper().parseText(it) as Map }
    }

    interface ResponseOps {
        HttpStatus getStatus()

        Map json()
    }

}
