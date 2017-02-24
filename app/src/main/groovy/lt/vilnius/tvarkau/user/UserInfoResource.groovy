package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.util.hypermedia.Resource

import java.time.LocalDate

class UserInfoResource implements Resource {
    String fullName
    String phoneNumber
    LocalDate dateOfBirth
}
