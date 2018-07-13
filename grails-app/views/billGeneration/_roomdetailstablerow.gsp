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
<g:each in="${booking.roomsBooked}" var="roomNo">
<tr>
    <td><a class="cut">-</a><span><g:textField name="roomNo" title="roomNo" value="${roomNo}"/></span></td>
    <td><span><g:textField name="roomRate" title="roomRate"  onChange="updateInvoice()" /></span></td>
    <td><span><g:textField name="noOfPerson" /></span></td>
    <td><span><g:textField name="noOfDays" title="noOfDays" onChange="updateInvoice()" value="${noOfDays}"/></span></td>
    <td><span><g:textField name="tax" title="tax"/></span></td>
    <td><span><g:textField name="taxRate" title="taxRate"/></span></td>
    <td><span><g:textField name="total" title="total"/></span></td>
</tr>
</g:each>
</tbody>
