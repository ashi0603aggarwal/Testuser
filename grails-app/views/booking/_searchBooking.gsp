<div>
    <g:form action="roomSelection" name="filterBookings">
        <div class="form-group label-floating row">
            <div class="col-lg-3">
                <label class="control-label">Customer Name:</label>
                <g:textField name="customerName" id="customerName" class="form-control" onkeyup="greetName()" ></g:textField>
            </div>
            <div class="col-lg-3">
                <label class="control-label">Customer Phone:</label>
                <g:textField name="customerPhNo" id="customerPhNo" class="form-control" onkeyup="greetName()" ></g:textField>
            </div>
            <div class="col-lg-3">
                <label class="control-label">Booking Status:</label><br>
                <g:select name="status" id="status" from="['Open','Closed']" onchange="greetName()" noSelection="['':'-Select-']"></g:select><br>
            </div>
            <div class="col-lg-3">
                <label class="control-label">Invoice Date:</label>
                <div class="row" >
                    <div class='input-group date col-sm-9' id="invDate" style="float: left">
                        <input type='text' class="form-control" name="invoiceDate" id="invoiceDate" onchange="greetName()" />
                        <span class="input-group-addon" >
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <div id="resetDate" class="input-group date col-sm-1" style="float: left">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-remove"></span>
                        </span>
                    </div>
                </div>

            </div>

        </div>
    </g:form>
</div>