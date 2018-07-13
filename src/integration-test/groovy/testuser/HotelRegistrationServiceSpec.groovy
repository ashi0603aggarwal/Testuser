package testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HotelRegistrationServiceSpec extends Specification {

    HotelRegistrationService hotelRegistrationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HotelRegistration(...).save(flush: true, failOnError: true)
        //new HotelRegistration(...).save(flush: true, failOnError: true)
        //HotelRegistration hotelRegistration = new HotelRegistration(...).save(flush: true, failOnError: true)
        //new HotelRegistration(...).save(flush: true, failOnError: true)
        //new HotelRegistration(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //hotelRegistration.id
    }

    void "test get"() {
        setupData()

        expect:
        hotelRegistrationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HotelRegistration> hotelRegistrationList = hotelRegistrationService.list(max: 2, offset: 2)

        then:
        hotelRegistrationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        hotelRegistrationService.count() == 5
    }

    void "test delete"() {
        Long hotelRegistrationId = setupData()

        expect:
        hotelRegistrationService.count() == 5

        when:
        hotelRegistrationService.delete(hotelRegistrationId)
        sessionFactory.currentSession.flush()

        then:
        hotelRegistrationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HotelRegistration hotelRegistration = new HotelRegistration()
        hotelRegistrationService.save(hotelRegistration)

        then:
        hotelRegistration.id != null
    }
}
