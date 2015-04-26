<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="WebApplication4_0.Request" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
 
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.24.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="Content/PopupBlur.css">
    <style>

     #requestContainer
       {
            margin-top:50px;
            margin-bottom:5px;
            width:100%;
            height:500px;
            border-radius:10px;
            /*background-color:#FFF;*/
            background-color: #3e454d;
            float:left;

            
        }
        
     #modDetails
        {
            margin-left:2.5%;
            width:95%;
            height:90%;
            table-layout:fixed;
            text-align:center;
            color:#3E454D;

        }

 
     .preferenceTable{
            margin-left:2.5%;
            width:95%;
            height:90%;
            table-layout:fixed;
            text-align:center;
            color:#3E454D;
     }

 
input[type="text"]{
	padding: 9px;
	width: 90%;
	font-size: 1.1em;
	margin: 18px 0px;
	border: 2px solid#EAEEF1;
	color: #666666;
	background:#EAEEF1;
	font-family: 'Open Sans', sans-serif;
	font-weight:600;
	margin-left: 5px;
	outline:none;
	-webkit-transition: all 0.3s ease-out;
	-moz-transition: all 0.3s ease-out;
	-ms-transition: all 0.3s ease-out;
	-o-transition: all 0.3s ease-out;
	transition: all 0.3s ease-out;
}

input[type="text"]:hover, #active
{
	background:#fff;
	border:2px solid #609EC3;
	outline:none;
}


textarea{
	padding: 9px;
	width: 90%;
	font-size: 1.1em;
	margin: 18px 0px;
	border: 2px solid#EAEEF1;
	color: #666666;
	background:#EAEEF1;
	font-family: 'Open Sans', sans-serif;
	font-weight:600;
	margin-left: 5px;
	outline:none;
	-webkit-transition: all 0.3s ease-out;
	-moz-transition: all 0.3s ease-out;
	-ms-transition: all 0.3s ease-out;
	-o-transition: all 0.3s ease-out;
	transition: all 0.3s ease-out;
}

textarea:hover, #active
{
	background:#fff;
	border:2px solid #609EC3;
	outline:none;
}

/*
    orange
input[type="text"]{
	padding: 9px;
	width: 90%;
	font-size: 1.1em;
	margin: 18px 0px;
	border-bottom: 4px solid #ff8060;
    border-top: 4px solid #ff8060;
	color: #666666;
	background:white;
	font-family: 'Open Sans', sans-serif;
	font-weight:600;
	margin-left: 5px;
	outline:none;
	-webkit-transition: all 0.3s ease-out;
	-moz-transition: all 0.3s ease-out;
	-ms-transition: all 0.3s ease-out;
	-o-transition: all 0.3s ease-out;
	transition: all 0.3s ease-out;
}

input[type="text"]:hover, #active, input[type="text"]:focus
{
	background:#fff;
	border-bottom:4px solid #609EC3;
    border-top:4px solid #609EC3;

	outline:none;
}

    */
.line{
    background: #3E454D;
    float:left;
    width:103%;
    height:1px;
}

   

.divClass {
	clear: both;
	margin: 0;
    width: 140px;
}

.divClass label {
  width: 140px;
  border-radius: 3px;
  border: 1px solid #D1D3D4
}

/* hide input */
.divClass input.radio:empty {
	margin-left: -999px;
    display: none;
}

/* style label */
.divClass input.radio:empty ~ label {
	position: relative;
	float: left;
	line-height: 2.5em;
	text-indent: 3.25em;
	margin-top: 2em;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
    font-family:"Segoe UI",Verdana,Helvetica,sans-serif;
    font-size:0.85em; /* sets size of the actual label */
}

.divClass input.radio:empty ~ label:before {
	position: absolute;
	display: block;
	top: 0;
	bottom: 0;
	left: 0;
	content: '';
	width: 2.5em;
	background: #D1D3D4;
	border-radius: 3px 0 0 3px;
}

/* toggle hover */
.divClass input.radio:hover:not(:checked) ~ label:before {
	/*content:'\03a7';*/
    content: '\2713';
	text-indent: .2em;
	/*color: #C2C2C2;*/
    color:#fff;
}

.divClass input.radio:hover:not(:checked) ~ label {
	color: #888;
}

/* toggle on */
.divClass input.radio:checked ~ label:before {
	/*content:'\03a7';  X*/
    content: '\2713';
	text-indent: .2em;
	color: white;
	background-color: #4DCB6D;
}

.divClass input.radio:checked ~ label {
	color: #777;
}

/* radio focus */
.divClass input.radio:focus ~ label:before {
	box-shadow: 0 0 0 3px #999;
}

/* checbox styling same as for radio button, but different colour */

.divClassCheckbox {
	clear: both;
	margin: 0;
    width: 140px;
}

.divClassCheckbox label {
  width: 140px;
  border-radius: 3px;
  border: 1px solid #D1D3D4
}

/* hide input */
.divClassCheckbox input.radio:empty {
	margin-left: -999px;
    display: none;
}

/* style label */
.divClassCheckbox input.radio:empty ~ label {
	position: relative;
	float: left;
	line-height: 2.5em;
	text-indent: 3.25em;
	margin-top: 2em;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
    font-family:"Segoe UI",Verdana,Helvetica,sans-serif;
    font-size:0.85em; /* sets size of the actual label */
}

.divClassCheckbox input.radio:empty ~ label:before {
	position: absolute;
	display: block;
	top: 0;
	bottom: 0;
	left: 0;
	content: '';
	width: 2.5em;
	background: #D1D3D4;
	border-radius: 3px 0 0 3px;
}

/* toggle hover */
.divClassCheckbox input.radio:hover:not(:checked) ~ label:before {
	/*content:'\03a7';*/
    content: '\2713';
	text-indent: .2em;
	/*color: #C2C2C2;*/
    color:#fff;
}

.divClassCheckbox input.radio:hover:not(:checked) ~ label {
	color: #888;
}

/* toggle on */
.divClassCheckbox input.radio:checked ~ label:before {
	/*content:'\03a7';  X*/
    content: '\2713';
	text-indent: .2em;
	color: white; /*color of tick when checked*/
	background-color: #86b4cc; /*color of box when checked*/
}

.divClassCheckbox input.radio:checked ~ label {
	color: #777;
}

/* radio focus */
.divClassCheckbox input.radio:focus ~ label:before {
	box-shadow: 0 0 0 3px #999;
}


.bubble
{
position: relative;
width: 130%;
height: 50px;
padding: 0px;
background: #ff8060;
-webkit-border-radius: 10px;
-moz-border-radius: 10px;
border-radius: 10px;
margin-left:50px;
color:white;
}

.bubble:after
{
content: '';
position: absolute;
border-style: solid;
border-width: 15px 15px 15px 0;
border-color: transparent #ff8060;
display: block;
width: 0;
z-index: 1;
left: -15px;
top: 10px;
}

.styled-select select {
   background: transparent;
   width: 130%;
   padding: 5px;
   font-size: 1em;
   line-height: 1;
   border: 0;
   border-radius: 0;
   height: 34px;
   -webkit-appearance: none;
   font-family: "Segoe UI",Verdana,Helvetica,sans-serif;
   cursor: pointer;
   }

.styled-select {
   width: 105%;
   height: 40px;
   overflow: hidden;
   background: url(Images/arrow.png) no-repeat right white;
   border: 2px solid #D1D3D4;
   border-radius:6px;
   }

label{
    
}

.ui-autocomplete {
            max-height: 150px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            /* add padding to account for vertical scrollbar */
            padding-right: 20px;
            max-width: 200px;

         
    }
    /* IE 6 doesn't support max-height
     * we use height instead, but this forces the menu to always be this tall
     */
* html .ui-autocomplete {
      height: 100px;
      width: 2000px;
 }

.pop{
  display:none;
  position:fixed;
  top:20%;
  left:7.5%;
  width:85%;
  height:60%;
  border-radius:8px;
  background:#ff8060;
  color:white;
  font-family: "Segoe UI",Verdana,Helvetica,sans-serif;
  
}

h1{
  font-family:"Segoe UI",Verdana,Helvetica,sans-serif;
}


input[type=checkbox] {
	visibility: hidden;
}

/**
 * Create the slider bar
 */
.checkboxOne {
	width: 50px;
	height: 15px;
	background: white;
	position: relative;
	border-radius: 3px;
}

/*text inside check box*/
/*
.checkboxOne:before {
	content: 'Yes';
	position: absolute;
	top: 12px;
	left: 13px;
	height: 2px;
	color: #26ca28;
	font-size: 16px;
}
*/
/**
 * Create the slider from the label
 */
.checkboxOne label {
	display: block;
	width: 35px;
	height: 35px;
	border-radius: 50%;

	-webkit-transition: all .5s ease;
	-moz-transition: all .5s ease;
	-o-transition: all .5s ease;
	-ms-transition: all .5s ease;
	transition: all .5s ease;
	cursor: pointer;
	position: absolute;
	top: -10px;
	left: -7px;

	background: #999;
}

/**
 * Move the slider in the correct position if the checkbox is clicked
 */
.checkboxOne input[type=checkbox]:checked + label {
	left: 27px;
    background: none repeat scroll 0 0 #4DCB6D;
    content: 'on';
}

.pop table td input[type=button]{
    margin-top: 0px;
    margin-bottom: 0px;
}


.orangeButton {
	-moz-box-shadow: 0px 10px 14px -7px #ff8060;
	-webkit-box-shadow: 0px 10px 14px -7px #ff8060;
	box-shadow: 0px 10px 14px -7px #ff8060;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ff8060), color-stop(1, #fa7250));
	background:-moz-linear-gradient(top, #ff8060 5%, #fa7250 100%);
	background:-webkit-linear-gradient(top, #ff8060 5%, #fa7250 100%);
	background:-o-linear-gradient(top, #ff8060 5%, #fa7250 100%);
	background:-ms-linear-gradient(top, #ff8060 5%, #fa7250 100%);
	background:linear-gradient(to bottom, #ff8060 5%, #fa7250 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff8060', endColorstr='#fa7250',GradientType=0);
	background-color:#ff8060;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #ff5126;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	font-weight:bold;
	padding:11px 20px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ff8060;
}
.orangeButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #e0512d), color-stop(1, #fa7250));
	background:-moz-linear-gradient(top, #e0512d 5%, #fa7250 100%);
	background:-webkit-linear-gradient(top, #e0512d 5%, #fa7250 100%);
	background:-o-linear-gradient(top, #e0512d 5%, #fa7250 100%);
	background:-ms-linear-gradient(top, #e0512d 5%, #fa7250 100%);
	background:linear-gradient(to bottom, #e0512d 5%, #fa7250 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#e0512d', endColorstr='#fa7250',GradientType=0);
	background-color:#3e7327;
}
.orangeButton:active {
	position:relative;
	top:1px;
}

/*size of font inside buttons */
td input[type="submit"], td input[type="button"], td button{
    font-size:1.5em;
}

#contentContainer{
     box-shadow: 10px 10px 40px grey; 
     -moz-box-shadow: 10px 10px 40px grey; 
     -webkit-box-shadow: 10px 10px 40px grey; 
}

.greenButton {
	-moz-box-shadow: 0px 10px 14px -7px #3e7327;
	-webkit-box-shadow: 0px 10px 14px -7px #3e7327;
	box-shadow: 0px 10px 14px -7px #3e7327;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77b55a), color-stop(1, #72b352));
	background:-moz-linear-gradient(top, #77b55a 5%, #72b352 100%);
	background:-webkit-linear-gradient(top, #77b55a 5%, #72b352 100%);
	background:-o-linear-gradient(top, #77b55a 5%, #72b352 100%);
	background:-ms-linear-gradient(top, #77b55a 5%, #72b352 100%);
	background:linear-gradient(to bottom, #77b55a 5%, #72b352 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77b55a', endColorstr='#72b352',GradientType=0);
	background-color:#77b55a;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #4b8f29;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	font-weight:bold;
	padding:11px 20px;
	text-decoration:none;
	text-shadow:0px 1px 0px #5b8a3c;
}
.greenButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #3e7327), color-stop(1, #77b55a));
	background:-moz-linear-gradient(top, #3e7327 5%, #77b55a 100%);
	background:-webkit-linear-gradient(top, #3e7327 5%, #77b55a 100%);
	background:-o-linear-gradient(top, #3e7327 5%, #77b55a 100%);
	background:-ms-linear-gradient(top, #3e7327 5%, #77b55a 100%);
	background:linear-gradient(to bottom, #3e7327 5%, #77b55a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3e7327', endColorstr='#77b55a',GradientType=0);
	background-color:#3e7327;
}
.greenButton:active {
	position:relative;
	top:1px;
}



#confirmationContainer{
  position:fixed;
  top:20%;
  left:30%;
  width:40%;
  /*height:30%; taking this out allows height to adjust*/ 
  border-radius:8px;
  background:white;
  border: solid 5px black;
  font-size: 1em;
  color:black;
  font-family: "Segoe UI",Verdana,Helvetica,sans-serif;
  box-shadow: 30px 30px 70px black;
  -moz-box-shadow: 30px 30px 70px black;
  -webkit-box-shadow: 30px 30px 70px black;
  
}

#validationContainer{
  /*display:none;*/
  position:fixed;
  top:35%;
  left:30%;
  width:40%;
  /*height:30%; taking this out allows height to adjust*/ 
  border-radius:8px;
  background:white;
  border: solid 5px black;
  font-size: 1em;
  color:black;
  font-family: "Segoe UI",Verdana,Helvetica,sans-serif;
  box-shadow: 30px 30px 70px black;
  -moz-box-shadow: 30px 30px 70px black;
  -webkit-box-shadow: 30px 30px 70px black;
}

</style>




    <script type="text/javascript">
       
   

        $(document).ready(function () {

            //on any input for the modcode, the data is sent to the c# function. This performs query on server and sends back data.
            //returns relevant modname depending on modcode entered
            $('#modcodeInput').on('input click paste focusout', function () {   //removed propertychange as it was buggy in ie8
                var modcode = $('#modcodeInput').val();
                //var modname = $('#MainContent_modnameInput').val();
                //var dataInput = "{modcode: " + modcode + "}";

                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ModcodeToModname",
                    data: JSON.stringify({ modcode: modcode }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        document.getElementById('modnameInput').value = result.d;   //have to write as result.d for some reason
                    }
                });
            });

            //on any input to modname, tries to find relevant modcode and updates modcode input
            //does same thing as function above, but for modname
            $('#modnameInput').on('input paste click focusout', function () {

                var modname = $('#modnameInput').val();

                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ModnameToModcode",
                    data: JSON.stringify({ modname: modname }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                    }
                });
            });




            $('#preferencesButton').click(function () {
                document.getElementById("modDetails").style.display = "none";
                document.getElementById("preferenceTable").style.display = "";
                $('#title').html("FACILITY OPTIONS (ROOM 1)");
            });
            $('#preferencesDoneButton, #preferencesDoneButton2, #preferencesDoneButton3').click(function () {
                document.getElementById("modDetails").style.display = "";
                document.getElementById("preferenceTable").style.display = "none";
                document.getElementById("preferenceTable2").style.display = "none";
                document.getElementById("preferenceTable3").style.display = "none";
                $('#title').html("MODULE DETAILS");
            });



            //autocomplete function for module name
            //minimum number of characters = 3, before search begins
            $("#modnameInput").autocomplete({ minLength: 3 }, {

                source: function (request, response) {

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Request.aspx/GetModnames",
                        data: "{'term':'" + $("#modnameInput").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
            });


            //autocomplete function for module code
            //minimum number of characters = 2, before search begins
            $("#modcodeInput").autocomplete({ minLength: 2 }, {

                source: function (request, response) {

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Request.aspx/GetModcodes",
                        data: "{'term':'" + $("#modcodeInput").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
            });

            /*
            Allows user to specify facilities of up to 3 rooms, depending on the number of rooms they require.
            Does this by hiding/unhiding the buttons that allows the user to go to the specific room facility page 
           */
            $(function () {
                //initially only 1 room chosen
                $('#gotoRoom2').hide();
                $('#gotoRoom3').hide();
                $('#numRooms').change(function () {
                    var numRooms = document.getElementById('numRooms').value;
                    if (numRooms == 1) {
                        $('#gotoRoom2').hide();
                        $('#gotoRoom3').hide();
                    }
                    //when 2 rooms chosen, access to room 2 must be given and access to room 3 must be disallowed. 
                    if (numRooms == 2) {
                        $('#gotoRoom2').show();
                        $('#gotoRoom3').hide();

                    }
                    //when 3 rooms chosen, access to room 3 AND room 2 must be given. All rooms are accessible
                    if (numRooms == 3) {
                        $('#gotoRoom2').show();
                        $('#gotoRoom3').show();
                    }
                });
            });

            /*
            Function to apply effects of blurring the background, whilst showing popup, then when popup closes, the background returns to normal 
            For weeks popup.
            Includes functions for the weeks popup.
            */
            $(function () {
                $("#defaultWeeksNo").click(function () { //onclick, fades in to display
                    $('#popupWeeks').fadeIn(1000);
                    $('#requestContainer').removeClass('blur-out');
                    $('#requestContainer').addClass('blur-in');

                    //only blurs the text in the footer
                    $('footer .float-left').removeClass('blur-out');
                    $('footer .float-left').addClass('blur-in');

                    //blurs header content, i.e. navigation
                    $('header').removeClass('blur-out');
                    $('header').addClass('blur-in');
                });

                //Close popup weeks
                $("#closePopup").click(function () { //onclick, fades out
                    $('#popupWeeks').fadeOut(1000);
                    //$('#requestContainer').removeClass('blur-in');
                    $('#requestContainer').addClass('blur-out');
                    $('#requestContainer').removeClass('blur-in');

                    //unblurs the text in the footer
                    $('footer .float-left').addClass('blur-out');
                    $('footer .float-left').removeClass('blur-in');

                    //unblurs header content
                    $('header').addClass('blur-out');
                    $('header').removeClass('blur-in');
                });

                //sets all the weeks to none checked
                $('#resetWeeks').click(function () {
                    // $('#week9').is(':checked')
                    for (i = 0; i < 16; i++) {
                        $('#week' + i).prop('checked', false);
                    }
                });

                //sets all the weeks to all checked
                $('#selectAllWeeks').click(function () {
                    // $('#week9').is(':checked')
                    for (i = 0; i < 16; i++) {
                        $('#week' + i).prop('checked', true);
                    }
                });
            });

            //closes and opens the facility popup
            $(function () {
                $('#checkbox_yesPreferences').click(function () {
                    $('#popupFacilities').fadeIn(1000);
                    $('#requestContainer').removeClass('blur-out');
                    $('#requestContainer').addClass('blur-in');

                    //only blurs the text in the footer
                    $('footer .float-left').removeClass('blur-out');
                    $('footer .float-left').addClass('blur-in');

                    //blurs header content, i.e. navigation
                    $('header').removeClass('blur-out');
                    $('header').addClass('blur-in');
                });

                $('#checkbox_yesPreferences2').click(function () {
                    $('#popupFacilities2').fadeIn(1000);
                    $('#requestContainer').removeClass('blur-out');
                    $('#requestContainer').addClass('blur-in');

                    //only blurs the text in the footer
                    $('footer .float-left').removeClass('blur-out');
                    $('footer .float-left').addClass('blur-in');

                    //blurs header content, i.e. navigation
                    $('header').removeClass('blur-out');
                    $('header').addClass('blur-in');
                });

                $('#checkbox_yesPreferences3').click(function () {
                    $('#popupFacilities3').fadeIn(1000);
                    $('#requestContainer').removeClass('blur-out');
                    $('#requestContainer').addClass('blur-in');

                    //only blurs the text in the footer
                    $('footer .float-left').removeClass('blur-out');
                    $('footer .float-left').addClass('blur-in');

                    //blurs header content, i.e. navigation
                    $('header').removeClass('blur-out');
                    $('header').addClass('blur-in');
                });

                //Close popup facilities
                $("#closePopupFacilities").click(function () { //onclick, fades out
                    $('#popupFacilities').fadeOut(1000);
                    //$('#requestContainer').removeClass('blur-in');
                    $('#requestContainer').addClass('blur-out');
                    $('#requestContainer').removeClass('blur-in');

                    //unblurs the text in the footer
                    $('footer .float-left').addClass('blur-out');
                    $('footer .float-left').removeClass('blur-in');

                    //unblurs header content
                    $('header').addClass('blur-out');
                    $('header').removeClass('blur-in');
                });

                //Close popup facilities 2
                $("#closePopupFacilities2").click(function () { //onclick, fades out
                    $('#popupFacilities2').fadeOut(1000);
                    //$('#requestContainer').removeClass('blur-in');
                    $('#requestContainer').addClass('blur-out');
                    $('#requestContainer').removeClass('blur-in');

                    //unblurs the text in the footer
                    $('footer .float-left').addClass('blur-out');
                    $('footer .float-left').removeClass('blur-in');

                    //unblurs header content
                    $('header').addClass('blur-out');
                    $('header').removeClass('blur-in');
                });

                //Close popup facilities 3
                $("#closePopupFacilities3").click(function () { //onclick, fades out
                    $('#popupFacilities3').fadeOut(1000);
                    //$('#requestContainer').removeClass('blur-in');
                    $('#requestContainer').addClass('blur-out');
                    $('#requestContainer').removeClass('blur-in');

                    //unblurs the text in the footer
                    $('footer .float-left').addClass('blur-out');
                    $('footer .float-left').removeClass('blur-in');

                    //unblurs header content
                    $('header').addClass('blur-out');
                    $('header').removeClass('blur-in');
                });
            });



            //allows user to go to preferences for 2nd room. So can select a different room on inputted capacity etc.
            $('#gotoRoom2').click(function () {
                $('#preferenceTable').hide();
                $('#preferenceTable2').show();
                $('#title').html("FACILITY OPTIONS (ROOM 2)");
            });

            $('#gotoPrevRoom1').click(function () {
                $('#preferenceTable2').hide();
                $('#preferenceTable').show();
                $('#title').html("FACILITY OPTIONS (ROOM 1)");
            });

            $('#gotoRoom3').click(function () {
                $('#preferenceTable2').hide();
                $('#preferenceTable3').show();
                $('#title').html("FACILITY OPTIONS (ROOM 3)");
            });

            $('#gotoPrevRoom2').click(function () {
                $('#preferenceTable3').hide();
                $('#preferenceTable2').show();
                $('#title').html("FACILITY OPTIONS (ROOM 2)");
            });
            /*
            On park checkbox selection, updates the buildings that the user can select from.
            If the user selects central park, only buildings from central park shown.
            User can select multiple parks through checkboxes.
            */
            $('.parkClass').change(function () {
                //if checked, then is set to true, otherwise false
                var central = document.getElementById('checkbox_centralPark').checked;
                var east = document.getElementById('checkbox_eastPark').checked;
                var west = document.getElementById('checkbox_westPark').checked;

                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowBuildingSelect",
                    data: JSON.stringify({ central: central, east: east, west: west }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_building').html(result.d);
                    }
                });
            });

            //same thing as above, but for room 2
            $('.parkClass2').change(function () {
                //if checked, then is set to true, otherwise false
                var central = document.getElementById('checkbox_centralPark2').checked;
                var east = document.getElementById('checkbox_eastPark2').checked;
                var west = document.getElementById('checkbox_westPark2').checked;

                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowBuildingSelect",
                    data: JSON.stringify({ central: central, east: east, west: west }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_building2').html(result.d);
                    }
                });
            });


            //same thing as above, but for room 3
            $('.parkClass3').change(function () {
                //if checked, then is set to true, otherwise false
                var central = document.getElementById('checkbox_centralPark3').checked;
                var east = document.getElementById('checkbox_eastPark3').checked;
                var west = document.getElementById('checkbox_westPark3').checked;

                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowBuildingSelect",
                    data: JSON.stringify({ central: central, east: east, west: west }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_building3').html(result.d);
                    }
                });
            });
            /*
            will show all buildings available to select onload, seeing as west, central, east initially checked onload
            Does this for room 2 and room 3 also
            */
            $(function () {
                var central = document.getElementById('checkbox_centralPark').checked;
                var east = document.getElementById('checkbox_eastPark').checked;
                var west = document.getElementById('checkbox_westPark').checked;
                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowBuildingSelect",
                    data: JSON.stringify({ central: central, east: east, west: west }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_building').html(result.d);
                        $('#select_building2').html(result.d);
                        $('#select_building3').html(result.d);
                    }
                });
            });

            /* 
            This will update the rooms available to select based on the building that the user selects.
            If user selects James France, then the rooms for james france will be shown.
            TO DO - This will also take into consideration room type, capacity and room facilities. 
            */
            //Updates when building selected changed, also when room type is changed
            $('#select_building, .roomTypeClass, #capacityInput, .facilityCheckboxes, .requestFacilitiesClass, .parkClass').change(function () {
                //variables to send to the C# class
                var building = document.getElementById('select_building').value; //selected building code
                var lecture = document.getElementById('checkbox_Lecture').checked; // set to true if user wants a lecture room type
                var seminar = document.getElementById('checkbox_Seminar').checked; //set to true if user wants a seminar
                var lab = document.getElementById('checkbox_Lab').checked; //set to true if user wants a lab
                var capacity = document.getElementById('capacityInput').value;

                if (document.getElementById('checkbox_noPreferences').checked) {// if user selects 'no' facilities required, then all set to default false 
                    var comp = false; //computer
                    var ddp = false;    //Dual Data projection
                    var dp = false;    //Data Projection
                    var il = false;    //Induction Loop
                    var mp = false;    //Media Player
                    var pa = false;    //PA
                    var plasma = false;  //Plasma
                    var rev = false;    //ReView
                    var mic = false;     //Radio Microphone
                    var vis = false;    //Visualiser
                    var wc = false;  //Wheelchair Access
                    var wb = false;      //Whiteboard
                } else {    //if user selects 'yes' they do want to specify facilities
                    //room preference selections, such as whiteboard
                    var comp = document.getElementById('checkbox_COMP').checked;    //computer 
                    var ddp = document.getElementById('checkbox_DDP').checked;     //Dual Data projection
                    var dp = document.getElementById('checkbox_DP').checked;      //Data Projection
                    var il = document.getElementById('checkbox_IL').checked;      //Induction Loop
                    var mp = document.getElementById('checkbox_MP').checked;      //Media Player
                    var pa = document.getElementById('checkbox_PA').checked;      //PA
                    var plasma = document.getElementById('checkbox_PLASMA').checked;  //Plasma
                    var rev = document.getElementById('checkbox_REV').checked;     //ReView
                    var mic = document.getElementById('checkbox_MIC').checked;      //Radio Microphone
                    var vis = document.getElementById('checkbox_VIS').checked;     //Visualiser
                    var wc = document.getElementById('checkbox_Wchair').checked;  //Wheelchair Access
                    var wb = document.getElementById('checkbox_WB').checked;      //Whiteboard
                }

                //if no building selected, then 0 is sent.
                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowRooms",
                    data: JSON.stringify({
                        building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                        comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                        vis: vis, wc: wc, wb: wb
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_room').html(result.d);
                    }
                });
            });

            //same as above, but for room 2
            $('#select_building2, .roomTypeClass2, #capacityInput2, .facilityCheckboxes2, .requestFacilitiesClass2, .parkClass2').change(function () {
                //variables to send to the C# class
                var building = document.getElementById('select_building2').value; //selected building code
                var lecture = document.getElementById('checkbox_Lecture2').checked; // set to true if user wants a lecture room type
                var seminar = document.getElementById('checkbox_Seminar2').checked; //set to true if user wants a seminar
                var lab = document.getElementById('checkbox_Lab2').checked; //set to true if user wants a lab
                var capacity = document.getElementById('capacityInput2').value;

                if (document.getElementById('checkbox_noPreferences2').checked) {// if user selects 'no' facilities required, then all set to default false 
                    var comp = false; //computer
                    var ddp = false;    //Dual Data projection
                    var dp = false;    //Data Projection
                    var il = false;    //Induction Loop
                    var mp = false;    //Media Player
                    var pa = false;    //PA
                    var plasma = false;  //Plasma
                    var rev = false;    //ReView
                    var mic = false;     //Radio Microphone
                    var vis = false;    //Visualiser
                    var wc = false;  //Wheelchair Access
                    var wb = false;      //Whiteboard
                } else {    //if user selects 'yes' they do want to specify facilities
                    //room preference selections, such as whiteboard
                    var comp = document.getElementById('checkbox_COMP2').checked;    //computer 
                    var ddp = document.getElementById('checkbox_DDP2').checked;     //Dual Data projection
                    var dp = document.getElementById('checkbox_DP2').checked;      //Data Projection
                    var il = document.getElementById('checkbox_IL2').checked;      //Induction Loop
                    var mp = document.getElementById('checkbox_MP2').checked;      //Media Player
                    var pa = document.getElementById('checkbox_PA2').checked;      //PA
                    var plasma = document.getElementById('checkbox_PLASMA2').checked;  //Plasma
                    var rev = document.getElementById('checkbox_REV2').checked;     //ReView
                    var mic = document.getElementById('checkbox_MIC2').checked;      //Radio Microphone
                    var vis = document.getElementById('checkbox_VIS2').checked;     //Visualiser
                    var wc = document.getElementById('checkbox_Wchair2').checked;  //Wheelchair Access
                    var wb = document.getElementById('checkbox_WB2').checked;      //Whiteboard
                }

                //if no building selected, then 0 is sent.
                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowRooms",
                    data: JSON.stringify({
                        building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                        comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                        vis: vis, wc: wc, wb: wb
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_room2').html(result.d);
                    }
                });
            });

            //same as above 2 functions, but for room 3
            $('#select_building3, .roomTypeClass3, #capacityInput3, .facilityCheckboxes3, .requestFacilitiesClass3, .parkClass3').change(function () {
                //variables to send to the C# class
                var building = document.getElementById('select_building3').value; //selected building code
                var lecture = document.getElementById('checkbox_Lecture3').checked; // set to true if user wants a lecture room type
                var seminar = document.getElementById('checkbox_Seminar3').checked; //set to true if user wants a seminar
                var lab = document.getElementById('checkbox_Lab3').checked; //set to true if user wants a lab
                var capacity = document.getElementById('capacityInput3').value;

                if (document.getElementById('checkbox_noPreferences3').checked) {// if user selects 'no' facilities required, then all set to default false 
                    var comp = false; //computer
                    var ddp = false;    //Dual Data projection
                    var dp = false;    //Data Projection
                    var il = false;    //Induction Loop
                    var mp = false;    //Media Player
                    var pa = false;    //PA
                    var plasma = false;  //Plasma
                    var rev = false;    //ReView
                    var mic = false;     //Radio Microphone
                    var vis = false;    //Visualiser
                    var wc = false;  //Wheelchair Access
                    var wb = false;      //Whiteboard
                } else {    //if user selects 'yes' they do want to specify facilities
                    //room preference selections, such as whiteboard
                    var comp = document.getElementById('checkbox_COMP3').checked;    //computer 
                    var ddp = document.getElementById('checkbox_DDP3').checked;     //Dual Data projection
                    var dp = document.getElementById('checkbox_DP3').checked;      //Data Projection
                    var il = document.getElementById('checkbox_IL3').checked;      //Induction Loop
                    var mp = document.getElementById('checkbox_MP3').checked;      //Media Player
                    var pa = document.getElementById('checkbox_PA3').checked;      //PA
                    var plasma = document.getElementById('checkbox_PLASMA3').checked;  //Plasma
                    var rev = document.getElementById('checkbox_REV3').checked;     //ReView
                    var mic = document.getElementById('checkbox_MIC3').checked;      //Radio Microphone
                    var vis = document.getElementById('checkbox_VIS3').checked;     //Visualiser
                    var wc = document.getElementById('checkbox_Wchair3').checked;  //Wheelchair Access
                    var wb = document.getElementById('checkbox_WB3').checked;      //Whiteboard
                }

                //if no building selected, then 0 is sent.
                $.ajax({
                    type: "POST",
                    url: "Request.aspx/ShowRooms",
                    data: JSON.stringify({
                        building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                        comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                        vis: vis, wc: wc, wb: wb
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                        //alert(result.d);
                        $('#select_room3').html(result.d);
                    }
                });
            });


            $('#changeTime').click(function () {
                if (document.getElementById('select_startTime').options[0].text != '1') { //if not already set to period, then set to period
                    //change label to say period
                    $('#MainContent_startPeriodLabel').show();
                    $('#MainContent_startTimeLabel').hide();
                    $('#MainContent_endPeriodLabel').show();
                    $('#MainContent_endTimeLabel').hide();

                    for (i = 0; i < 9; i++) {
                        document.getElementById('select_startTime').options[i].text = i + 1;
                        document.getElementById('select_endTime').options[i].text = i + 2;
                    }

                } else {    //if it has been set to period, now changes back to normal time

                    //change label to say time
                    $('#MainContent_startPeriodLabel').hide();
                    $('#MainContent_startTimeLabel').show();
                    $('#MainContent_endPeriodLabel').hide();
                    $('#MainContent_endTimeLabel').show();
                    for (i = 0; i < 9; i++) { //sets back to normal time form rather than periods i.e. 09:00:00 instead of 1
                        //document.getElementById('select_startTime').options[i].text = (document.getElementById('select_startTime').options[i].value).substring(0, 5);
                        //document.getElementById('select_endTime').options[i].text = (document.getElementById('select_endTime').options[i].value).substring(0, 5);
                        document.getElementById('select_startTime').options[i].text = i + 9 + ":00";
                        document.getElementById('select_endTime').options[i].text = i + 10 + ":00";
                    }
                 
                }
            });

         

            /*
                 VALIDATION FOR TIME SELECTION
                 if the user selects a start time which is later then the end time, will not be allowed, user will be notified.
            */
            $('#select_startTime, #select_endTime').change(function () {
                var startTime = document.getElementById('select_startTime').value;
                var endTime = document.getElementById('select_endTime').value;
                if (startTime >= endTime) {
                    showValidation();                    
                    //showValidation("The <b>'Start time'</b> cannot finish after <b>'End Time'</b>, it must be before.");   //opens up validation message box
                    $('#messageContents').html("The <b>'Start time'</b> must be before the <b>'End Time'</b>.");
                    //Sets red to bottom border of the corresponding labels, highlighting user of the location of the error.
                    document.getElementById("MainContent_startTimeLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_endTimeLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "3px solid red";
                } else { //gets rid of the red border
                    document.getElementById("MainContent_startTimeLabel").style.borderBottom = "";
                    document.getElementById("MainContent_endTimeLabel").style.borderBottom = "";
                    document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "";
                    document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "";
                }
            });

            function showValidation() {
                $('#validationContainer').show();
                formInputEnabled('false');  //disable changing of input until this is closed.
                $('#requestContainer').removeClass('blur-out');
                $('#requestContainer').addClass('blur-in');

                //only blurs the text in the footer
                $('footer .float-left').removeClass('blur-out');
                $('footer .float-left').addClass('blur-in');

                //blurs header content, i.e. navigation
                $('header').removeClass('blur-out');
                $('header').addClass('blur-in');
            }


            $('#closeValidation').click(function () {
                $('#validationContainer').hide();
                formInputEnabled('true');
                $('#requestContainer').addClass('blur-out');
                $('#requestContainer').removeClass('blur-in');

                //unblurs the text in the footer
                $('footer .float-left').addClass('blur-out');
                $('footer .float-left').removeClass('blur-in');

                //unblurs header content
                $('header').addClass('blur-out');
                $('header').removeClass('blur-in');
            });

            /* brings up confirmation box */
            function showConfirmation() {
                $('#confirmationContainer').show();
                $('#requestContainer').removeClass('blur-out');
                $('#requestContainer').addClass('blur-in');

                //only blurs the text in the footer
                $('footer .float-left').removeClass('blur-out');
                $('footer .float-left').addClass('blur-in');

                //blurs header content, i.e. navigation
                $('header').removeClass('blur-out');
                $('header').addClass('blur-in');
            }

            $('#cancelRequest').click(function () {
                formInputEnabled("true");
                $('#confirmationContainer').hide();
                
                $('#requestContainer').addClass('blur-out');
                $('#requestContainer').removeClass('blur-in');

                //unblurs the text in the footer
                $('footer .float-left').addClass('blur-out');
                $('footer .float-left').removeClass('blur-in');

                //unblurs header content
                $('header').addClass('blur-out');
                $('header').removeClass('blur-in');
            });

            /*
                Submits the request.
                Also, performs validation before submitting the request, to ensure required fields entered are valid and non empty.
            */
            $('#submitButton').click(function () {
                var modcode = $('#modcodeInput').val().toUpperCase();
                var modname = $('#modnameInput').val();

                var day = $('#daySelect').val();
                var dayString = document.getElementById('daySelect').options[document.getElementById('daySelect').value - 1].text; //i.e. monday instead of 1

                var startTimeString = document.getElementById('select_startTime').options[document.getElementById('select_startTime').value - 1].text;//i.e. 10:00 instead of 2
                var endTimeString = document.getElementById('select_endTime').options[document.getElementById('select_endTime').value - 2].text;//i.e. 10:00 instead of 2
                var startTime = document.getElementById('select_startTime').value; //1-9
                var endTime = document.getElementById('select_endTime').value; //2-10

                var numRooms = $('#numRooms').val();
                var roomCap1 = $('#capacityInput').val();
                var roomCap2 = $('#capacityInput2').val();
                var roomCap3 = $('#capacityInput3').val();
                //var weeks array is an array containing the weeks selected. Declared later on.
                var capacity = +roomCap1;

                if(numRooms == 2){
                    capacity = +roomCap1 + +roomCap2;
                }
                if(numRooms == 3){
                    capacity = +roomCap1 + +roomCap2 + +roomCap3;   //unary plus operator, converts string to number                }
                }

                var flag = true; // if on clicking submit, no errors occur, can complete submission. Else will notify user of the errors to fix.

                $('#messageContents').html("<ul id='errorList'></ul>");
                $('#messageContents').append("Cannot submit until you correct the above error(s)");

                /*if module code is empty*/

                if (modcode == "") {
                    flag = false;
                    showValidation();
                    $('#errorList').append("<li><b>'Module Code'</b> is empty. Please enter a value</li>");
                    document.getElementById("MainContent_modcodeLabel").style.borderBottom = "3px solid red";
                } else { //error corrected
                    document.getElementById("MainContent_modcodeLabel").style.borderBottom = "";
                }

                /*if module name is empty*/

                if (modname == "") {
                    flag = false;
                    showValidation();
                    $('#errorList').append("<li><b>'Module Name'</b> is empty. Please enter a value</li>");
                    document.getElementById("MainContent_modnameLabel").style.borderBottom = "3px solid red";
                } else { //error corrected
                    document.getElementById("MainContent_modnameLabel").style.borderBottom = "";
                }

                /*if module name is empty */

                if (startTime > endTime) {
                    flag = false;
                    showValidation();
                    $('#errorList').append("<li><b>'Start Time'</b> must be before <b>'End Time'</b>.  Please change desired times.</li>");
                    document.getElementById("MainContent_startTimeLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_endTimeLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "3px solid red";
                    document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "3px solid red";
                } else { //gets rid of the red border
                    document.getElementById("MainContent_startTimeLabel").style.borderBottom = "";
                    document.getElementById("MainContent_endTimeLabel").style.borderBottom = "";
                    document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "";
                    document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "";
                }

                /*if the capacity input is empty*/
                if (numRooms == 1) {
                    if (roomCap1 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
                    }
                }

                if (numRooms == 2) {
                    if (roomCap1 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
                    }
                    if (roomCap2 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 2. Can be found in <b>'Preferences'</b> for Room 2 </li>");
                        document.getElementById("MainContent_capacity2Label").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacity2Label").style.borderBottom = "";
                    }
                }

                if (numRooms == 3) {
                    if (roomCap1 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
                    }
                    if (roomCap2 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 2. Can be found in <b>'Preferences'</b> for Room 2 </li>");
                        document.getElementById("MainContent_capacity2Label").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacity2Label").style.borderBottom = "";
                    }
                    if (roomCap3 == "") {
                        flag = false;
                        showValidation();
                        $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 3. Can be found in <b>'Preferences'</b> for Room 3 </li>");
                        document.getElementById("MainContent_capacity3Label").style.borderBottom = "3px solid red";
                    } else {  //gets rid of the red border
                        document.getElementById("MainContent_capacity3Label").style.borderBottom = "";
                    }
                }// numRooms 3 closing tag

                var defaultWeeks = document.getElementById('defaultWeeksYes').checked; //if false, then user has selected to choose own weeks
                
              
                //var weeks = []; //creates empty array
              
                /*
                    Check if any weeks have been selected when user selects to choose his/her own weeks.
                */
         
                var weeks = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
                var weekChecked = 15; //15 weeks checked automatically

                if (document.getElementById('defaultWeeksNo').checked == true) {    //if user has selected to choose own weeks
                    //check to see if any weeks have been selected.
                    weeks = []; //sets the weeks array to empty, so can add the specific weeks user chooses.
                    var weekChecked = 0;
                    for (i = 1; i < 16; i++) {
                        if (document.getElementById('week' + i).checked == true) {
                            weekChecked = weekChecked + 1; //if at least 1 week has been checked, then weekChecked set to true
                            weeks.push(i); //corresponding week number will be added to the array if it has been checked
                            /*
                              If at least 1 week has been checked, then checked weeks set to true.
                              Otherwise, no weeks have been selected. User must be notified.
                          */
                        }
                     }
                }

                //if user selects to choose own weeks, must select at least 1 week.
                if (weekChecked == 0) {
                    flag = false;
                    showValidation();
                    $('#errorList').append("<li>No weeks have been selected. Please select at least 1 week to continue or set <b>'Default Weeks'</b> to <b>'Yes'</b></li>");
                    document.getElementById("MainContent_defaultWeeksLabel").style.borderBottom = "3px solid red";
                } else {  //gets rid of the red border
                    document.getElementById("MainContent_defaultWeeksLabel").style.borderBottom = "";
                }
               

                /*
                    If the flag is still true, that means all errors have been handled, can now submit the request to the DB.
                */

                var weeksString = "";
                //iterates through the weeks array, to find out which weeks have been selected
                for (i = 0; i<weeks.length; i++) {
                    weeksString += weeks[i] + ", "  //puts contents of the array into the form 1, 2, 3 etc.
                }
                weeksString = weeksString.substring(0, weeksString.length - 2); //gets rid of the ',' at the end.
                if (flag == true) {
                    formInputEnabled("false");  //cannot change data once in submission mode
                    showConfirmation(); //brings up confirmation pop up
                    $('#confirmationContents').html(""); //clears previous added content
                    $('#confirmationContents').append("<strong>Module:</strong> " + modname + " (" + modcode + ")" + "<br />");
                    //$('#confirmationContents').append("<strong>Module Code:</strong> " + modcode + "<br />");
                    $('#confirmationContents').append("<strong>Day:</strong> " + dayString + "<br />");
                    $('#confirmationContents').append("<strong>Start Time:</strong> " + startTimeString + " (Period " + startTime + ")" + "<br />");
                    $('#confirmationContents').append("<strong>End Time:</strong> " + endTimeString + " (Period " + endTime + ")" + "<br />");
                    $('#confirmationContents').append("<strong>Weeks:</strong> " + weeksString + "<br />");
                    if (numRooms == 1) { //if user has requested just 1 room
                        if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                            $('#confirmationContents').append("<strong>Room:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room:</strong> n/a <br />");
                        }
                        $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");  
                    }
                    if (numRooms == 2) {    //if user has requested 2 rooms
                        if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                            $('#confirmationContents').append("<strong>Room 1:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room 1:</strong> n/a <br />");
                        }
                        if (document.getElementById('select_room2').value != 0) {    //if a room2 has been chosen
                            $('#confirmationContents').append("<strong>Room 2:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room 2:</strong> n/a <br />");
                        }
                        $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");
                    }
                    if (numRooms == 3) {    //if user has requested 2 rooms
                        if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                            $('#confirmationContents').append("<strong>Room 1:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room 1:</strong> n/a <br />");
                        }
                        if (document.getElementById('select_room2').value != 0) {    //if a room2 has been chosen
                            $('#confirmationContents').append("<strong>Room 2:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room 2:</strong> n/a <br />");
                        }
                        if (document.getElementById('select_room3').value != 0) {    //if a room2 has been chosen
                            $('#confirmationContents').append("<strong>Room 3:</strong> " + document.getElementById('select_room').value + "<br />");
                        } else {
                            $('#confirmationContents').append("<strong>Room 3:</strong> n/a <br />");
                        }
                        $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");
                    }

                }
            }); //submit action closing tag

            /* 
                disables, or re-enables user input into the form
                If parameter is 'true', input is enabled
                if parameter is 'false', input is disabled
            */
            function formInputEnabled(decision) {
                var status = false;
                if (decision == "false") {
                    status = true;
                }
                document.getElementById('modcodeInput').disabled = status;
                document.getElementById('modnameInput').disabled = status;
                document.getElementById('daySelect').disabled = status;
                document.getElementById('select_startTime').disabled = status;
                document.getElementById('select_endTime').disabled = status;
                document.getElementById('numRooms').disabled = status;
                document.getElementById('defaultWeeksYes').disabled = status;
                document.getElementById('defaultWeeksNo').disabled = status;
                document.getElementById('submitButton').disabled = status;
                document.getElementById('preferencesButton').disabled = status;
            }

        }); //document.ready closing tag


 
      
        
    </script>

    <div id="requestContainer">
        <h2 id="title"style="color:white; text-align:center; font-family: 'Segoe UI',Verdana,Helvetica,sans-serif">MODULE DETAILS</h2>

        <div id="contentContainer" style="background-color:white; position:relative; top:1%; height:90%; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px;">
            <table id="modDetails">
                <tr>
                    <!-- module code input with validator-->
                    <td>
                        <asp:Label ID="modcodeLabel" ToolTip="Enter a module code i.e. COA123" runat="server" Text="MODULE CODE"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="modcodeInput" style="width: 200%;" placeholder="e.g. COA101"/>

                    </td>

                    <!--  <div id="modcodeFieldValidator" style="display:none;" class="bubble" style="margin-left:-5px;">Please enter a module code</div>
                       <div id="modnameFieldValidator" style="display:none;" class="bubble">Please enter a module name</div> <!-- temporarily hidden  -->

                    <td>
                        <!--empty -->
                    </td>
                    <!-- module name input with validator-->
                    <td>
                        <!-- <label ID="modnameLabel"  for="modnameInput" title="Enter a module name i.e. Server Side Programming">MODULE NAME</label>-->
                        <asp:Label ID="modnameLabel" runat="server" Text="MODULE NAME" ToolTip="Enter a module name i.e. Server Side Programming"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="modnameInput" style="width: 200%;" placeholder="e.g. Essential Skills for Computing"/>
                        <!--<asp:TextBox ID="modnameInput" runat="server" style="width:135%;"></asp:TextBox>-->
                    </td>
                    <td>
                        <!-- empty -->
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="daySelectLabel" runat="server" Text="DAY" ToolTip="Select the day that you would like to make the booking for"></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="daySelect">
                                <option value="1">Monday</option>
                                <option value="2">Tuesday</option>
                                <option value="3">Wednesday</option>
                                <option value="4">Thursday</option>
                                <option value="5">Friday</option>
                            </select>
                        </div>
                    </td>

                    <td>
                        <asp:Label ID="startTimeLabel" runat="server" Text="START TIME" ToolTip="Select the time that you would like the lecture to start i.e. 10:00"></asp:Label>
                        <asp:Label ID="startPeriodLabel" runat="server" Text="START PERIOD" style="display:none" ToolTip="Select the period that you would like the lecture to start i.e. 2"></asp:Label>
                        <img id="changeTime" src="images/change.png" style="width:20px; height:20px; margin-left:5px; cursor:pointer"/>
                        
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="select_startTime">
                                <option value="1">9:00</option>
                                <option value="2">10:00</option>
                                <option value="3">11:00</option>
                                <option value="4">12:00</option>
                                <option value="5">13:00</option>
                                <option value="6">14:00</option>
                                <option value="7">15:00</option>
                                <option value="8">16:00</option>
                                <option value="9">17:00</option>
                            </select>
                        </div>
                    </td>

                    <td>
                        <asp:Label ID="endTimeLabel" runat="server" Text="END TIME" ToolTip="Select the time that you would like the lecture to end i.e. 11:00"></asp:Label>
                        <asp:Label ID="endPeriodLabel" runat="server" Text="END PERIOD" style="display:none" ToolTip="Select the period that you would like the lecture to end i.e. 5"></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="select_endTime">
                                <option value="2">10:00</option>
                                <option value="3">11:00</option>
                                <option value="4">12:00</option>
                                <option value="5">13:00</option>
                                <option value="6">14:00</option>
                                <option value="7">15:00</option>
                                <option value="8">16:00</option>
                                <option value="9">17:00</option>
                                <option value="10">18:00</option>
                            </select>
                        </div>
                    </td>
                </tr>


                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="NUMBER OF ROOMS" ToolTip="Select the number of rooms that you would like for this booking."></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="numRooms">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                            </select>
                        </div>
                    </td>

                    <td>
                        <asp:Label ID="defaultWeeksLabel" runat="server" Text="DEFAULT WEEKS?" ToolTip="Default weeks are weeks 1 to 12. if you wish to choose the specific weeks yourself, select 'No'."></asp:Label>
                    </td>
                    <td>
                        <div class="divClass">
                            <input type="radio" name="radioWeek" id="defaultWeeksYes" class="radio" checked />
                            <!-- checked by default -->
                            <label for="defaultWeeksYes">Yes</label>
                        </div>
                        <div class="divClass">
                            <input type="radio" name="radioWeek" id="defaultWeeksNo" class="radio" />
                            <label for="defaultWeeksNo">No</label>
                        </div>
                    </td>
                    
                    <td colspan="2">
                        <input type="button" id="preferencesButton" value="Preferences" class="orangeButton" style="font-size:1.5em; margin: auto; width: 60%; display:block;"/>
                        <input type="button" id="submitButton" value="Submit" style="margin-bottom:0px; width:60%; position:relative; top:10px;" class="greenButton"/>
                    </td>
                </tr>

            </table>
        

        <!-- preference table for room 1, room 2 and room 3-->

        <table id="preferenceTable" class="preferenceTable" style="display:none">
             <tr>
                 <td>
                    <asp:Label ID="capacityLabel" for="capacityInput" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput" value='30'/>
                </td>
                <td>
                    <asp:Label ID="roomType" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass">
                         <input type="checkbox" id="checkbox_Lecture" class="radio" checked /> <!-- all checked by default -->
                         <label for="checkbox_Lecture">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass">
                         <input type="checkbox" id="checkbox_Seminar" class="radio" />
                         <label for="checkbox_Seminar">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass">
                         <input type="checkbox" id="checkbox_Lab" class="radio" />
                         <label for="checkbox_Lab">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label4" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass">  
                         <input type="checkbox" name="park" id="checkbox_centralPark" class="radio" checked/>
                         <label for="checkbox_centralPark">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass">  
                         <input type="checkbox" name="park" id="checkbox_westPark" class="radio" checked/>
                         <label for="checkbox_westPark">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass">  
                         <input type="checkbox" name="park" id="checkbox_eastPark" class="radio" checked/>
                         <label for="checkbox_eastPark">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
             
                <td>
                     <asp:Label ID="Label8" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass">
                       <input type="radio" name="preferenceRadio" class="radio" id="checkbox_noPreferences" checked />
                       <label for="checkbox_noPreferences">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass">
                       <input type="radio" name="preferenceRadio" class="radio" id="checkbox_yesPreferences" />
                       <label for="checkbox_yesPreferences">Yes</label>
                   </div>
                </td>   

                <td>
                    <!-- empty cell - formatting -->
                </td>
                   
                
                <td>
                    <asp:Label ID="Label5" runat="server" Text="BUILDING"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="Label7" runat="server" Text="ROOM"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_building">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_room">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton" value="Done" class="orangeButton" />
                </td>
                <td>
                    <!-- empty - formatting -->
                </td>
                <td>
                    <input type="button" id="gotoRoom2" value="Next Room"/>
                </td>
            </tr>
        </table>

        <!-- preferences for 2nd room selection. Only selectable if user selects that they want to book 2 rooms.  -->
         <table id="preferenceTable2" class="preferenceTable" style="display:none">
           <tr>
                 <td>
                    <asp:Label ID="capacity2Label" for="capacityInput2" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput2"  value="30" />
                </td>
                <td>
                    <asp:Label ID="Label9" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass2">
                         <input type="checkbox" id="checkbox_Lecture2" class="radio" checked /> <!-- all checked by default -->
                         <label for="checkbox_Lecture2">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass2">
                         <input type="checkbox" id="checkbox_Seminar2" class="radio" />
                         <label for="checkbox_Seminar2">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass2">
                         <input type="checkbox" id="checkbox_Lab2" class="radio" />
                         <label for="checkbox_Lab2">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label10" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="checkbox" name="park" id="checkbox_centralPark2" class="radio" checked/>
                         <label for="checkbox_centralPark2">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="checkbox" name="park" id="checkbox_westPark2" class="radio" checked/>
                         <label for="checkbox_westPark2">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="checkbox" name="park" id="checkbox_eastPark2" class="radio" checked/>
                         <label for="checkbox_eastPark2">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
             
                <td>
                     <asp:Label ID="Label11" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass2">
                       <input type="radio" name="preferenceRadio2" class="radio" id="checkbox_noPreferences2" checked />
                       <label for="checkbox_noPreferences2">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass2">
                       <input type="radio" name="preferenceRadio2" class="radio" id="checkbox_yesPreferences2" />
                       <label for="checkbox_yesPreferences2">Yes</label>
                   </div>
                </td>   

                <td>
                    <!-- empty cell - formatting -->
                </td>
                   
                
                <td>
                    <asp:Label ID="Label12" runat="server" Text="BUILDING"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="Label13" runat="server" Text="ROOM"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_building2">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_room2">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton2" value="Done" class="orangeButton"/>
                </td>
                
                <td>
                    <input type="button" id="gotoPrevRoom1" value="Previous Room" />
                </td>
                <td>
                    <input type="button" id="gotoRoom3" value="Next Room"/>
                </td>
            </tr>
        </table>

         <!-- preferences for 3rd room selection. Only selectable if user selects that they want to book 3 rooms.  -->
         <table id="preferenceTable3" class="preferenceTable" style="display:none">
           <tr>
                 <td>
                    <asp:Label ID="capacity3Label" for="capacityInput3" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput3" value='30' placeholder="e.g. 50"  />
                </td>
                <td>
                    <asp:Label ID="Label15" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass3">
                         <input type="checkbox" id="checkbox_Lecture3" class="radio" checked /> <!-- all checked by default -->
                         <label for="checkbox_Lecture3">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass3">
                         <input type="checkbox" id="checkbox_Seminar3" class="radio" />
                         <label for="checkbox_Seminar3">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass3">
                         <input type="checkbox" id="checkbox_Lab3" class="radio" />
                         <label for="checkbox_Lab3">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label16" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="checkbox" name="park" id="checkbox_centralPark3" class="radio" checked/>
                         <label for="checkbox_centralPark3">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="checkbox" name="park" id="checkbox_westPark3" class="radio" checked/>
                         <label for="checkbox_westPark3">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="checkbox" name="park" id="checkbox_eastPark3" class="radio" checked/>
                         <label for="checkbox_eastPark3">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
             
                <td>
                     <asp:Label ID="Label17" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass3">
                       <input type="radio" name="preferenceRadio3" class="radio" id="checkbox_noPreferences3" checked />
                       <label for="checkbox_noPreferences3">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass3">
                       <input type="radio" name="preferenceRadio3" class="radio" id="checkbox_yesPreferences3" />
                       <label for="checkbox_yesPreferences3">Yes</label>
                   </div>
                </td>   

                <td>
                    <!-- empty cell - formatting -->
                </td>
                   
                
                <td>
                    <asp:Label ID="Label18" runat="server" Text="BUILDING"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="Label19" runat="server" Text="ROOM"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_building3">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:170%; margin-top:20px; margin-bottom:20px">
                        <select id="select_room3">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton3" value="Done" class="orangeButton"/>
                </td>
      
                <td>
                    <input type="button" id="gotoPrevRoom2" value="Previous Room" />
                </td>

            </tr>
        </table>

   
        </div>
    </div>
    


<!-- popup contents for week selection-->
<div class="pop" id="popupWeeks">

    <span id="closePopup" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Week Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
       
         <table style="width:70%; height:80%; top: 5%; left:15%;position:relative; table-layout:fixed;">
            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 1
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne">
                        <input type="checkbox" id="week1"/>
                        <label for="week1" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 2
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week2"/>
                        <label for="week2" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 3
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week3"/>
                        <label for="week3" ></label>
                    </div>
                </td>

               <td>
                  &nbsp;&nbsp;  WEEK 4
               </td>
                <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week4"/>
                        <label for="week4" ></label>
                    </div>
                </td>
            </tr>
            
            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                    &nbsp;&nbsp; WEEK 5
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week5"/>
                        <label for="week5" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 6
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week6"/>
                        <label for="week6" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 7
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week7"/>
                        <label for="week7" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 8
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week8"/>
                        <label for="week8" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                   &nbsp;&nbsp;  WEEK 9
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week9"/>
                        <label for="week9" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 10
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week10"/>
                        <label for="week10" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 11
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week11"/>
                        <label for="week11" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 12
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week12"/>
                        <label for="week12" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 13
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week13"/>
                        <label for="week13" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 14
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week14"/>
                        <label for="week14" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp;  WEEK 15
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week15"/>
                        <label for="week15" ></label>
                    </div>
                </td>

                <td>
                    <input type="button" value="Reset" id="resetWeeks" style="margin-left:10px; background-color:white; width: 90%; font-size: 1em; border-radius:8px"/>
                </td>
               <td>
                    <input type="button" value="Select All" id="selectAllWeeks" style="background-color:white; width: 100%; font-size: 1em; border-radius:8px"/>
               </td>
            </tr>
        </table>

    </div>
</div>

<!-- popup contents for facility selection - Room 1-->
<div class="pop" id="popupFacilities">

    <span id="closePopupFacilities" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_COMP"/>
                        <label for="checkbox_COMP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_DDP"/>
                        <label for="checkbox_DDP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_DP"/>
                        <label for="checkbox_DP" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_IL"/>
                        <label for="checkbox_IL" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_MP"/>
                        <label for="checkbox_MP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_PA"/>
                        <label for="checkbox_PA" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_PLASMA"/>
                        <label for="checkbox_PLASMA" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_REV"/>
                        <label for="checkbox_REV" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_MIC"/>
                        <label for="checkbox_MIC" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_VIS"/>
                        <label for="checkbox_VIS" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_Wchair"/>
                        <label for="checkbox_Wchair" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_WB"/>
                        <label for="checkbox_WB" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>


<!-- popup contents for facility selection - Room 2-->
<div class="pop" id="popupFacilities2">

    <span id="closePopupFacilities2" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_COMP2"/>
                        <label for="checkbox_COMP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_DDP2"/>
                        <label for="checkbox_DDP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_DP2"/>
                        <label for="checkbox_DP2" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_IL2"/>
                        <label for="checkbox_IL2" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_MP2"/>
                        <label for="checkbox_MP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_PA2"/>
                        <label for="checkbox_PA2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_PLASMA2"/>
                        <label for="checkbox_PLASMA2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_REV2"/>
                        <label for="checkbox_REV2" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_MIC2"/>
                        <label for="checkbox_MIC2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_VIS2"/>
                        <label for="checkbox_VIS2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_Wchair2"/>
                        <label for="checkbox_Wchair2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_WB2"/>
                        <label for="checkbox_WB2" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
    


<!-- popup contents for facility selection - Room 2-->
<div class="pop" id="popupFacilities3">

    <span id="closePopupFacilities3" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_COMP3"/>
                        <label for="checkbox_COMP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_DDP3"/>
                        <label for="checkbox_DDP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_DP3"/>
                        <label for="checkbox_DP3" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_IL3"/>
                        <label for="checkbox_IL3" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_MP3"/>
                        <label for="checkbox_MP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_PA3"/>
                        <label for="checkbox_PA3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_PLASMA3"/>
                        <label for="checkbox_PLASMA3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_REV3"/>
                        <label for="checkbox_REV3" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_MIC3"/>
                        <label for="checkbox_MIC3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_VIS3"/>
                        <label for="checkbox_VIS3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_Wchair3"/>
                        <label for="checkbox_Wchair3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_WB3"/>
                        <label for="checkbox_WB3" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
 
    <!-- box to show validation errors -->
    <div id="validationContainer" style="display:none">

            <table style="table-layout:fixed; width:100%; height:90%; position:relative; color:black;text-align:center">
                <tr>
                    <td id="messageContents" style="font-size: 1em;">
                        <!-- filled in with js depending on error -->
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" id="closeValidation" class="orangeButton" style="width:30%;" value="OK"/>
                    </td>
                </tr>
            </table>
    
    </div>

    <!-- box to show validation errors -->
    <div id="confirmationContainer" style="display:none">

            <table style="table-layout:fixed; width:100%; left:10px; height:90%; position:relative; color:black;text-align:center">
                <tr>
                    <td style="font-size: 1em; text-align:center" colspan="2">
                        
                    </td>
                </tr>
                <tr>
                     <td id="confirmationContents" style="font-size: 1em; text-align:center" colspan="2">
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea style="max-height:100px; max-width:92%; min-width:40%; color: black; position:relative; text-align:center;"  wrap="soft" placeholder="Please enter any 'Special Requirements' here."></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Please double check the details above to ensure that they are correct. If you are happy, click 'Yes' to submit.
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" id="submitRequest" class="greenButton" style="width:30%; float:right;" value="Yes"/>
                    </td>
                    <td>
                        <input type="button" id="cancelRequest" class="orangeButton" style="width:30%; float:left;" value="No" />
                    </td>
                </tr>
            </table>
    
    </div>
</asp:Content>
