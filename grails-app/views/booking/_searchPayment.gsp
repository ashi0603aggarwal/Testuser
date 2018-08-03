<div>
    <g:form action="filterBooking" name="filterBooking">
        <div class="form-group label-floating row">
            <div class="col-lg-3">
                <label class="control-label">Booked By:</label><br>
                <g:select name="status" id="status" from="['HOTEL BOOKING','OYO','GOIBIBO','TRIVAGO','MMT']" onchange="greetName()" noSelection="['':'-Select-']"></g:select><br>
            </div>
            <div class="col-lg-3" style="padding-left: 30px">
                <label class="control-label">From Date</label>
                <div class="row" >
                    <div class='input-group date col-sm-9' id="minDate" style="float: left">
                        <input type='text' class="form-control" name="minDateRange" id="minDateRange" onchange="greetName()" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <div id="resetDate1" class="input-group date col-sm-1" style="float: left">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-remove"></span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <label class="control-label">To Date</label>
                <div class="row" >
                    <div class='input-group date col-sm-9' id="maxDate" style="float: left">
                        <input type='text' class="form-control" name="maxDateRange" id="maxDateRange" onchange="greetName()" />
                        <span class="input-group-addon" >
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <div id="resetDate2" class="input-group date col-sm-1" style="float: left">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-remove"></span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </g:form>
</div>