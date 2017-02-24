package lt.vilnius.tvarkau.util.hypermedia

import com.google.gson.annotations.SerializedName

trait Resource {
    @SerializedName('_links')
    private Map<String, Link> links = [:]

    // Keeping links private with an explicit getter, due to public trait
    // field names being remapped (to avoid the diamond issue)
    Map<String, Link> getLinks() {
        return links
    }

    Resource linkTo(Link link) {
        links << [(link.rel): link]
        return this
    }
}
