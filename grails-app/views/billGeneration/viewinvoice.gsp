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
    <asset:stylesheet src="print.css"></asset:stylesheet>
    <asset:stylesheet src="Booking/book.css"></asset:stylesheet>
    <asset:javascript src="Validate_Js.js"></asset:javascript>
    <link rel="license" href="https://www.opensource.org/licenses/mit-license/">
</head>
<body class="bg-view">
<h3 align="right"><a href="/default/dash" class="btn btn-lg" role="button">Dashboard</a></h3>
    <header>
        <g:if test="${booking?.billGeneration?.total>999}">
            <g:if test="${booking?.billGeneration?.gstTotal>0}">
                <h2 id="billHeading">Tax Invoice</h2>
            </g:if>
            <g:else>
                <h2 id="billHeading">Bill Of Supply</h2>
            </g:else>
        </g:if>
        <g:else>
            <h2 id="billHeading">Bill Of Supply</h2>
        </g:else>
        <address>
            <p style="font-weight: bold; font-size: 18px" >${hr.hotelName}</p>
            <p>Address: ${hr.address}</p>
            <p>Ph No: ${hotelDetails.phoneNo}</p>
            <p>GST No: ${hr.gstin}</p>
            <p>License No: ${hr.hotelLicenceNo}</p>
            <p>Food License No: ${hr.foodLicenceNo}</p>
        </address>
        <span style="width: 38%; height: 18%"><img alt="" src="data:image/png;base64,${hotelDetails.logo.encodeBase64()}"></span>
    </header>
    <article>
        <div class="row">
            <table class="col-lg-12">
                <tr>
                    <th width="14%"><span>Guest Name</span></th>
                    <td width="82%"><span>${booking.customerName}</span></td>
                </tr>
            </table>
            <div class="col-md-7" style="padding-right: 0;">
            <table class="">
                <tr>
                    <th width="25%"><span>Address</span></th>
                    <td width="75%"><span>${booking.customerAddress}</span></td>
                </tr>
                <tr>
                    <th><span>Phone No</span></th>
                    <td><span >${booking.customerPhNo}</span></td>
                </tr>
                <tr>
                    <th><span>GST</span></th>
                    <td><span >${booking?.billGeneration?.customerGst}</span></td>
                </tr>
                <tr>
                    <th><span>Others</span></th>
                    <td><span></span></td>
                </tr>
            </table>
            </div>
            <div class="col-md-4" style="width: 37%">
                <table class="">
                    <tr>
                        <th><span>Invoice No</span></th>
                        <td colspan="3"><span>${booking.billGeneration.billNo}</span></td>
                    </tr>
                    <tr>
                        <th><span>Invoice Date</span></th>
                        <td colspan="3"><span><g:formatDate format="dd/MM/yyyy" date="${booking.billGeneration.invoiceDate}"></g:formatDate></span></td>
                    </tr>
                    <tr>
                        <th><span>Check In Date</span></th>
                        <td>
                            <span><g:formatDate format="dd/MM/yyyy" date="${booking.checkInDate}"></g:formatDate></span>
                        </td>
                        <th><span>Time</span></th>
                        <td>
                            <span><g:formatDate format="HH:mm aa" date="${booking.checkInTime}"/></span>
                        </td>
                    </tr>
                    <tr>
                        <th><span>Check Out Date</span></th>
                        <td><span><g:formatDate format="dd/MM/yyyy" date="${booking.checkOutDate}"></g:formatDate></span></td>
                        <th><span> Time</span></th>
                        <td><span><g:formatDate format="HH:mm aa" date="${booking.checkOutTime}"/></span></td>
                    </tr>
                </table>
            </div>
        </div>
        <table class="inventory" style="padding-bottom: 0">
            <thead>
            <tr>
                <th width="9% !important"><span >Room No</span></th>
                <th width="13% !important"><span >No. Of Guest</span></th>
                <th width="12% !important"><span >No. Of Days</span></th>
                <th width="19% !important"><span >Room Rate (with Tax)</span></th>
                <th width="7% !important"><span >Tax @</span></th>
                <th width="20% !important"><span >Tax</span></th>
                <th width="20% !important"><span >Total</span></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${booking.billGeneration.roomDetails}" var="room">
                <tr>
                    <td width><a class="cut">-</a><span >${room.roomNo}</span></td>
                    <td><span>${room.noOfPerson}</span></td>
                    <td><span>${room.noOfDays}</span></td>
                    <td><span data-prefix>Rs </span><span>${room.roomRate}</span></td>
                    <td><span >${room.taxRate}</span></td>
                    <td><span data-prefix>Rs </span><span >${room.tax}</span></td>
                    <td><span data-prefix>Rs </span><span>${room.total}</span></td>
                </tr>
            </g:each>
            </tbody>
            <table class="" style="padding-top: 0; padding-left: 0">
                <tr>
                    <th colspan="1"><span>Total Rooms</span></th>
                    <td colspan="1"><span>${tRoom}</span></td>
                    <th colspan="2"><span>Other Extra Charges</span></th>
                    <td colspan="2"><span></span>RS. <span>${booking.billGeneration.otherCharges}</span></td>
                </tr>
                <tr>
                    <th colspan="1"><span>Amount in Words</span></th>
                    <td colspan="5"><span>Rupees ${booking.billGeneration.amtInWords} Only.</span></td>
                </tr>
            </table>
        </table>
        <table class="balance" style="width: 38%; padding-top: 0">
            <table class="balance">
                <tr>
                    <th><span>SGST</span></th>
                    <td>${booking.billGeneration.sgst}</td>
                    <th><span>CGST</span></th>
                    <td>${booking.billGeneration.cgst}</td>
                    <th><span>Total GST</span></th>
                    <td>${booking.billGeneration.gstTotal}</td>
                </tr>

                <tr>
                    <th colspan="3"><span>Total Amount</span></th>
                    <td colspan="3"><span>${booking.billGeneration.total}</span></td>
                </tr>
                <tr>
                    <th><span>Advance Payment Oyo</span></th>
                    <td><span>${booking.billGeneration.oyoAdvance}</span></td>
                    <th><span>Cash At Hotel</span></th>
                    <td><span>${booking.billGeneration.cashAdvance}</span></td>
                    <th><span>Advance PayTM</span></th>
                    <td><span>${booking.billGeneration.paytmAdvance}</span></td>
                </tr>
                <tr>
                    <th><span>Advance Paid</span></th>
                    <td><span>${advPaymentAmt}</span></td>
                    <th><span>Balance Payment By</span><br></th>
                    <td><span>${booking.billGeneration.balPaymentBy}</span></td>
                    <th><span>Balance Payment</span></th>
                    <td><span>${booking.billGeneration.balPaymentAmt}</span></td>
                </tr>
    </table>
<br><br>
        <aside>
                <p style="font-size: smaller">Terms & Conditions<br>
                    1. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br>
                    2. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br>
                    3. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br>
                    4. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br>
                    5. A finance charge of 1.5% will be made on unpaid balances after 30 days.
                </p>
        </aside>
        <br><br><br><br>
        <p style="float: right">Authorised Signatory</p>
    </article>

</body>
</html>

