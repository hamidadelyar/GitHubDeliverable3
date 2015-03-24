<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="WebApplication4_0.Request" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.24.min.js" type="text/javascript"></script>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
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

 
     #preferenceTable{
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
	content:'\03a7';
	text-indent: .2em;
	/*color: #C2C2C2;*/
    color:#fff;
}

.divClass input.radio:hover:not(:checked) ~ label {
	color: #888;
}

/* toggle on */
.divClass input.radio:checked ~ label:before {
	content:'\03a7'; /* this is the css symbol, e.g. X */
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

.circle{
   
}

/*
#MainContent_RequiredFieldValidator1{
    font-size:2em;
    text-align:center;
    cursor:pointer;
}
*/
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
   
      
    </style>




    <script type="text/javascript">
       
   

        $(document).ready(function () {

            //on any input for the modcode, the data is sent to the c# function. This performs query on server and sends back data.
            //returns relevant modname depending on modcode entered
            $('#modcodeInput').on('input propertychange paste click focusout', function () {
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
            $('#modnameInput').on('input propertychange paste click focusout', function () {
              
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
        });



       
      
      
        
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
                    <asp:Label ID="capacityLabel" for="capacityInput" runat="server" Text="CAPACITY" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                     <asp:TextBox ID="capacityInput" runat="server"></asp:TextBox>
                </td>
                <td>   
                     <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="capacityInput" ErrorMessage="Please enter a number within the range 5-500" ForeColor="Red" MaximumValue="500" MinimumValue="5" SetFocusOnError="True"></asp:RangeValidator>
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
                    <asp:Label ID="Label1" runat="server" Text="Start Time"></asp:Label>
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
                    <asp:Label ID="startTimeSelectLabel" runat="server" Text="End Time"></asp:Label>
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

        <!-- preference table -->

        <table id="preferenceTable" style="display:none">
            <!-- Facility section -->
            <tr>
                <td>
                    <b>FACILITY OPTIONS</b>
                </td>
            </tr>

             <tr>
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
                   
                </td>
            </tr>

            <tr>
                <td colspan="6">
                    <input type="button" id="preferencesDoneButton" value="Done" />
                </td>
            </tr>
        </table>
        
    </div>
    
</asp:Content>
