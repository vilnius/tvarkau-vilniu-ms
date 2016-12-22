package lt.vilnius.tvarkau.issue

import lt.vilnius.commons.hypermedia.CollectionResource
import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import static spark.Spark.get
import static spark.Spark.post

class IssueController {

    IssueController() {
        post('/issues', this.&reportIssue)
        get('/issues', this.&listIssues, Config.JSON)
        get('/issues/:issueId', this.&showIssue, Config.JSON)
    }

    void reportIssue(Request req, Response res) {
        res.body('')
        res.status(201)
    }

    CollectionResource<IssueResource> listIssues(Request req, Response res) {
        new CollectionResource<IssueResource>([
            new IssueResource(
                referenceNumber: 'FOO#1',
                status: IssueStatus.REGISTERED,
                type: IssueType.ANIMAL_RULES_VIOLATION,
                description: 'We have an issue')
        ])
    }

    IssueResource showIssue(Request req, Response res) {
        new IssueResource(
            referenceNumber: 'FOO#1',
            status: IssueStatus.REGISTERED,
            type: IssueType.ANIMAL_RULES_VIOLATION,
            description: 'We have an issue'
        )
    }

}
