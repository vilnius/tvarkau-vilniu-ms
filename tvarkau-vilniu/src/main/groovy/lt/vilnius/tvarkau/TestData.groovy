package lt.vilnius.tvarkau

import groovy.util.logging.Slf4j
import lt.vilnius.tvarkau.user.User
import lt.vilnius.tvarkau.user.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Profile

import javax.annotation.PostConstruct

import static lt.vilnius.tvarkau.common.Profiles.dev

@Slf4j
@Profile(dev)
@Configuration
class TestData {

    private final UserRepository userRepository

    @Autowired
    TestData(UserRepository userRepository) {
        this.userRepository = userRepository
    }

    @PostConstruct
    void seed() {
        log.info 'dev profile detected, populating test data'
        testUser().with(userRepository.&save)
    }

    private User testUser() {
        new User(
                token: UUID.fromString('00000000-0000-0000-0000-000000000000'),
                enabled: true
        )
    }

}
