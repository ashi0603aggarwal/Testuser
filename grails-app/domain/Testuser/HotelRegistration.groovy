package testuser

class HotelRegistration {

    String hotelName
    String gstin
    String email
    String password
    String address
    String hotelLicenceNo
    String foodLicenceNo

    static constraints = {
        hotelName blank: false
        password size: 3..15, blank: false
        email  blank: false,unique: true
        gstin unique: true, blank: false
        hotelLicenceNo unique: true, blank: false
        foodLicenceNo unique: true, blank: false
    }

}
