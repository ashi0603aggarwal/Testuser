package testuser

import Testuser.Booking
import Testuser.HotelRooms
import Testuser.HotelRoomsExcelImporter
import Testuser.Role
import Testuser.User
import Testuser.UserRole
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import com.jameskleeh.excel.ExcelBuilder
import pl.touk.excel.export.WebXlsxExporter

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_USER')
class HotelDetailsController {

    HotelDetailsService hotelDetailsService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond hotelDetailsService.list(params), model:[hotelDetailsCount: hotelDetailsService.count()]
    }

    def show(Long id) {
        respond hotelDetailsService.get(id)
    }

    def create() {
        respond new testuser.HotelDetails(params)
    }

    def save(testuser.HotelDetails hotelDetails) {
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hotelRegistration = HotelRegistration.findByEmail(user.username)
        hotelDetails.hotelRegistration = hotelRegistration
        if (hotelDetails == null) {
            notFound()
            return
        }
        try {
            hotelDetailsService.save(hotelDetails)
        } catch (ValidationException e) {
            respond hotelDetails.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'hotelDetails.label', default: 'HotelDetails'), hotelDetails.id])
                redirect hotelDetails
            }
            '*' { respond hotelDetails, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond hotelDetailsService.get(id)
    }

    def update(testuser.HotelDetails hotelDetails) {
        if (hotelDetails == null) {
            notFound()
            return
        }

        try {
            hotelDetailsService.save(hotelDetails)
        } catch (ValidationException e) {
            respond hotelDetails.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'hotelDetails.label', default: 'HotelDetails'), hotelDetails.id])
                redirect hotelDetails
            }
            '*'{ respond hotelDetails, [status: OK] }
        }
    }

    def createHotelDetails(){
        render(view:'createHotelDetails')
    }

    def templateDownload()
    {
        def headers = ['Room No', 'Availability']
        new WebXlsxExporter().with {
            setResponseHeaders(response)
            fillHeader(headers)
            fillRow(["101", "No"],1)
            fillRow(["102", "Yes"],2)
            fillRow(["103", "No"],3)
            fillRow(["104", "No"],4)
            fillRow(["105", "Yes"],5)
            fillRow(["106", "Yes"],6)
            save(response.outputStream)
        }
    }

    def submitHotelDetail()
    {
        testuser.HotelDetails hotelDetails1 = new testuser.HotelDetails(billSeries: params.billSeries, phoneNo: params.phoneNo )
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hotelRegistration = testuser.HotelRegistration.findByEmail(user.username)
        hotelDetails1.hotelRegistration = hotelRegistration
        def logo = request.getFile("logoFile")
        hotelDetails1.logo = logo.getBytes()
         def file = request.getFile('hotelRoomsFile')
        if(!file.empty) {
            def sheetheader = []
            def values = []
            def workbook = new XSSFWorkbook(file.getInputStream())
            def sheet = workbook.getSheetAt(0)
            for (cell in sheet.getRow(0).cellIterator()) {
                sheetheader << cell.stringCellValue
            }
            def headerFlag = true
            for (row in sheet.rowIterator()) {
                if (headerFlag) {
                    headerFlag = false
                    continue
                }
                def value = ''
                def map = [:]
                for (cell in row.cellIterator()) {
                    switch(cell.cellType) {
                        case 1:
                            value = cell.stringCellValue
                            map["${sheetheader[cell.columnIndex]}"] = value
                            break
                        case 0:
                            value = cell.numericCellValue
                            map["${sheetheader[cell.columnIndex]}"] = value
                            break
                        default:
                            value = ''
                    }
                }
                values.add(map)
            }

            values.each { data ->
                if(data) {
                    String j = data.roomNo
                    if (j.indexOf('.')){
                        j=j.substring(0,j.indexOf('.'))
                    }
                    HotelRooms hotelRooms = new HotelRooms()
                    hotelRooms.roomNo=j
                    hotelRooms.availability=data.availability
                    hotelRooms.save(flush: true,failOnError : true)
                    hotelDetails1.hotelRooms.add(hotelRooms)
                }
            }

        }

       /* def file = request.getFile("hotelRoomsFile")
        def paymentDatas = []
        if(file && !file.empty){
            def newFile = File.createTempFile('grails', 'hotelRoomsFile')
            file.transferTo(newFile)
            def importer = new HotelRoomsExcelImporter(newFile)
            paymentDatas = importer.list()
            paymentDatas.each{ data->
                String j = data.roomNo
                if (j.indexOf('.')){
                    j=j.substring(0,j.indexOf('.'))
                }
                HotelRooms hotelRooms = new HotelRooms()
                hotelRooms.roomNo=j
                hotelRooms.availability=data.availability
                hotelRooms.save(flush: true,failOnError : true)
                hotelDetails1.hotelRooms.add(hotelRooms)
            }
        } */

        if (hotelDetails1 == null) {
            notFound()
            return
        }
        try {
            hotelDetails1.save(flush: true,failOnError : true)
            flash.message = "successfully saved details"
        } catch (ValidationException e) {
            flash.error = "failed"
            respond hotelDetails1.errors, view:'create'
            return
        }
        chain(controller:'default',action: 'dash')
    }

    def updateHotelDetails()
    {
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hotelRegistration = testuser.HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = testuser.HotelDetails.findByHotelRegistration(hotelRegistration)
        render(view:'updateHotelDetails',model: [hotelDetails:hotelDetails])
    }

    def updateDetails()
    {
        User user = (User)springSecurityService.currentUser
        testuser.HotelRegistration hotelRegistration = testuser.HotelRegistration.findByEmail(user.username)
        testuser.HotelDetails hotelDetails = testuser.HotelDetails.findByHotelRegistration(hotelRegistration)
        hotelDetails.billSeries = params.billSeries
        hotelDetails.phoneNo = params.phoneNo
        def logo = request.getFile("logoFile")
        if(logo && !logo.empty) {
            hotelDetails.logo = logo.getBytes()
        }
        def file = request.getFile("hotelRoomsFile")

        if(!file.empty) {
            def sheetheader = []
            def values = []
            def workbook = new XSSFWorkbook(file.getInputStream())
            def sheet = workbook.getSheetAt(0)
            for (cell in sheet.getRow(0).cellIterator()) {
                sheetheader << cell.stringCellValue
            }
            def headerFlag = true
            for (row in sheet.rowIterator()) {
                if (headerFlag) {
                    headerFlag = false
                    continue
                }
                def value = ''
                def map = [:]
                for (cell in row.cellIterator()) {
                    switch(cell.cellType) {
                        case 1:
                            value = cell.stringCellValue
                            map["${sheetheader[cell.columnIndex]}"] = value
                            break
                        case 0:
                            value = cell.numericCellValue
                            map["${sheetheader[cell.columnIndex]}"] = value
                            break
                        default:
                            value = ''
                    }
                }
                values.add(map)
            }

            values.each { data ->
                if(data) {
                    String j = data.roomNo
                    if (j.indexOf('.')){
                        j=j.substring(0,j.indexOf('.'))
                    }
                    HotelRooms hotelRooms = new HotelRooms()
                    hotelRooms.roomNo=j
                    hotelRooms.availability=data.availability
                    hotelRooms.save(flush: true,failOnError : true)
                    hotelDetails.hotelRooms.add(hotelRooms)
                    //Subscriber.findByEmail(v.email)?: new Subscriber(email:v.email,fullname:v.fullname).save flush:true, failOnError:true
                }
            }

        }
        /*if(file && !file.empty){
            def paymentDatas = []
            def newFile = File.createTempFile('grails', 'hotelRoomsFile')
            log.error("ABCDEFGHIJ"+newFile)
            file.transferTo(newFile)
            def importer = new HotelRoomsExcelImporter(newFile)
            log.error("ABCDEFGHIJ"+importer)
            paymentDatas = importer.list()
            if (paymentDatas){
                hotelDetails.hotelRooms =[]
            }
            paymentDatas.each{ data->
                String j = data.roomNo
                if (j.indexOf('.')){
                    j=j.substring(0,j.indexOf('.'))
                }
                HotelRooms hotelRooms = new HotelRooms()
                hotelRooms.roomNo=j
                hotelRooms.availability=data.availability
                hotelRooms.save(flush: true,failOnError : true)
                hotelDetails.hotelRooms.add(hotelRooms)
            }
        }*/

        try {
            hotelDetails.save(flush:true,failOnError:true)
            flash.message = "successfully saved details"
        } catch (ValidationException e) {
            flash.error = "failed"
            respond hotelDetails.errors, view:'updateHotelDetails',model: [hotels: hotelDetails]
            return
        }
        chain(controller:'default',action: 'dash')
    }


    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        hotelDetailsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'hotelDetails.label', default: 'HotelDetails'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'hotelDetails.label', default: 'HotelDetails'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
