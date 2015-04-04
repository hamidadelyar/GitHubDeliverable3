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
            width:100%;
            height:600px;
            border-radius:10px;
            background-color:#FFF;
            float:left;
        }
        
     #requestTable
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
	color: #9CE2AE;
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
                    data: JSON.stringify({ modcode: modcode}),
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
                document.getElementById("requestTable").style.display = "none";
                document.getElementById("preferenceTable").style.display = "";
            });
            $('#preferencesDoneButton').click(function () {
                document.getElementById("requestTable").style.display = "";
                document.getElementById("preferenceTable").style.display = "none";
            });
           
            
         
            //autocomplete function for module name
            //minimum number of characters = 3, before search begins
            $("#modnameInput").autocomplete({minLength:3},{
                
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

       
            /* function to apply effects of blurring the background, whilst showing popup, then when popup closes, the background returns to normal */
            $(function () {
              //  $('.pop').hide(); //initially hidden

                $("#defaultWeeksNo").click(function () { //onclick, fades in to display
                    $('.pop').fadeIn(1000);
                    $('#requestContainer').removeClass('blur-out');
                    $('#requestContainer').addClass('blur-in');
                    
                    //only blurs the text in the footer
                    $('footer .float-left').removeClass('blur-out'); 
                    $('footer .float-left').addClass('blur-in');

                    //blurs header content, i.e. navigation
                    $('header').removeClass('blur-out');
                    $('header').addClass('blur-in');

                    
                   
                });

                $("#closePopup").click(function () { //onclick, fades out
                    $('.pop').fadeOut(1000);
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
            
            //allows user to go to preferences for 2nd room. So can select a different room on inputted capacity etc.
            $('#gotoRoom2').click(function () {
                $('#preferenceTable').hide();
                $('#preferenceTable2').show();


            });
           


        }); //document.ready closing tag


        /*
        function showPopup() { 
            $("#defaultWeeksNo").click(function () { //onclick, fades in to display
                $('.pop').fadeIn(1000);
                $('#requestContainer').removeClass('blur-out');
                $('#requestContainer').addClass('blur-in');

            });   
        }

        function hidePopup() { 
                $('.pop').fadeOut(1000);
                //$('#requestContainer').removeClass('blur-in');
                $('#requestContainer').addClass('blur-out');
                $('#requestContainer').removeClass('blur-in');

        }*/
      
      
        
    </script>

    <div id="requestContainer">
        <table id="requestTable">
            <tr>
                <td>
                    <b>MODULE DETAILS</b>
                </td>
            </tr>

              <!-- line seperator-->
            <tr>
                <td colspan="6">
                    <div class="line"></div>
                </td>
            </tr>

            <tr>
                <!-- module code input with validator-->
                <td>
                   <asp:Label ID="modcodeLabel" ToolTip="Enter a module code i.e. COA123" runat="server" Text="MODULE CODE" ></asp:Label>
                </td>
                <td>
                    <input type="text" ID="modcodeInput" style="width:200%;"/>
               
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
                    <input type="text" ID="modnameInput" style="width:200%;"/>
                    <!--<asp:TextBox ID="modnameInput" runat="server" style="width:135%;"></asp:TextBox>-->
                </td>
                <td>
                    <!-- empty -->
                </td>
            </tr>
            <tr>
                <td>   
                    <asp:Label ID="Label2" runat="server" Text="NUMBER OF ROOMS"></asp:Label>
                </td>
                <td>
                     <div class="styled-select">
                        <select>
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select>
                     </div>
                </td>
            </tr>

          

            <tr>
                <td>
                    <asp:Label ID="daySelectLabel" runat="server" Text="DAY"></asp:Label>
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
                    <asp:Label ID="Label1" runat="server" Text="START TIME"></asp:Label>
                </td>
                <td>
                    <div class="styled-select">
                        <select>
                            <option>09:00</option>
                            <option>10:00</option>
                            <option>11:00</option>
                            <option>12:00</option>
                            <option>13:00</option>
                            <option>14:00</option>
                            <option>15:00</option>
                            <option>16:00</option>
                            <option>17:00</option>
                        </select>
                    </div>
                </td>

                <td>
                    <asp:Label ID="startTimeSelectLabel" runat="server" Text="END TIME"></asp:Label>
                </td>
                <td>
                    <div class="styled-select">
                        <select>
                            <option>10:00</option>
                            <option>11:00</option>
                            <option>12:00</option>
                            <option>13:00</option>
                            <option>14:00</option>
                            <option>15:00</option>
                            <option>16:00</option>
                            <option>17:00</option>
                            <option>18:00</option>
                        </select>
                    </div>
                </td>
            </tr>

         

           
            <tr>
                <td colspan="6">
                    <input type="button" id="preferencesButton" value="Preferences"/>
                </td>
            </tr>
         </table>

        <!-- preference table for room 1-->

        <table id="preferenceTable" class="preferenceTable" style="display:none">
            <!-- Facility section -->
            <tr>
                <td>
                    <b>FACILITY OPTIONS</b>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <div class="line"></div>
                </td>
            </tr>
             <tr>
                 <td>
                    <asp:Label ID="capacityLabel" for="capacityInput" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput" />
                </td>
                <td>
                    <asp:Label ID="roomType" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     <div class="divClass">
                         <input type="radio" name="radio" id="radioLecture" class="radio" checked> <!-- checked by default -->
                         <label for="radioLecture">Lecture</label>
                     </div>
                     <div class="divClass">
                         <input type="radio" name="radio" id="radioSeminar" class="radio"/>
                         <label for="radioSeminar">Seminar</label>
                     </div>
                      <div class="divClass">
                         <input type="radio" name="radio" id="radioLab" class="radio"/>
                         <label for="radioLab">Lab</label>
                     </div>
                 </td>  

                 <td>
                    <asp:Label ID="Label3" runat="server" Text="DEFAULT WEEKS?" ToolTip="Default weeks are weeks 1 to 12"></asp:Label>
                 </td>
                 <td>
                     <div class="divClass">
                         <input type="radio" name="radioWeek" id="defaultWeeksYes" class="radio" checked /> <!-- checked by default -->
                         <label for="defaultWeeksYes">Yes</label>
                     </div>
                     <div class="divClass">
                         <input type="radio" name="radioWeek" id="defaultWeeksNo" class="radio"/>
                         <label for="defaultWeeksNo">No</label>
                     </div>
                 </td>
            </tr>

            <tr>
                 <td>
                     <asp:Label ID="Label4" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox">  
                         <input type="checkbox" name="park" id="centralPark" class="radio" checked/>
                         <label for="centralPark">Central</label>
                     </div>
                     <div class="divClassCheckbox">  
                         <input type="checkbox" name="park" id="westPark" class="radio" checked/>
                         <label for="westPark">West</label>
                     </div>
                     <div class="divClassCheckbox">  
                         <input type="checkbox" name="park" id="eastPark" class="radio" checked/>
                         <label for="eastPark">Central</label>
                     </div>
                 </td>

                <td>
                     <asp:Label ID="Label8" runat="server" Text="ROOM FACILITIES" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="COMP" class="radio" />
                        <label for="COMP">Computer</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="DDP" class="radio" /> <!-- dual data projection -->
                        <label for="DDP">DDP</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="DP" class="radio" />
                        <label for="DP">Data Projection</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="IL" class="radio" /> <!-- induction loop -->
                        <label for="IL">Induction Loop</label>
                    </div>
                </td>
                <td>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="MP" class="radio" />
                        <label for="MP">Media Player</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="PA" class="radio" />
                        <label for="PA">PA</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="PLASMA" class="radio" />
                        <label for="PLASMA">Plasma Screen</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="REV" class="radio" />
                        <label for="REV">ReView</label>
                    </div>
                </td>
                <td>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="MIC" class="radio" />
                        <label for="MIC">Microphone</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="VIS" class="radio" />
                        <label for="VIS">Visualiser</label>
                    </div>
                    <div class="divClassCheckbox" >
                        <input type="checkbox" id="Wchair" class="radio" />
                        <label for="Wchair">Wheelchair</label>
                    </div>
                    <div class="divClassCheckbox">
                        <input type="checkbox" id="WB" class="radio" />
                        <label for="WB">Whiteboard</label>
                    </div>
                </td>
            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton" value="Done" />
                </td>
                
                <td>
                    <input type="button" id="gotoRoom2" value="Next Room"/>
                </td>
            </tr>
        </table>

        <!-- preferences for 2nd room selection. Only selectable if user selects that they want to book 2 rooms.  -->
         <table id="preferenceTable2" class="preferenceTable" style="display:none">
            <!-- Facility section -->
            <tr>
                <td>
                    <b>FACILITY OPTIONS</b>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <div class="line"></div>
                </td>
            </tr>
        </table>
        
    </div>
    


<!-- popup contents for week selection-->
<div class="pop">

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
                    <input type="button" value="Reset" id="resetWeeks" style="margin-left:10px; background-color:white; width: 90%; border-radius:8px"/>
                </td>
               <td>
                    <input type="button" value="Select All" id="selectAllWeeks" style="background-color:white; width: 100%; border-radius:8px"/>
               </td>
            </tr>
        </table>

    </div>
</div>

    
</asp:Content>
