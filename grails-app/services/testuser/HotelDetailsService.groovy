package testuser

import grails.gorm.services.Service

@Service(HotelDetails)
interface HotelDetailsService {

    HotelDetails get(Serializable id)

    List<HotelDetails> list(Map args)

    Long count()

    void delete(Serializable id)

    HotelDetails save(HotelDetails hotelDetails)

}