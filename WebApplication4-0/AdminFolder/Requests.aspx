<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Requests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="AdminStyle.css"> 

<style>
    .requestHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
    }

    .requestInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }
</style>

<div class="contentHolder">
    <h1 align="center">Requests</h1>
    

    <div class="requestHeader">
        <h2 class="white">COA123 - Server Side Programming</h2> 
    </div>

    <table class="requestInfoTable">
        <tr>
            <th>Day</th><th>Start Time</th><th>End Time</th><th>Weeks</th><th>Students</th>
        </tr>
        <tr>
            <td>1 - Monday</td><td>2 - 10:00</td><td>3 - 11:00</td><td>1-12</td><td>100</td><td>
                <asp:Button ID="respondButton1" runat="server" Text="Respond" /></td>
        </tr>
    </table>





    <div class="requestHeader">
        <h2 class="white">COA101 - Team Projects</h2>
    </div>

    <table class="requestInfoTable">
        <tr>
            <th>Day</th><th>Start Time</th><th>End Time</th><th>Weeks</th><th>Students</th>
        </tr>
        <tr>
            <td>3 - Wednesday</td><td>4 - 12:00</td><td>6 - 14:00</td><td>1-12</td><td>150</td><td>
                <asp:Button ID="respondButton2" runat="server" Text="Respond" /></td>
        </tr>
    </table>



</div> 


</asp:Content>