﻿var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK FIFTEEN", ""];
var currWeek = 1;
var semester = 1;
var showing = false;
var type = 1;
$(document).ready(function () {
    if ($('.roomTxt').val() != "")
    {
        fillTable();
        getBooking();
    }
    updateWeeks();
    $('.bookingSpan').hide();
    $('.leftWk').click(function () { // the week to the left of the selected week is clicked so it scrolls through the weeks setting the left one to be the current week
        $('.weeksRw').hide();
        if (currWeek != 1) {
            currWeek -= 1;
            updateWeeks();
        }
    });
    $('.rightWk').click(function () { // the week to the right of the selected week is clicked so it scrolls through the weeks setting the right one to be the current week
        $('.weeksRw').hide();
        if (currWeek != 15) {
            currWeek += 1;
            updateWeeks();
        }
    });
    $('.weeksRw').hide();
    $('.centWk').click(function () { // shows the table containing all the weeks values so user doesnt have to click through them all
        $('.weeksTbl span').css('background-color', '#EAEAEA');
        $('.weeksRw').toggle();
        $(".weeksTbl span").each(function () {
            if ($(this).html() == currWeek) {
                $(this).css('background-color', '#FF8060');
            }
        });
    });
    $('.weeksTbl span').click(function () { // runs the code to tell that someone has changed the selected week
        $('.weeksTbl span').css('background-color', '#EAEAEA');
        $('.weeksRw').hide();
        currWeek = parseInt($(this).html());
        updateWeeks();
    });
    for (var i = 0; i < roomsArray.length; i++) { // Set the initial rooms table to hold all the rooms taken from the database
        $('.suggestTbl').append("<tr><td>" + roomsArray[i]['Room_ID'] + "</td></tr>");
    }
    $('.suggestTbl').hide();
    $('.roomTxt').focusin(function () { // shows the suggestions table and sets its height and width to fill all the space below the textbox
        $('.suggestTbl').show();
        $('.semesters').hide();
        $('.suggestTbl').css('display', 'block');
        $('.suggestTbl').height(425);
        $('.suggestTbl').width('100%');
        $('.suggestTbl td').width($('.suggestTbl').width());
        fillTable();
    });
    $('.roomTxt').on('input propertychange paste', function () { // Finds suggestion to put in table that match the users input everytime they alter the text
        $('.suggestTbl').html('');
        fillTable();
    });
    $('.suggestTbl td').click(function () { // Put text of clicked suggestion in the text box and searches for bookings
        $('.suggestTbl').hide();
        $('.semesters').show();
        $('.roomTxt').val($(this).html());
        $('.suggestTbl').html('');
        fillTable();
        getBooking();
    });
    $('.rooms img').click(function () { //Clear text in box and reset the table to hold all rooms
        $('.roomTxt').val("");
        $('.suggestTbl').html('');
        fillTable();
    });

    $('.weekBtn').click(function () { // updates timetable when week is changed
        getBooking();
    });
    $('.semOne').click(function(){ // changes the chosen semester and updates the timetable
        semester = 1;
        getBooking();
        $(this).css('background-color', '#FF8060');
        $('.semTwo').css('background-color', '#2B3036')
    });
    $('.semTwo').click(function(){ // change the chosen semester and updates the timetable
        semester = 2;
        getBooking();
        $(this).css('background-color', '#FF8060');
        $('.semOne').css('background-color', '#2B3036')
    });

    $('.parts').hide();

    $(document).click(function (event) { // Clear table when anywhere else on page click
        if (event.target.id !== 'roomTxt' && event.target.id !== 'clearImg') {
            $(".suggestTbl").hide();
            $('.semesters').show();
            if(type == 4)
            {
                $('.parts').show();
            }
        }
    })

    $('.booking').mouseover(function () { // shows the extra data for the booking when the user hovers the booking
        var left = $(this).position().left + $(this).width();
        var top = $(this).position().top;
        $(this).find('span').show().css('top', top + 'px').css('left', left + 'px');
    });
    $('.booking').mouseout(function () { // hides the extra data 
        $(this).find('span').hide();
    });

    $('.roomChoice').click(function () { // change the tools panel to reflect that they wish to search room timetables
        type = 1;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('ROOM');
        $('.parts').hide();
    });

    $('.modChoice').click(function () { // change the tools panel to reflect that they wish to search module timetables
        type = 2;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('MODULE CODE');
        $('.parts').hide();
    });

    $('.lectChoice').click(function () { // change the tools panel to reflect that they wish to search module timetables
        type = 3;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('LECTURER');
        $('.parts').hide();
    });

    $('.degChoice').click(function () { // change the tools panel to reflect that they wish to search module timetables
        type = 4;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('DEGREE');
        $('.parts').show();
    });

    $('.partSel').change(function () {
        getBooking();
    })
});
function fillTable() // fills the rooms suggestion table with data that matches the input
{
    var roomTxt = $('.roomTxt').val().split('.').join('').toUpperCase();
    if (type == 1)
    {
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
    }
    else if (type == 2)
    {
        if (roomTxt == "") {
            if ($('.suggestTbl tr').length == modsArray.length) {
                return;
            }
            else {
                $('.suggestTbl').html('');
                for (var i = 0; i < modsArray.length; i++) {
                    $('.suggestTbl').append("<tr><td>" + modsArray[i]['Module_Code'] + "</td></tr>");
                }
            }
        }
        else {
            $('.suggestTbl').html('');
            for (var i = 0; i < modsArray.length; i++) {
                var searchTxt = modsArray[i]['Module_Code'].split('.').join('').toUpperCase();
                if (searchTxt.indexOf(roomTxt) != -1) {
                    $('.suggestTbl').append("<tr><td>" + modsArray[i]['Module_Code'] + "</td></tr>");
                }
            }
        }
    }
    else if(type == 3) {
        if (roomTxt == "") {
            if ($('.suggestTbl tr').length == lectsArray.length) {
                return;
            }
            else {
                $('.suggestTbl').html('');
                for (var i = 0; i < lectsArray.length; i++) {
                    $('.suggestTbl').append("<tr><td>" + lectsArray[i]['Lecturer_ID'] + "</td></tr>");
                }
            }
        }
        else {
            $('.suggestTbl').html('');
            for (var i = 0; i < lectsArray.length; i++) {
                var searchTxt = lectsArray[i]['Lecturer_ID'].split('.').join('').toUpperCase();
                if (searchTxt.indexOf(roomTxt) != -1) {
                    $('.suggestTbl').append("<tr><td>" + lectsArray[i]['Lecturer_ID'] + "</td></tr>");
                }
            }
        }
    }
    else {
        if (roomTxt == "") {
            if ($('.suggestTbl tr').length == degsArray.length) {
                return;
            }
            else {
                $('.suggestTbl').html('');
                for (var i = 0; i < degsArray.length; i++) {
                    $('.suggestTbl').append("<tr><td>" + degsArray[i]['Program_Code'] + "</td></tr>");
                }
            }
        }
        else {
            $('.suggestTbl').html('');
            for (var i = 0; i < degsArray.length; i++) {
                var searchTxt = degsArray[i]['Program_Code'].split('.').join('').toUpperCase();
                if (searchTxt.indexOf(roomTxt) != -1) {
                    $('.suggestTbl').append("<tr><td>" + degsArray[i]['Program_Code'] + "</td></tr>");
                }
            }
        }
    }
    $('.suggestTbl td').width($('.suggestTbl').width());
    $('.suggestTbl td').click(function () {
        $('.suggestTbl').hide();
        $('.semesters').show();
        $('.roomTxt').val($(this).html());
        $('.suggestTbl').html('');
        fillTable();
        getBooking();
    })
}
function getBooking() // uses ajax to run the code behind and then put the data returned into the timetable
{
    showLoader();
    showing = true;
    shrink();
    var search = $('.roomTxt').val();
    var week = currWeek;
    $.ajax({
        type: "POST",
        url: "Timetable.aspx/SearchAll",
        data: JSON.stringify({search: search, semester: semester, type: type, part: $('.partSel').val()}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
        },
        success: function (result) {
            insertData(result);
        }
    });
}
function arraysEqual(arr1, arr2) {
    if (arr1.length !== arr2.length)
    {
        return false;
    }
    for(var i = arr1.length; i--;) {
        if(arr1[i] !== arr2[i])
            return false;
    }

    return true;
}
function unique(list) {
    var result = [];
    $.each(list, function(i, e) {
        if ($.inArray(e, result) == -1) result.push(e);
    });
    return result;
}
function escapeRegExp(string) {
    return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}
function replaceAll(string, find, replace) {
    return string.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}
function checkType(type, booking)
{
    if(type == 1)
    {
        var data = booking['roomCode'].toUpperCase();
        if(data.indexOf($('.roomTxt').val()) != -1)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    if (type == 3) {
        var data = booking['lectCode'].toUpperCase()
        if (data.indexOf($('.roomTxt').val().split(' ')[0]) != -1) {
            return true;
        }
        else {
            return false;
        }
    }
    return true;
}
function insertData(result)
{
    hideLoader();
    $('.slot').show();
    showing = false;
    finAnim();
    var bookings = $.parseJSON(result.d);
    var col = 0;
    var row = 0;
    $('.slot').each(function () {
        $(this).attr('rowspan', 1);
        $(this).html('').removeClass('booking');
    });
    $('.slot').each(function () {
        var slot = $(this);
        var col = $(this).parent().children().index($(this));
        var row = $(this).parent().parent().children().index($(this).parent());
        var prevBooking = [];
        for (var j = 0; j < bookings.length; j++)
        {
            if (bookings[j]['day'] == col && bookings[j]['start'] == row - 2)
            {
                for (var k = 0; k < bookings[j]['week'].length; k++)
                {
                    if (currWeek == bookings[j]['week'][k])
                    {
                        var weekData = replaceAll(bookings[j]['week'].toString(), ',', '|');
                        bookings[j]['roomCode'] += '[' + weekData + ']';
                        if (prevBooking['modCode'] == bookings[j]['modCode'] && prevBooking['start'] == bookings[j]['start'] && prevBooking['day'] == bookings[j]['day'])
                        {
                            bookings[j]['lectCode'] += ',' + prevBooking['lectCode'];
                            bookings[j]['lectName'] += ',' + prevBooking['lectName'];
                            bookings[j]['roomCode'] += ',' + prevBooking['roomCode'];
                        }
                        prevBooking = bookings[j];
                        var lecSpans = "";
                        var lecCodes = bookings[j]['lectCode'].split(',');
                        lecCodes = unique(lecCodes);
                        var lecNames = bookings[j]['lectName'].split(',');
                        lecNames = unique(lecNames);
                        for (var l = 0; l < lecCodes.length; l++)
                        {
                            lecSpans += '<span class="lectName">' + lecCodes[l].toUpperCase() + ' ' + lecNames[l] + '</span>,<br />';
                        }
                        lecSpans = lecSpans.substring(0, lecSpans.length - 7);
                        var roomSpans = "";
                        var roomCodes = bookings[j]['roomCode'].split(',');
                        roomCodes = unique(roomCodes);
                        for (var l = 0; l < roomCodes.length; l++)
                        {
                            var weekData = roomCodes[l].substring(roomCodes[l].indexOf('[') + 1, roomCodes[l].indexOf(']'));
                            var roomData = roomCodes[l].substring(0, roomCodes[l].indexOf('['));
                            weekData = weekData.split('|');
                            var weekSpan = "";
                            for (var m = 0; m < weekData.length; m++)
                            {
                                weekSpan += '<span class="weekSpan" >' + weekData[m] + '</span>, ';
                            }
                            roomSpans += '<span class="roomId">' + roomData + '</span> [' + weekSpan.substring(0, weekSpan.length - 2) + '],<br />';
                        }
                        roomSpans = roomSpans.substring(0, roomSpans.length - 7);

                        if(checkType(type, bookings[j]))
                        {
                            $(slot).attr('rowspan', bookings[j]['end'] - bookings[j]['start'] + 1);
                            $(slot).html(bookings[j]['modCode'] + '<span class="bookingSpan" ><span class="modCode" >' + bookings[j]['modCode'] + '<br />' + bookings[j]['modName'] + '</span><br />' + lecSpans + '<br />' + roomSpans + '<br /></span>').addClass('booking');
                            $('.bookingSpan').hide();
                            bookingHover();
                            var table = $(".timetbl")[0];
                            var cell = table.rows[row].cells[cell]; // This is a DOM "TD" element
                            var $cell = $(cell);// Now it's a jQuery object.
                            for (var l = 1; l < bookings[j]['end'] - bookings[j]['start'] + 1; l++) {
                                var cell = table.rows[row + l].cells[col];
                                var $cell = $(cell);
                                $(cell).hide();
                            }
                        }
                    }
                }
            }
        }
    })
}
function bookingHover() // adds the booking hover features to bookings added after the initial page load
{
    $('.booking').mouseover(function () {
        var left = $(this).position().left + $(this).width() + 1;
        var top = $(this).position().top;
        $(this).find('span').show().css('top', top + 'px').css('left', left + 'px');
    });
    $('.booking').mouseout(function () {
        $(this).find('span').hide();
    });
    $('.roomId').click(function () {
        type = 1;
        $('.choice').css('text-decoration', 'none');
        $('.roomChoice').css('text-decoration', 'underline');
        $('.roomTxt').val($(this).html());
        $('.rooms b').html('ROOM');
        fillTable();
        getBooking();
    })
    $('.modCode').click(function () {
        type = 2;
        $('.choice').css('text-decoration', 'none');
        $('.modChoice').css('text-decoration', 'underline');
        var text = $(this).html()
        $('.roomTxt').val(text.replace('<br>', ' '));
        $('.rooms b').html('MODULE CODE');
        fillTable();
        getBooking();
    });
    $('.lectName').click(function () {
        type = 3;
        $('.choice').css('text-decoration', 'none');
        $('.lectChoice').css('text-decoration', 'underline');
        var text = $(this).html().trim();
        $('.roomTxt').val(text.replace('<br>', ' '));
        $('.rooms b').html('LECTURER');
        fillTable();
        getBooking();
    })
    $('.weekSpan').click(function() {
       currWeek = parseInt($(this).html());
       updateWeeks();
       $('.bookingSpan').remove();
       getBooking();
    });
}
function updateWeeks() { // sets the week labels to be correct after selection is changed
    $('.leftWk').html(weeksArray[currWeek - 1].substring(5));
    $('.centWk').html(weeksArray[currWeek]);
    $('.rightWk').html(weeksArray[currWeek + 1].substring(5));
}
