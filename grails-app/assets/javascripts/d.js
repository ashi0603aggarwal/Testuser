/* Shivving (IE8 is not supported, but at least it won't look as awful)
 /* ========================================================================== */

(function (document) {
    var
        head = document.head = document.getElementsByTagName('head')[0] || document.documentElement,
        elements = 'article aside audio bdi canvas data datalist details figcaption figure footer header hgroup mark meter nav output picture progress section summary time video x'.split(' '),
        elementsLength = elements.length,
        elementsIndex = 0,
        element;

    while (elementsIndex < elementsLength) {
        element = document.createElement(elements[++elementsIndex]);
    }

    element.innerHTML = 'x<style>' +
        'article,aside,details,figcaption,figure,footer,header,hgroup,nav,section{display:block}' +
        'audio[controls],canvas,video{display:inline-block}' +
        '[hidden],audio{display:none}' +
        'mark{background:#FF0;color:#000}' +
        '</style>';

    return head.insertBefore(element.lastChild, head.firstChild);
})(document);

/* Prototyping
 /* ========================================================================== */

(function (window, ElementPrototype, ArrayPrototype, polyfill) {
    function NodeList() { [polyfill] }
    NodeList.prototype.length = ArrayPrototype.length;

    ElementPrototype.matchesSelector = ElementPrototype.matchesSelector ||
        ElementPrototype.mozMatchesSelector ||
        ElementPrototype.msMatchesSelector ||
        ElementPrototype.oMatchesSelector ||
        ElementPrototype.webkitMatchesSelector ||
        function matchesSelector(selector) {
            return ArrayPrototype.indexOf.call(this.parentNode.querySelectorAll(selector), this) > -1;
        };

    ElementPrototype.ancestorQuerySelectorAll = ElementPrototype.ancestorQuerySelectorAll ||
        ElementPrototype.mozAncestorQuerySelectorAll ||
        ElementPrototype.msAncestorQuerySelectorAll ||
        ElementPrototype.oAncestorQuerySelectorAll ||
        ElementPrototype.webkitAncestorQuerySelectorAll ||
        function ancestorQuerySelectorAll(selector) {
            for (var cite = this, newNodeList = new NodeList; cite = cite.parentElement;) {
                if (cite.matchesSelector(selector)) ArrayPrototype.push.call(newNodeList, cite);
            }

            return newNodeList;
        };

    ElementPrototype.ancestorQuerySelector = ElementPrototype.ancestorQuerySelector ||
        ElementPrototype.mozAncestorQuerySelector ||
        ElementPrototype.msAncestorQuerySelector ||
        ElementPrototype.oAncestorQuerySelector ||
        ElementPrototype.webkitAncestorQuerySelector ||
        function ancestorQuerySelector(selector) {
            return this.ancestorQuerySelectorAll(selector)[0] || null;
        };
})(this, Element.prototype, Array.prototype);

/* Helper Functions
 /* ========================================================================== */

function generateTableRow() {
    var emptyColumn = document.createElement('tr');
    alert(document.getElementsByName("roomNo").value)

    emptyColumn.innerHTML = '<td><a class="cut">-</a><span data-prefix>Rs.</span><span><input type="text" name="roomRate" title="roomRate" id="roomRate"></span></td>' +
        '<td><span><input type="text" name="noOfRooms" onChange="updateInvoice()" title="noOfRooms"></span></td>' +
        '<td><span><input type="text" name="roomNo" title="roomNo"></span></td>' +
        '<td><span data-prefix>Rs.</span><span><input type="text" name="tax"></span></td>' +
        '<td><span><input type="text" name="noOfDays" title="noOfDays"></span></td>'+
        '<td><span data-prefix>Rs.</span><span><input type="text" name="total"></span></td>';

    return emptyColumn;
}

function parseFloatHTML(element) {
    return parseFloat(element.innerHTML.replace(/[^\d\.\-]+/g, '')) || 0;
}

function updateDays()
{
    var checkout = document.getElementById('checkOut').value;
    var checkin =  document.getElementById('checkIn').value;
    var date1 = GetDate(checkout);
    var date2 = GetDate(checkin);
    var diffDays = Math.floor(( Date.parse(date1) - Date.parse(date2) ) / 86400000);
   //alert(diffDays);
    return diffDays;
}
function GetDate(str)
{

    var arr = str.split('/');
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    var i = 1;
    for (i; i <= months.length; i++) {
        if (months[i] == arr[1])
        {
            break;
        }
    }
    var formatddate = i  + '/' + arr[0] + '/' + arr[2];
    return formatddate;

}

/* Update Invoice
 /* ========================================================================== */

function updateInvoice() {

    var total = 0;
    var totalTax = 0.0;
    var tax = 0.00;
    var noroom = 0;
    var cells, price, sprice, nodays, total, a, i;

    nodays = updateDays();
    // update inventory cells
    // ======================
    for (var a = document.querySelectorAll('table.inventory tbody tr'), i = 0; a[i]; ++i) {
        // get inventory row cells
        cells = a[i].querySelectorAll('span:last-child');
        noroom=1;
        sprice=cells[1].getElementsByTagName("input")[0].value;
        //cells[3].getElementsByTagName("input")[0].value= nodays;
        price = (noroom)*(sprice);

        //alert(price)
        // set price as cell[2] * cell[3]
        //price = parseFloatHTML(cells[1]) * parseFloatHTML(cells[2]);

        //set tax
        var taxRate = 0;
        if(sprice>0 && sprice<1000)
        {
            tax=0;

        }
        else if(sprice>=1000 && sprice<2500)
        {
            taxRate = 12;
            tax=(sprice)-(sprice/(1.12));
            tax=tax*noroom*nodays;
        }
        else if(sprice>=2500 && sprice<5000)
        {
            taxRate = 18
            tax=(sprice)-(sprice/(1.18));
            tax=tax*noroom*nodays;
        }
        else if(sprice>=5000)
        {
            taxRate = 28;
            tax=(sprice)-(sprice/(1.28));
            tax=tax*noroom*nodays;
        }

        cells[5].innerHTML = '<input type="text" name="taxRate" value="'+taxRate+'%'+'">';
        cells[3].innerHTML = '<input type="text" name="noOfDays" value="'+nodays+'">';

        tax=tax.toFixed(3);
        cells[4].innerHTML = '<input type="text" name="tax" value="'+tax+'">';


        // set row total
        price=price*nodays;
        cells[6].innerHTML = '<input type="text" name="total" value="'+price+'" >';

        // add price to total

        total += price;
        totalTax += Number(tax);
    }

    // update balance cells
    // ====================

    // get balance cells
    cells = document.querySelectorAll('table.balance td:last-child span:last-child');
    var other = document.getElementById("otherCharges").value;

    var finalTotal = Number(other) + total;
    // set total
    document.getElementById("grandTotal").value=finalTotal;

    totalTax= totalTax.toFixed(2);
    //cells[1].innerHTML = totalTax
    document.getElementById("gstTotal").value=totalTax;

    var cgst = 0.0;
    var sgst = 0.0;
    cgst = ((totalTax*50)/100).toFixed(3);
    sgst = ((totalTax*50)/100).toFixed(3);
    document.getElementById("cgstTotal").value= cgst;
    document.getElementById("sgstTotal").value= sgst;

    var amount= finalTotal;
    convertNumberToWords(amount);
    function convertNumberToWords(amount) {
        var words = new Array();
        words[0] = '';
        words[1] = 'One';
        words[2] = 'Two';
        words[3] = 'Three';
        words[4] = 'Four';
        words[5] = 'Five';
        words[6] = 'Six';
        words[7] = 'Seven';
        words[8] = 'Eight';
        words[9] = 'Nine';
        words[10] = 'Ten';
        words[11] = 'Eleven';
        words[12] = 'Twelve';
        words[13] = 'Thirteen';
        words[14] = 'Fourteen';
        words[15] = 'Fifteen';
        words[16] = 'Sixteen';
        words[17] = 'Seventeen';
        words[18] = 'Eighteen';
        words[19] = 'Nineteen';
        words[20] = 'Twenty';
        words[30] = 'Thirty';
        words[40] = 'Forty';
        words[50] = 'Fifty';
        words[60] = 'Sixty';
        words[70] = 'Seventy';
        words[80] = 'Eighty';
        words[90] = 'Ninety';
        amount = amount.toString();
        var atemp = amount.split(".");
        var number = atemp[0].split(",").join("");
        var n_length = number.length;
        var words_string = "";
        if (n_length <= 9) {
            var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
            var received_n_array = new Array();
            for (var i = 0; i < n_length; i++) {
                received_n_array[i] = number.substr(i, 1);
            }
            for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
                n_array[i] = received_n_array[j];
            }
            for (var i = 0, j = 1; i < 9; i++, j++) {
                if (i == 0 || i == 2 || i == 4 || i == 7) {
                    if (n_array[i] == 1) {
                        n_array[j] = 10 + parseInt(n_array[j]);
                        n_array[i] = 0;
                    }
                }
            }
            value = "";
            for (var i = 0; i < 9; i++) {
                if (i == 0 || i == 2 || i == 4 || i == 7) {
                    value = n_array[i] * 10;
                } else {
                    value = n_array[i];
                }
                if (value != 0) {
                    words_string += words[value] + " ";
                }
                if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Crores ";
                }
                if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Lakhs ";
                }
                if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Thousand ";
                }
                if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
                    words_string += "Hundred and ";
                } else if (i == 6 && value != 0) {
                    words_string += "Hundred ";
                }
            }
            words_string = words_string.split("  ").join(" ");
        }
        document.getElementById("amountInWords").value=words_string;
        return words_string;

    }

    var advance = document.getElementById("advPaymentAmt").value;
    var balance = finalTotal- Number(advance) ;
    document.getElementById("balPaymentAmt").value = balance;
    if(finalTotal<=999) {
        document.getElementById("billHeading").innerHTML = "Bill Of Supply";
    }
    else
    {
        document.getElementById("billHeading").innerHTML = "Invoice";
    }
    // set balance and meta balance
    //cells[2].innerHTML = document.querySelector('table.meta tr:last-child td:last-child span:last-child').innerHTML = parsePrice(total - parseFloatHTML(cells[1]));

    // update prefix formatting
    // ========================

// var prefix = document.querySelector('#prefix').innerHTML;
// for (a = document.querySelectorAll('[data-prefix]'), i = 0; a[i]; ++i) a[i].innerHTML = prefix;

    // update price formatting
    // =======================

// for (a = document.querySelectorAll('span[data-prefix] + span'), i = 0; a[i]; ++i) if (document.activeElement != a[i]) a[i].innerHTML = parsePrice(parseFloatHTML(a[i]));
}


/* Update Other Charges to Total
 /* ========================================================================== */

function updateTotal() {
    // update balance cells
    // ====================


    var cells;


    // get balance cells
    // cells = document.querySelectorAll('table.balance td:last-child span:last-child');

    //other = cells[0].getElementsByTagName("input")[0].value;
    var other = document.getElementById("otherCharges").value;
    var e = document.getElementById("total")


    //add other charges to total
    e.innerText = e.innerText + other;


    // set total
    //cells[1].innerHTML = total;

}

/* On Content Load
 /* ========================================================================== */

function onContentLoad() {

    //updateInvoice();

    var
        input = document.querySelector('input'),
        image = document.querySelector('img');

    function onClick(e) {

        if (e.target.matchesSelector('.add')) {
            document.querySelector('table.inventory tbody').appendChild(generateTableRow());
        }
        else if (e.target.className == 'cut') {
            row = e.target.ancestorQuerySelector('tr');

            row.parentNode.removeChild(row);
        }

        updateInvoice();
    }

    function onEnterCancel(e) {
        e.preventDefault();

        image.classList.add('hover');
    }

    function onLeaveCancel(e) {
        e.preventDefault();

        image.classList.remove('hover');
    }

    function onFileInput(e) {
        image.classList.remove('hover');

        var
            reader = new FileReader(),
            files = e.dataTransfer ? e.dataTransfer.files : e.target.files,
            i = 0;

        reader.onload = onFileLoad;

        while (files[i]) reader.readAsDataURL(files[i++]);
    }

    function onFileLoad(e) {
        var data = e.target.result;

        image.src = data;
    }

    if (window.addEventListener) {
        document.addEventListener('click', onClick);

//    alert("hi")

        //document.addEventListener('mousewheel', updateNumber);
        //document.addEventListener('keydown', updateNumber);

        document.addEventListener('keydown', updateInvoice);
        document.addEventListener('keyup', updateInvoice);
        document.addEventListener('paste', updateInvoice);
        document.addEventListener('input', updateInvoice);

        input.addEventListener('focus', onEnterCancel);
        input.addEventListener('mouseover', onEnterCancel);
        input.addEventListener('dragover', onEnterCancel);
        input.addEventListener('dragenter', onEnterCancel);

        input.addEventListener('blur', onLeaveCancel);
        input.addEventListener('dragleave', onLeaveCancel);
        input.addEventListener('mouseout', onLeaveCancel);

        input.addEventListener('drop', onFileInput);
        input.addEventListener('change', onFileInput);
    }
}

window.addEventListener && document.addEventListener('DOMContentLoaded', onContentLoad);