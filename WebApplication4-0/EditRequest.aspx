<%@ Page Title="Edit Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditRequest.aspx.cs" Inherits="WebApplication4_0.EditRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Content/EditRequest.css" />
    <script>
        var modData = <%= this.modData %>;
        var lectData = <%= this.lectData %>;
        var requestData = <%= this.request %>;
        var selLects = <%= this.selLects %>;
        var navigable = [];
        var curr = -1;
        var numLects = 0;
        $(document).ready(function(){
            $('.editHolder').hide();
        })
    </script>
    <script src="/Scripts/EditRequestControls.js" ></script>
    <script src="/Scripts/EditRequestPageLoad.js" ></script>
    <div class="editHolder reqHolder">
        <div class="hdr" ><b>EDIT REQUEST</b></div>
        <table class="modData">
            <tr>
                <td class="subHdr codeTit" id="modCode" colspan="3"><b>MODULE CODE</b><span class="alert" ></span></td>
                <td class="subHdr nameTit" id="modName" colspan="6"><b>MODULE TITLE</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp modTxt" id="modTxt"  /></td>
                <td colspan="6"><input autocomplete="off" type="text" class="inp nameTxt" id="nameTxt" /></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr dayTit" colspan="3"><b>DAY</b><span class="alert" ></span></td>
                <td class="subHdr startTit" colspan="3"><b>START TIME</b><span class="alert" ></span></td>
                <td class="subHdr endTit" colspan="3"><b>END TIME</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp dayTxt" id="dayTxt" /></td>
                <td colspan="3"><input autocomplete="off" type="text" class="inp startTxt" id="startTxt" /></td>
                <td colspan="3"><input autocomplete="off" type="text" class="inp endTxt" id="endTxt" /></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr roomTit" colspan="3"><b>NUMBER OF ROOMS</b><span class="alert" ></span></td>
                <td class="subHdr priTit" colspan="6"><b>PRIORITY</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp roomTxt" id="roomTxt" /></td>
                <td colspan="6"><span class="tickBox priTick priYes">&nbsp;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="1"/></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"></td>
                <td colspan="6"><span class="tickBox priTick selTick priNo">&#10004;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr lectTit" colspan="9"><b>LECTURER</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="9"><input autocomplete="off" type="text" class="inp lectTxt" id="lectTxt" /><span class="lectTick addLect">ADD</span><span class="lectTick subLect">DEL</span></td>
            </tr>
            <tr>
                <td colspan="9" class="lectList" ></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td colspan="9"><span class="prefBtn"><b>PREFERENCES</b></span><span class="subBtn"><b>SUBMIT</b></span></td>
            </tr>
        </table>
        <table class="codeHolderTbl">
        <tr class="codeRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
    </table>
    <table class="nameHolderTbl">
        <tr class="nameRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
    </table>
    <table class="dayHolderTbl">
        <tr class="dayRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="dayTbl" id="mon" >Monday</span></td>
        </tr>
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="dayTbl" id="tue" >Tuesday</span></td>
        </tr>
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="dayTbl" id="wed" >Wednesday</span></td>
        </tr>
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="dayTbl" id="thur" >Thursday</span></td>
        </tr>
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="dayTbl" id="fri" >Friday</span></td>
        </tr>
    </table>
    <table class="startHolderTbl">
        <tr class="startRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="nine" >09:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="ten" >10:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="eleven" >11:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="twelve" >12:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="thirt" >13:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="fourt" >14:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="fift" >15:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl" id="sixt" >16:00</span></td>
        </tr>
        <tr class="startRw">
            <td colspan="8"><span tabindex="99" class="startTbl"  id="sevent">17:00</span></td>
        </tr>
    </table>
    <table class="endHolderTbl">
        <tr class="dayRw">
            <td colspan="8"><span tabindex="99" class="triang"></span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="nineEnd" >09:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="tenEnd" >10:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="elevenEnd" >11:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="twelveEnd" >12:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="thirtEnd" >13:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="fourtEnd" >14:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="fiftEnd" >15:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="sixtEnd" >16:50</span></td>
        </tr>
        <tr class="endRw">
            <td colspan="8"><span tabindex="99" class="endTbl" id="seventEnd" >17:50</span></td>
        </tr>
    </table>
    <table class="roomHolderTbl">
        <tr class="roomRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
        <tr class="roomRw">
            <td colspan="8"><span tabindex="99" class="roomTbl" id="roomOne" >1</span></td>
        </tr>
        <tr class="roomRw">
            <td colspan="8"><span tabindex="99" class="roomTbl" id="roomTwo" >2</span></td>
        </tr>
        <tr class="roomRw">
            <td colspan="8"><span tabindex="99" class="roomTbl" id="roomThree" >3</span></td>
        </tr>
    </table>
    <table class="lectHolderTbl">
        <tr class="lectRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
    </table>
    </div>
    <div class="roomOneHolder reqHolder" >
        <div class="hdr" ><b>PREFERENCES (ROOM 1)</b></div>
        <table class="modData">
            <tr>
                <td class="subHdr studTit" colspan="9"><b>NUMBER OF STUDENTS</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="9"><input autocomplete="off" type="text" class="inp studTxt" id="studTxt" /></td>
            </tr>
            <tr>
                <td class="spc" ></td>
            </tr>
            <tr>
                <td class="subHdr typeTit" colspan="9"><b>ROOM TYPE</b><span class="alert" ></span></td>
            </tr>
            <tr>
                <td><b>LECTURE</b></td><td> <span class="outCirc" ></span><span class="inCirc selectRad"  ></span><input class="typeCheck" type="hidden" value="1" /></td>
                <td><b>SEMINAR</b></td><td> <span class="outCirc" ></span><span class="inCirc" ></span><input class="typeCheck" type="hidden" value="2" /></td>
                <td><b>IT LAB</b></td><td> <span class="outCirc" ></span><span class="inCirc" ></span><input class="typeCheck" type="hidden" value="3" /></td>
            </tr>
            <tr>
                <td class="spc" ></td>
            </tr>
            <tr>
                <td class="subHdr parkTit" colspan="9"><b>PARK</b><span class="alert" ></span></td>
            </tr>
            <tr>
                <td><b>CENTRAL</b></td><td> <span class="outCirc" ></span><span class="parkCirc selectRad"  ></span><input class="parkCheck" type="hidden" value="1" /></td>
                <td><b>WEST</b></td><td> <span class="outCirc" ></span><span class="parkCirc" ></span><input class="parkCheck" type="hidden" value="2" /></td>
                <td><b>EAST</b></td><td> <span class="outCirc" ></span><span class="parkCirc" ></span><input class="parkCheck" type="hidden" value="3" /></td>
            </tr>
            <tr>
                <td class="spc" ></td>
            </tr>
            <tr>
                <td class="subHdr buildTit" colspan="3"><b>BUILDING</b><span class="alert" ></span></td>
                <td class="subHdr roomTit" colspan="3"><b>ROOM</b><span class="alert" ></span></td>
                <td class="subHdr" colspan="3"></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp buildTxt" id="buildTxt" /></td>
                <td colspan="3"><input autocomplete="off" type="text" class="inp roomCodeTxt" id="roomCodeTxt" /></td>
                <td colspan="3"></td>
            </tr>
        </table>
    </div>
    <!--
    <td class="subHdr weekTit" colspan="4"><b>DEFAULT WEEKS</b><span class="alert" ></span></td>
    <td class="weekTd" colspan="6">
        <span class="week" >1</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >2</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >3</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >4</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >5</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >6</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >7</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >8</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >9</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >10</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >11</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >12</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >13</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >14</span><input class="weekCheck" type="hidden" value="0" />
        <span class="week" >15</span><input class="weekCheck" type="hidden" value="0" />
    </td>
    <td class="yesTd" colspan="6"><span class="tickBox weekTick yesTick">&nbsp;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="0"/></td>
    <td class="noTd" colspan="6"><span class="tickBox weekTick noTick">&nbsp;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
    <td class="weekBtnTd" colspan="6">
        <span class="weekBtn defBtn" >DEFAULT</span>
        <span class="weekBtn allBtn" >ALL</span>
        <span class="weekBtn oddBtn" >ODD</span>
        <span class="weekBtn evenBtn" >EVEN</span>
        <span class="weekBtn clrBtn" >CLEAR</span>
    </td>
    -->

</asp:Content>
