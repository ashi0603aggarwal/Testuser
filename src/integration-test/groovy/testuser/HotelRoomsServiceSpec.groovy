package Testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HotelRoomsServiceSpec extends Specification {

    HotelRoomsService hotelRoomsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HotelRooms(...).save(flush: true, failOnError: true)
        //new HotelRooms(...).save(flush: true, failOnError: true)
        //HotelRooms hotelRooms = new HotelRooms(...).save(flush: true, failOnError: true)
        //new HotelRooms(...).save(flush: true, failOnError: true)
        //new HotelRooms(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //hotelRooms.id
    }

    void "test get"() {
        setupData()

        expect:
        hotelRoomsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HotelRooms> hotelRoomsList = hotelRoomsService.list(max: 2, offset: 2)

        then:
        hotelRoomsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        hotelRoomsService.count() == 5
    }

    void "test delete"() {
        Long hotelRoomsId = setupData()

        expect:
        hotelRoomsService.count() == 5

        when:
        hotelRoomsService.delete(hotelRoomsId)
        sessionFactory.currentSession.flush()

        then:
        hotelRoomsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HotelRooms hotelRooms = new HotelRooms()
        hotelRoomsService.save(hotelRooms)

        then:
        hotelRooms.id != null
    }
}
