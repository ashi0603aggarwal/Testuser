<html>
<head>
    <asset:javascript src="application.js"></asset:javascript>
    <asset:stylesheet src="booking/guestList.css"></asset:stylesheet>
    <asset:javascript src="booking/guestList.js"></asset:javascript>
    <g:javascript library="jquery"/>
</head>
<body>
<div id="demo">
    <h1>Hotel Details</h1>
    <h2></h2>
    <h3 align="right"><a href="/hotelRegistration/adminDash" class="btn btn-lg" role="button">Dashboard</a></h3>
    <g:render template="searchBooking" />

    <div id="hotelList">
        <g:render template="viewHotelList" model="['hotels':hotels]" />
    </div>
</div>

<script>
    function greetName() {
        var name = document.getElementById('hotelName').value
        var email = document.getElementById('email').value
        $.ajax({
            url:'${g.createLink( controller:'hotelRegistration', action:'filterHotels' )}',
            data:{ name: name , email: email},
            success: function(data) {
                $("#hotelList").html(data.htmlContent);
            }
        });
    }
</script>
</body>
</html>
