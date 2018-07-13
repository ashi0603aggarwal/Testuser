package testuser

import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class DummyController {

    def index() { }
}
