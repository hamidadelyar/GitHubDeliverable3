<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="WebApplication4_0.Request" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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

.line{
    background: #3E454D;
    float:left;
    width:100%;
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

   
      
    </style>




    <script type="text/javascript">
       
   

        $(document).ready(function () {

            //on any input for the modcode, the data is sent to the c# function. This performs query on server and sends back data.
            //returns relevant modname depending on modcode entered
            $('#MainContent_modcodeInput').on('input propertychange paste', function () {
                var modcode = $('#MainContent_modcodeInput').val();
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
                        document.getElementById('MainContent_modnameInput').value = result.d;   //have to write as result.d for some reason
                    }
                });
            });

            //on any input to modname, tries to find relevant modcode and updates modcode input
            //does same thing as function above, but for modname
            $('#MainContent_modnameInput').on('input propertychange paste', function () {
                var modname = $('#MainContent_modnameInput').val();
               
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
                        document.getElementById('MainContent_modcodeInput').value = result.d;   //have to write as result.d for some reason
                    }
                });
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
            <tr>
                <td>
                    <asp:Label ID="modcodeLabel" runat="server" Text="MODULE CODE" ToolTip="Enter a module code i.e. COA123"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="modcodeInput" runat="server"></asp:TextBox>
                </td>

                <td>
                    <asp:Label ID="modnameLabel" runat="server" Text="MODULE NAME" ToolTip="Enter a module name i.e. Server Side Programming"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="modnameInput" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="capacityLabel" runat="server" Text="CAPACITY" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                     <asp:TextBox ID="capacityInput" runat="server"></asp:TextBox>
                    
                </td>
            </tr>

            <!-- line seperator-->
            <tr>
                <td colspan="6">
                    <div class="line"></div>
                </td>
            </tr>

            <!-- Facility section -->
            <tr>
                <td>
                    <b>FACILITY OPTIONS</b>
                </td>
            </tr>

            <tr style="height:100px">
                <td>
                    <asp:Label ID="roomType" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     <div class="divClass">
                         <input type="radio" name="radio" id="radioLecture" class="radio" checked onclick =""> <!-- checked by default -->
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
                    <p id="testpara" runat="server"></p>
                </td>
               
            </tr>


            
                


         </table>
        
    </div>
    
</asp:Content>
