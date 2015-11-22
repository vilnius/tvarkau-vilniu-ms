package lt.vilnius.tvarkau.issue

import groovy.transform.PackageScope
import lt.vilnius.tvarkau.user.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

import static lt.vilnius.tvarkau.issue.IssueStatus.CREATED

interface IssueService {
    @Transactional
    Issue createNewIssue(User user, IssueType type, String description)

    @Transactional(readOnly = true)
    Collection<Issue> list()

    @Transactional(readOnly = true)
    Issue getById(Long id)
}

@Service
@PackageScope
class DefaultIssueService implements IssueService {

    @Autowired
    IssueRepository repository

    @Override
    Issue createNewIssue(User user, IssueType type, String description) {
        new Issue(
            reporter: user,
            type: type,
            status: CREATED,
            description: description
        ).with {
            repository.save(it)
        }
    }

    @Override
    Collection<Issue> list() {
        repository.findAll()
    }

    @Override
    Issue getById(Long id) {
        repository.getOne(id)
    }

}
