<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('.parkMen').hide();
            $('.weekMen').hide();
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
            margin-top:3%;
            width:95%;
            table-layout:fixed;
            text-align:center;
            color:#3E454D;
            font-size:1.4em;
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
        .menArr
        {
            -ms-transform: rotate(90deg); /* IE 9 */
            -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
            transform: rotate(90deg);
        }
        .park
        {
            margin-top:23px;
            color:#FFF;
        }
        .parkBtn
        {
            position:relative;
            padding:10px;
            top:25px;
            border-radius:7px;
            cursor:pointer;
            font-size:0.8em;
            background-color:#2B3036;
        }
        .parkBtn:hover
        {
            background-color:#FF8060;
        }
        .week
        {
            margin-top:23px;
            color:#FFF;
        }
        .weekBtn
        {
            position:relative;
            padding:10px;
            top:25px;
            border-radius:7px;
            cursor:pointer;
            font-size:0.8em;
            margin-top:5px;
            background-color:#2B3036;
        }
        .weekBtn:hover
        {
            background-color:#FF8060;
        }
        .secRow
        {
            top:52px!important;
        }
        .thirdRow
        {
            top:77px!important;
        }
        .splitter
        {
            position:relative;
            background-color:#3E454D;
            padding:5px;
            top:25px;
            width:5px;
        }
        .greyOut
        {
            position:relative;
            left:2.5%;
            background-color:#FFF;
            height:80%;
            width:95%;
            display:block;
        }
        .greyOut img
        {   
            position:relative;
            left:50%;
            top:50%;
            margin-left:-35px;
            margin-top:-35px;
        }
        .switchView
        {
            float:right;
            padding:10px;
            color:#FFFFFF;
            background-color:#3E454D;
            border-radius:10px;
            font-weight:bold;
            cursor:pointer;
        }
        .switchView:hover
        {
            background-color:#2B3036;
        }
        .whiteSpace
        {
            height:30px;
            width:100%;
            float:left;
        }
    </style>
    <div class="timetblHolder" >
        <table class="timetbl" >
            <tr>
                <td><b>POSSIBLE ROOMS</b></td>
            </tr>
        </table>
        <!--<div class="greyOut" ><img src="Images/Loading.png" width="70" height="70" /></div>-->
    </div>
    <div class="toolsHolder" >
        <div class="hdr" ><b>TOOLS</b></div>
        <div class="park" ><b>PARK &nbsp;<img class="menArr" src="Images/RightArrow.png" width="6" height="11" /></b><br /><span class="parkMen" ><span class="parkBtn" >WEST</span><span class="splitter" ></span><span class="parkBtn" >CENTRAL</span><span class="splitter" ></span><span class="parkBtn" >EAST</span></span></div>
        <div class="week" ><b>WEEK &nbsp;<img class="menArr" src="Images/RightArrow.png" width="6" height="11" /></b><br /><span class="weekMen" >
            <span class="weekBtn" >01</span><span class="splitter"></span><span class="weekBtn" >02</span><span class="splitter"></span><span class="weekBtn" >03</span><span class="splitter"></span><span class="weekBtn" >04</span><span class="splitter"></span><span class="weekBtn" >05</span>
            <span class="weekBtn secRow" >06</span><span class="splitter secRow"></span><span class="weekBtn secRow" >07</span><span class="splitter secRow"></span><span class="weekBtn secRow" >08</span><span class="splitter secRow"></span><span class="weekBtn secRow" >09</span><span class="splitter secRow"></span><span class="weekBtn secRow" >10</span>
            <span class="weekBtn thirdRow" >11</span><span class="splitter thirdRow"></span><span class="weekBtn thirdRow" >12</span><span class="splitter thirdRow"></span><span class="weekBtn thirdRow" >13</span><span class="splitter thirdRow"></span><span class="weekBtn thirdRow" >14</span><span class="splitter thirdRow"></span><span class="weekBtn thirdRow" >15</span>        
        </span></div>
    </div>
    <div class="whiteSpace" ></div>
    <div class="switchView" onclick="window.location.href = 'Timetable.aspx'" >VIEW TIMETABLES <img src="/Images/RightArrow.png" height="11" width="6" /></div>
</asp:Content>