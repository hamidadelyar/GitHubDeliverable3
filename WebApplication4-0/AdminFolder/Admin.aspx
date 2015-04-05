<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication4_0.Admin" MasterPageFile="~/AdminFolder/AdminSite.master" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>

	
    <link rel="stylesheet" href="css/style.css"> 
    <!-- Resource style -->
	
    <script src="js/modernizr.js"></script> 
    <!-- Modernizr -->
  	


    <div class="contentHolder">
        <h1 align="center">Welcome, Admin.</h1>

        <div class="updatesHolder">
            <h2 class="white" align="center">New Requests:</h2>
            <p class="white" align="center">There are currently no new requests.</p>
            <br />
            <br />
        </div>
                <table id="newsTable">
                    <tr>
                        <th colspan="4"  style="text-align:center;">News & Announcements</th>
                    </tr>
                    <tr>
                        <td>Round 1 Has Started</td><td>13/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                    <tr>
                        <td>AD Hoc Round Has Started</td><td>10/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                    <tr>
                        <td>Tips for Creating Requests</td><td>04/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                </table>

        <asp:SqlDataSource 
            ID="SqlDataSource1"
            runat="server" >

        </asp:SqlDataSource>
            
    </div>

</asp:Content>