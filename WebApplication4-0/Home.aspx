<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication4_0.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    <style>
        .contentHolder
        {
            margin-top:50px;
            width:100%;
            height:600px;
            border-top-left-radius:10px;
            border-top-right-radius:10px;
            border-bottom-left-radius:10px;
            border-bottom-right-radius:10px;
            background-color:#FFF;
            float:left;
        }
        .updatesHolder
        {
            margin-top:10px;
            width:100%;
            height:200px;
            background-color:#3E454D;
        }

    </style>
    <div class="contentHolder">
        <h1 align="center">Time until end of Round XX</h1>
        
        <div class="updatesHolder">

        </div>
        
        <table>
            <tr>
                <th colspan="2">News & Announcements</th>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
        </table>
        <table>
            <tr>
                <th colspan="2">Recent Activity</th>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
            <tr>
                <td>Round 1 Has Started</td><td>13/03/2015</td>
            </tr>
        </table>
    </div>
</asp:Content>
