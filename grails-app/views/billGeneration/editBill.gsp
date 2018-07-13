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
    <title>Invoice</title>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <asset:stylesheet src="d.css"></asset:stylesheet>
    <asset:stylesheet src="Booking/book.css"></asset:stylesheet>
    <asset:javascript src="Validate_Js.js"></asset:javascript>
    <asset:javascript src="d.js"></asset:javascript>
    <link rel="license" href="https://www.opensource.org/licenses/mit-license/">
</head>
<body class="bg">
<header>
    <g:if test="${booking?.billGeneration?.total>999}">
        <h2 id="billHeading">Invoice</h2>
    </g:if>
    <g:else>
        <h2 id="billHeading">Bill Of Supply</h2>
    </g:else>
    <address>
        <p>${hr.hotelName}, Address: ${hr.address}, Ph No: </p>
        <p>GST No: ${hr.gstin}
        <p>License No: ${hr.hotelLicenceNo}</p>
        <p>Food License No: ${hr.foodLicenceNo}</p>
    </address>
    <span style="width: 38%; height: 20%"><img alt="" src="data:image/png;base64,${hotelDetails.logo.encodeBase64()}"></span>
</header>
<article>
<g:form action="createInvoice" controller="billGeneration" >
    <div>
        <div class="row">
            <div class="" style="padding: 0px;">
                <table class="">
                    <tr style="visibility: hidden">
                        <th><span>Amount Due</span></th>
                        <td><span id="prefix">Rs.</span><span>600.00</span></td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-12" style="padding: 0px">
                <table class="">
                    <tr>
                    </tr>
                    <tr>
                        <th><span>Invoice No</span></th>
                        <td><span><input name="billNo" type="text" value="${hotelDetails.billSeries + booking.billGeneration.id}"></span></td>
                        <th><span>Check In Date</span></th>
                        <td>
                            <div class='input-group date' id='checkInDate'>
                                <input type='text'  class="form-control" name="checkInDate" value="${checkInDate}"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </td>
                        <th><span>Check In Time</span></th>
                        <td>
                            <div class='input-group date' id='checkInTime'>
                                <input type='text'  class="form-control" name="checkInTime" value="${checkInTime}"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><span>Invoice Date</span></th>
                        <td>
                            <div class='input-group date' id='invoiceDate'>
                                <input type='text' class="form-control" name="invoiceDate" value="${invoiceDate}"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </td>
                        <th><span>Check Out Date</span></th>
                        <td>
                            <div class='input-group date' id='checkOutDate'>
                                <input type='text' class="form-control" name="checkOutDate" value="${checkOutDate}"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </td>
                        <th><span>Check Out Time</span></th>
                        <td>
                            <div class='input-group date' id='checkOutTime'>
                                <input type='text'  class="form-control" name="checkOutTime" value="${checkOutTime}" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-12" style="padding: 0px">
                <table class="guest">
                    <tr>
                        <th><span>Guest Name</span></th>
                        <td><span><input name="customerName" title="customerName" id="customerName" type="text" value="${booking.customerName}"/></span></td>
                    </tr>
                    <tr>
                        <th><span>Address</span></th>
                        <td><span ><input name="customerAddress" title="customerAddress" type="text" id="customerAddress" value="${booking.customerAddress}" style="width: 100%"/></span></td>
                    </tr>
                    <tr>
                        <th><span>Phone No</span></th>
                        <td><span ><input name="customerPhNo" type="text" title="customerPhNo" id="customerPhNo" value="${booking.customerPhNo}"></span></td>

                    </tr>
                    <tr>
                        <th><span>GST</span></th>
                        <td><span ><input type="text" name="customerGST" title="customerGST" id="customerGST" ></span></td>

                    </tr>
                    <tr>
                        <th><span>Other</span></th>
                        <td><span ><input type="text" name="customerOther" title="customerOther" id="customerOther" ></span></td>

                    </tr>
                </table>
            </div>
        </div>
    </div>
    <br>
    <table class="inventory">
        <g:render template="/billGeneration/editRoomDetailsRow" model="['booking':booking]"></g:render>
    </table>
    <table class="balance">
        <tr>
            <th><span>SGST</span></th>
            <td><input type="text" name="sgstTotal" id="sgstTotal" title="sgstTotal" value="${booking.billGeneration.sgst}"/></td>
            <th><span>CGST</span></th>`
            <td><input type="text" name="cgstTotal" id="cgstTotal" title="cgstTotal" value="${booking.billGeneration.cgst}"/></td>
            <th><span>Total</span></th>
            <td><input type="text" name="gstTotal" id="gstTotal" title="gstTotal" value="${booking.billGeneration.gstTotal}"/></td>
        </tr>
        <tr>
            <th colspan="3"><span>Other Charges</span></th>
            <td colspan="3"><span><input type="text" name="otherCharges" id="otherCharges" onChange="updateTotal()" title="otherCharges" value="${booking.billGeneration.otherCharges}"/></span></td>
        </tr>
        <tr>
            <th colspan="3"><span>Total Amount</span></th>
            <td colspan="3"><input type="text" name="grandTotal" id="grandTotal" title="grandTotal" value="${booking.billGeneration.total}"/></td>
        </tr>
        <tr>
            <th><span>Advance Payment Oyo</span></th>
            <td><span><input type="text" name="oyoAdvance" id="oyoAdvance"  title="oyoAdvance" value="${booking.billGeneration.oyoAdvance}"/></span></td>
            <th><span>Cash At Hotel</span></th>
            <td><span><input type="text" name="cashAdvance" id="cashAdvance"  title="cashAdvance" value="${booking.billGeneration.cashAdvance}"/></span></td>
            <th><span>Advance PayTM</span></th>
            <td><span><input type="text" name="paytmAdvance" id="paytmAdvance"  title="paytmAdvance" value="${booking.billGeneration.paytmAdvance}"/></span></td>
        </tr>
        <tr>
            <th><span>Advance Paid</span></th>
            <td><span><input type="text" name="advPaymentAmt" id="advPaymentAmt" title="advPaymentAmt" value="${advPaymentAmt}" onChange="updateTotal()"/></span></td>
            <th><span>Balance Payment By</span><br></th>
            <td><span><g:select name="balPaymentBy" id="balPaymentBy" from="['Cash','Oyo','GoIbibo','PayTM']" value="${booking.billGeneration.balPaymentBy}"/></span></td>
            <th><span>Balance Payment</span></th>
            <td><span><input type="text" name="balPaymentAmt" id="balPaymentAmt" title="balPaymentAmt"  value="${booking.billGeneration.balPaymentAmt}"/></span></td>
        </tr>
    </table>
    <aside>
        Amount in Words Rupees <input id="amountInWords" name="amountInWords" title="amountInWords" value="${booking.billGeneration.amtInWords}" style="width: 250px"/>

    </aside>
    <input type="hidden" value="${booking.billGeneration.id}" name="billId" >
    </article>
    <g:actionSubmit class="btn btn-fill btn-wd" value="Submit" action="createInvoice"/>
</g:form>
</body>
<script type="application/javascript">
    $( function() {

        $('#invoiceDate').datetimepicker({
            format: 'DD/MMM/YYYY'
        });

        $('#checkInDate').datetimepicker({
            format: 'DD/MMM/YYYY'
        });
        $('#checkInTime').datetimepicker({
            format: 'LT'
        });
        $('#checkOutDate').datetimepicker({
            format: 'DD/MMM/YYYY'
        });
        $('#checkOutTime').datetimepicker({
            format: 'LT'
        });

        var myVal = {
            change_customerName_alert: "required( 'customerName', 'Mandatory to Enter..!!!' ),alphanumeric('customerName','Invalid Name....Re-Enter...!!!'),minLength('customerName',3,'Not Meeting Minimum Length criteria...Re-Enter...!!!')"
            ,
            change_customerEmail_alert: "email('customerEmail','Not a valid Email Id...Re-Enter...!!!'),minLength('customerEmail',6,'Not Meeting Minimum Length criteria...Re-Enter...!!!')"
            ,
            change_customerPhNo_alert: "checkMobileNumber('customerPhNo','Invalid Mobile Number..Re-Enter...!!!')"
            ,
            change_customerGST_alert: "alphanumeric('customerGST','Invalid GST Number!!')"
            ,
            change_noOfRooms_alert: "numeric('noOfRooms','Non Numeric Rate!!')"
            ,
            change_customerAddress_alert: "notEmpty('customerAddress','Invalid address entered....Re-Enter...!!!'),alphaNumericSymbols('customerAddress','Invalid address entered....Re-Enter...!!!')"
        };
        init_validations(myVal);
    });
</script>
</html>
