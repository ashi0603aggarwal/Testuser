package Testuser

import testuser.BillGeneration
import testuser.HotelDetails

class Booking {

    String customerName
    String customerAddress
    String customerEmail
    int noOfPerson
    Date checkInDate
    Date checkInTime
    Date checkOutDate
    Date checkOutTime
    String customerPhNo
    String bookingStatus = "Open"
    String bookedBy
    static hasMany = [roomsBooked: String]
    List roomsBooked = []
    BillGeneration billGeneration
    static belongsTo = [hotelDetails : HotelDetails]

    static constraints = {
        checkInDate(nullable: true, blank: true,)
        checkOutDate(nullable: true, blank: true)
        checkInTime(nullable: true, blank: true,)
        checkOutTime(nullable: true, blank: true)
        customerEmail(nullable: true, email: true)
        customerAddress(nullable: true, blank: true)
        customerPhNo(nullable: true, blank: true)
        noOfPerson(nullable: true, blank: true)
        bookedBy(nullable: true, null: true, blank: true)
        billGeneration(nullable: true, blank: true)
    }

}
