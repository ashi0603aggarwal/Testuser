<!-- Responsive table starts here -->
    <!-- For correct display on small screens you must add 'data-title' to each 'td' in your table -->
<div class="table-responsive-vertical shadow-z-1">
    <!-- Table starts here -->
    <table id="table" class="table table-hover table-mc-light-blue" style="font-size: 15px">
        <thead>
        <tr>
            <th>S.No</th>
            <th>CheckIn Date</th>
            <th>Bill No</th>
            <th>Guest Name</th>
            <th>Total Amount</th>
            <th>Oyo Advance</th>
            <th>Oyo Balance</th>
            <th>Cash Hotel</th>
            <th>Cash Balance</th>
            <th>Bank PayTM</th>
            <th>Balance PayTM</th>
        </tr>
        </thead>
        <tbody>
        <g:set var="totalAmount" value="${0}"/>
        <g:set var="oyoAdvanceTotal" value="${0}"/>
        <g:set var="oyoBalanceTotal" value="${0}"/>
        <g:set var="cashAdvanceTotal" value="${0}"/>
        <g:set var="cashBalanceTotal" value="${0}"/>
        <g:set var="paytmAdvanceTotal" value="${0}"/>
        <g:set var="paytmBalanceTotal" value="${0}"/>
        <g:each in="${booking1}" var="b">
            <tr>
                <td data-title="test.Booking Id">${b.id}</td>
                <td data-title="CheckIn Date"><g:formatDate format="dd/MM/yyyy" date="${b.checkInDate}"/></td>
                <td data-title="Bill No">${b.billGeneration.billNo.toInteger()}</td>
                <td data-title="Name">${b.customerName}</td>
                <td data-title="Total Amount">${b.billGeneration.total}
                    <g:set var="totalAmount" value="${totalAmount + b.billGeneration.total}"/></td>
                <td data-title="Advance Oyo">${b.billGeneration.oyoAdvance}
                    <g:set var="oyoAdvanceTotal" value="${oyoAdvanceTotal + b.billGeneration.oyoAdvance}"/></td>
                <td data-title="Balance Oyo">
                    <g:if test="${b.billGeneration.balPaymentBy == "Oyo"}">${b.billGeneration.balPaymentAmt}
                        <g:set var="oyoBalanceTotal" value="${oyoBalanceTotal + b.billGeneration.balPaymentAmt}"/></g:if>
                    <g:else>-</g:else>
                </td>
                <td data-title="Cash">${b.billGeneration.cashAdvance}
                    <g:set var="cashAdvanceTotal" value="${cashAdvanceTotal + b.billGeneration.cashAdvance}"/></td>
                <td data-title="Balance Cash">
                    <g:if test="${b.billGeneration.balPaymentBy == "Cash"}">${b.billGeneration.balPaymentAmt}
                        <g:set var="cashBalanceTotal" value="${cashBalanceTotal + b.billGeneration.balPaymentAmt}"/></g:if>
                    <g:else>-</g:else>
                </td>
                <td data-title="Bank PayTM">${b.billGeneration.paytmAdvance}
                    <g:set var="paytmAdvanceTotal" value="${paytmAdvanceTotal + b.billGeneration.paytmAdvance}"/></td>
                <td data-title="Balance PayTM">
                    <g:if test="${b.billGeneration.balPaymentBy == "PayTM"}">${b.billGeneration.balPaymentAmt}
                        <g:set var="paytmBalanceTotal" value="${paytmBalanceTotal + b.billGeneration.balPaymentAmt}"/> </g:if>
                    <g:else>-</g:else>
                </td>
            </tr>
        </g:each>

        <tr>
            <th>Total</th>
            <th></th>
            <th></th>
            <th></th>
            <th>${totalAmount}</th>
            <th>${oyoAdvanceTotal}</th>
            <th>${oyoBalanceTotal}</th>
            <th>${cashAdvanceTotal}</th>
            <th>${cashBalanceTotal}</th>
            <th>${paytmAdvanceTotal}</th>
            <th>${paytmBalanceTotal}</th>
        </tr>
        </tbody>
    </table>
</div>

<div class="paginateButtons">
    <util:remotePaginate total="${bookingcount}" update="hotelbookings" action="paginate"  max="2"  params="${params}"/>
</div>