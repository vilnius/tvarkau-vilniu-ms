package lt.vilnius.tvarkau.issue

import lt.vilnius.tvarkau.util.hypermedia.Resource

class IssueResource implements Resource {
    String referenceNumber
    long categoryId
    String categoryName
    String description
    IssueStatus status
    String address
    float lat, lon
}
