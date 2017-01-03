package lt.vilnius.tvarkau.util.hypermedia

import com.google.gson.annotations.SerializedName

class Resource {
    @SerializedName('_links')
    final Map<String, Link> links = [:]

    Resource linkTo(Link link) {
        links << [(link.rel): link]
        return this
    }
}
