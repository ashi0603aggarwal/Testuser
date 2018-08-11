package testuser

import Testuser.Role
import Testuser.User
import Testuser.UserRole
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import static org.springframework.http.HttpStatus.*

@Secured('ROLE_ADMIN')
class HotelRegistrationController {

    HotelRegistrationService hotelRegistrationService
    SpringSecurityService springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond hotelRegistrationService.list(params), model:[hotelRegistrationCount: hotelRegistrationService.count()]
    }

    def show(Long id) {
        respond hotelRegistrationService.get(id)
    }

    def create() {
        respond new testuser.HotelRegistration(params)
    }

    def save(testuser.HotelRegistration hotelRegistration) {

        def userRole = new Role(authority:'ROLE_USER').save()
        def me = new User(username:hotelRegistration.email, password:hotelRegistration.password).save()
        UserRole.create me, userRole
        UserRole.withSession {
            it.flush()
            it.clear()
        }

        if (hotelRegistration == null) {
            notFound()
            return
        }

        try {
            hotelRegistrationService.save(hotelRegistration)
        } catch (ValidationException e) {
            respond hotelRegistration.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'hotelRegistration.label', default: 'HotelRegistration'), hotelRegistration.id])
                redirect hotelRegistration
            }
            '*' { respond hotelRegistration, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond hotelRegistrationService.get(id)
    }

    def update(testuser.HotelRegistration hotelRegistration) {
        if (hotelRegistration == null) {
            notFound()
            return
        }

        try {
            hotelRegistrationService.save(hotelRegistration)
        } catch (ValidationException e) {
            respond hotelRegistration.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'hotelRegistration.label', default: 'HotelRegistration'), hotelRegistration.id])
                redirect hotelRegistration
            }
            '*'{ respond hotelRegistration, [status: OK] }
        }
    }

    def appLogin()
    {
        render(view:'appLogin')
    }
    def registerHotel() {
        render(view:'registerHotel')
    }
    def adminDash() {
        render(view:'adminDash')
    }
    def updateHotel(){
        String id = params.id
        Long hotelId = id.toLong()
        testuser.HotelRegistration hotelRegistration = testuser.HotelRegistration.findById(hotelId)
        render(view:'updateHotel',model: [hotelRegistration:hotelRegistration])
    }

    def updateHotelRegister(){
        testuser.HotelRegistration hotelRegistration = testuser.HotelRegistration.findByEmail(params.hotelEmail)
        hotelRegistration.email = params.email
        hotelRegistration.hotelName= params.hotelName
        hotelRegistration.gstin = params.gstin
        hotelRegistration.password = params.password
        hotelRegistration.address = params.address
        hotelRegistration.hotelLicenceNo = params.hotelLicenceNo
        hotelRegistration.foodLicenceNo = params.foodLicenceNo
        try {
            //hotelRegistrationService.save(hotelRegister1)
            hotelRegistration.save(flush:true,failOnError:true)
            println(hotelRegistration.email)
            User me = User.findByUsername(params.hotelEmail)
            me.username= hotelRegistration.email
            me.password= hotelRegistration.password
            me.save(flush:true,failOnError:true)
            def userRole = new Role(authority:'ROLE_USER').save()
            UserRole.create me, userRole
            UserRole.withSession{
                it.flush()
                it.clear()
            }
            flash.message = "successfully registered"
        } catch (ValidationException e) {
            flash.error = "failed update"
            respond hotelRegistration.errors, view:'updateHotel', model: [hotels: hotelRegistration]
            return
        }
        chain(controller:'hotelRegistration',action: 'hotelList')
    }

    def hotelList(){
        List<testuser.HotelRegistration> hotelRegistrationList = testuser.HotelRegistration.findAll()
        render(view: 'hotelList', model: [hotels:hotelRegistrationList])
    }

    def filterHotels(){
        String name = params.name
        String n = "%" + name + "%"
        String email = params.email
        String e = "%" +email + "%"
        List<testuser.HotelRegistration> hotelRegistrationList = testuser.HotelRegistration.findAllByHotelNameIlikeAndEmailIlike(n,e)
        String htmlContent = g.render([template:"viewHotelList", model:[hotels: hotelRegistrationList]])
        Map responseData = [htmlContent:htmlContent]
        render(responseData as JSON)
    }

    def submitHotelRegister() {
        testuser.HotelRegistration hotelRegister1 = new testuser.HotelRegistration(hotelName: params.hotelName, gstin: params.gstin, email: params.email, password: params.password, address: params.address, hotelLicenceNo: params.hotelLicenceNo, foodLicenceNo: params.foodLicenceNo)
        try {
            def me = new User(username:hotelRegister1.email, password:hotelRegister1.password).save(flush:true,failOnError:true)
            def UserRole= new UserRole(user: me, role: Role.findByAuthority('ROLE_USER')).save(flush: true,failOnError:true)
            UserRole.withSession {
                it.flush()
                it.clear()
            }
            hotelRegistrationService.save(hotelRegister1)
            flash.message = "successfully registered"
            chain(controller:'hotelRegistration',action: 'adminDash')
        } catch (ValidationException e) {
            flash.error = "failed"
            def er = hotelRegister1.errors
            //respond hotelRegistration.errors, view:'registerHotel'
            chain(action: 'registerHotel', model:[er:er])
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        hotelRegistrationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'hotelRegistration.label', default: 'HotelRegistration'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'hotelRegistration.label', default: 'HotelRegistration'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
