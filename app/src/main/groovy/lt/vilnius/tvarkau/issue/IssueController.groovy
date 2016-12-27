package lt.vilnius.tvarkau.issue

import lt.vilnius.commons.hypermedia.CollectionResource
import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import static spark.Spark.get
import static spark.Spark.post

class IssueController {

    private static final List<CategoryResource> MOCK_CATEGORIES = [
        new CategoryResource(id: 1, name: 'Animal safety'),
        new CategoryResource(id: 3, name: 'Noise prevention')
    ]

    IssueController() {
        get('/categories', this.&listCategories, Config.JSON)
        post('/issues', this.&reportIssue)
        get('/issues', this.&listIssues, Config.JSON)
        get('/issues/:issueId', this.&showIssue, Config.JSON)
    }

    CollectionResource<CategoryResource> listCategories(Request req, Response res) {
        new CollectionResource<CategoryResource>(MOCK_CATEGORIES)
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
                categoryId: 1,
                categoryName: MOCK_CATEGORIES.find { it.id == 1 }.name,
                description: 'I am scared of the big dogs in the neighbourhood',
                address: 'Ozo parkas',
                lat: 54.718662,
                lon: 25.280228)
        ])
    }

    IssueResource showIssue(Request req, Response res) {
        new IssueResource(
            referenceNumber: 'FOO#1',
            status: IssueStatus.REGISTERED,
            categoryId: 3,
            categoryName: MOCK_CATEGORIES.find { it.id == 3 }.name,
            description: 'Somebody is screaming all night long',
            address: 'Ozo parkas',
            lat: 54.718662,
            lon: 25.280228
        )
    }

}
