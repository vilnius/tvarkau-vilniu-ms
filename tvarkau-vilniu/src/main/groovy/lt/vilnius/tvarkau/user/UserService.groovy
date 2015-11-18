package lt.vilnius.tvarkau.user

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

interface UserService {

    @Transactional
    User create()

    @Transactional(readOnly = true)
    Optional<User> findByToken(UUID token)

}

@Service
class DefaultUserService implements UserService {

    @Autowired
    UserRepository repository

    @Override
    User create() {
        new User(token: UUID.randomUUID(), enabled: true)
                .with(repository.&save)
    }

    @Override
    Optional<User> findByToken(UUID token) {
        repository.findByToken(token)
    }

}
