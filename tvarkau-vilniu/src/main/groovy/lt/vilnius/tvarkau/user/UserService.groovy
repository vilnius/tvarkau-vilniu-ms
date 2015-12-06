package lt.vilnius.tvarkau.user

import groovy.transform.PackageScope
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

interface UserService {

    @Transactional
    User create(UUID token)

    @Transactional(readOnly = true)
    Optional<User> findByToken(UUID token)

}

@Service
@PackageScope
class DefaultUserService implements UserService {

    private final UserRepository repository

    @Autowired
    DefaultUserService(UserRepository repository) {
        this.repository = repository
    }

    @Override
    User create(UUID token) {
        new User(token: token, enabled: true)
                .with(repository.&save)
    }

    @Override
    Optional<User> findByToken(UUID token) {
        repository.findByToken(token)
    }

}
