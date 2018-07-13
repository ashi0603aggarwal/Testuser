package Testuser

import grails.gorm.services.Service

@Service(HotelRooms)
interface HotelRoomsService {

    HotelRooms get(Serializable id)

    List<HotelRooms> list(Map args)

    Long count()

    void delete(Serializable id)

    HotelRooms save(HotelRooms hotelRooms)

}