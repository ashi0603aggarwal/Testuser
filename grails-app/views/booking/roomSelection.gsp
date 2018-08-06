
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
<div>
    <div class="cockpit">
        <h1>Room availability </h1>
    </div>

    <ol class="cabin fuselage">
        <g:form action="submitForm">
            <g:each in="${1..r}" var="ro">
                <li class="row">
                    <ol class="seats" type="A">
                        <g:each in="${1..10}" var="c">
                            <g:set var="room" value="${hotelRoomsList.get((10*(ro-1))+(c-1))}"/>
                            <g:set var="disabled" value=""/>
                            <g:if test="${room.availability=="No"}">
                                <g:set var="disabled" value="disabled"/>
                            </g:if>
                            <li class="seat">
                                <input type="checkbox" name="check" ${disabled} id="${room.roomNo}" value="${room.roomNo}" onclick="getRooms(${room.roomNo})"/>
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
            <g:hiddenField name="oyo" value="${p.oyo}"/>
            <g:hiddenField name="cash" value="${p.cash}"/>
            <g:hiddenField name="paytm" value="${p.paytm}"/>
            <br/><br/>



            <div class="input-group" style="padding-left: 43%;">
              <button type="button" class="btn btn-success btn-lg" id="myBtn" onclick="enterRates()">Enter Room Rates</button>
            </div>
            <div id="box" style="padding-left: 38%; width: inherit"></div>

            <br/><br/>
            <g:actionSubmit value="Submit" class="btn btn-success btn-lg" action="submitForm" style="margin-left: 45%;" />

        </g:form>
    </ol>
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
</div>
</body>
<script>
    var countRooms = 0;
    var roomSelected = [];
    function getRooms(roomNo) {
        var rooms = roomNo;
        if (document.getElementById(roomNo).checked == true) {
            if (countRooms < 5) {
                countRooms = countRooms + 1;
                roomSelected.push(roomNo);
            }
            else {
                alert("Cannot select more than 5 Rooms");
                document.getElementById(roomNo).checked = false;
                alert(roomSelected);
            }
        }
        else {
            roomSelected.splice(roomSelected.indexOf(roomNo), 1);
            countRooms = countRooms - 1;
        }
    }
    function enterRates()
    {
        var html = "<table style='font-size: 18px; width:inherit;  '>";
        html+="<tr>";
        html+="<th>"+"Room No"+"</th>";
        html+="<th>"+"Room Rate"+"</th>";
        html+="</tr>";
        for (var i = 0; i < roomSelected.length; i++) {
            html+="<tr>";
            html+="<td>"+"<input type='text' class='roomNo' name='roomNo' value='"+roomSelected[i]+"'  style='border: 0; font-size: 18px;' readonly></td>";
            html+="<td><input type='text' class='roomRate' name='roomRate'></td>";
            html+="</tr>";
        }
        html+="</table>";
        document.getElementById("box").innerHTML = html;
    }

</script>

</html>