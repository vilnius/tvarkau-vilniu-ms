package lt.vilnius.tvarkau.user

import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByToken(UUID token)
}
