package lt.vilnius.tvarkau.issue

import lt.vilnius.commons.hypermedia.Resource

class IssueResource extends Resource {
    String referenceNumber
    long categoryId
    String categoryName
    String description
    IssueStatus status
    String address
    float lat, lon
}
