<html>
<head>
    <asset:javascript src="application.js"></asset:javascript>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <asset:stylesheet src="Booking/guestList.css"></asset:stylesheet>
    <asset:javascript src="Booking/guestList_js.js"></asset:javascript>
    <g:javascript library="jquery"/>
</head>
<body>
<div id="demo">
    <h1>Booking Details</h1>
    <h3 align="right"><a href="/default/dash" class="btn btn-lg" role="button">Dashboard</a></h3>
    <g:render template="searchBooking" />

    <div id="hotelbookings">
        <g:render template="bookingList" model="['booking1':booking1,bookingcount:bookingcount]" />
    </div>
</div>

<script>
    function greetName() {
        var name = document.getElementById('customerName').value
        var customerPhNo = document.getElementById('customerPhNo').value
        var status = document.getElementById('status').value
        var invoiceDate = document.getElementById('invoiceDate').value
        $.ajax({
            url:'${g.createLink( controller:'booking', action:'filterBookings' )}',
            data:{ name: name , customerPhNo: customerPhNo, status: status,invoiceDate:invoiceDate},
            success: function(data) {
                $("#hotelbookings").html(data.htmlContent);
            }

        });
    }

    $( function() {
        $('#invDate').datetimepicker({
            format: 'DD/MMM/YYYY',
        }).on('dp.change', function (selected) {
            greetName()
        });
    });

    $("#resetDate").click(function(){
        $('#invDate').data("DateTimePicker").clear();
    });

</script>
</body>
</html>
