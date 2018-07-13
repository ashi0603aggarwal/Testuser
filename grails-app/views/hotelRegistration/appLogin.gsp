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

    <title></title>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <!-- Wizard container -->
            <div class="wizard-container">
                <div class="card wizard-card" data-color="red" id="wizard">
                    <g:form action="">
                        <!--        You can switch " data-color="blue" "  with one of the next bright colors: "green", "orange", "red", "purple"             -->

                        <div class="wizard-header">
                            <h3 class="wizard-title">
                                Login
                            </h3>
                            <h5></h5>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <h4 class="info-text"> </h4>
                            </div>
                            <div class="col-sm-6">
                                <div class="input-group">

                                    <div class="form-group label-floating">
                                        <label class="control-label">Username</label>
                                        <input name="userName" title="userName" id="userName" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="input-group">

                                    <div class="form-group label-floating">
                                        <label class="control-label">Password</label>
                                        <input name="password" title="password" id="password" type="text" class="form-control">
                                    </div>
                                </div>

                            </div>

                        </div>
                        <div class="wizard-footer">
                            <div class="pull-right">
                                <g:actionSubmit class="btn btn-success btn-wd" value="Submit" action=""/>
                            </div>
                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>