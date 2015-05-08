<%@ Page Title="Edit Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditRequest.aspx.cs" Inherits="WebApplication4_0.EditRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var modData = <%= this.modData %>;
        var lectData = <%= this.lectData %>;
        var requestData = <%= this.request %>;
        var selLects = <%= this.selLects %>;
        var navigable = [];
        var curr = -1;
        var numLects = 0;
    </script>
    <script src="/Scripts/EditRequestControls.js" ></script>
    <script src="/Scripts/EditRequestPageLoad.js" ></script>
    <style>
        .editHolder {
            width: 95%;
            padding: 2.5%;
            margin-top: 50px;
            background-color: #3E454D;
            border-radius: 10px;
        }
        .hdr
        {
            margin-top:10px;
            font-size:1.4em;
            color:#FFF;
            float:left;
            text-align:center;
            width:95%;
            margin-left:2.5%;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
            padding-top:15px;
        }
        .alert
        {
            margin-top:10px;
            color:#FFD800;
        }
        .spc
        {
            height:15px;
        }
        .smlSpc
        {
            height:5px;
        }
        .inp
        {
            line-height:17.5px;
            width:200px;
            background-color:#2B3036;
            border-radius:3px;
            border:1px #2B3036 solid;
            color:#FFF;
        }
        .nameTxt
        {
            width:400px!important;
        }
        .lectTxt
        {
            width:400px!important;
        }
        .modData
        {
            margin-top:35px;
            width:110%;
            table-layout:fixed;
            color: #FFF;
        }
        .line
        {
            margin-left:-5px;
            position:relative;
            top:-3px;
            height:13px;
            width:30px;
            background-color:#FFF;
            border-radius:3px;
            display:inline-block;
        }
        .darkLine
        {
            margin-left:5px;
            position:relative;
            top:1px;
            height:13px;
            width:30px;
            background-color:#3E454D;
            border-radius:3px;
            display:inline-block;
        }
        .circ
        {
            position:relative;
            top:2.5px;
            left:-42px;
            height:25px;
            width:25px;
            background-color:#999;
            border-radius:35px;
            display:inline-block;
            cursor:pointer;
        }
        .selected
        {
            left:-12px;
            background-color:#FF8060;
        }
        .tickBox {
            border-radius: 3px;
            background-color: #2b3036;
            line-height: 17.5px;
            padding: 5px;
            border: 1px solid #2b3036;
            width: 17.5px;
            display: inline-block;
            cursor: pointer;
            text-align: center;
        }
        .optSpan {
            margin-left: 15px;
            text-align: center;
        }
        .selTick {
            background-color: #FF8060;
            border: 1px solid #FF8060;
        }
        .prefBtn
        {
            line-height:30px;
            width:100px;
            background-color:#2B3036;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            padding: 5px;
            float:left;
        }
        .prefBtn:hover
        {
            background-color:#FF8060;
        }
        .subBtn
        {
            line-height:30px;
            width:100px;
            background-color:#FF8060;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            padding: 5px;
            float:right;
            margin-right:6.66%;
        }
        .week
        {
            width:32.5px;
            line-height:32.5px;
            border-radius:3px;
            background-color:#999;
            display:inline-block;
            text-align:center;
            cursor:pointer;
        }
        .week:hover
        {
            background-color:#FF8060;
        }
        .weekBtn
        {
            margin-top:10px;
            line-height:32.5px;
            width:74px;
            background-color:#2B3036;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
        }
        .weekBtn:hover
        {
            background-color:#FF8060;
        }
        .blurHolder
        {
            -webkit-filter: blur(5px);
            -moz-filter: blur(5px);
            -o-filter: blur(5px);
            -ms-filter: blur(5px);
            filter: blur(5px);
            opacity: 0.4;
        }
        .triang {
            position: relative;
            display: inline-block;
            left: 90px;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 0 15px 15px 15px;
            border-color: transparent transparent #2b3036 transparent;
            top: 3.5px;
        }
        .codeTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:200px;
            display: inline-block;
        }
        .codeTbl:hover 
        {
            background-color: #FF8060;

        }
        .codeHolderTbl {
            position: absolute;
            width:200px;
        }
        .codeHolderTbl td {
            padding: 0;
        }
        .nameTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:400px;
            display: inline-block;
        }
        .nameTbl:hover 
        {
            background-color: #FF8060;

        }
        .nameHolderTbl {
            position: absolute;
            width:400px;
        }
        .nameHolderTbl td {
            padding: 0;
        }
        .dayTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:200px;
            display: inline-block;
        }
        .dayTbl:hover 
        {
            background-color: #FF8060;

        }
        .dayHolderTbl {
            position: absolute;
            width:200px;
        }
        .dayHolderTbl td {
            padding: 0;
        }
        .startTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:200px;
            display: inline-block;
        }
        .startTbl:hover 
        {
            background-color: #FF8060;

        }
        .startHolderTbl {
            position: absolute;
            width:200px;
        }
        .startHolderTbl td {
            padding: 0;
        }
        .endTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:200px;
            display: inline-block;
        }
        .endTbl:hover 
        {
            background-color: #FF8060;

        }
        .endHolderTbl {
            position: absolute;
            width:200px;
        }
        .endHolderTbl td {
            padding: 0;
        }
        .roomTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:200px;
            display: inline-block;
        }
        .roomTbl:hover 
        {
            background-color: #FF8060;

        }
        .roomHolderTbl {
            position: absolute;
            width:200px;
        }
        .roomHolderTbl td {
            padding: 0;
        }
        .lectTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:400px;
            display: inline-block;
        }
        .lectTbl:hover 
        {
            background-color: #FF8060;

        }
        .lectHolderTbl {
            position: absolute;
            width:400px;
        }
        .lectHolderTbl td {
            padding: 0;
        }
        .lectTick {
            border-radius: 3px;
            background-color: #FF8060;
            line-height: 17.5px;
            padding: 5px;
            border: 1px solid #FF8060;
            display: inline-block;
            cursor: pointer;
            text-align: center;
            margin-left: 10px;
        }
        .lectList {
            padding-left: 5px;
        }
        .lectList span {
            text-decoration: underline;
            margin-right: 10px;
            display: inline-block;
        }
    </style>
    <div class="editHolder">
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
                <td class="subHdr weekTit" colspan="6"><b>DEFAULT WEEKS</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp roomTxt" id="roomTxt" /></td>
                <td colspan="6" class="yesTd"><span class="tickBox selTick weekTick yesTick">&#10004;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="1"/></td>
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

            </tr>
            <tr class="roomRw">
                <td colspan="3"></td>
                <td class="noTd" colspan="6"><span class="tickBox weekTick noTick">&nbsp;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
                <td class="weekBtnTd" colspan="6">
                    <span class="weekBtn defBtn" >DEFAULT</span>
                    <span class="weekBtn allBtn" >ALL</span>
                    <span class="weekBtn oddBtn" >ODD</span>
                    <span class="weekBtn evenBtn" >EVEN</span>
                    <span class="weekBtn clrBtn" >CLEAR</span>
                </td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr lectTit" colspan="5"><b>LECTURER</b><span class="alert" ></span></td>
                <td class="subHdr priTit" colspan="4"><b>PRIORITY</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="5"><input autocomplete="off" type="text" class="inp lectTxt" id="lectTxt" /><span class="lectTick addLect">ADD</span><span class="lectTick subLect">DEL</span></td>
                <td colspan="4"><span class="tickBox priTick priYes">&nbsp;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="1"/></td>
            </tr>
            <tr>
                <td colspan="5" class="lectList" ></td>
                <td colspan="4"><span class="tickBox priTick selTick priNo">&#10004;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td colspan="9"><span class="prefBtn"><b>PREFERENCES</b></span><span class="subBtn"><b>SUBMIT</b></span></td>
            </tr>
        </table>
    </div>
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

</asp:Content>
