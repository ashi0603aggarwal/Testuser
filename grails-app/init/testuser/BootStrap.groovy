package testuser

import Testuser.Role
import Testuser.User
import Testuser.UserRole

class BootStrap {

    def init = { servletContext ->
        def adminRole = new Role(authority:'ROLE_ADMIN').save()
        def userRole = new Role(authority:'ROLE_USER').save()

        def me = new User(username:'thedesignwiz@gmail.com',password:'123456').save()

        UserRole.create me, adminRole

        UserRole.withSession {
            it.flush()
            it.clear()
        }
    }
    def destroy = {
    }
}
