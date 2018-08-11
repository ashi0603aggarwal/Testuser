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
    <h2 align="right"><a href="/default/dash" class="btn btn-lg btn-info" role="button">Back</a></h2>

    <div class="cockpit">
        <h1>Room availability </h1>
    </div>

    <ol class="cabin fuselage">
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
                                <input class="single-checkbox" type="checkbox" name="check" ${disabled} id="${room.roomNo}" value="${room.roomNo}" />
                                <label for="${room.roomNo}">${room.roomNo}</label>
                            </li>
                        </g:each>
                    </ol>
                </li>
            </g:each>
    </ol>
</div>
<br><br>
<table border="1" style="font-size: 14px;width: 15%;">
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
<script>
    $('.single-checkbox').on('change', function() {
        if($('.single-checkbox:checked').length > 3) {
            this.checked = false;
        }
    });
</script>
</html>