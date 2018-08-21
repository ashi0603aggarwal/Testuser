<!-- Responsive table starts here -->
    <!-- For correct display on small screens you must add 'data-title' to each 'td' in your table -->
<div class="table-responsive-vertical shadow-z-1">
    <!-- Table starts here -->
    <table id="table" class="table table-hover table-mc-light-blue" style="font-size: 16px;">
        <thead>
        <tr>
            <th>S.No</th>
            <th>Name</th>
            <th>Contact No</th>
            <th>CheckIn Date</th>
            <th>CheckOut Date</th>
            <th>Status</th>
            <th>Details</th>
            <th>Bill Action</th>
        </tr>
        </thead>
        <tbody>

        <g:each in="${booking1}" var="b" >
            <tr>
                <td data-title="test.Booking Id">${b.billGeneration.billNo.toInteger()}</td>
                <td data-title="Name">${b.customerName}</td>
                <td data-title="Contact No">${b.customerPhNo}</td>
                <td data-title="CheckIn Date"><g:formatDate format="dd/MM/yyyy" date="${b.checkInDate}"/></td>
                <td data-title="CheckOut Date"><g:formatDate format="dd/MM/yyyy" date="${b.checkOutDate}"/></td>
                <td data-title="Status">${b.bookingStatus}</td>
                <td data-title="Booking Details"><g:link controller="booking" action="viewBooking" id="${b.id}">View/Edit Booking</g:link></td>

                <g:if test="${b.bookingStatus == "Open"}">
                    <td data-title="Generate Bill/Checkout">
                         &nbsp;<g:link action="checkOut" id="${b.id}">Checkout</g:link>
                    </td>
                </g:if>
                <g:if test="${b.bookingStatus == "Closed"}">
                    <td data-title="Generate Bill/Checkout">
                        <g:link controller="billGeneration" action="viewBill" id="${b.id}">View</g:link> &nbsp;
                        <g:link controller="billGeneration" action="editBill" id="${b.id}">Edit</g:link> &nbsp;
                        <g:link controller="billGeneration" action="printBill" id="${b.id}">Print A4</g:link>&nbsp;
                        <g:link controller="billGeneration" action="printBillA5" id="${b.id}">Print A5</g:link>
                    </td>
                </g:if>
                <g:else>
                    <g:if test="${b.bookingStatus == "Cancelled"}">
                        Cancelled
                    </g:if>
                </g:else>
            </tr>
        </g:each>

        </tbody>
    </table>
</div>


<div class="paginateButtons">
    <util:remotePaginate total="${bookingcount}" update="hotelbookings" action="pagin"  max="20"  params="${params}"/>
</div>