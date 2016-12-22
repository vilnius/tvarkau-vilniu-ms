package lt.vilnius.commons.hypermedia

import groovy.transform.builder.Builder
import groovy.transform.builder.SimpleStrategy

@Builder(builderStrategy = SimpleStrategy, prefix = '')
class Link {
    String rel, href
}
