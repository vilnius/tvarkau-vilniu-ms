package lt.vilnius.commons.hypermedia

class Resource {
    final Map<String, Link> links = [:]

    Resource linkTo(Link link) {
        links << [(link.rel): link]
        return this
    }
}
