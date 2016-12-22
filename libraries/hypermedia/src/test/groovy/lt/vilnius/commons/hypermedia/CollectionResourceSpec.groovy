package lt.vilnius.commons.hypermedia

import spock.lang.Specification

class CollectionResourceSpec extends Specification {

    def 'collection representation'() {
        given:
            def resource = new TestResource(prop1: 'foo')
        when:
            def collectionResource = new CollectionResource<TestResource>([
                resource, resource
            ])
        then:
            with(collectionResource.entries) {
                size() == 2
                get(0).prop1 == 'foo'
                get(1).prop1 == 'foo'
            }
    }
}
