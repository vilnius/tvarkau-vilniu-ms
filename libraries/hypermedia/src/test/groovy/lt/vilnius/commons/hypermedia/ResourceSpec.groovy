package lt.vilnius.commons.hypermedia

import spock.lang.Specification

class ResourceSpec extends Specification {

    def 'supports links'() {
        given:
            def resource = new TestResource()
        when:
            resource.linkTo(new Link().rel('something').href('/something'))
        then:
            resource.links.something
            resource.links.something.href == '/something'
    }
}
