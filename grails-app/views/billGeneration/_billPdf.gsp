<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<link rel="stylesheet" href="http://localhost:8080/assets/maxcdn.css?compile=false"  />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
   %{-- <g:render template="css"></g:render>--}%
    <style type="text/css">
    /* reset */
    * {
        border: 0;
        box-sizing: content-box;
        color: inherit;
        font-family: "Arial";
        font-size: 9px;
        font-style: inherit;
        font-weight: bolder;
        line-height: inherit;
        list-style: none;
        margin: 0;
        padding: 0;
        text-decoration: none;
        text-transform: uppercase;
    }
    /* content editable */
    *[contenteditable] { border-radius: 0.25em; min-width: 1em; outline: 0; }
    *[contenteditable] { cursor: pointer; }
    *[contenteditable]:hover, *[contenteditable]:focus, td:hover *[contenteditable], td:focus *[contenteditable], img.hover { background: #DEF; box-shadow: 0 0 1em 0.5em #DEF; }
    span[contenteditable] { display: inline-block; }

    /* heading */
    h2 { font: bold 100% sans-serif; letter-spacing:1em; text-align: center; text-transform: uppercase; }
    /* table */

    table { font-size: 30%; table-layout: inherit; width: 100%; }
    table {border-collapse: separate;  border-spacing: 0px;}
    th, td { border-width: 0.5px; padding: 0.5em; position: relative; text-align: left; }
    th, td { border-radius: 0.25em; border-style: solid; }
    th { background: #EEE; border-color: black; }
    td { border-color: black; }
    tr th span { font-weight: bold; font-size: 10px; !important;}

    /* page */

    html { font: 16px/1 'Open Sans', sans-serif; overflow: auto; padding: 0.5in; }
    html { background: #999; cursor: default; }

    body { box-sizing: border-box; height: 11in; margin: 0 auto; overflow: hidden; padding: 0.5in; width: 8.5in; }
    body { background: #FFF; border-radius: 1px; box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5); }

    header h2 { background: #000; border-radius: 0.25em; color: #FFF; margin: 0 0 0.2em; padding: 0em 0; font-size: 2em}
    address {  text-transform: uppercase; float: left; font-size: 100%; font-style: normal; line-height: 1;  margin: 0em 20em 0em 0em; font-family: Arial; width: 50%}
    header address p { margin: 0 0 0.25em; font-size: 11.5px }
    header span { display: block; float: right; }
    header img { display: block; float: left; }
    header span { margin: 0 0 0em 0em; max-height: 25%; max-width: 60%; position: relative; }
    header img { max-height: 100%; max-width: 100%; }
    header input { cursor: pointer; -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; height: 100%; left: 0; opacity: 0; position: absolute; top: 0; width: 100%; }

    .bg-print{
        height: 100%;
        background-color: #FFFFFF;
        width: 90%;
        line-height: 1em;
        padding-top: 5px;
      }

    .sub-bill1{
        position: fixed;
        padding-top:1%;
        height: 50%;
        width: 88%;
        left: 6%
    }
    .sub-bill2{
        position: fixed;
        padding-top: 62%;
        height: 50%;
        width: 88%;
        left:6%
    }

    article, article address, table.meta, table.inventory { margin: 0 0 0.5em; }
    article h1 { clip: rect(0 0 0 0); position: absolute; }

    article address { float: left; font-size: 125%; font-weight: bold; }
    article span img { height:15%; width:15%; padding-top: 0%; padding-right: 10%; }
    /* table meta  balance */

    table.balance {float:right;  width: 37%; }

    /* table meta */
    table.meta th { width: 40%; }
    table.meta td { width: 60%; }
    
    /* table items */

    table.inventory { clear: both; width:100%; }
    table.inventory th { font-weight: bold; text-align: left}
    table.inventory td:nth-child(1) {  }
    table.inventory td:nth-child(2) {  }
    table.inventory td:nth-child(3) { text-align: left}
    table.inventory td:nth-child(4) { text-align: left}
    table.inventory td:nth-child(5) { text-align: left}
    table.inventory td:nth-child(6) { text-align: left}

    /* table balance */

    table.balance th, table.balance td { width: inherit; }
    table.balance td { text-align: right; }

    /* aside */

    aside { font-size: 11px; line-height: 0.9em; }
    aside h2 { border: none; border-width: 0 0 1px; margin: 0 0 1em;}
    aside h2 { border-color: #999; border-bottom-style: solid; }
    address { float: left; font-size: 125%; font-weight: bold; }

    @media print {
        * { -webkit-print-color-adjust: exact; }
        html { background: none; padding: 0; }
        body { box-shadow: none; margin: 0; }
        span:empty { display: none; }
        .add, .cut { display: none; }
    }

    @page { margin: 0; }
    </style>

</head>
<body class="bg-print">
<div class="sub-bill1">
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
            <p style="font-weight: bold; font-size: 30px; padding-top: inherit">${hr.hotelName}</p>
            <p>Address: ${hr.address}</p>
            <p>Phone No: 9890989000</p>
            <p>GST No: ${hr.gstin}</p>
            <p>License No: ${hr.hotelLicenceNo}, Food License No: ${hr.foodLicenceNo}</p>
        </address>
    </header>
    <article>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <span><img alt="logo" src="data:image/png;base64,${hotelDetails.logo.encodeBase64()}"/></span>
        <div style="padding-right: 0; padding-top: 2px;" >
            <table>
                <tr>
                    <th width="14%"><span>Guest Name</span></th>
                    <td width="86%" colspan="5"><span>${booking.customerName}</span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Address</span></th>
                    <td width="46%"><span>${booking.customerAddress}</span></td>
                    <th width="14%"><span>Invoice No</span></th>
                    <td colspan="3" width="20%"><span>${booking.billGeneration.billNo}</span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Phone No</span></th>
                    <td width="46%"><span >${booking.customerPhNo}</span></td>
                    <th width="14%"><span>Invoice Date</span></th>
                    <td colspan="3" width="20%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.billGeneration.invoiceDate}"></g:formatDate></span></td>
                </tr>
                <tr>
                    <th width="14%"><span>GST</span></th>
                    <td width="46%"><span >${booking?.billGeneration?.customerGst}</span></td>
                    <th width="14%"><span>Check In Date</span></th>
                    <td width="8%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.checkInDate}"></g:formatDate></span></td>
                    <th width="4%"><span>Time</span></th>
                    <td width="8%"><span><g:formatDate format="HH:mm aa" date="${booking.checkInTime}"/></span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Others</span></th>
                    <td width="46%"><span></span></td>
                    <th width="14%"><span>Check Out Date</span></th>
                    <td width="8%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.checkOutDate}"></g:formatDate></span></td>
                    <th width="4%"><span> Time</span></th>
                    <td width="8%"><span><g:formatDate format="HH:mm aa" date="${booking.checkOutTime}"/></span></td>
                </tr>
            </table>
                </div>
            <table class="inventory" style="padding-bottom: 0px;">
                <thead>
                <tr>
                    <th width="10% !important"><span >Room No</span></th>
                    <th width="12% !important"><span >No. Of Guest</span></th>
                    <th width="12% !important"><span >No. Of Days</span></th>
                    <th width="19% !important"><span >Room Rate(with Tax)</span></th>
                    <th width="10% !important"><span >Tax @</span></th>
                    <th width="15% !important"><span >Tax</span></th>
                    <th width="26% !important"><span >Total</span></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${booking.billGeneration.roomDetails}" var="room">
                    <tr>
                        <td><span>${room.roomNo}</span></td>
                        <td><span>${room.noOfPerson}</span></td>
                        <td><span>${room.noOfDays}</span></td>
                        <td><span >Rs </span><span>${room.roomRate}</span></td>
                        <td><span >${room.taxRate}</span></td>
                        <td><span >Rs </span><span >${room.tax}</span></td>
                        <td><span >Rs </span><span>${room.total}</span></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
                <table class="" style=" padding-top: 0px;">
                    <tr>
                        <th colspan="1" style="width: 10%"><span>Rooms</span></th>
                        <td colspan="1" style="width: 12%"><span>${tRoom}</span></td>
                        <th colspan="1" style="width: 12%"><span>Total Days</span></th>
                        <td colspan="1" style="width: 19%"><span>${booking.billGeneration.roomDetails.noOfDays[0]}</span></td>
                        <th colspan="2" style="width: 25%"><span>Other Extra Charges</span></th>
                        <td colspan="1" style="width: 27%"><span></span>RS. <span>${booking.billGeneration.otherCharges}</span></td>
                    </tr>
                    <tr>
                        <th colspan="2"><span>Amount in Words</span></th>
                        <td colspan="6"><span>Rupees ${booking.billGeneration.amtInWords} Only</span></td>
                    </tr>
                </table>
        <div style="position:fixed; left:6%; bottom: 532px; width: 100%;">
            <table class="balance" style="padding-top: 0px">
                <tr>
                    <th><span>SGST</span></th>
                    <td><span>Rs ${booking.billGeneration.sgst}</span></td>
                    <th><span>Total Excl.</span></th>
                    <td><span>Rs ${total}</span></td>
                </tr>
                <tr>
                    <th><span>CGST</span></th>
                    <td><span>Rs ${booking.billGeneration.cgst}</span></td>
                    <th><span>Total Tax</span></th>
                    <td><span >Rs. </span><span>${booking.billGeneration.gstTotal}</span></td>
                </tr>
                <tr>
                    <th><span>Total</span></th>
                    <td><span>Rs ${booking.billGeneration.gstTotal}</span></td>
                    <th ><span>Total</span></th>
                    <td><span >Rs </span><span>${booking.billGeneration.total}</span></td>
                </tr>
            </table>
            <aside>
                <p style="font-size: 9px">Terms and Conditions</p> <p style="font-size: smaller">
                    1. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                    2. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                    3. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                    4. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                    5. A finance charge of 1.5% will be made on unpaid balances after 30 days.
                </p>
            </aside>
            <p style="float: right; padding-left: 80%; font-size: 9px;">FOR ${hr.hotelName}
                <br></br><br></br><br></br><br></br>
                Authorised Signatory</p>
        </div>
    </article>
</div><br></br><br></br>
<div class="sub-bill2">
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    <br></br>
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
            <p style="font-weight: bold; font-size: 30px; padding-top: inherit" >${hr.hotelName}</p>
            <p>Address: ${hr.address}</p>
            <p>Phone No: 9890989000</p>
            <p>GST No: ${hr.gstin}</p>
            <p>License No: ${hr.hotelLicenceNo}, Food License No: ${hr.foodLicenceNo}</p>
        </address>
    </header>
    <article>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <span><img alt="logo" src="data:image/png;base64,${hotelDetails.logo.encodeBase64()}"/></span>
        <div  style="padding-right: 0;padding-top: 2px;">
            <table>
                <tr>
                    <th width="14%"><span>Guest Name</span></th>
                    <td width="86%" colspan="5"><span>${booking.customerName}</span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Address</span></th>
                    <td width="46%"><span>${booking.customerAddress}</span></td>
                    <th width="14%"><span>Invoice No</span></th>
                    <td colspan="3" width="20%"><span>${booking.billGeneration.billNo}</span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Phone No</span></th>
                    <td width="46%"><span >${booking.customerPhNo}</span></td>
                    <th width="14%"><span>Invoice Date</span></th>
                    <td colspan="3" width="20%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.billGeneration.invoiceDate}"></g:formatDate></span></td>
                </tr>
                <tr>
                    <th width="14%"><span>GST</span></th>
                    <td width="46%"><span >${booking?.billGeneration?.customerGst}</span></td>
                    <th width="14%"><span>Check In Date</span></th>
                    <td width="8%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.checkInDate}"></g:formatDate></span></td>
                    <th width="4%"><span>Time</span></th>
                    <td width="8%"><span><g:formatDate format="HH:mm aa" date="${booking.checkInTime}"/></span></td>
                </tr>
                <tr>
                    <th width="14%"><span>Others</span></th>
                    <td width="46%"><span></span></td>
                    <th width="14%"><span>Check Out Date</span></th>
                    <td width="8%"><span><g:formatDate format="dd/MM/yyyy" date="${booking.checkOutDate}"></g:formatDate></span></td>
                    <th width="4%"><span> Time</span></th>
                    <td width="8%"><span><g:formatDate format="HH:mm aa" date="${booking.checkOutTime}"/></span></td>
                </tr>
            </table>
        </div>
        <table class="inventory" style="padding-bottom: 0px">
            <thead>
            <tr>
                <th width="10% !important"><span >Room No</span></th>
                <th width="12% !important"><span >No. Of Guest</span></th>
                <th width="12% !important"><span >No. Of Days</span></th>
                <th width="19% !important"><span >Room Rate(with Tax)</span></th>
                <th width="10% !important"><span >Tax @</span></th>
                <th width="15% !important"><span >Tax</span></th>
                <th width="26% !important"><span >Total</span></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${booking.billGeneration.roomDetails}" var="room">
                <tr>
                    <td><span>${room.roomNo}</span></td>
                    <td><span>${room.noOfPerson}</span></td>
                    <td><span>${room.noOfDays}</span></td>
                    <td><span >Rs </span><span>${room.roomRate}</span></td>
                    <td><span >${room.taxRate}</span></td>
                    <td><span >Rs </span><span >${room.tax}</span></td>
                    <td><span >Rs </span><span>${room.total}</span></td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <table class="" style="padding-top: 0; padding-left: 0">
            <tr>
                <th colspan="1" style="width: 10%"><span>Rooms</span></th>
                <td colspan="1" style="width: 12%"><span>${tRoom}</span></td>
                <th colspan="1" style="width: 12%"><span>Total Days</span></th>
                <td colspan="1" style="width: 19%"><span>${booking.billGeneration.roomDetails.noOfDays[0]}</span></td>
                <th colspan="2" style="width: 25%"><span>Other Extra Charges</span></th>
                <td colspan="1" style="width: 27%"><span></span>RS. <span>${booking.billGeneration.otherCharges}</span></td>
            </tr>
            <tr>
                <th colspan="2"><span>Amount in Words</span></th>
                <td colspan="6"><span>Rupees ${booking.billGeneration.amtInWords} Only</span></td>
            </tr>
        </table>
        <div style="position:fixed; left:6%; bottom:2px; width:100%;">
            <table class="balance" style="padding-top: 0px;">
                <tr>
                    <th><span>SGST</span></th>
                    <td><span>Rs ${booking.billGeneration.sgst}</span></td>
                    <th><span>Total Excl.</span></th>
                    <td><span>Rs ${total}</span></td>
                </tr>
                <tr>
                    <th><span>CGST</span></th>
                    <td><span>Rs ${booking.billGeneration.cgst}</span></td>
                    <th><span>Total Tax</span></th>
                    <td><span >Rs. </span><span>${booking.billGeneration.gstTotal}</span></td>
                </tr>
                <tr>
                    <th><span>Total</span></th>
                    <td><span>Rs ${booking.billGeneration.gstTotal}</span></td>
                    <th ><span>Total</span></th>
                    <td><span >Rs </span><span>${booking.billGeneration.total}</span></td>
                </tr>
            </table>
            <aside>
                <p style="font-size: 9px">Terms and Conditions</p> <p style="font-size: smaller">
                1. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                2. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                3. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                4. A finance charge of 1.5% will be made on unpaid balances after 30 days.<br> </br>
                5. A finance charge of 1.5% will be made on unpaid balances after 30 days.
            </p>
            </aside>
            <p style="float: right; padding-left: 80%; font-size: 9px;">FOR ${hr.hotelName}
                <br></br><br></br><br></br><br></br>
                Authorised Signatory</p>
        </div>
    </article>
</div>
</body>
</html>