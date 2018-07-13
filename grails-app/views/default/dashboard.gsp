<%@ page contentType="text/html;charset=UTF-8" %>
<asset:javascript src="application.js"></asset:javascript>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <asset:stylesheet src="booking/book.css"></asset:stylesheet>
    <asset:javascript src="booking/book.js"></asset:javascript>
    <asset:javascript src="Validate.js"></asset:javascript>
    <title>Dashboard</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <!-- Wizard container -->
            <div class="wizard-container">
                <div class="card wizard-card" data-color="red" id="wizard">
                        <div class="wizard-header">
                            <h3 class="wizard-title">Welcome</h3>
                        </div>
                    <div class="panel-body" align="center">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <a href="/booking/checkIn" class="btn btn-info btn-lg" role="button"><span class="glyphicon glyphicon-pencil"></span> Create<br/>Booking</a>
                            <a href="/booking/guestList" class="btn btn-info btn-lg" role="button"><span class="glyphicon glyphicon-search"></span> View<br/>Bookings</a>
                            <a href="/booking/roomSelection" class="btn btn-info btn-lg" role="button"> Available<br>Rooms </a>
                            <a href="/booking/detailList" class="btn btn-info btn-lg" role="button"> Payment<br>Details</a>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <g:link controller="hotelDetails" action="updateHotelDetails" class="btn btn-success btn-lg"> Edit Hotel<br>Details </g:link>
                            <a href="/logout" class="btn btn-danger btn-lg" role="button"> Logout<br><br></a>
                        </div>
                    </div>
                    </div>
                    <g:if test="${flash.message}">
                        <script> alert('Successful'); </script>
                    </g:if>
                    <g:if test="${flash.error}">
                        <script> alert('Failed'); </script>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>