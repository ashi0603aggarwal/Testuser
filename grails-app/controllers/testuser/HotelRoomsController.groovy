package Testuser

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_USER')
class HotelRoomsController {

    Testuser.HotelRoomsService hotelRoomsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond hotelRoomsService.list(params), model:[hotelRoomsCount: hotelRoomsService.count()]
    }

    def show(Long id) {
        respond hotelRoomsService.get(id)
    }

    def create() {
        respond new HotelRooms(params)
    }

    def save(HotelRooms hotelRooms) {
        if (hotelRooms == null) {
            notFound()
            return
        }

        try {
            hotelRoomsService.save(hotelRooms)
        } catch (ValidationException e) {
            respond hotelRooms.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'hotelRooms.label', default: 'HotelRooms'), hotelRooms.id])
                redirect hotelRooms
            }
            '*' { respond hotelRooms, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond hotelRoomsService.get(id)
    }

    def update(HotelRooms hotelRooms) {
        if (hotelRooms == null) {
            notFound()
            return
        }

        try {
            hotelRoomsService.save(hotelRooms)
        } catch (ValidationException e) {
            respond hotelRooms.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'hotelRooms.label', default: 'HotelRooms'), hotelRooms.id])
                redirect hotelRooms
            }
            '*'{ respond hotelRooms, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        hotelRoomsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'hotelRooms.label', default: 'HotelRooms'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'hotelRooms.label', default: 'HotelRooms'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def processUpload(){
        def file = request.getFile("hotelRoomsFile")
        def paymentDatas = []
        if(file && !file.empty){
            def newFile = File.createTempFile('grails', 'hotelRoomsFile')
            file.transferTo(newFile)
            def importer = new HotelRoomsExcelImporter(newFile)
            paymentDatas = importer.list()
            paymentDatas.each{ data->
                print(data.roomNo)
                HotelRooms hotelRooms1 = HotelRooms.findByRoomNo(data.roomNo)
                if (hotelRooms1){
                    hotelRooms1.availability = data.availability
                    hotelRooms1.save(flush: true,failOnError : true)
                }else {
                    HotelRooms hotelRooms = new HotelRooms(data)
                    hotelRooms.save(flush: true,failOnError : true)
                }
            }
        }
        render("successs")
    }
    def saveHotelRooms(){

    }

    def excelUpload(){

    }
}
