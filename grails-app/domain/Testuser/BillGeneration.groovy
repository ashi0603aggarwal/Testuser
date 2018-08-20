package testuser

import Testuser.RoomDetails

class BillGeneration {

    String billNo
    String invoiceNo
    String balPaymentBy
    String customerGst
    Date invoiceDate
    double oyoAdvance
    double cashAdvance
    double paytmAdvance
    double balPaymentAmt
    double otherCharges
    double total
    double cgst
    double sgst
    double gstTotal
    String amtInWords

    static hasMany = [roomDetails:RoomDetails]
    List roomDetails = []

    static constraints = {
        invoiceDate(nullable: true,null:true,blank: true)
        invoiceNo(nullable: true,null:true,blank: true, unique: true)
        billNo(nullable: true,null:true,blank: true)
        customerGst(nullable: true,null:true,blank: true)
        otherCharges(nullable: true, null:true, blank: true)
        roomDetails(nullable: true,null:true,blank: true)
        amtInWords(nullable: true,null:true,blank: true)
        oyoAdvance(nullable: true,null:true,blank: true)
        cashAdvance(nullable: true,null:true,blank: true)
        paytmAdvance(nullable: true,null:true,blank: true)
        balPaymentBy(nullable: true,null:true,blank: true)
        balPaymentAmt(nullable: true,null:true,blank: true)
    }

}
