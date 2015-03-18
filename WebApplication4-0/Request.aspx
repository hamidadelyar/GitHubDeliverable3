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

 

   
      
    .auto-style1 {
        width: 73%;
    }

 

   
      
</style>

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
                    Lecture
                </td>  
                <td>
                    Wheelchair access
                </td>
               
            </tr>


            
                


         </table>
        
    </div>
    
</asp:Content>
