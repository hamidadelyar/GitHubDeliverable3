$(document).ready(function () {
    var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    var starts = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
    var ends = ['09:50', '10:50', '11:50', '12:50', '13:50', '14:50', '15:50', '16:50', '17:50'];
    if (requestData.length == 0) {
        alert("Request doesn't exist");
        Window.Location.hfref = "ViewRequets.aspx";
    }
    $('.modTxt').val(requestData[0]['Module_Code']);
    for (var i = 0; i < modData.length; i++) {
        if (modData[i]['Module_Code'] == requestData[0]['Module_Code']) {
            $('.nameTxt').val(modData[0]['Module_Title']);
        }
    }
    $('.dayTxt').val(days[requestData[0]['Day']])
    $('.startTxt').val(starts[requestData[0]['Start_Time']])
    $('.endTxt').val(ends[requestData[0]['End_Time']]);
    $('.roomTxt').val(requestData[0]['Number_Rooms']);
    if (requestData[0]['Priority'] == 1 || requestData[0]['Priority'] == 'true') {
        $('.priNo').removeClass('selTick');
        $('.priNo').html('&nbsp;');
        $('.priYes').addClass('selTick');
        $('.priYes').html('&#10004;');
    }

    for (var i = 0; i < selLects.length; i++) {
        $('.lectList').append('<span>' + selLects[i]['Lecturer_ID'] + ' - ' + selLects[i]['Lecturer_Name'] + '</span>');
        numLects++;
    }
});