package testuser

import Testuser.Booking
import Testuser.HotelRooms
import Testuser.RoomDetails

class HotelDetails {
    String billSeries
    String phoneNo
    byte[] logo
    testuser.HotelRegistration hotelRegistration
    static hasMany = [bookings:Booking, hotelRooms:HotelRooms]
    List bookings = []
    List hotelRooms = []

    static constraints = {
        logo nullable: true, maxSize: 1000000
        hotelRegistration(display:false)
        bookings(nullable: true,null:true,blank: true)
        hotelRooms(nullable: true,null:true,blank: true)
    }
}
