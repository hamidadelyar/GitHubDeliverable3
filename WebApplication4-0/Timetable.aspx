<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
     <script>
         var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK FIFTEEN", ""];
         var currWeek = 1;
         var roomsArray = <%= this.data %>
         $(document).ready(function () {
             updateWeeks();
             $('.bookingSpan').hide();
             $('.leftWk').click(function () {
                 $('.weeksRw').hide();
                 if (currWeek != 1) {
                     currWeek -= 1;
                     updateWeeks();
                 }
             });
             $('.rightWk').click(function () {
                 $('.weeksRw').hide();
                 if (currWeek != 15) {
                     currWeek += 1;
                     updateWeeks();
                 }
             });
             $('.weeksRw').hide();
             $('.centWk').click(function () {
                 $('.weeksTbl span').css('background-color', '#EAEAEA');
                 $('.weeksRw').toggle();
                 $(".weeksTbl span").each(function () {
                     if ($(this).html() == currWeek) {
                         $(this).css('background-color', '#FF8060');
                     }
                 });
             });
             $('.weeksTbl span').click(function () {
                 $('.weeksTbl span').css('background-color', '#EAEAEA');
                 $('.weeksRw').hide();
                 currWeek = parseInt($(this).html());
                 updateWeeks();
             });
             for (var i = 0; i < roomsArray.length; i++) {
                 $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
             }
             $('.suggestTbl').hide();
             $('.roomTxt').focusin(function () {
                 $('.suggestTbl').show();
                 $('.semesters').hide();
                 $('.suggestTbl').css('display', 'block');
                 $('.suggestTbl').height(420);
             });
             $('.roomTxt').on('input propertychange paste', function () {
                 $('.suggestTbl').html('');
                 var roomTxt = $('.roomTxt').val().split('.').join('').toUpperCase();;
                 for (var i = 0; i < roomsArray.length; i++) {
                     var searchTxt = roomsArray[i]['Room_ID'].split('.').join('');
                     if (roomTxt == searchTxt.substring(0, roomTxt.length)) {
                         $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                         $('.suggestTbl td').click(function () {
                             $('.suggestTbl').hide();
                             $('.semesters').show();
                             $('.roomTxt').val($(this).html());
                         })
                     }
                 }
             });
             $(document).click(function (event) {
                 if (event.target.id !== 'roomTxt' && event.target.id !== 'clearImg') {
                     $(".suggestTbl").hide();
                     $('.semesters').show();
                 }
             })
             $('.suggestTbl td').click(function () {
                 $('.suggestTbl').hide();
                 $('.semesters').show();
                 $('.roomTxt').val($(this).html());
                 $('.suggestTbl').html('');
                 var roomTxt = $('.roomTxt').val().split('.').join('');
                 for (var i = 0; i < roomsArray.length; i++) {
                     var searchTxt = roomsArray[i]['Room_ID'].split('.').join('');
                     if (roomTxt == searchTxt.substring(0, roomTxt.length)) {
                         $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                         $('.suggestTbl td').click(function () {
                             $('.suggestTbl').hide();
                             $('.roomTxt').val($(this).html());
                         })
                     }
                 }
             });
             $('.rooms img').click(function () {
                 $('.roomTxt').val("");
                 $('.suggestTbl').html('');
                 var roomTxt = $('.roomTxt').val().split('.').join('');
                 for (var i = 0; i < roomsArray.length; i++) {
                     var searchTxt = roomsArray[i]['Room_ID'].split('.').join('');
                     if (roomTxt == searchTxt.substring(0, roomTxt.length)) {
                         $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                         $('.suggestTbl td').click(function () {
                             $('.suggestTbl').hide();
                             $('.semesters').show();
                             $('.roomTxt').val($(this).html());
                         })
                     }
                 }
             });
             $('.booking').mouseover(function () {
                 var left = $(this).position().left + $(this).width();
                 var top = $(this).position().top;
                 $(this).find('span').show().css('top', top + 'px').css('left', left + 'px');
             });
             $('.booking').mouseout(function () {
                 $(this).find('span').hide();
             });
         });
         function updateWeeks() {
             $('.leftWk').html(weeksArray[currWeek - 1].substring(5));
             $('.centWk').html(weeksArray[currWeek]);
             $('.rightWk').html(weeksArray[currWeek + 1].substring(5));
         }
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
        .leftWk
        {
            cursor:pointer;
        }
        .centWk
        {
            cursor:pointer;
        }
        .rightWk
        {
            cursor:pointer;
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
            width: -moz-calc(100% - 28px);
            width: -webkit-calc(100% - 28px);
            width: calc(100% - 28px);
            color:#FFF;
            padding-left:5px;
            text-transform:uppercase;
        }
        .rooms img
        {
            cursor:pointer;
        }
        .suggest
        {
            margin-top:-10px;
        }
        .suggestTbl
        {
            width:100%;
            height:420px;
            max-height:420px;
            overflow:auto;
            text-align:left;
        }
         .suggestTbl td
         {
             padding:5px!important;
             cursor:pointer;
         }
        .suggestTbl td:hover
        {
            background-color:#2B3036;
        }
        .semesters
        {
            margin-top:40px;
            width:100%;
        }
        .semBtn
        {
            position:relative;
            padding:10px;
            top:25px;
            border-radius:7px;
            cursor:pointer;
        }
        .semBtn:hover
        {
            background-color:#FF8060;
        }
        .semOne
        {
            background-color:#FF8060;
        }
        .semTwo
        {
            background-color:#2B3036;
        }
        .splitter
        {
            position:relative;
            background-color:#3E454D;
            padding:10px;
            top:25px;
            width:25px;
        }
        .weeksTbl
        {
            margin-top:-10px;
            width:100%;
            table-layout:fixed;
        }
        .weeksTbl td
        {
            padding-bottom:5px!important;
        }
        .weeksTbl span
        {
            position:relative;
            background-color:#EAEAEA;
            border-radius: 50%;
	        width: 20px;
	        height: 20px;
            left:50%;
            margin-left:-10px;
            display:block;
            cursor:pointer;
        }
        .weeksTbl span:hover
        {
            background-color:#FF8060;
        }
        .booking
        {
            cursor:pointer;
            background-color:#FF8060;
            color:#FFF;
        }
        .bookingSpan
        {
            position: absolute;
            background-color: #3E454D;
            display:block;
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
                <td colspan="2" class="nonSelect" ><span class="leftWk"></span></td>
                <td colspan="2" class="select" ><b class="centWk"></b></td>
                <td colspan="2" class="nonSelect" ><span class="rightWk"></span></td>
            </tr>
            <tr class="weeksRw">
                <td colspan="2" ></td>
                <td colspan="2" >
                    <table class="weeksTbl">
                        <tr>
                            <td><span>1</span></td><td><span>2</span></td><td><span>3</span></td><td><span>4</span></td>
                        </tr>
                        <tr>
                            <td><span>5</span></td><td><span>6</span></td><td><span>7</span></td><td><span>8</span></td>
                        </tr>
                        <tr>
                            <td><span>9</span></td><td><span>10</span></td><td><span>11</span></td><td><span>12</span></td>
                        </tr>
                        <tr>
                            <td><span>13</span></td><td><span>14</span></td><td><span>15</span></td><td></td>
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
        <div class="rooms" ><b>ROOM</b><br /><input style="text-transform:uppercase" autocomplete="off" type="text" class="roomTxt" id="roomTxt" name="roomTxt" /><img id="clearImg" src="Images/clear.png" width="23" height="15" /></div>
        <div class="suggest" >
            <table class="suggestTbl">
            </table>
        </div>
        <div class="semesters" ><b>SEMESTERS</b><br /><span class="semOne semBtn" >One</span><span class="splitter" ></span><span class="semTwo semBtn" >Two</span></div>
    </div>
    <div class="whiteSpace" ></div>
</asp:Content>
