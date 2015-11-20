package lt.vilnius.tvarkau.user

import groovy.transform.ToString

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
@ToString(includes = ['id'])
class User {

    @Id
    @GeneratedValue
    Long id
    UUID token
    boolean enabled

}
