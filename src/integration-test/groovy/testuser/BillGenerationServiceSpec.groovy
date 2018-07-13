package testuser

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class BillGenerationServiceSpec extends Specification {

    BillGenerationService billGenerationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new BillGeneration(...).save(flush: true, failOnError: true)
        //new BillGeneration(...).save(flush: true, failOnError: true)
        //BillGeneration billGeneration = new BillGeneration(...).save(flush: true, failOnError: true)
        //new BillGeneration(...).save(flush: true, failOnError: true)
        //new BillGeneration(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //billGeneration.id
    }

    void "test get"() {
        setupData()

        expect:
        billGenerationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<BillGeneration> billGenerationList = billGenerationService.list(max: 2, offset: 2)

        then:
        billGenerationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        billGenerationService.count() == 5
    }

    void "test delete"() {
        Long billGenerationId = setupData()

        expect:
        billGenerationService.count() == 5

        when:
        billGenerationService.delete(billGenerationId)
        sessionFactory.currentSession.flush()

        then:
        billGenerationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        BillGeneration billGeneration = new BillGeneration()
        billGenerationService.save(billGeneration)

        then:
        billGeneration.id != null
    }
}
