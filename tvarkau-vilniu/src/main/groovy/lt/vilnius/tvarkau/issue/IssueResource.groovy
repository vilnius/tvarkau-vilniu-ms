package lt.vilnius.tvarkau.issue

import com.fasterxml.jackson.annotation.JsonRootName
import org.springframework.hateoas.ResourceSupport

@JsonRootName('issue')
class IssueResource extends ResourceSupport {

    String referenceNumber

    IssueType type
    String description
    IssueStatus status

}
