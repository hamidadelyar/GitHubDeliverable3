var weeksArray = ["", "WEEK ONE", "WEEK TWO", "WEEK THREE", "WEEK FOUR", "WEEK FIVE", "WEEK SIX", "WEEK SEVEN", "WEEK EIGHT", "WEEK NINE", "WEEK TEN", "WEEK ELEVEN", "WEEK TWELVE", "WEEK THIRTEEN", "WEEK FOURTEEN", "WEEK FIFTEEN", ""];
var currWeek = 1;
var semester = 1;
var showing = false;
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
    showLoader();
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
            hideLoader();
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
function updateWeeks() {
    $('.leftWk').html(weeksArray[currWeek - 1].substring(5));
    $('.centWk').html(weeksArray[currWeek]);
    $('.rightWk').html(weeksArray[currWeek + 1].substring(5));
}