<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Rooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="AdminStyle.css"> 

<style>
    .buildingHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
    }

    .roomInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }
</style>

<div class="contentHolder">

    <h1 align="center">Rooms</h1>
    <asp:Button ID="addRoom" runat="server" Text="Add Room" />
    <asp:Button ID="addFacility" runat="server" Text="Add Facility" />

    <div class="buildingHeader" >
        <h2 class="white">James France - East Park</h2> 
    </div>

    <table class="roomInfoTable">
        <tr>
            <th>Room No</th><th>Capacity</th><th>Room Type</th><th>Facilities</th>
        </tr>
        <tr>
            <td>JF.0.0.1</td><td>120</td><td>Lecture</td><td>OHP, Wheelchair Access, Dual Projectors</td><td></td>
        </tr>
        <tr>
            <td>JF.0.0.2</td><td>100</td><td>Lab</td><td>Visualiser, Wheelchair Access, Dual Projectors</td><td></td>
        </tr>
    </table>
</div> 

    

</asp:Content>
