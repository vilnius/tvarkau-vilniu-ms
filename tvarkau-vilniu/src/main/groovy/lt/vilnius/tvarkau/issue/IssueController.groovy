package lt.vilnius.tvarkau.issue

import lt.vilnius.tvarkau.user.AuthenticatedUser
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.hateoas.ExposesResourceFor
import org.springframework.hateoas.Resources
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

import static org.springframework.http.ResponseEntity.created
import static org.springframework.web.bind.annotation.RequestMethod.GET
import static org.springframework.web.bind.annotation.RequestMethod.POST

@RestController
@ExposesResourceFor(Issue)
@RequestMapping(value = '/issues')
class IssueController {

    @Autowired
    IssueService issueService

    @Autowired
    IssueResourceAssembler resourceAssembler

    @RequestMapping(method = POST)
    ResponseEntity reportIssue(@AuthenticationPrincipal AuthenticatedUser authenticatedUser,
                               @RequestBody ReportIssueRequest request) {
        issueService.createNewIssue(authenticatedUser.user, request.type as IssueType, request.description)
            .with(resourceAssembler.&toResource)
            .with { created(it.getLink('self').href.toURI()).build() }
    }

    @RequestMapping(method = GET)
    Resources<IssueResource> list() {
        new Resources<IssueResource>(issueService.list().with(resourceAssembler.&toResources))
    }

    @RequestMapping(method = GET, value = '/{id}')
    IssueResource showIssue(@PathVariable('id') Long id) {
        issueService.getById(id).with(resourceAssembler.&toResource)
    }
}
