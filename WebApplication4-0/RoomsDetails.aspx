﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomsDetails.aspx.cs" Inherits="WebApplication4_0.RoomsDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>var roomsArray = <%= this.roomData %>;</script>
    <script>var modsArray = <%= this.modData %>;</script>
    <script>var lectsArray = <%= this.lectData %>;</script>
    <script src="Scripts/Loading.js" type="text/javascript" ></script>
    <script src="Scripts/Timetable.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="Content/Timetable.css" />
    <script>
        var facs = <%= this.facs %>;
        $(document).ready(function(){
            $('.noImg').hide();
            for(var i = 0; i < facs.length; i++)
            {
                $('#'+facs[i]['Facility_ID']).addClass('selected')
            }
        });
        function imgError(image)
        {
            image.onerror = "";
            $('.dataHolder img').hide();
            $('.noImg').show();
            $('.noImg img').show();
            return true;
        }
        function scrollFrame()
        {

        }
    </script>
    <style>
        .dataHolder
        {
            color:#FFF!important;
            margin-top:50px;
            width:95%;
            padding:2.5%;
            border-radius:10px;
            background-color:#FFF;
            height:173px;
        }
        .dataHolder img
        {
            float:left;
            display:inline;
            height:173px;
            width:250px;
            margin-right:25px;
        }
        .noImg
        {
            float:left;
            display:inline;
            height:173px;
            width:250px;
            margin-right:25px;
            background-color:#999;
        }
        .noImg img
        {
            position:relative;
            top:50%;
            margin-top:-32px;
            left:50%;
            margin-left:-32px;
            height:64px;
            width:64px;
        }
        .detHolder
        {
            display:inline-block;
            margin-top:-7px;
            color:#999;
        }
        .hdr
        {
            color:#FF8060;
            font-size:1.4em;
        }
        .facHolder
        {
            margin-top:50px;
            width:95%;
            background-color:#3E454D;
            border-radius:10px;
            padding:0.5% 2.5% 2% 2.5%;
            min-width:800px;
        }
        .facChecks
        {
            width:105%;
            color:#FFF;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
        }
        .line
        {
            position:relative;
            left:7px;
            top:-3px;
            height:13px;
            width:30px;
            background-color:#FFF;
            border-radius:3px;
            display:inline-block;
        }
        .circ
        {
            position:relative;
            top:2.5px;
            left:-35px;
            height:25px;
            width:25px;
            background-color:#999;
            border-radius:35px;
            display:inline-block;
            cursor:default;
        }
        .selected
        {
            left:-7px;
            background-color:#FF8060;
        }
    </style>
        <div class="dataHolder" >
            <img src="Images/Room Pictures/<%= this.img %>.jpg" onerror="imgError(this)"/>
            <span class="noImg" ><img src="Images/Room Pictures/noImage.png" /></span>
            <span class="detHolder" >
                <b class="hdr" >ROOM: <%= this.code %></b><br /><br />
                <b>BUILDING: <%= this.building %></b><br />
                <b>CAPACITY: <%= this.capacity %></b><br />
                <b>TYPE: <%= this.type %></b><br />
                <b>PARK: <%= this.park %></b><br />
            </span>
        </div>
        <div class="facHolder" >
            <table class="facChecks">
                <tr>
                    <td class="subHdr" colspan="8"><b>FACILITIES</b></td>
                </tr>
                <tr class="facRw">
                    <td><b>COMPUTER</b></td><td> <span class="line" ></span><span class="circ" id="C"></span></td>
                    <td><b>MEDIA PLAYER</b></td><td> <span class="line" ></span><span class="circ" id="MP"></span></td>
                    <td><b>MICROPHONE</b></td><td > <span class="line" ></span><span class="circ" id="RM"></span></td>
                    <td><b>DATA PROJECTOR</b></td><td> <span class="line" ></span><span class="circ" id="DP"></span></td>
                </tr>
                <tr class="facRw">
                    <td><b>PLASMA SCREEN</b></td><td> <span class="line" ></span><span class="circ" id="PS"></span></td>
                    <td><b>VISUALISER</b></td><td> <span class="line" ></span><span class="circ" id="V"></span></td>
                    <td><b>PA</b></td><td> <span class="line" ></span><span class="circ" id="PA"></span></td>
                    <td><b>DUAL DATA PROJECTION</b></td><td> <span class="line" ></span><span class="circ" id="DDP"></span></td>
                </tr>
                <tr class="facRw">
                    <td><b>WHEELCHAIR</b></td><td> <span class="line" ></span><span class="circ" id="W"></span></td>
                    <td><b>WHITEBOARD</b></td><td> <span class="line" ></span><span class="circ" id="WB"></span></td>
                    <td><b>REVIEW</b></td><td> <span class="line" ></span><span class="circ" id="RLC"></span></td>
                    <td><b>INDUCTION LOOP</b></td><td> <span class="line" ></span><span class="circ" id="I"></span></td>
                </tr>
            </table>
        </div>
        <div class="timetblHolder" >
        <table class="timetbl">
            <tr>
                <td colspan="2" class="nonSelect" ><span class="leftWk weekBtn"></span></td>
                <td colspan="2" class="select" ><b class="centWk"></b></td>
                <td colspan="2" class="nonSelect" ><span class="rightWk weekBtn"></span></td>
            </tr>
            <tr class="weeksRw">
                <td colspan="2" ></td>
                <td colspan="2" >
                    <table class="weeksTbl">
                        <tr>
                            <td><span class="weekBtn" >1</span></td><td><span class="weekBtn" >2</span></td><td><span class="weekBtn" >3</span></td><td><span class="weekBtn" >4</span></td>
                        </tr>
                        <tr>
                            <td><span class="weekBtn" >5</span></td><td><span class="weekBtn" >6</span></td><td><span class="weekBtn" >7</span></td><td><span class="weekBtn" >8</span></td>
                        </tr>
                        <tr>
                            <td><span class="weekBtn" >9</span></td><td><span class="weekBtn" >10</span></td><td><span class="weekBtn" >11</span></td><td><span class="weekBtn" >12</span></td>
                        </tr>
                        <tr>
                            <td><span class="weekBtn" >13</span></td><td><span class="weekBtn" >14</span></td><td><span class="weekBtn" >15</span></td><td></td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" ></td>
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
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >10:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >11:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >12:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >13:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >14:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >15:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="btmBdr rightBdr" >16:00</td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr slot" ></td>
                <td class="btmBdr rightBdr" ></td>
                <td class="btmBdr slot" ></td>
            </tr>
            <tr>
                <td class="rightBdr" >17:00</td>
                <td class="rightBdr slot" ></td>
                <td class="rightBdr slot" ></td>
                <td class="rightBdr slot" ></td>
                <td class="rightBdr slot" ></td>
                <td></td>
            </tr>
        </table>
        <div class="greyOut" ><img src="Images/Loading.png" width="70" height="70" /></div>
    </div>
    <div class="toolsHolder" >
        <div class="hdr" ><b>TOOLS</b></div>
        <div class="options" ><span class="roomChoice choice" >ROOM</span> | <span class="modChoice choice" >MODULE</span> | <span class="lectChoice choice" >LECTURER</span></div>
        <div class="rooms" ><b>ROOM</b><br /><input style="text-transform:uppercase" autocomplete="off" type="text" class="roomTxt" id="roomTxt" name="roomTxt" value="<%= this.code %>" /><img id="clearImg" src="Images/clear.png" width="23" height="15" /></div>
        <div class="suggest" >
            <table class="suggestTbl">
            </table>
        </div>
        <div class="semesters" ><b>SEMESTERS</b><br /><span class="semOne semBtn" >ONE</span><span class="splitter" ></span><span class="semTwo semBtn" >TWO</span></div>
    </div>
</asp:Content>
