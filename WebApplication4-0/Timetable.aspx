<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.24.min.js" type="text/javascript"></script>
    <script>var roomsArray = <%= this.data %>;</script>
    <script>var modsArray = <%= this.modData %>;</script>
    <script>var lectsArray = <%= this.lectData %>;</script>
    <script src="Scripts/Loading.js" type="text/javascript" ></script>
    <script src="Scripts/Timetable.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="Content/Timetable.css" />
    <div class="switchView" onclick="window.location.href = 'FindRoom.aspx'" >FIND FREE ROOM <img src="./Images/RightArrow.png" height="11" width="6" /></div>
    <div class="topSpacer" >&nbsp;</div>
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
    <div class="whiteSpace" ></div>
</asp:Content>
