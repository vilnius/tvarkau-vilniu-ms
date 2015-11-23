package lt.vilnius.tvarkau.infra

import com.fasterxml.jackson.annotation.JsonRootName
import org.atteo.evo.inflector.English
import org.springframework.hateoas.RelProvider
import org.springframework.hateoas.core.DefaultRelProvider
import org.springframework.stereotype.Component

@Component
class JsonRootRelProvider implements RelProvider {

    DefaultRelProvider defaultRelProvider = new DefaultRelProvider()

    @Override
    String getItemResourceRelFor(Class<?> type) {
        JsonRootName rootName = type.getAnnotationsByType(JsonRootName)?.find()
        return rootName ? rootName.value() : defaultRelProvider.getItemResourceRelFor(type)
    }

    @Override
    String getCollectionResourceRelFor(Class<?> type) {
        JsonRootName rootName = type.getAnnotationsByType(JsonRootName)?.find()
        return rootName ? English.plural(rootName.value())
            : English.plural(defaultRelProvider.getCollectionResourceRelFor(type))
    }

    @Override
    boolean supports(Class<?> delimiter) {
        defaultRelProvider.supports(delimiter)
    }
}