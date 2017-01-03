package lt.vilnius.tvarkau.user

import lt.vilnius.tvarkau.util.hypermedia.Resource

import java.time.LocalDate

class UserInfoResource extends Resource {
    String fullName
    String phoneNumber
    LocalDate dateOfBirth
}
