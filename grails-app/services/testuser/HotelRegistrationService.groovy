package testuser

import grails.gorm.services.Service
import testuser.HotelRegistrationService


@Service(testuser.HotelRegistration)
interface HotelRegistrationService {

    testuser.HotelRegistration get(Serializable id)

    List<testuser.HotelRegistration> list(Map args)

    Long count()

    void delete(Serializable id)

    testuser.HotelRegistration save(testuser.HotelRegistration hotelRegistration)

}