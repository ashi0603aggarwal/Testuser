package Testuser

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured('ROLE_USER')
class RoomDetailsController {

    Testuser.RoomDetailsService roomDetailsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond roomDetailsService.list(params), model:[roomDetailsCount: roomDetailsService.count()]
    }

    def show(Long id) {
        respond roomDetailsService.get(id)
    }

    def create() {
        respond new RoomDetails(params)
    }

    def save(RoomDetails roomDetails) {
        if (roomDetails == null) {
            notFound()
            return
        }

        try {
            roomDetailsService.save(roomDetails)
        } catch (ValidationException e) {
            respond roomDetails.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'roomDetails.label', default: 'RoomDetails'), roomDetails.id])
                redirect roomDetails
            }
            '*' { respond roomDetails, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond roomDetailsService.get(id)
    }

    def update(RoomDetails roomDetails) {
        if (roomDetails == null) {
            notFound()
            return
        }

        try {
            roomDetailsService.save(roomDetails)
        } catch (ValidationException e) {
            respond roomDetails.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'roomDetails.label', default: 'RoomDetails'), roomDetails.id])
                redirect roomDetails
            }
            '*'{ respond roomDetails, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        roomDetailsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'roomDetails.label', default: 'RoomDetails'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'roomDetails.label', default: 'RoomDetails'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
