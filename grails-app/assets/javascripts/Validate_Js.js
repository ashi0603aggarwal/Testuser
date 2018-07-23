var fso = new ActiveXObject( "Scripting.FileSystemObject" );
// 2=overwrite, true=create if not exist, 0 = ASCII
varFileObject = fso.OpenTextFile( "Log.txt", 2, true, 0 );
varFileObject.writeline( "ID" + "						" + "State" + "				" + "Timestamp" );
varFileObject.writeline( "--" + "						" + "-----" + "				" + "---------" );


//Global Variables Declared

var count = 0;
var element = {};
var elementId = '';
var elementVal = '';
var confirmPassword = "";
var list_state = '';
var arr = [];


// --------------------------------jQuery Functions-------------------------------
function init_validations( myVar )
{

	jQuery.each( myVar, function( key, value )
			{
				var carry = true;
				count++;
				arr1 = key.split( "_" );
				value2 = value.replace("),","){~}");
				arr2 = value2.split("{~}");
				var obj = { id: arr1[1],
						   effect: arr1[0],
					       funcs: arr2,
					       display: arr1[2]
						  };

				
				if( document.getElementById( obj.id ).title.length == 0 )
				{
					document.getElementById( obj.id ).title = " ";
				}


				/*
				 * DISPLAY THE OBJECT DETAILS
				 * *
                 alert( "id is " + obj.id + "\n" + "effect is " + obj.effect +
                 "\nFunctions called are:" + obj.funcs ); alert( obj.funcs );
				 */

				var temp = "#" + obj.id;
				
				$( temp ).bind( obj.effect, function()
						{
							var arrNew = {};
							$.each( obj.funcs, function( index, value )
									{
										var x = value;
										var z = x + ';';
										var temp = z.replace(");",",");
										var temp1 = "'"+obj.display + "');";
										var temp2 = temp + temp1;
										var ret = eval( temp2 );
										arrNew[index] = ret;

									});
			
							// DISPLAY THE FINAL STATE OF VALIDATION
							// alert("Finally the field is: " +
							// checkAll(arrNew));
							var state = checkAll( arrNew );
							var timestamp = new Date().toString();
							varFileObject.writeline( obj.id + "						" + state + "				" + timestamp );
							keyTemp	= obj.id;
							element[keyTemp] = state;
							if( state )
							{	
								$( temp ).tooltip( "destroy" );
										
							}
				
				
						});
				});
	
}

// returns the final boolean value for a particular field element
function checkAll( arrNew )
{	
	var carry = true;
	$.each( arrNew, function( key, value )
			{
		  		carry = carry && value;
			});
	return carry;
}

// To Display message according to the user
function displayMessage( message, id, display )
{
	switch( display )
	{
	case "alert":   alert( message );
					document.getElementById(id).value="";
			        break;
	case "dialog":  var nw = "#" + id;
					function custom_alert( message, title_msg )
					{
						if ( !title_msg )
						    title_msg = 'Message!!';
						$( "<div></div>" ).html( message ).dialog
							({
								title: title_msg,
							    //resizable: false,
							    modal: false,
							    show : 'fade',
							    hide : 'fade',
							    minHeight: 50, 
							    //width: 250,
							    height : 'auto',
							    width : '300',
							    position:{my: 'left+15 center',at: 'right center',of: $(nw)},
							    buttons: {
							        		"OK": function() 
							        			{
							            			$( this ).dialog( "close" );
							        			}
							    		 }
							});
					 }
					 custom_alert( message );
					 break;
	case "tooltip" : var nw = "#" + id;
					 $(	function()
							 {
						 		$( nw ).tooltip({ content: message 
						 				,position: {of: $( nw ), my: "left+15 center", at: "right center" } 
						 				,hide: {duration:3000}
						 				,relative : true
						 				,collision : "fit" 
						 						}).tooltip( "open" );
						
							 });
					break;
	default		: 	alert( message );	  	
	}
	
}

function submitCheck()
{
	var checkField = new Array();
	var checkSubmit = new Array();
	var countLocal = 0;
	for( var key in element )
	{
		countLocal++;
		checkSubmit.push( element[key] );
	}
	if( count == countLocal )
	{	
		for( var key2 in element )
		{
			if( element[key2] == false )
			{
					checkField.push( key2 );
			}
		}
		if( checkAll( checkSubmit ) )
		{
			return true;
		}
		else
		{	
			alert( "Complete all Fields" );
			return false;
		}
		
	}
	else
	{		alert( "Complete All Fields" );
			return false;
	}

}


function required(id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if ( /^\s+$/.test( elementVal ) || elementVal == null || elementVal.length == 0)
	{
	      //string contains only whitespace
	      	displayMessage( message, id, display );
			return false;
	}
	else
	{
		return true;
	}

}

//Function to check and validate 15 digit length of the input field
function gstinLength( id, message, display )
{
    elementId = document.getElementById( id );
    elementVal = elementId.value;
    if( elementVal.length == 15 )
    {
        return true;
    }
    else
    {
        displayMessage( message, id, display );
        return false;
    }
}


//Function to check and validate maximum length of the input field
function maxLength( id, length, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if( elementVal.length <= length )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}




//Function to validate minimum length of a input field
function minLength( id, length, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if( elementVal.length <= length )
	{
		displayMessage( message, id, display );
		return false;
	}
	else
	{
		return true;
	}
}




//Function to validate input field with user defined range 
function length( id, up_length, lo_length, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if( elementVal.length <= up_length && elementVal.length >= lo_length )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}

}

//Function to validate alphanumeric field
function alphanumeric( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var rexp = /^[ 0-9a-zA-Z]+$/;
	if( rexp.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}



//Function to validate Email
function email( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var pattern = /^[a-zA-Z0-9\-_]+(\.[a-zA-Z0-9\-_]+)*@[a-z0-9]+(\-[a-z0-9]+)*(\.[a-z0-9]+(\-[a-z0-9]+)*)*\.[a-z]{2,4}$/;
	if( pattern.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}

//Function to check password
function checkPassword( id, message, display )   
{   
	elementId = document.getElementById( id );
	elementVal = elementId.value; 
	// atleast one uppercase,one special character and one digit
	var pass =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,20}$/; 
	if( elementVal.match( pass ) )   
	{   
		confirmPassword = elementVal;
		return true;  
	}  
	else  
	{     
		displayMessage( message, id, display );
		return false;  
	}  
}



//Function to match with password entered previously
function matches( id, message, display )
{
	var passwordResponse = checkPassword( 'password', 'Invalid Password,Re-Enter...!!' );
	var lengthResponse = length( 'password', 15, 6, 'Password not fulfilling all Criterias...Re-Enter...!!!' );
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if( passwordResponse && lengthResponse )
	{
		if( elementVal.match( confirmPassword ) )
		{	
			
			confirmPassword = '';
			return true;
		}
		else
		{	
			displayMessage( message, id, display );	
			return false;
		}	
	}
	else
	{
		displayMessage( "Enter Above Password Correctly", id , display );
		return false;
	}
}

// Function to validate Age
function validateAge( id, min_age, max_age, message, display )
{	
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	if( !( isNaN( elementVal ) ) )
	{
		if( elementVal >= min_age && elementVal <= max_age )
		{
			return true;
		}
		else
		{
			displayMessage( message, id, display );
			return false;
		}
	}
	else
	{
		displayMessage( message, id, display );	
		return false;
	}
}

//Function to validate current Date (Example:-5/20/2014,5.20.2014,5-20-2014)
function dateMMDDYYYY( id, message, display )
{
	elementVal = document.getElementById( id ).value;
	// regular expression for mm/dd/yyyy format and m/d/yyyy format
	var date_regex1 = /^(1[0-2]|0?[1-9])\/(3[01]|[12][0-9]|0?[1-9])\/(?:[0-9]{2})?[0-9]{2}$/;
	var date_regex11 = /^(1[0-2]|0?[1-9])\-(3[01]|[12][0-9]|0?[1-9])\-(?:[0-9]{2})?[0-9]{2}$/;
	var date_regex111 = /^(1[0-2]|0?[1-9])\.(3[01]|[12][0-9]|0?[1-9])\.(?:[0-9]{2})?[0-9]{2}$/;
  
	// alert( date );
	var p1 = elementVal.split( '/' );
	var userMonth1 = parseInt( p1[0] );
	var userDay1 = parseInt( p1[1] );
	var userYear1 = parseInt( p1[2] );
	
	
	var p11 = elementVal.split( '-' );
	var userMonth11 = parseInt( p11[0] );
	var userDay11 = parseInt( p11[1] );
	var userYear11 = parseInt( p11[2] );
 
	var p111 = elementVal.split( '.' );
	var userMonth111 = parseInt( p111[0] );
	var userDay111 = parseInt( p111[1] );
	var userYear111 = parseInt( p111[2] );
	

	var today = new Date();
	var currentMonth = parseInt( today.getMonth() );
	var currentDay = parseInt( today.getDate() );
	var currentYear = parseInt( today.getFullYear() );
	
	 if( date_regex1.test( elementVal ) && userMonth1 == ( currentMonth + 1 ) && userDay1 == currentDay && userYear1 == currentYear )
	    {
		 	return true;
		}
	    else if( date_regex11.test( elementVal ) && userMonth11 == ( currentMonth + 1 ) && userDay11 == currentDay && userYear11 == currentYear )
	    {
	    		return true;
	    }
	    
	    else if( date_regex111.test( elementVal ) && userMonth111 == ( currentMonth + 1 ) && userDay111 == currentDay && userYear111 == currentYear )
	    {
	    		return true;
	    }
	    else
	    {
	    	displayMessage( message, id, display );
	    	return false;
	    }
	
}

//Function to validate current Date (Example-20/5/2014,20-5-2014,20.5.2014)
function dateDDMMYYYY( id, message, display )
{
	elementVal = document.getElementById( id ).value;
	
	var date_regex1 = /^(3[01]|[12][0-9]|0?[1-9])\/(1[0-2]|0?[1-9])\/(?:[0-9]{2})?[0-9]{2}$/;
	var date_regex11  = /^(3[01]|[12][0-9]|0?[1-9])\-(1[0-2]|0?[1-9])\-(?:[0-9]{2})?[0-9]{2}$/; 
	var date_regex111 = /^(3[01]|[12][0-9]|0?[1-9])\.(1[0-2]|0?[1-9])\.(?:[0-9]{2})?[0-9]{2}$/;

	var p1 = elementVal.split( '/' );
	var userMonth1 = parseInt( p1[1] );
	var userDay1 = parseInt( p1[0] );
	var userYear1 = parseInt( p1[2] );

	var p11 = elementVal.split( '-' );
	var userMonth11 = parseInt( p11[1] );
	var userDay11 = parseInt( p11[0] );
	var userYear11 = parseInt( p11[2] );

	var p111 = elementVal.split( '.' );
	var userMonth111 = parseInt( p111[1] );
	var userDay111 = parseInt( p111[0] );
	var userYear111 = parseInt( p111[2] );

	var today = new Date();
	var currentMonth = parseInt( today.getMonth() );
	var currentDay = parseInt( today.getDate() );
	var currentYear = parseInt( today.getFullYear() );
	
	 if( date_regex1.test( elementVal ) && userMonth1 == ( currentMonth + 1 ) && userDay1 == currentDay && userYear1 == currentYear )
	    {
	    		return true;
	    }
	    else if( date_regex11.test( elementVal ) && userMonth11 == ( currentMonth + 1 ) && userDay11 == currentDay && userYear11 == currentYear )
	    {
	    		return true;
	    }
	    else if( date_regex111.test( elementVal ) && userMonth111 == ( currentMonth + 1 ) && userDay111 == currentDay && userYear111 == currentYear )
	    {
	    		return true;
	    }
	    else
	    {
	    	displayMessage( message, id, display );
	    	return false;
	    }
	
}

//Function to validate current Date (Example:-20-may-2014,20/May/2014,20.may.2014)
function dateWithMonth( id, message, display )
{
	var elementVal = document.getElementById( id ).value;
	var date_regex3 = /^(3[01]|[12][0-9]|0?[1-9])\/(Jan|jan|JAN|Feb|FEB|feb|MAR|Mar|mar|Apr|APR|apr|May|MAY|may|Jun|JUN|jun|Jul|JUL|jul|Aug|AUG|aug|Sep|SEP|sep|Oct|OCT|oct|Nov|NOV|nov|Dec|DEC|dec)\/(?:[0-9]{2})?[0-9]{2}$/;
	var date_regex33 = /^(3[01]|[12][0-9]|0?[1-9])\-(Jan|jan|JAN|Feb|feb|FEB|Mar|MAR|mar|Apr|APR|apr|May|MAY|may|Jun|JUN|jun|Jul|JUL|jul|Aug|AUG|aug|Sep|sep|SEP|Oct|OCT|oct|Nov|NOV|nov|Dec|DEC|dec)\-(?:[0-9]{2})?[0-9]{2}$/;
	var date_regex333 = /^(3[01]|[12][0-9]|0?[1-9])\.(Jan|jan|JAN|Feb|FEB|feb|Mar|MAR|mar|Apr|APR|apr|May|MAY|may|Jun|JUN|jun|Jul|JUL|jul|Aug|AUG|aug|Sep|sep|SEP|Oct|OCT|oct|Nov|NOV|nov|Dec|DEC|dec)\.(?:[0-9]{2})?[0-9]{2}$/;
  
	var today = new Date();
	var currentMonth=parseInt( today.getMonth() );
	var currentDay=parseInt( today.getDate() );
	var currentYear=parseInt( today.getFullYear() );
	
	
	var p1 = elementVal.split( '/' );
	var p11 = elementVal.split( '-' );
	var p111 = elementVal.split( '.' );
	
	
	if( p1!=elementVal )
	{
	var userDay1 = parseInt( p1[0] );
	var userYear1 = parseInt( p1[2] );
	var userMonth1=p1[1].toUpperCase();
	if( userMonth1 == "JAN")
	{
		userMonth_1 = 1;
	}
	else if( userMonth1 == "FEB" )
	{
		userMonth_1 = 2;
	}
	else if( userMonth1 == "MAR" )
	{
		userMonth_1 = 3;
	}
	else if( userMonth1 == "APR" )
	{
		userMonth_1 = 4;
	}
	else if( userMonth1 == "MAY" )
	{
		userMonth_1 = 5;
	}
	else if( userMonth1 == "JUN" )
	{
		userMonth_1 = 6;
	}
	else if( userMonth1 == "JUL" )
	{
		userMonth_1 = 7;
	}
	else if( userMonth1 == "AUG" )
	{
		userMonth_1 = 8;
	}
	else if( userMonth1 == "SEP" )
	{
		userMonth_1 = 9;
	}
	else if( userMonth1 == "OCT" )
	{
		userMonth_1 = 10;
	}
	else if( userMonth1 == "NOV" )
	{
		userMonth_1 = 11;
	}
	else if( userMonth1 == "DEC" )
	{
		userMonth_1 = 12;
	}
	}
	else if( p11!=elementVal )
	{
		var userDay11 = parseInt( p11[0] );
		var userYear11 = parseInt( p11[2] );	
		var userMonth11 = p11[1].toUpperCase();
		if( userMonth11 == "JAN" )
		{
			userMonth_11 = 1;
		}
		else if( userMonth11 == "FEB" )
		{
			userMonth_11 = 2;
		}
		else if( userMonth11 == "MAR" )
		{
			userMonth_11 = 3;
		}
		else if( userMonth11 == "APR" )
		{
			userMonth_11 = 4;
		}
		else if( userMonth11 == "MAY" )
		{
			userMonth_11 = 5;
		}
		else if( userMonth11 == "JUN" )
		{
			userMonth_11 = 6;
		}
		else if( userMonth11 == "JUL" )
		{
			userMonth_11 = 7;
		}
		else if( userMonth11 == "AUG" )
		{
			userMonth_11 = 8;
		}
		else if( userMonth11 == "SEP" )
		{
			userMonth_11 = 9;
		}
		else if( userMonth11 == "OCT" )
		{
			userMonth_11 = 10;
		}
		else if( userMonth11 == "NOV" )
		{
			userMonth_11 = 11;
		}
		else if( userMonth11 == "DEC" )
		{
			userMonth_11 = 12;
		}
		
	}
	else if( p111!=elementVal )
	{
		var userDay111 = parseInt( p111[0] );
		var userYear111 = parseInt( p111[2] );
		var userMonth111 = p111[1].toUpperCase();
		if( userMonth111 == "JAN" )
		{
			userMonth_111 = 1;
		}
		else if( userMonth111 == "FEB" )
		{
			userMonth_111 = 2;
		}
		else if( userMonth111 == "MAR" )
		{
			userMonth_111 = 3;
		}
		else if( userMonth111 == "APR" )
		{
			userMonth_111 = 4;
		}
		else if( userMonth111 == "MAY" )
		{
			userMonth_111 = 5;
		}
		else if( userMonth111 == "JUN" )
		{
			userMonth_111 = 6;
		}
		else if( userMonth111 == "JUL" )
		{
			userMonth_111 = 7;
		}
		else if( userMonth11 == "AUG" )
		{
			userMonth_111 = 8;
		}
		else if( userMonth111 == "SEP" )
		{
			userMonth_111 = 9;
		}
		else if( userMonth111 == "OCT" )
		{
			userMonth_111 = 10;
		}
		else if( userMonth111 == "NOV" )
		{
			userMonth_111 = 11;
		}
		else if( userMonth111 == "DEC" )
		{
			userMonth_111 = 12;
		}
		
	}
	
	
	if( date_regex3.test( elementVal ) && userMonth_1 == ( currentMonth + 1 ) && userDay1 == currentDay && userYear1 == currentYear )
	  {
	  	  return true;
	  }
	  else if( date_regex33.test( elementVal ) && userMonth_11 == ( currentMonth + 1 ) && userDay11 == currentDay && userYear11 == currentYear )
	  {
		  return true;
	  }
	  
	  else if(date_regex333.test( elementVal ) && userMonth_111 == ( currentMonth + 1 ) && userDay111 == currentDay && userYear111 == currentYear )
	  {
		  return true;
	  }
	  else
	  {
	  	displayMessage( message, id, display );
	  	return false;
	  
	  }
}


//Function to validate date of birth

function isFutureDate( iDate )
{
    var today = new Date().getTime(),
        iDate = iDate.split( "/" );
    var arr = iDate.split("-");
    var months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"];
    var month = months.indexOf(arr[1].toLowerCase());
    var update_idate = arr[0]  + '/' + month + '/' + arr[2];
    alert(iDate);
    idate = new Date( iDate[2], iDate[1] - 1, iDate[0] ).getTime();
    alert(iDate)
    return ( today - iDate ) < 0 ? true : false;
}


function dateOfBirth( id, message, display )
{
	// eg dd/mm/yyyy
	elementId = document.getElementById( id );
	elementVal = elementId.value;  
	var dateReg = /(0[1-9]|[12][0-9]|3[01])[\/.-](0[1-9]|1[012])[\/.-](\d{4})$/; 
	if( dateReg.test( elementVal ) )
	{
		if( !( isFutureDate( elementVal ) ) )
		{
			return true;
		}
		else
		{
	    	displayMessage( message, id, display );	
	        return false;
	    }
  } 
	else
	{
  	displayMessage( message, id, display );	
      return false;
  }
}

//Validation for RadioButton
function checkRadio( name, message, display )
{
	  var radios = document.getElementsByName( name );
	  for ( var i = 0; i < radios.length ; i++ ) 
	  {	
		if ( radios[i].checked ) 
	    {		
	    	return true;       
	    }
	   else
	   	{		
		    return false;
	   	}
	  }
}

//validation for drop down

function checkSelected( id, message, display)
{
	var select = document.getElementById( id );
	if( !isNaN( [select.selectedIndex] ) )
	{
		return true;
	}
	else
	{
		return false;
	}
		
}

//Function to validate that an input field is a number or not
function numeric( id, message, display )
{
	var pattern =/^\d*$/;
	elementVal = document.getElementById( id ).value;
	if( pattern.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}


//Function to validate size of a file 
function checkFileSize( id, size, message, display )
{
	if((Math.round(document.getElementById(id).files[0].size )/(1024*1024))> size)
	{
		displayMessage( message, id, display );
		return false;
	} 
	else
	{
		displayMessage( "File Uploaded", id );
		return true;
	}
}


//Function to validate natural numbers

function isNatural( id, message, display )
{
	var x = document.getElementById(id).value;

	var pattern = /^[0-9]*[1-9]+$|^[1-9]+[0-9]*$/;
	if( pattern.test( x ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return true;
	}
 
}


//Function to validate url
function checkUrl( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var pattern = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
	if ( pattern.test( elementVal ) ) 
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;	
	}
	
}


//Function to validate pin code
function pincode( id, length, message, display )
{	
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	
	if( elementVal.length == length )
	{	
		return true;
		
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
	
}



//Function to validate Credit Card Type
function checkCreditCardType( id, message, display )
{	
	
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var americanExpressCardNo = /^(?:3[47][0-9]{13})$/;  // American Express
															// card numbers
															// start with 34 or
															// 37 and have 15
															// digits.
	var visaCardNo = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;  // All Visa card numbers
														// start with a 4. New
														// cards have 16 digits.
														// Old cards have 13.
	var masterCardNo = /^(?:5[1-5][0-9]{14})$/;   // All MasterCard numbers
													// start with the numbers 51
													// through 55. All have 16
													// digits.
	 if( elementVal.match( americanExpressCardNo ) )  
	 {  
		 message = "American Express Card";  
		 displayMessage( message, id, display );
		 return true;
	 } 
	 else if( elementVal.match( visaCardNo ) )  
	 {  
		 message = "Visa Card";
		 displayMessage( message, id, display );
		 return true;
	 }
	 else if( elementVal.match( masterCardNo ) )
	 {
		 message = "Master Card";
		 displayMessage( message, id, display );
		 return true;
	 }
	 else
	 {	
		 displayMessage( message, id, display );
		 return false;
	 }
} 


//Function to validate IP Address
function ipAddress( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var pattern = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
	if( pattern.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}


//Function to validate Decimal Number

function decimal( id, message, display ) 
{ 
	var x = document.getElementById(id).value;
	var decimal = /^[-+]?[0-9]+\.[0-9]+$/; 
	if( decimal.test(x) ) 
	{ 
		
		return true;
	}
	else
	{ 
		displayMessage( message, id, display ); 
		return false;
	}
}

//Function to validate Mobile Number
function checkMobileNumber( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var pattern = /^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$/i;
	if( pattern.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}


//Function to validate landline numbers

function checkLandline( id, message, display )
{	
	elementId = document.getElementById(id);
	elementVal = elementId.value;
	
	//var reg = /^[0-9]\d{2,4}\d{8}$/; 
	var reg = /^[0-9]\d{2,4}-\d{6,8}$/ ; 
	// eg 0222-8345622 or 09786-567567
	if( reg.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
}




//Right click Disabled

document.onmousedown = disableclick;
status = "Right Click Disabled";
// Function to disable Right click
function disableclick( event )
{
  if( event.button == 2 ) 
   {
     alert( status );
     return false;    
   }
}

//Function to generate Captcha
function drawCaptcha( id1 )
{
    var a = Math.ceil( Math.random() * 10 )+ '';
    var b = Math.ceil( Math.random() * 10 )+ '';       
    var c = Math.ceil( Math.random() * 10 )+ '';  
    var d = Math.ceil( Math.random() * 10 )+ '';  
    var e = Math.ceil( Math.random() * 10 )+ '';  
    var f = Math.ceil( Math.random() * 10 )+ '';  
    var g = Math.ceil( Math.random() * 10 )+ '';  
    var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' '+ f + ' ' + g;
    document.getElementById( id1 ).value = code;
}

function removeSpaces( string )
{
    return string.split( ' ' ).join('');
}

// Function for Captcha Validation
function checkCaptcha( id1, id2, display )
{	
	
	var captchaVal = document.getElementById( id1 ).value ;
	var userVal = document.getElementById( id2 ).value;
	//facing undefined problem in telling true false in the final function array call
    var str1 = removeSpaces( captchaVal );
    var str2 = removeSpaces( userVal );
 
    if ( str1 == str2 )
    {
		displayMessage( "Matched..!!", id2 );
    	return true;        
        	
    }
    else
    {
		drawCaptcha( id1 );
		displayMessage( "Failed to match", id2 );
    	return false;	
    }
}



// White list Validation

function whitelist()
{
	var args = [].join.call( arguments, ':' );
	var list_state = 1;
	arr = args.split( ":" );
	return true;
}

function country(id, message, display)
{	var arr1 = [];
	var flag = 0;
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	arr1 = arr[0].split(",");
	for ( var i = 0; i < arr1.length; i++ ) 
	{
		if( elementVal == arr1[i] )
		{
			flag = 1;
		}
	}
	if( flag == 1)
	{	
		return true;
	}
	else
	{	
		displayMessage( message, id, display );
		return false;
	}
}


//Step Function

function stepInput( id, multiple, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value; 
	var pattern =/^[0-9]+$/;
	var x = parseInt( elementVal );
	if( pattern.test( x ) && x%multiple == 0)
	{
		return true;
 
	}
	else
	{
		displayMessage( message, id, display );	
        return false;
	}
 
}

//Function to check field is empty
function notEmpty( id, message, display ) 
{

	elementId = document.getElementById( id );
	if( elementId.value == '' )
    {
		displayMessage( message, id, display );
        // alert( "Please Write Problem Description" );
        return false;
    }
	else
    {
		return true;
    }
}


function alphaNumericSymbols( id, message, display )
{
	elementId = document.getElementById( id );
	elementVal = elementId.value;
	var re = /^[ A-Za-z0-9.//#&+\-,]*$/;
	if( re.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}

}

//Function to check alphabetic input
function alphabets( id, message, display )
{
	elementVal = document.getElementById( id ).value;
	var pattern = /^[a-zA-Z ]*$/;
	if( pattern.test( elementVal ) )
	{
		return true;
	}
	else
	{
		displayMessage( message, id, display );
		return false;
	}
 
}
