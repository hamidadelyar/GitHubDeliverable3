<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditRequest.aspx.cs" Inherits="WebApplication4_0.EditRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            var week = 0;
            var pri = 0
            $('.weekTick').click(function () {
                $('.weekTick').removeClass('selTick');
                $('.weekTick').html('&nbsp;');
                $(this).addClass('selTick');
                $(this).html('&#10004');
                week = $(this).siblings('input').val();
            });
            $('.priTick').click(function () {
                $('.priTick').removeClass('selTick');
                $('.priTick').html('&nbsp;');
                $(this).addClass('selTick');
                $(this).html('&#10004');
                pri = $(this).siblings('input').val();
            });
            $('.circ').click(function () {
                var currVal = $(this).siblings('input').val();
                $(this).siblings('input').val(Math.abs(currVal - 1));
                if (currVal == 0) {
                    $(this).animate({
                        backgroundColor: '#FF8060',
                        left: "+=30"
                    }, 500, function () {
                        //Animation Complete
                    });
                }
                else {
                    $(this).animate({
                        backgroundColor: '#999',
                        left: "-=30"
                    }, 500, function () {
                        //Animation Complete
                    });
                }
            });
        });
    </script>
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
        }
        .prefBtn
        {
            line-height:40px;
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
            line-height:40px;
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
                <td colspan="3"><input autocomplete="off" type="text" class="inp dayTxt"  /></td>
                <td colspan="3"><input autocomplete="off" type="text" class="inp startTxt" /></td>
                <td colspan="3"><input autocomplete="off" type="text" class="inp endTxt" /></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr roomTit" colspan="3"><b>NUMBER OF ROOMS</b><span class="alert" ></span></td>
                <td class="subHdr weekTit" colspan="3"><b>DEFAULT WEEKS</b><span class="alert" ></span></td>
                <td class="subHdr priTit" colspan="3"><b>PRIORITY</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp dayTxt"  /></td>
                <td colspan="3"><span class="tickBox selTick weekTick">&#10004;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="1"/></td>
                <td colspan="3"><span class="tickBox priTick">&nbsp;</span><span class="optSpan"><b>YES</b></span><input type="hidden" value="1"/></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"></td>
                <td colspan="3"><span class="tickBox weekTick">&nbsp;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
                <td colspan="3"><span class="tickBox selTick priTick">&#10004;</span><span class="optSpan"><b>NO</b></span><input type="hidden" value="0"/></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr lectTit" colspan="3"><b>LECTURER</b><span class="alert" ></span></td>
                <td class="subHdr" colspan="3"></td>
                <td class="subHdr" colspan="3"></td>
            </tr>
            <tr class="roomRw">
                <td colspan="9"><input autocomplete="off" type="text" class="inp dayTxt"  /></td>
            </tr>
            <tr>
                <td colspan="9" class="spc"></td>
            </tr>
            <tr>
                <td colspan="9"><span class="prefBtn"><b>PREFERENCES</b></span><span class="subBtn"><b>SUBMIT</b></span></td>
            </tr>
        </table>
    </div>
</asp:Content>
