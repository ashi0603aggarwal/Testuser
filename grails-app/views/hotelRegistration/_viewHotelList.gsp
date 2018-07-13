<!-- Responsive table starts here -->
    <!-- For correct display on small screens you must add 'data-title' to each 'td' in your table -->
<div class="table-responsive-vertical shadow-z-1">
    <!-- Table starts here -->

    <table id="table" class="table table-hover table-mc-light-blue">
        <thead>
        <tr>
            <th>Hotel ID</th>
            <th>Hotel Name</th>
            <th>User Name </th>
            <th>Gstin</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${hotels}" var="h" >
            <tr>
                <td data-title="Booking Id">${h.id}</td>
                <td data-title="Hotel Name">${h.hotelName}</td>
                <td data-title="User Name">${h.email}</td>
                <td data-title="Gstin">${h.gstin}</td>
                <td data-title="Generate Bill/Checkout">
                    <g:link action="updateHotel" id="${h.id}">View/Update</g:link>
                </td>

            </tr>
        </g:each>
        <g:if test="${flash.message}">
            <script> alert('Updated'); </script>
        </g:if>
        <g:if test="${flash.error}">
            <script> alert('Failed'); </script>
        </g:if>
        </tbody>
    </table>
</div>