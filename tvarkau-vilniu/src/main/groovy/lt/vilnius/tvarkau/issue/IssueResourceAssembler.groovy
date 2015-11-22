package lt.vilnius.tvarkau.issue

import org.springframework.hateoas.mvc.ResourceAssemblerSupport
import org.springframework.stereotype.Component

@Component
class IssueResourceAssembler extends ResourceAssemblerSupport<Issue, IssueResource> {

    IssueResourceAssembler() {
        super(IssueController, IssueResource)
    }

    @Override
    IssueResource toResource(Issue entity) {
        IssueResource resource = createResourceWithId(entity.id, entity)

        resource.with {
            referenceNumber = entity.referenceNumber
            type = entity.type
            description = entity.description
            status = entity.status
        }

        return resource
    }
}
