﻿<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
     <script>
         var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK FIFTEEN", ""];
         var currWeek = 1;
         var semester = 1;
         var roomsArray = <%= this.data %> ;
         var showing = false;
         $(document).ready(function () {
             $('.greyOut').hide();
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
                 $('.suggestTbl').width('100%');
                 $('.suggestTbl td').width($('.suggestTbl').width());
             });
             $('.roomTxt').on('input propertychange paste', function () {
                 $('.suggestTbl').html('');
                 var roomTxt = $('.roomTxt').val().split('.').join('').toUpperCase();;
                 for (var i = 0; i < roomsArray.length; i++) {
                     var searchTxt = roomsArray[i]['Room_ID'].split('.').join('');
                     if (roomTxt == searchTxt.substring(0, roomTxt.length)) {
                         $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                         $('.suggestTbl td').width($('.suggestTbl').width());
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
                         $('.suggestTbl td').width($('.suggestTbl').width());
                         $('.suggestTbl td').click(function () {
                             $('.suggestTbl').hide();
                             $('.roomTxt').val($(this).html());
                         })
                     }
                 }
                 getBooking();
             });
             $('.rooms img').click(function () {
                 $('.roomTxt').val("");
                 $('.suggestTbl').html('');
                 var roomTxt = $('.roomTxt').val().split('.').join('');
                 for (var i = 0; i < roomsArray.length; i++) {
                     var searchTxt = roomsArray[i]['Room_ID'].split('.').join('');
                     if (roomTxt == searchTxt.substring(0, roomTxt.length)) {
                         $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                         $('.suggestTbl td').width($('.suggestTbl').width());
                         $('.suggestTbl td').click(function () {
                             $('.suggestTbl').hide();
                             $('.semesters').show();
                             $('.roomTxt').val($(this).html());
                         })
                     }
                 }
                 getBooking();
             });
             $('.booking').mouseover(function () {
                 var left = $(this).position().left + $(this).width();
                 var top = $(this).position().top;
                 $(this).find('span').show().css('top', top + 'px').css('left', left + 'px');
             });
             $('.booking').mouseout(function () {
                 $(this).find('span').hide();
             });
             $('.weekBtn').click(function () {
                 getBooking();
             });
             $('.semOne').click(function(){
                 semester = 1;
                 getBooking();
                 $(this).css('background-color', '#FF8060');
                 $('.semTwo').css('background-color', '#2B3036')
             });
             $('.semTwo').click(function(){
                 semester = 2;
                 getBooking();
                 $(this).css('background-color', '#FF8060');
                 $('.semOne').css('background-color', '#2B3036')
             });
         });
         function getBooking()
         {
             $('.greyOut').show();
             showing = true;
             shrink();
             var room = $('.roomTxt').val();
             var week = currWeek;
             $.ajax({
                 type: "POST",
                 url: "Timetable.aspx/SearchRoom",
                 data: JSON.stringify({room: room, week: week, semester:semester}),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                 },
                 success: function (result) {
                     $('.greyOut').hide();
                     $('.slot').show();
                     showing = false;
                     finAnim();
                     var bookings = $.parseJSON(result.d);
                     var i = 0
                     $('.slot').each(function () {
                         if (typeof bookings[i][0]['Module_Code'] != 'undefined')
                         {
                             var innerData = bookings[i][0];
                             $(this).html(innerData['Module_Code'] + '<span class="bookingSpan" >' + innerData['Module_Code'] + '<br />' + innerData['Module_Title'] + '<br />' + innerData['Lecturer_Name'] + '</span>').addClass('booking');
                             var cellIndex = $(this).index();
                             var $currCell = $(this);
                             for(var j = 0; j < innerData['End_Time'] - innerData['Start_Time'] -1; j++)
                             {
                                 $currCell =  $currCell.closest('tr').next().children().eq(cellIndex)
                                 $currCell.hide();
                             }
                             $(this).attr('rowSpan', innerData['End_Time'] - innerData['Start_Time']);
                             $('.bookingSpan').hide();
                             bookingHover();
                         }
                         else
                         {
                             $(this).html('').removeClass('booking');
                             $(this).attr('rowSpan', 1);
                         }
                         i++;
                     })
                 }
             });
         }
         function bookingHover()
         {
             $('.booking').mouseover(function () {
                 var left = $(this).position().left + $(this).width();
                 var top = $(this).position().top;
                 $(this).find('span').show().css('top', top + 'px').css('left', left + 'px');
             });
             $('.booking').mouseout(function () {
                 $(this).find('span').hide();
             });
         }
         function shrink() {
            $('.greyOut img').animate({
                height: '5px',
                width: '5px',
                padding: '32.5px'
            },
            {
                duration: 1500,
                easing: 'swing',
                complete: function () {
                    if(showing)
                    {
                        grow()
                    }
                    else
                    {
                        finAnim()
                    }
                }
            });
         }
         function grow() {
             $('.greyOut img').animate({
                 height: '70px',
                 width: '70px',
                 padding: '0px'
             },
             {
                 duration : 1500,
                 easing   : 'swing',
                 complete: function () {
                     if(showing)
                     {
                         shrink()
                     }
                     else
                     {
                         finAnim()
                     }
                 }
            });
         }
         function finAnim()
         {
             $('.greyOut img').css('height', '70px');
             $('.greyOut img').css('width', '70px');
             $('.greyOut img').css('padding', '0px');
         }
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
        .options
        {
            cursor:default;
        }
        .roomChoice
        {
            cursor:pointer;
            text-decoration:underline;
        }
        .roomChoice:hover
        {
            text-decoration:underline;
        }
        .modChoice
        {
            cursor:pointer;
        }
        .modChoice:hover
        {
            text-decoration:underline;
        }
        .lectChoice
        {
            cursor:pointer
        }
        .lectChoice:hover
        {
            text-decoration:underline;
        }
        .rooms
        {
            margin-top:43px;
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
             width:100%;
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
            padding:5px;
        }
        .greyOut
        {
            position:relative;
            left:2.5%;
            top:-80%;
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
        <div class="options" ><span class="roomChoice" >ROOM</span> | <span class="modChoice" >MODULE</span> | <span class="lectChoice" >LECTURER</span></div>
        <div class="rooms" ><b>ROOM</b><br /><input style="text-transform:uppercase" autocomplete="off" type="text" class="roomTxt" id="roomTxt" name="roomTxt" /><img id="clearImg" src="Images/clear.png" width="23" height="15" /></div>
        <div class="suggest" >
            <table class="suggestTbl">
            </table>
        </div>
        <div class="semesters" ><b>SEMESTERS</b><br /><span class="semOne semBtn" >ONE</span><span class="splitter" ></span><span class="semTwo semBtn" >TWO</span></div>
    </div>
    <div class="whiteSpace" ></div>
    <div class="switchView" onclick="window.location.href = 'FindRoom.aspx'" >FIND FREE ROOM <img src="/Images/RightArrow.png" height="11" width="6" /></div>
</asp:Content>
