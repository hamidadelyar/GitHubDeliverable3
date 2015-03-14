<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication4_0.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#progressbar").progressbar({
                value: 37
            });
        });
    </script>
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
            padding-top:10px;
            width:100%;
            background-color:#3E454D;
        }
        #progressbar{
            width:94%;
            margin-left:3%;
            margin-right:3%;
            margin-bottom:15px;
        }

        .ui-progressbar-value{
            background:#79A2B8;
        }

        #newsTable{
            
            margin: 10px 5% 10px 5%;
            width:90%;

        }

        #activityTable{
            
            margin: 10px 5% 10px 5%;
            width:90%;
        }

        .white{
            color:white;
        }

        .leftBorder{
            border-left: 1px solid black; 
        }

        h1{
            margin-bottom:10px;
           
        }

        h2 {
            margin-top:0px;
        }

        #containerTable{
            width:100%;
        }

    </style>
    
    <div class="contentHolder">
        <h1 align="center">Time until end of Round XX</h1>
        
        <div id="progressbar"></div>

        <div class="updatesHolder">
            <h2 class="white" align="center">Request Results:</h2>
            <p class="white" align="center">There are currently no new request results.</p>
            <br />
            <br />
        </div>
        <table id="containerTable">
            <tr>
                <td style="text-align:center;"><table id="newsTable">
                    <tr>
                        <th colspan="3"  style="text-align:center;">News & Announcements</th>
                    </tr>
                    <tr>
                        <td>Round 1 Has Started</td><td>13/03/2015</td><td>Details</td>
                    </tr>
                    <tr>
                        <td>AD Hoc Round Has Started</td><td>10/03/2015</td><td>Details</td>
                    </tr>
                    <tr>
                        <td>Tips for Creating Requests</td><td>04/03/2015</td><td>Details</td>
                    </tr>
                </table>
                </td>
                <td class="leftBorder"  style="text-align:center;">
                <table id="activityTable">
                    <tr>
                        <th colspan="3"  style="text-align:center;">Recent Activity</th>
                    </tr>
                    <tr>
                        <td>Request for COA123 made</td><td>13/03/2015</td><td>View</td>
                    </tr>
                    <tr>
                        <td>#Announcement#</td><td>11/03/2015</td><td>View</td>
                    </tr>
                    <tr>
                        <td>#Announcement#</td><td>10/03/2015</td><td>View</td>
                    </tr>
                </table></td>
            </tr>
        </table>
    </div>
</asp:Content>
