package testuser

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class DummyControllerSpec extends Specification implements ControllerUnitTest<DummyController> {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
