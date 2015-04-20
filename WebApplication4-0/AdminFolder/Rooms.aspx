﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Rooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

 <style>
        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=80);
        }
        .white_content {
            display: none;
            position: absolute;
            top: 30%;
            right: 30%;
            width: 40%;
            max-width:370px;
            height: 250px;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }


    .buildingHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
        clear:both;
    }

    .roomInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }

    #buttonsDiv{
        float:right;
        margin-right:5%;
    }
</style>

<div class="contentHolder">

    <h1 align="center">Rooms</h1>
    <div id="buttonsDiv">
        <input type="button" ID="addRoom" Value="Add Room" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
        <input type="button" ID="addFacility" Value="Add Facility" onclick = "document.getElementById('light2').style.display = 'block'; document.getElementById('fade2').style.display = 'block'" />
    </div>

    <div id="light" class="white_content">
        <h1>New Room</h1>
        Building: <br />
        <asp:TextBox id="TextBox1" runat="server" /><br />
        Room Number: <br />
        <asp:TextBox id="TextBox2" runat="server" />
        Capacity: <br />
        <asp:TextBox id="TextBox5" runat="server" />
        Room Type: <br />
        <asp:TextBox id="TextBox6" runat="server" />

        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" /> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>

    <div id="fade" class="black_overlay">
    </div>

            

    <div id="light2" class="white_content">
        <h1>New Facility</h1>
        Facility Name: <br />
        <asp:TextBox id="TextBox3" runat="server" /><br />
        Facility ID: <br />
        <asp:TextBox id="TextBox4" runat="server" />

        <br />
        <asp:Button ID="Button2" runat="server" Text="Save" /> 
        <input type="button" ID="closeInsert2" value="Close" onclick = "document.getElementById('light2').style.display = 'none'; document.getElementById('fade2').style.display = 'none'" />

    </div>

    <div id="fade2" class="black_overlay">
    </div>
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

    <div class="buildingHeader" >
        <h2 class="white">Haslegrave - East Park</h2> 
    </div>

    <table class="roomInfoTable">
        <tr>
            <th>Room No</th><th>Capacity</th><th>Room Type</th><th>Facilities</th>
        </tr>
        <tr>
            <td>N.0.0.1</td><td>120</td><td>Lab</td><td>OHP, Wheelchair Access, Dual Projectors</td><td></td>
        </tr>
        <tr>
            <td>N.0.0.2</td><td>100</td><td>Lab</td><td>Visualiser, Wheelchair Access, Dual Projectors</td><td></td>
        </tr>
    </table>




         
   


</div> 

    

</asp:Content>
