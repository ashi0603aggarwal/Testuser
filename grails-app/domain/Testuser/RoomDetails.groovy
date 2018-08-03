package Testuser

class RoomDetails {

    String roomNo
    String roomRate
    String noOfPerson
    String tax
    String taxRate
    String total
    String noOfDays

    static constraints = {
        noOfPerson(nullable: true,null:true,blank: true)
        tax(nullable: true,null:true,blank: true)
        taxRate(nullable: true,null:true,blank: true)
        total(nullable: true,null:true,blank: true)
        noOfDays(nullable: true,null:true,blank: true)
    }
}
