package lt.vilnius.tvarkau.issue

import lt.vilnius.commons.hypermedia.Resource

class IssueResource extends Resource {
    String referenceNumber
    IssueType type
    String description
    IssueStatus status
}
