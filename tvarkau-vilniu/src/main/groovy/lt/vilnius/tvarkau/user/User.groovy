package lt.vilnius.tvarkau.user

import groovy.transform.ToString

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
@ToString(includes = ['id'])
class User {

    @Id
    @GeneratedValue
    Long id

    @Column(unique = true)
    UUID token

    boolean enabled

}
