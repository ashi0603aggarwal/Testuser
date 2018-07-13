package Testuser

import grails.gorm.services.Service

@Service(RoomDetails)
interface RoomDetailsService {

    RoomDetails get(Serializable id)

    List<RoomDetails> list(Map args)

    Long count()

    void delete(Serializable id)

    RoomDetails save(RoomDetails roomDetails)

}