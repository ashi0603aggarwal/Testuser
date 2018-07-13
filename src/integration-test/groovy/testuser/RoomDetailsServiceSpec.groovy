package Testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class RoomDetailsServiceSpec extends Specification {

    RoomDetailsService roomDetailsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new RoomDetails(...).save(flush: true, failOnError: true)
        //new RoomDetails(...).save(flush: true, failOnError: true)
        //RoomDetails roomDetails = new RoomDetails(...).save(flush: true, failOnError: true)
        //new RoomDetails(...).save(flush: true, failOnError: true)
        //new RoomDetails(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //roomDetails.id
    }

    void "test get"() {
        setupData()

        expect:
        roomDetailsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<RoomDetails> roomDetailsList = roomDetailsService.list(max: 2, offset: 2)

        then:
        roomDetailsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        roomDetailsService.count() == 5
    }

    void "test delete"() {
        Long roomDetailsId = setupData()

        expect:
        roomDetailsService.count() == 5

        when:
        roomDetailsService.delete(roomDetailsId)
        sessionFactory.currentSession.flush()

        then:
        roomDetailsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        RoomDetails roomDetails = new RoomDetails()
        roomDetailsService.save(roomDetails)

        then:
        roomDetails.id != null
    }
}
