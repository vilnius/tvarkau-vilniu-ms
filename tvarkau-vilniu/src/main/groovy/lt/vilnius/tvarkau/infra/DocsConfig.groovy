package lt.vilnius.tvarkau.infra

import com.google.common.base.Predicate
import lt.vilnius.tvarkau.user.AuthenticatedUser
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter
import springfox.documentation.service.ApiInfo
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.swagger2.annotations.EnableSwagger2

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE

@EnableSwagger2
@Configuration
class DocsConfig {

    @Bean
    public Docket swaggerSpringMvcPlugin() {
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .paths({ String s -> !s.contains('/error') } as Predicate)
                .build()
                .apiInfo(apiInfo())
                .consumes([APPLICATION_JSON_VALUE].toSet())
                .produces([APPLICATION_JSON_VALUE].toSet())
                .ignoredParameterTypes(AuthenticatedUser, MetaClass)
    }

    @Bean
    public WebMvcConfigurerAdapter forwardToIndex() {
        return new WebMvcConfigurerAdapter() {
            @Override
            public void addViewControllers(ViewControllerRegistry registry) {
                registry.addViewController('/api-docs').viewName = 'forward:/swagger-ui.html'
            }

            @Override
            void addResourceHandlers(ResourceHandlerRegistry registry) {
                registry.addResourceHandler("/api-docs/**").addResourceLocations("classpath:/META-INF/resources/webjars/swagger-ui/2.1.3/");
            }
        }
    }

    private static ApiInfo apiInfo() {
        new ApiInfo(
                /* title             */ 'Tvarkau Vilnių API documentation (beta)',
                /* description       */ 'Warning! Beta - subject to changes/improvements',
                /* version           */ '0.0.1',
                /* termsOfServiceUrl */ null,
                /* contact           */ 'tadas.krivickas@gmail.com',
                /* license           */ 'MIT',
                /* licenseUrl        */ 'https://raw.githubusercontent.com/vilnius/tvarkau-vilniu-ms/master/LICENSE'
        )
    }

}