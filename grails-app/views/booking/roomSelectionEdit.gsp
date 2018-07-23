
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="Booking/roomSelection.css"/>
    <title></title>
</head>
<style>
table { font-size:65%; width: 10%; border-collapse: separate; border-spacing: 1px;}
th, td { border-width: 1px; padding: 0.5em; position: relative; text-align: left; }
th, td { border-radius: 0.20em; border-style: solid; }
</style>
<body>
<div >
    <div class="cockpit">
        <h1>Room availability </h1>
    </div>

    <ol class="cabin fuselage">
        <g:form action="editForm">
            <g:each in="${1..r}" var="ro">
                <li class="row">
                    <ol class="seats" type="A">
                        <g:each in="${1..10}" var="c">
                            <g:set var="room" value="${hotelRoomsList.get((10*(ro-1))+(c-1))}"/>
                            <g:set var="disabled" value=""/>
                            <g:set var="checked" value=""/>
                            <g:if test="${hotelRoomsBooked.contains(room.roomNo)}">
                                <g:set var="checked" value="checked"/>
                            </g:if>
                            <g:elseif test="${room.availability=="No"}">
                                <g:set var="disabled" value="disabled"/>
                            </g:elseif>
                            <li class="seat">
                                <input type="checkbox" name="check" ${checked} ${disabled} id="${room.roomNo}" value="${room.roomNo}" />
                                <label for="${room.roomNo}">${room.roomNo}</label>
                            </li>
                        </g:each>
                    </ol>
                </li>
            </g:each>
            <g:hiddenField name="customerName" value="${p.customerName}"/>
            <g:hiddenField name="customerEmail" value="${p.customerEmail}"/>
            <g:hiddenField name="customerAddress" value="${p.customerAddress}"/>
            <g:hiddenField name="customerPhNo" value="${p.customerPhNo}"/>
            <g:hiddenField name="checkInDate" value="${p.checkInDate}"/>
            <g:hiddenField name="checkInTime" value="${p.checkInTime}"/>
            <g:hiddenField name="noOfPerson" value="${p.noOfPerson}"/>
            <g:hiddenField name="bookedBy" value="${p.bookedBy}"/>
            <g:hiddenField name="blockedBy" value="${p.blockedBy}"/>
            <g:hiddenField name="bookingId" value="${p.bookingId}"/>
            <g:hiddenField name="oyo" value="${p.oyo}"/>
            <g:hiddenField name="cash" value="${p.cash}"/>
            <g:hiddenField name="paytm" value="${p.paytm}"/>

            <g:actionSubmit class="btn btn-success btn-lg" value="Save Changes"  action="editForm"/>

        </g:form>
    </ol>
</div>
<br><br>
<table border="1">
    <tr>
        <th>Room Status</th>
        <td>Color</td>
    </tr>
    <tr>
        <th>Room Not Available</th>
        <td bgcolor="#d3d3d3"></td>
    </tr>
    <tr>
        <th>Room Available</th>
        <td bgcolor="red"></td>
    </tr>
    <tr>
        <th>Room Selected</th>
        <td bgcolor="#adff2f"></td>
    </tr>
</table>

</body>
</html>