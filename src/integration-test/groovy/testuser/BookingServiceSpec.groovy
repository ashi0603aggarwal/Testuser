package Testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class BookingServiceSpec extends Specification {

    BookingService bookingService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Booking(...).save(flush: true, failOnError: true)
        //new Booking(...).save(flush: true, failOnError: true)
        //Booking booking = new Booking(...).save(flush: true, failOnError: true)
        //new Booking(...).save(flush: true, failOnError: true)
        //new Booking(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //booking.id
    }

    void "test get"() {
        setupData()

        expect:
        bookingService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Booking> bookingList = bookingService.list(max: 2, offset: 2)

        then:
        bookingList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        bookingService.count() == 5
    }

    void "test delete"() {
        Long bookingId = setupData()

        expect:
        bookingService.count() == 5

        when:
        bookingService.delete(bookingId)
        sessionFactory.currentSession.flush()

        then:
        bookingService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Booking booking = new Booking()
        bookingService.save(booking)

        then:
        booking.id != null
    }
}
