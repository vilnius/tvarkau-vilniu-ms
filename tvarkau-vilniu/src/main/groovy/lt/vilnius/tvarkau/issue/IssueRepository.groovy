package lt.vilnius.tvarkau.issue

import org.springframework.data.jpa.repository.JpaRepository

interface IssueRepository extends JpaRepository<Issue, Long> {
}
