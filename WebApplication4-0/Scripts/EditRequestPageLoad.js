var prefID;
var lesserVal = -1;
$(document).ready(function () {
    mainLoad()
    prefLoad(roomNumber - 1)
});
function mainLoad() {
    if (requestData.length == 0) {
        alert("Request doesn't exist");
        window.location.href = "ViewRequest.aspx";
    }
    $('.modTxt').val(requestData[0]['Module_Code']);
    for (var i = 0; i < modData.length; i++) {
        if (modData[i]['Module_Code'] == requestData[0]['Module_Code']) {
            $('.nameTxt').val(modData[i]['Module_Title']);
        }
    }
    $('.dayTxt').val(days[requestData[0]['Day'] - 1])
    $('.startTxt').val(starts[requestData[0]['Start_Time'] - 1])
    $('.endTxt').val(ends[requestData[0]['End_Time'] - 1]);
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

    $('.specReqs').val(preferences[0]["Special_Requirements"]);
}
function prefLoad(i) {
    while ($('.roomTxt').val() > preferences.length) {
        preferences.push({ Pref_ID: lesserVal, Room_ID: '', Building_ID: '', Room_Type: 'T', Park_ID: 'C', Number_Students: '', Special_Requirements: '', Weeks: 1 });
        lesserVal--;
    }
    while ($('.roomTxt').val() < preferences.length) {
        preferences.pop();
    }
    $('.studTxt').val(preferences[i]['Number_Students']);
    $('.inCirc').removeClass('selectRad');
    $('#' + preferences[i]['Room_Type']).addClass('selectRad');
    typeSet = $('#' + preferences[i]['Room_Type']).siblings('input').val();

    $('.parkCirc').removeClass('selectRad');
    $('#' + preferences[i]['Park_ID']).addClass('selectRad');
    parkSet = $('#' + preferences[i]['Park_ID']).siblings('input').val();
    var buildName = "NO PREFERENCE";
    for (var j = 0; j < buildData.length; j++) {
        if (buildData[j]['Building_ID'] == preferences[i]['Building_ID']) {
            buildName = buildData[j]['Building_Name'];
        }
    }

    $('.buildTxt').val(buildName);
    if (preferences[i]['Room_ID'] != null && preferences[i]['Room_ID'] != "") {
        $('.roomCodeTxt').val(preferences[i]['Room_ID']);
    }
    else {
        $('.roomCodeTxt').val("NO PREFERENCE");
    }
    var wkcounter = 0;
    $('.week').attr('chosen', false);
    $(this).css('background-color', '#999');
    if (preferences[i]['Weeks'] != 1 && preferences[i]['Weeks'] != 'true') {
        $('.noTick').click();
        for (var j = 0; j < weekData.length; j++) {
            if (weekData[j]['Pref_ID'] == preferences[i]['Pref_ID']) {
                $('#week' + weekData[j]['Week_ID']).css('background-color', '#FF8060');
                $('#week' + weekData[j]['Week_ID']).attr('clicked', 'true');
                $('#week' + weekData[j]['Week_ID']).next('.weekCheck').val(1);
                wkcounter++;
            }
        }
    }
    if (wkcounter == 0) {
        $('.defBtn').click();
    }
    facTicks($('.facYes'));
    var counter = 0;
    clearFacs();
    for (var j = 0; j < facData.length; j++) {
        if (facData[j]['Pref_ID'] == preferences[i]['Pref_ID']) {
            counter++
            $('#fac' + facData[j]['Facility_ID']).val('0');
            moveCirc($('#fac' + facData[j]['Facility_ID']).siblings('.circ'));
        }
    }
    if (counter == 0) {
        facTicks($('.facNo'));
    }
    $('.prefTit').html('<b>PREFERENCES (ROOM ' + (i + 1) + ')</b>');
    prefID = preferences[i]['Pref_ID'];
}
function savePref(i) {
    preferences[i]['Room_ID'] = $('.roomCodeTxt').val();
    var buildName = "";
    for (var j = 0; j < buildData.length; j++) {
        if (buildData[j]['Building_Name'] == $('.buildTxt').val()) {
            buildName = buildData[j]['Building_ID'];
        }
    }
    preferences[i]['Building_ID'] = buildName;
    preferences[i]['Room_Type'] = typeCodes[typeSet - 1];
    preferences[i]['Park_ID'] = parkCodes[typeSet - 1];
    preferences[i]['Number_Students'] = parseInt($('.studTxt').val());
    preferences[i]['Special_Requirements'] = "";
    preferences[i]['Weeks'] = Math.abs(week - 1);
    for (var j = weekData.length - 1; j >= 0; j--) {
        if (weekData[j]['Pref_ID'] == preferences[i]['Pref_ID']) {
            weekData.splice(j, 1);
        }
    }
    for (var j = facData.length - 1; j >= 0; j--) {
        if (facData[j]['Pref_ID'] == preferences[i]['Pref_ID']) {
            facData.splice(j, 1);
        }
    }

    $('.weekCheck').each(function () {
        if ($(this).val() == 1) {
            weekData.push({ Pref_ID: prefID, Week_ID: $(this).prev('.week').html() })
        }
    });
    $('.weekCheck').val(0);
    $('.facCheck').each(function () {
        if ($(this).val() == 1) {
            facCode = $(this).attr('id').replace("fac", "");
            facData.push({ Pref_ID: prefID, Facility_ID: facCode })
        }
    });
    $('.facCheck').val(0);
    $('.week').attr('chosen', false);
    $(this).css('background-color', '#999');

}