<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
     <script>
         var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK IFTEEN"];
         var currWeek = 1;
         $(document).ready(function () {
             $('.leftWk').html(weeksArray[currWeek - 1].substring(5));
             $('.centWk').html(weeksArray[currWeek]);
             $('.rightWk').html(weeksArray[currWeek + 1].substring(5));
         });
         $('.leftWk').click(function () {

         });
     </script>
     <style>
        .timetblHolder
        {
            margin-top:50px;
            width:75%;
            height:600px;
            border-top-left-radius:10px;
            border-bottom-left-radius:10px;
            background-color:#FFF;
            float:left;
        }
        .timetbl
        {
            margin-left:2.5%;
            width:95%;
            height:90%;
            table-layout:fixed;
            text-align:center;
            color:#3E454D;
        }
        td
        {
            padding:0!important;
        }
        .btmBdr
        {
            border-bottom:#FF8060 solid 1px;
        }
        .rightBdr
        {
            border-right:#FF8060 solid 1px;
        }
        .select
        {
            font-size:1.4em;
            color:#3E454D;
        }
        .nonSelect
        {
            color:#FF8060;
        }
        .toolsHolder
        {
            color:#FFF!important;
            margin-top:50px;
            float:right;
            width:25%;
            height:600px;
            border-top-right-radius:10px;
            border-bottom-right-radius:10px;
            background-color:#3E454D;
        }
        .toolsHolder div
        {
            width:95%;
            margin-left:2.5%;
            text-align:center;
        }
        .hdr
        {
            margin-top:10%;
            font-size:1.4em;
            color:#FFF;
        }
        .rooms
        {
            margin-top:25%;
            border-bottom:#FFF solid 1px;
        }
        .rooms input
        {
            background-color:transparent;
            border:none;
            padding:0;
            width: -moz-calc(100% - 23px);
            width: -webkit-calc(100% - 23px);
            width: calc(100% - 23px);
        }
        .rooms img
        {
            cursor:pointer;
        }
        .whiteSpace
        {
            height:50px;
            width:100%;
            float:left;
        }
    </style>
    <div class="timetblHolder" >
        <table class="timetbl" >
            <tr>
                <td colspan="2" class="leftWk nonSelect" ></td>
                <td colspan="2" class="select" ><b class="centWk" ></b></td>
                <td colspan="2" class="rightWk nonSelect" ></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="days" ><b>MON</b></td>
                <td class="days" ><b>TUE</b></td>
                <td class="days" ><b>WED</b></td>
                <td class="days" ><b>THUR</b></td>
                <td class="days" ><b>FRI</b></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >09:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >10:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >11:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >12:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >13:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >14:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >15:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >16:00</td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr" ></td>
            </tr>
            <tr>
                <td class="rightBdr" >17:00</td>
                <td class="rightBdr" ></td>
                <td class="rightBdr" ></td>
                <td class="rightBdr" ></td>
                <td class="rightBdr" ></td>
                <td></td>
            </tr>
        </table>
    </div>
    <div class="toolsHolder" >
        <div class="hdr" ><b>TOOLS</b></div>
        <div class="rooms" ><b>ROOM</b><br /><input type="text" name="roomTxt" /><img src="Images/clear.png" width="23" height="15" /></div>
    </div>
    <div class="whiteSpace" ></div>
    <p id="sessionTest" runat="server"></p>
</asp:Content>
