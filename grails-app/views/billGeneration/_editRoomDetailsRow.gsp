<thead>
<tr>
    <th><span >Room No</span></th>
    <th><span >Room Rate</span></th>
    <th><span >No. Of Persons</span></th>
    <th><span >No. Of Days</span></th>
    <th><span >Tax</span></th>
    <th><span >Tax Rate</span></th>
    <th><span >Total</span></th>
</tr>
</thead>
<tbody>
<g:each in="${booking.billGeneration.roomDetails}" var="room">
    <tr>
        <td><a class="cut">-</a><span ><g:textField name="roomNo" value="${room.roomNo}"></g:textField></span></td>
        <td><span><g:textField name="roomRate" title="roomRate"  value="${room.roomRate}" onChange="updateInvoice()"/></span></td>
        <td><span><g:textField name="noOfPerson" value="${room.noOfPerson}"></g:textField></span></td>
        <td><span><g:textField name="noOfDays" title="noOfDays" onChange="updateInvoice()" value="${room.noOfDays}"/></span></td>
        <td><span><g:textField name="tax" title="tax" value="${room.tax}"/></span></td>
        <td><span><g:textField name="taxRate" title="taxRate" value="${room.taxRate}"/></span></td>
        <td><span><g:textField name="total" title="total" value="${room.total}"/></span></td>
    </tr>
</g:each>
</tbody>