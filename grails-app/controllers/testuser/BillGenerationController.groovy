package testuser

import Testuser.Booking
import Testuser.HotelRooms
import Testuser.RoomDetails
import Testuser.User
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import javax.servlet.ServletOutputStream

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_USER')
class BillGenerationController {

    BillGenerationService billGenerationService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond billGenerationService.list(params), model:[billGenerationCount: billGenerationService.count()]
    }

    def show(Long id) {
        respond billGenerationService.get(id)
    }

    def create() {
        respond new testuser.BillGeneration(params)
    }

    def booking(){
        //test
    }


    def createInvoice(params){
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        String billId = params.billId
        Long id = billId.toLong()
        testuser.BillGeneration billGeneration = BillGeneration.findById(id)
        billGeneration.billNo = params.billNo
        String inDate = params.invoiceDate
        Date invoiceDate = new Date().parse("dd/MMM/yyyy",inDate)
        billGeneration.invoiceDate = invoiceDate
        String extraCharges = params.otherCharges
        double otherCharges = extraCharges.toDouble()
        billGeneration.otherCharges = otherCharges
        String cgst = params.cgstTotal
        double cgstTotal = cgst.toDouble()
        billGeneration.cgst = cgstTotal
        String sgst = params.sgstTotal
        double sgstTotal = sgst.toDouble()
        billGeneration.sgst = sgstTotal
        String gstTotal = params.gstTotal
        double gTotal = gstTotal.toDouble()
        billGeneration.gstTotal = gTotal
        String grandTotal = params.grandTotal
        double fTotal = grandTotal.toDouble()
        billGeneration.total = fTotal
        billGeneration.amtInWords=params.amountInWords
        String balPayment = params.balPaymentAmt
        double balPaymentAmt = balPayment.toDouble()
        billGeneration.balPaymentAmt=balPaymentAmt
        billGeneration.balPaymentBy = params.balPaymentBy

        billGeneration.save(flush: true,failOnError : true)
        Booking booking = Booking.findByBillGeneration(billGeneration)
        String checkIn = params.checkInDate
        Date checkInDate = new Date().parse("dd/MMM/yyyy",checkIn)
        booking.checkInDate=checkInDate
        String checkOut = params.checkOutDate
        Date checkOutDate = new Date().parse("dd/MMM/yyyy",checkOut)
        booking.checkOutDate=checkOutDate
        String outTime = params.checkOutTime
        Date checkOutTime = new Date().parse("hh:mm aa",outTime)
        booking.checkOutTime=checkOutTime
        booking.bookingStatus = "Closed"

        booking.customerName = params.customerName
        booking.customerAddress = params.customerAddress
        booking.customerPhNo = params.customerPhNo
        booking.billGeneration.customerGst = params.customerGST

        if(params.roomNo.class.isArray()) {
            List roomNos = params.roomNo.toList()
            List roomRate = params.roomRate.toList()
            List noOfPerson = params.noOfPerson.toList()
            List noOfDays = params.noOfDays.toList()
            List tax = params.tax.toList()
            List taxRate = params.taxRate.toList()
            List total = params.total.toList()
            List<RoomDetails> rms = []
            billGeneration.roomDetails.removeAll()

            roomNos.eachWithIndex { it, index ->
                RoomDetails roomDetails = new RoomDetails()
                roomDetails.roomNo = roomNos.get(index)
                roomDetails.roomRate = roomRate.get(index)
                roomDetails.noOfPerson = noOfPerson.get(index)
                roomDetails.noOfDays = noOfDays.get(index)
                roomDetails.tax = tax.get(index)
                roomDetails.taxRate = taxRate.get(index)
                roomDetails.total = total.get(index)
                roomDetails.save(flush:true,failOnError:true)
                rms.add(roomDetails)
                billGeneration.roomDetails = rms
            }
        }
        else
        {
            List<RoomDetails> rms = []
            billGeneration.roomDetails.remove()

            RoomDetails roomDetails = new RoomDetails()
            roomDetails.roomNo = params.roomNo
            roomDetails.roomRate = params.roomRate
            roomDetails.noOfPerson = params.noOfPerson
            roomDetails.noOfDays = params.noOfDays
            roomDetails.tax = params.tax
            roomDetails.taxRate = params.taxRate
            roomDetails.total = params.total
            roomDetails.save(flush:true,failOnError:true)
            rms.add(roomDetails)
            billGeneration.roomDetails = rms
        }

        List<HotelRooms> hotelRoomsList = HotelRooms.findAllByRoomNoInList(booking.roomsBooked)
        hotelRoomsList.each {
            it.availability = "Yes"
            it.save(flush: true,failOnError : true)
        }

        billGeneration.save(flush: true,failOnError : true)
        booking.save(flush: true,failOnError : true)
        def total= booking.billGeneration.total-booking.billGeneration.gstTotal
        def tRoom= booking.billGeneration.roomDetails.size().toInteger()
        testuser.HotelDetails hotelDetails = testuser.HotelDetails.findByHotelRegistration(hr)
        //render(view: 'createinvoice',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom])
        renderPdf(template: 'billPdf', model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom])
    }

    def viewBill()
    {
        String id = params.id
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        def total= booking.billGeneration.total-booking.billGeneration.gstTotal
        def tRoom= booking.billGeneration.roomDetails.size().toInteger()
        render(view: 'viewinvoice',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom])
    }

    def printBill() {
        String id = params.id
        Long bookingId = id.toLong()
        //def bId = Booking.get( params.offerId )
        Booking booking = Booking.findById(bookingId)
        User user = (User) springSecurityService.currentUser
        testuser.HotelRegistration hr = HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        def total = booking.billGeneration.total - booking.billGeneration.gstTotal
        def tRoom = booking.billGeneration.roomDetails.size().toInteger()
        //def createPdfReport = { renderPdf(template: '/billGeneration/createinvoice', model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom], filename: "invoice") }
        //render(view: 'createinvoice',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom])
        //renderPdf(template: "/billGeneration/printinvoice", model: [booking: booking, hr: hr, hotelDetails: hotelDetails, total: total, tRoom: tRoom], filename: "invoice.pdf")
        renderPdf(template: 'billPdf', model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom,test:"test"])
    }
    def printBillA5() {
        String id = params.id
        Long bookingId = id.toLong()
        //def bId = Booking.get( params.offerId )
        Booking booking = Booking.findById(bookingId)
        User user = (User) springSecurityService.currentUser
        testuser.HotelRegistration hr = HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        def total = booking.billGeneration.total - booking.billGeneration.gstTotal
        def tRoom = booking.billGeneration.roomDetails.size().toInteger()
        //def createPdfReport = { renderPdf(template: '/billGeneration/createinvoice', model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom], filename: "invoice") }
        //render(view: 'createinvoice',model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom])
        //renderPdf(template: "/billGeneration/printinvoice", model: [booking: booking, hr: hr, hotelDetails: hotelDetails, total: total, tRoom: tRoom], filename: "invoice.pdf")
        renderPdf(template: 'billPdfA5', model: [booking:booking,hr: hr,hotelDetails:hotelDetails,total:total,tRoom:tRoom,test:"test"])
    }
    def bill(){
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        render(view: "bill", model: [hr:hr,hotelDetails:hotelDetails])
    }

    def save(testuser.BillGeneration billGeneration) {
        if (billGeneration == null) {
            notFound()
            return
        }

        try {
            billGenerationService.save(billGeneration)
        } catch (ValidationException e) {
            respond billGeneration.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'billGeneration.label', default: 'BillGeneration'), billGeneration.id])
                redirect billGeneration
            }
            '*' { respond billGeneration, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond billGenerationService.get(id)
    }

    def update(testuser.BillGeneration billGeneration) {
        if (billGeneration == null) {
            notFound()
            return
        }
        try {
            billGenerationService.save(billGeneration)
        } catch (ValidationException e) {
            respond billGeneration.errors, view:'edit'
            return
        }
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'billGeneration.label', default: 'BillGeneration'), billGeneration.id])
                redirect billGeneration
            }
            '*'{ respond billGeneration, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        billGenerationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'billGeneration.label', default: 'BillGeneration'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'billGeneration.label', default: 'BillGeneration'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def editBill(){
        String id = params.id
        Long bookingId = id.toLong()
        Booking booking = Booking.findById(bookingId)
        String checkInTime = booking.checkInTime.format("HH:mm")
        String checkOutTime = booking.checkOutTime.format("HH:mm")
        String checkInDate = booking.checkInDate.format("dd/MMM/yyyy")
        String checkOutDate = booking.checkOutDate.format("dd/MMM/yyyy")
        String invoiceDate = booking.billGeneration.invoiceDate.format("dd/MMM/yyyy")
        println(booking.billGeneration.roomDetails)
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hr =  HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = HotelDetails.findByHotelRegistration(hr)
        double advPaymentAmt= booking.billGeneration.cashAdvance + booking.billGeneration.oyoAdvance + booking.billGeneration.paytmAdvance
        render(view: 'editBill',model: [booking:booking,checkInTime:checkInTime,checkOutTime:checkOutTime,checkInDate:checkInDate,checkOutDate:checkOutDate,advPaymentAmt:advPaymentAmt,invoiceDate:invoiceDate,hr:hr, hotelDetails:hotelDetails])
    }
}
