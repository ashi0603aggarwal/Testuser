package testuser

import Testuser.User
import Testuser.UserRole
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_USER','ROLE_ADMIN'])
class DefaultController {

    SpringSecurityService springSecurityService
    def index() { }

    def dash(){
        User user = (User)springSecurityService.currentUser
        UserRole userRole = UserRole.findByUser(user)
        if (userRole.role.authority == 'ROLE_ADMIN'){
            redirect('controller':'hotelRegistration','action':'adminDash')
        }else {
            testuser.HotelRegistration hr =  testuser.HotelRegistration.findByEmail(user.username)
            testuser.HotelDetails hotelDetails = testuser.HotelDetails.findByHotelRegistration(hr)
            if (hotelDetails){
                render(view: 'dashboard')
            }else{
                redirect(controller: 'hotelDetails', action: 'createHotelDetails' )
            }
        }
    }



}