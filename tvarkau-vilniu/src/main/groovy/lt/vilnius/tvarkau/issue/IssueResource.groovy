package lt.vilnius.tvarkau.issue

import org.springframework.hateoas.ResourceSupport

class IssueResource extends ResourceSupport {

    String referenceNumber

    IssueType type
    String description
    IssueStatus status

}
