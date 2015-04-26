var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK FIFTEEN", ""];
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

    $(document).click(function (event) { // Clear table when anywhere else on page click
        if (event.target.id !== 'roomTxt' && event.target.id !== 'clearImg') {
            $(".suggestTbl").hide();
            $('.semesters').show();
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
    });

    $('.modChoice').click(function () { // change the tools panel to reflect that they wish to search module timetables
        type = 2;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('MODULE CODE');
    });

    $('.lectChoice').click(function () { // change the tools panel to reflect that they wish to search module timetables
        type = 3;
        $('.choice').css('text-decoration', 'none');
        $(this).css('text-decoration', 'underline');
        $('.roomTxt').val('');
        $('.rooms b').html('LECTURER');
    });
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
    else {
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
        url: "Timetable.aspx/SearchRoom",
        data: JSON.stringify({search: search, week: week, semester:semester, type:type}),
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
function insertData(result)
{
    hideLoader();
    $('.slot').show();
    showing = false;
    finAnim();
    var bookings = $.parseJSON(result.d);
    var i = 0
    $('.slot').each(function () {
        if (typeof bookings[i][0]['Module_Code'] != 'undefined') {
            var innerData = bookings[i][0];
            var lecCodes = innerData['Lecturer_ID'].split(",");
            var lecNames = innerData['Lecturer_Name'].split(",");
            var lecSpans = "";
            for (var j = 0; j < lecCodes.length; j++)
            {
                lecSpans += '<span class="lectName">' + lecCodes[j].toUpperCase() + ' ' + lecNames[j] + '</span>,<br />';
            }
            lecSpans = lecSpans.substring(0, lecSpans.length - 7);
            $(this).html(innerData['Module_Code'] + '<span class="bookingSpan" ><span class="modCode" >' + innerData['Module_Code'] + '<br />' + innerData['Module_Title'] + '</span><br />'+lecSpans+'<br /><span class="roomId">' + innerData['Room_ID'] + '</span></span>').addClass('booking');
            var cellIndex = $(this).index();
            var $currCell = $(this);
            for (var j = 0; j < innerData['End_Time'] - innerData['Start_Time'] - 1; j++) {
                $currCell = $currCell.closest('tr').next().children().eq(cellIndex)
                $currCell.hide();
            }
            $(this).attr('rowSpan', innerData['End_Time'] - innerData['Start_Time']);
            $('.bookingSpan').hide();
            bookingHover();
        }
        else {
            $(this).html('').removeClass('booking');
            $(this).attr('rowSpan', 1);
        }
        i++;
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
}
function updateWeeks() { // sets the week labels to be correct after selection is changed
    $('.leftWk').html(weeksArray[currWeek - 1].substring(5));
    $('.centWk').html(weeksArray[currWeek]);
    $('.rightWk').html(weeksArray[currWeek + 1].substring(5));
}