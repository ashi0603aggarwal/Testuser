package testuser

import grails.gorm.services.Service

@Service(BillGeneration)
interface BillGenerationService {

    BillGeneration get(Serializable id)

    List<BillGeneration> list(Map args)

    Long count()

    void delete(Serializable id)

    BillGeneration save(BillGeneration billGeneration)

}