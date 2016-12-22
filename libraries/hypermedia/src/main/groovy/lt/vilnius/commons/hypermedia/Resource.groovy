package lt.vilnius.commons.hypermedia

import com.google.gson.annotations.SerializedName

class Resource {
    @SerializedName('_links')
    final Map<String, Link> links = [:]

    Resource linkTo(Link link) {
        links << [(link.rel): link]
        return this
    }
}
