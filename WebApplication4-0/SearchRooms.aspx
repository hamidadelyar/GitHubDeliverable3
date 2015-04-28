<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchRooms.aspx.cs" Inherits="WebApplication4_0.SearchRooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var roomsArray = <%= this.data %>;
        $(document).ready(function(){
            $('.suggestTbl').hide();
            $('.txtBox').focusin(function () { // shows the suggestions table and sets its height and width to fill all the space below the textbox
                $('.suggestTbl').show();
                $('.suggestTbl').css('display', 'block');
                $('.suggestTbl').height(425);
                $('.suggestTbl').width('100%');
                $('.suggestTbl td').width($('.suggestTbl').width());
                fillTable();
            });
            $('.txtBox').on('input propertychange paste', function () { // Finds suggestion to put in table that match the users input everytime they alter the text
                $('.suggestTbl').html('');
                fillTable();
            });
            $(document).click(function (event) { // Clear table when anywhere else on page click
                if (event.target.id !== 'roomTxt') {
                    $(".suggestTbl").hide();
                }
            })
        });
        function fillTable() // fills the rooms suggestion table with data that matches the input
        {
            var roomTxt = $('.txtBox').val().split('.').join('').toUpperCase();
            if (roomTxt == "")
            {
                if ($('.suggestTbl tr').length == roomsArray.length)
                {
                    return;
                }
                else
                {
                    $('.suggestTbl').html('');
                    for (var i = 0; i < roomsArray.length; i++) {
                        $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                    }
                }
            }
            else
            {
                $('.suggestTbl').html('');
                for (var i = 0; i < roomsArray.length; i++) {
                    var searchTxt = roomsArray[i]['Room_ID'].split('.').join('').toUpperCase();
                    if (searchTxt.indexOf(roomTxt) != -1) {
                        $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
                    }
                }
            }
            $('.suggestTbl td').width($('.suggestTbl').width());
            $('.suggestTbl td').click(function () {
                $('.suggestTbl').hide();
                $('.txtBox').val($(this).html());
                $('.suggestTbl').html('');
                fillTable();
                window.location.href = '/RoomsDetails.aspx?roomCode='+$(this).html();
            })
        }
    </script>
    <style>
        h1
        {
            color:#3E454D;
            margin-bottom:25px;
        }
        .lbl
        {
            float:left;
            width:95%;
            border-radius:10px;
            background-color:#FFF;
            color:#FF8060;
            font-size:1.4em;
            padding:2.5%;
        }
        .txt
        {
            position:relative;
            top:-7px;
        }
        .txtBox 
        {
            border: 1px solid #e2e2e2;
            background: #e2e2e2;
            color: #333;
            font-size: 1.2em;
            margin: 5px 0 6px 0;
            padding: 5px;
            width: 300px;
        }
        .searchBtn
        {
            border: 1px solid #FF8060;
            background: #FF8060;
            color: #FFF;
            font-size: 1.2em;
            margin: 5px 0 6px 22px;
        }
        .suggestTbl
        {
            width:100%;
            max-height:425px;
            overflow:auto;
            text-align:left;
        }
        .suggestTbl td
        {
            cursor:pointer;
        }
        .suggestTbl td:hover
        {
            text-decoration:underline;
        }
    </style>
    <h1>Oops! It appears you haven't entered a valid room code!</h1>
    <div class="lbl" >
        <b class="txt" >Enter a room code: </b><br />
        <input class="txtBox" autocomplete="off" id="roomTxt" />
        <table class="suggestTbl">
            </table>
    </div>
</asp:Content>
