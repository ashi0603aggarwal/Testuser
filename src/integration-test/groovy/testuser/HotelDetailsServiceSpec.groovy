package testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HotelDetailsServiceSpec extends Specification {

    HotelDetailsService hotelDetailsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HotelDetails(...).save(flush: true, failOnError: true)
        //new HotelDetails(...).save(flush: true, failOnError: true)
        //HotelDetails hotelDetails = new HotelDetails(...).save(flush: true, failOnError: true)
        //new HotelDetails(...).save(flush: true, failOnError: true)
        //new HotelDetails(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //hotelDetails.id
    }

    void "test get"() {
        setupData()

        expect:
        hotelDetailsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HotelDetails> hotelDetailsList = hotelDetailsService.list(max: 2, offset: 2)

        then:
        hotelDetailsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        hotelDetailsService.count() == 5
    }

    void "test delete"() {
        Long hotelDetailsId = setupData()

        expect:
        hotelDetailsService.count() == 5

        when:
        hotelDetailsService.delete(hotelDetailsId)
        sessionFactory.currentSession.flush()

        then:
        hotelDetailsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HotelDetails hotelDetails = new HotelDetails()
        hotelDetailsService.save(hotelDetails)

        then:
        hotelDetails.id != null
    }
}
