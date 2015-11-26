package lt.vilnius.tvarkau.issue

import lt.vilnius.tvarkau.user.User

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne

@Entity
class Issue {

    @Id
    @GeneratedValue
    Long id
    String referenceNumber

    IssueType type
    String description
    IssueStatus status

    @OneToOne
    User reporter

}