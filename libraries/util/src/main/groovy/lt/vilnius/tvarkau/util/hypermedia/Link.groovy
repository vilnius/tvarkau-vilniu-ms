package lt.vilnius.tvarkau.util.hypermedia

import groovy.transform.builder.Builder
import groovy.transform.builder.SimpleStrategy

@Builder(builderStrategy = SimpleStrategy, prefix = '')
class Link {
    static final String REL_SELF = 'self'

    String rel, href

    static Link selfLink(String href) {
        return new Link(rel: REL_SELF, href: href)
    }
}
