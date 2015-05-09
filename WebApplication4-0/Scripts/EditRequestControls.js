var week = 1;
var pri = 0;
var fac = 0;
var typeSet = 1;
var parkSet = 1;
var cols = 1;
var facCells = "";
var parkCodes = ['C', 'W', 'E'];
var typeCodes = ['T', 'S', 'L'];
var buildID = "NONE";
$(document).ready(function () {
    $('.prevBtn').hide();
    $('.prefBtn').click(function () {
        $('.editHolder').hide();
        $('.roomOneHolder').show();
        prefLoad(roomNumber-1)
    })
    for (var i = 0; i < facs.length; i++) {
        if (cols == 1) {
            facCells += '<tr class="facRw" >'
        }
        facCells += '<td><b>' + facs[i]['Facility_Name'].toUpperCase() + '</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" id="fac'+facs[i]['Facility_ID']+'" type="hidden" value="0" /></td>'
        if (cols == 4) {
            facCells += '</tr>';
            cols = 0;
        }
        cols++;
    }
    if (facCells.substr(facCells.length - 5) != '<tr/>') {
        facCells += '</tr>';
    }
    $(facCells).insertAfter('.facHd');
    $('.facStuff').hide();
    $('.addLect').click(function () {
        addLect();
    });
    $('.subLect').click(function () {
        subLect();
    });
    $('.weekTd').hide();
    $('.weekBtnTd').hide();
    $('.priTick').click(function () {
        $('.priTick').removeClass('selTick');
        $('.priTick').html('&nbsp;');
        $(this).addClass('selTick');
        $(this).html('&#10004');
        pri = $(this).siblings('input').val();
    });
    $('.facTick').click(function () {
        $('.facTick').removeClass('selTick');
        $('.facTick').html('&nbsp;');
        $(this).addClass('selTick');
        $(this).html('&#10004');
        fac = $(this).siblings('input').val();
        if(fac == 1)
        {
            $('.facStuff').show();
        }
        else
        {
            $('.facStuff').hide();
            clearFacs();
        }
    });
    $('.noTick').click(function () {
        $('.yesTd').hide();
        $('.noTd').hide();
        $('.weekTd').show();
        $('.weekBtnTd').show();
        $('.weekTit').html('<b>CHOSEN WEEKS</b>');
        week = 1;
    });
    $('.defBtn').click(function () {
        $('.yesTd').show();
        $('.noTd').show();
        $('.weekTd').hide();
        $('.weekBtnTd').hide();
        $('.weekTit').html('<b>DEFAULT WEEKS</b>');
        $('.clrBtn').click();
        week = 0;
    });
    $('.week').click(function () {
        var currInp = $(this).next('.weekCheck').val();
        $(this).next('.weekCheck').val(Math.abs(currInp - 1));
        if (currInp == 0) {
            $(this).css('background-color', '#FF8060');
            $(this).attr('clicked', 'true');
        }
        else {
            $(this).css('background-color', '#999');
            $(this).attr('clicked', 'false');
            $(this).hover(function () {
                $(this).css("background-color", "#FF8060");
            }, function () {
                if ($(this).attr('clicked') != 'true') {
                    $(this).css("background-color", "#999");
                }
            });
        }
    });
    $('.allBtn').click(function () {
        $('.week').each(function () {
            $(this).next('.weekCheck').val(1);
            $(this).css("background-color", "#FF8060");
            $(this).attr('clicked', 'true');
        });
    });
    $('.clrBtn').click(function () {
        $('.week').each(function () {
            $(this).next('.weekCheck').val(0);
            $(this).css("background-color", "#999");
            $(this).attr('clicked', 'false');
        });
    });
    $('.oddBtn').click(function () {
        $('.week').each(function (i) {
            if (i % 2 == 0) {
                $(this).next('.weekCheck').val(1);
                $(this).css("background-color", "#FF8060");
                $(this).attr('clicked', 'true');
            }
            else {
                $(this).css('background-color', '#999');
                $(this).attr('clicked', 'false');
                $(this).hover(function () {
                    $(this).css("background-color", "#FF8060");
                }, function () {
                    if ($(this).attr('clicked') != 'true') {
                        $(this).css("background-color", "#999");
                    }
                });
            }
        });
    });
    $('.evenBtn').click(function () {
        $('.week').each(function (i) {
            if (i % 2 != 0) {
                $(this).next('.weekCheck').val(1);
                $(this).css("background-color", "#FF8060");
                $(this).attr('clicked', 'true');
            }
            else {
                $(this).css('background-color', '#999');
                $(this).attr('clicked', 'false');
                $(this).hover(function () {
                    $(this).css("background-color", "#FF8060");
                }, function () {
                    if ($(this).attr('clicked') != 'true') {
                        $(this).css("background-color", "#999");
                    }
                });
            }
        });
    });
    $('.inCirc').click(function () {
        $('.inCirc').removeClass('selectRad');
        $(this).addClass('selectRad');
        typeSet = $(this).siblings('.typeCheck').val();
        $('.buildTxt').val('NO PREFERENCE');
        $('.roomCodeTxt').val('NO PREFERENCE');
    });
    $('.parkCirc').click(function () {
        $('.parkCirc').removeClass('selectRad');
        $(this).addClass('selectRad');
        parkSet = $(this).siblings('.parkCheck').val();
        $('.buildTxt').val('NO PREFERENCE');
        $('.roomCodeTxt').val('NO PREFERENCE');
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
    $('.prevBtn').click(function () {
        if (prefValid())
        {
            if (roomNumber != 1) {
                $('.nextBtn').show();
                savePref(roomNumber - 1);
                roomNumber--;
                prefLoad(roomNumber - 1)
            }
            else {
                $('.prevBtn').hide();
            }
        }
    });
    $('.nextBtn').click(function () {
        if (prefValid())
        {
            if (roomNumber != preferences.length) {
                savePref(roomNumber - 1);
                roomNumber++;
                prefLoad(roomNumber - 1);
            }
            else {
                $('.nextBtn').hide();
            }
        }
    });
    $('.doneBtn').click(function () {
        if (prefValid())
        {
            savePref(roomNumber - 1);
            $('.editHolder').show();
            $('.roomOneHolder').hide();
            roomNumber = 1;
        }
    });
    dropDowns();
});
function clearFacs() {
    $('.facCheck').each(function () {
        $(this).val('0');
        $(this).siblings('.circ').css('left', '-42px');
        $(this).siblings('.circ').css('background-color', '#999');
    });
}
function dropDowns() {
    for (var i = 0; i < modData.length; i++) {
        $('<tr><td colspan="8"><span tabindex="' + i + '" class="codeTbl" id="code' + i + '" >' + modData[i]['Module_Code'] + '</span></td></tr>').insertAfter('.codeRw');
    }
    $('.codeHolderTbl').hide();
    $('.modTxt').focusin(function () {
        var left = $('.modTxt').position().left;
        var top = $('.modTxt').position().top;
        var width = $('.modTxt').width();
        $('.codeHolderTbl').css('left', left);
        $('.codeHolderTbl').css('top', top + 22);
        $('.modHolderTbl').show();
        $('.nameHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.codeHolderTbl').css('width', width + 12);
        $('.codeHolderTbl').css('max-height', '400px');
        $('.codeTxt').css('width', '100%!important')
        $('.codeHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.codeTbl');
    });
    $('.modTxt').on('input propertychange paste', function () {
        $('.nameTxt').val("");
        txtPredict($(this), '.codeTbl');
    });
    $('.modTxt').focusout(function () {
        findName($(this).val());
    });
    $('.codeTbl').click(function () {
        $('.modTxt').val($(this).html());
        findName($(this).html());
        $('.modTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    for (var i = 0; i < modData.length; i++) {
        $('<tr><td colspan="8"><span tabindex="' + i + '" class="nameTbl" id="name' + i + '" >' + modData[i]['Module_Title'] + '</span></td></tr>').insertAfter('.nameRw');
    }
    $('.nameHolderTbl').hide();
    $('.nameTxt').focusin(function () {
        var left = $('.nameTxt').position().left;
        var top = $('.nameTxt').position().top;
        var width = $('.nameTxt').width();
        $('.nameHolderTbl').css('left', left);
        $('.nameHolderTbl').css('top', top + 22);
        $('.modHolderTbl').hide();
        $('.nameHolderTbl').show();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.nameHolderTbl').css('width', width + 12);
        $('.nameTxt').css('width', '100%!important')
        $('.nameHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.nameTbl');
    });
    $('.nameTxt').on('input propertychange paste', function () {
        $('.modTxt').val("");
        txtPredict($(this), '.nameTbl');
    });
    $('.nameTxt').focusout(function () {
        findCode($(this).val());
    });
    $('.nameTbl').click(function () {
        $('.nameTxt').val($(this).html())
        findCode($(this).html());
        findCode($(this).html());
        $('.nameTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    $('.dayHolderTbl').hide();
    $('.dayTxt').focusin(function () {
        var left = $('.dayTxt').position().left;
        var top = $('.dayTxt').position().top;
        var width = $('.dayTxt').width();
        $('.dayHolderTbl').css('left', left);
        $('.dayHolderTbl').css('top', top + 22);
        $('.modHolderTbl').hide();
        $('.dayHolderTbl').show();
        $('.nameHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.dayHolderTbl').css('width', width + 12);
        $('.dayTxt').css('width', '100%!important')
        $('.dayHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.dayTbl');
    });
    $('.dayTxt').on('input propertychange paste', function () {
        txtPredict($(this), '.dayTbl');
    });
    $('.dayTbl').click(function () {
        $('.dayTxt').val($(this).html());
        $('.dayTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    $('.startHolderTbl').hide();
    $('.startTxt').focusin(function () {
        var left = $('.startTxt').position().left;
        var top = $('.startTxt').position().top;
        var width = $('.startTxt').width();
        $('.startHolderTbl').css('left', left);
        $('.startHolderTbl').css('top', top + 22);
        $('.modHolderTbl').hide();
        $('.startHolderTbl').show();
        $('.dayHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.startHolderTbl').css('width', width + 12);
        $('.startTxt').css('width', '100%!important')
        $('.startHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.startTbl');
    });
    $('.startTxt').on('input propertychange paste', function () {
        txtPredict($(this), '.startTbl');
    });
    $('.startTbl').click(function () {
        $('.startTxt').val($(this).html());
        $('.startTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    $('.endHolderTbl').hide();
    $('.endTxt').focusin(function () {
        var left = $('.endTxt').position().left;
        var top = $('.endTxt').position().top;
        var width = $('.endTxt').width();
        $('.endHolderTbl').css('left', left);
        $('.endHolderTbl').css('top', top + 22);
        $('.modHolderTbl').hide();
        $('.endHolderTbl').show();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.endHolderTbl').css('width', width + 12);
        $('.endTxt').css('width', '100%!important')
        $('.endHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.endTbl');
    });
    $('.endTxt').on('input propertychange paste', function () {
        txtPredict($(this), '.endTbl');
    });
    $('.endTbl').click(function () {
        $('.endTxt').val($(this).html());
        $('.endTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    $('.roomHolderTbl').hide();
    $('.roomTxt').focusin(function () {
        var left = $('.roomTxt').position().left;
        var top = $('.roomTxt').position().top;
        var width = $('.roomTxt').width();
        $('.roomHolderTbl').css('left', left);
        $('.roomHolderTbl').css('top', top + 22);
        $('.codeHolderTbl').hide();
        $('.roomHolderTbl').show();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.endHolderTbl').css('width', width + 12);
        $('.endTxt').css('width', '100%!important')
        $('.endHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.roomTbl');
    });
    $('.roomTxt').on('input propertychange paste', function () {
        txtPredict($(this), '.roomTbl');
    });
    $('.roomTbl').click(function () {
        $('.roomTxt').val($(this).html());
        $('.roomTxt').focus();
        $(this).css('background-color:', '#2b3036');
    });
    $('.lectHolderTbl').hide();
    for (var i = 0; i < lectData.length; i++) {
        $('<tr><td colspan="8"><span tabindex="' + i + '" class="lectTbl" id="lect' + i + '" >' + lectData[i]['Lecturer_ID'] + '</span></td></tr>').insertAfter('.lectRw');
    }
    $('.lectTxt').focusin(function () {
        var left = $('.lectTxt').position().left;
        var top = $('.lectTxt').position().top;
        var width = $('.lectTxt').width();
        $('.lectHolderTbl').css('left', left);
        $('.lectHolderTbl').css('top', top + 22);
        $('.modHolderTbl').hide();
        $('.lectHolderTbl').show();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.lectHolderTbl').css('width', width + 12);
        $('.lectTxt').css('width', '100%!important')
        $('.lectHolderTbl').children('.triang').css('left', width / 2);
        txtPredict($(this), '.lectTbl');
    });
    $('.lectTxt').on('input propertychange paste', function () {
        txtPredict($(this), '.lectTbl');
    });
    $('.lectTbl').click(function () {
        $('.lectTxt').val($(this).html())
    });
    $('.buildHolderTbl').hide();
    for (var i = 0; i < buildData.length; i++) {
        $('<tr><td colspan="8"><span tabindex="' + i + '" class="buildTbl '+buildData[i]['Park_ID']+'" id="'+buildData[i]['Building_ID']+'" >' + buildData[i]['Building_Name'] + '</span></td></tr>').insertAfter('.buildRw');
    }
    $('.buildTxt').focusin(function () {
        var left = $('.buildTxt').position().left;
        var top = $('.buildTxt').position().top;
        var width = $('.buildTxt').width();
        $('.buildHolderTbl').css('left', left);
        $('.buildHolderTbl').css('top', top + 22);
        $('.roomCodeHolderTbl').hide();
        $('.buildHolderTbl').show()
        $('.buildHolderTbl').css('width', width + 12);
        $('.buildTxt').css('width', '100%!important')
        $('.buildHolderTbl').children('.triang').css('left', width / 2);
        var selPark = parkCodes[parkSet - 1];
        $('.buildTbl').hide();
        $('.buildTbl').each(function () {
            if($(this).hasClass(selPark))
            {
                $(this).show();
            }
        })
        buildTxtPredict($(this), '.buildTbl');
    });
    $('.buildTxt').on('input propertychange paste', function () {
        buildTxtPredict($(this), '.buildTbl');
    });
    $('.buildTbl').click(function () {
        $('.buildTxt').val($(this).html());
        buildID = $(this).attr('id');
    });
    $('.roomCodeHolderTbl').hide();
    for (var i = 0; i < roomData.length; i++) {
        $('<tr><td colspan="8"><span tabindex="' + i + '" class="roomCodeTbl ' + roomData[i]['Building_ID'] + ' '+roomData[i]['Room_Type']+'" id="roomCode' + i + '" >' + roomData[i]['Room_ID'] + '</span></td></tr>').insertAfter('.roomCodeRw');
    }
    $('.roomCodeTxt').focusin(function () {
        var left = $('.roomCodeTxt').position().left;
        var top = $('.roomCodeTxt').position().top;
        var width = $('.roomCodeTxt').width();
        $('.roomCodeHolderTbl').css('left', left);
        $('.roomCodeHolderTbl').css('top', top + 22);
        $('.roomCodeHolderTbl').show();
        $('.buildHolderTbl').hide()
        $('.roomCodeHolderTbl').css('width', width + 12);
        $('.roomCodeTxt').css('width', '100%!important')
        $('.roomCodeHolderTbl').children('.triang').css('left', width / 2);
        var selType = typeCodes[typeSet - 1];
        $('.roomCodeTbl').hide();
        $('.roomCodeTbl').each(function () {
            if ($(this).hasClass(selType) && $(this).hasClass(buildID)) {
                $(this).show();
            }
        })
        roomTxtPredict($(this), '.roomCodeTbl');
    });
    $('.roomCodeTxt').on('input propertychange paste', function () {
        roomTxtPredict($(this), '.roomCodeTbl');
    });
    $('.roomCodeTbl').click(function () {
        $('.roomCodeTxt').val($(this).html())
    });
    $('input').focusin(function (event) { // Clear table when anywhere else on page click
        $('.codeHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.lectHolderTbl').hide();
        if (event.target.id == 'modTxt') {
            $('.codeHolderTbl').show();
        }
        if (event.target.id == 'nameTxt') {
            $('.nameHolderTbl').show();
        }
        if (event.target.id == 'dayTxt') {
            $('.dayHolderTbl').show();
        }
        if (event.target.id == 'startTxt') {
            $('.startHolderTbl').show();
        }
        if (event.target.id == 'endTxt') {
            $('.endHolderTbl').show();
        }
        if (event.target.id == 'roomTxt') {
            $('.roomHolderTbl').show();
        }
        if (event.target.id == 'lectTxt') {
            $('.lectHolderTbl').show();
        }
    });
    $(document).click(function (event) { // Clear table when anywhere else on page click
        $('.codeHolderTbl').hide();
        $('.nameHolderTbl').hide();
        $('.dayHolderTbl').hide();
        $('.startHolderTbl').hide();
        $('.endHolderTbl').hide();
        $('.roomHolderTbl').hide();
        $('.lectHolderTbl').hide();
        $('.buildHolderTbl').hide();
        $('.roomCodeHolderTbl').hide();
        $('.codeTbl').css('background-color:', '#2b3036');
        $('.nameTbl').css('background-color:', '#2b3036');
        $('.dayTbl').css('background-color:', '#2b3036');
        $('.startTbl').css('background-color:', '#2b3036');
        $('.endTbl').css('background-color:', '#2b3036');
        $('.roomTbl').css('background-color:', '#2b3036');
        $('.lectTbl').css('background-color:', '#2b3036');
        if (event.target.id == 'modTxt') {
            $('.codeHolderTbl').show();
        }
        if (event.target.id == 'nameTxt') {
            $('.nameHolderTbl').show();
        }
        if (event.target.id == 'dayTxt') {
            $('.dayHolderTbl').show();
        }
        if (event.target.id == 'startTxt') {
            $('.startHolderTbl').show();
        }
        if (event.target.id == 'endTxt') {
            $('.endHolderTbl').show();
        }
        if (event.target.id == 'roomTxt') {
            $('.roomHolderTbl').show();
        }
        if (event.target.id == 'lectTxt') {
            $('.lectHolderTbl').show();
        }
        if (event.target.id == 'buildTxt') {
            $('.buildHolderTbl').show();
        }
        if (event.target.id == 'roomCodeTxt') {
            $('.roomCodeHolderTbl').show();
        }
    })
    $(document).on('keyup', function (e) {
        if (e.which === 40) {
            $('#' + navigable[curr]).css('background-color', '#2b3036');
            if (curr != navigable.length - 1) {
                curr++;
            }
            $('#' + navigable[curr]).css('background-color', '#FF8060');
            $('#' + navigable[curr]).focus();
        };
        if (e.which === 38) {
            $('#' + navigable[curr]).css('background-color', '#2b3036');
            if (curr != 0) {
                curr--;
            }
            $('#' + navigable[curr]).css('background-color', '#FF8060');
            $('#' + navigable[curr]).focus();
        };
        if (e.which === 13) {
            $(document.activeElement).click();
        }
    });
}
function findName(code) {
    for (var i = 0; i < modData.length; i++) {
        if (modData[i]['Module_Code'].toUpperCase() == code.toUpperCase()) {
            $('.nameTxt').val(modData[i]['Module_Title']);
            break;
        }
    }
}
function findCode(code) {
    for (var i = 0; i < modData.length; i++) {
        if (modData[i]['Module_Title'].toUpperCase() == code.toUpperCase()) {
            $('.modTxt').val(modData[i]['Module_Code'])
            break;
        }
    }
}
function txtPredict(inputBox, rowClass) {
    var ids = [];
    var txt = $(inputBox).val();
    if (txt.trim() == "") {
        $(rowClass).show();
        $(rowClass).each(function () {
            ids.push($(this).attr('id'));
        });
    } else {
        $(rowClass).each(function () {
            if ($(this).html().toUpperCase().indexOf(txt.toUpperCase()) != -1) {
                $(this).show();
                ids.push($(this).attr('id'));
            } else {
                $(this).hide();
            }
        })
    };
    if (ids.length > 7) {
        $(rowClass).hide();
        ids = ids.slice(0, 7);
        for (var i = 0; i < ids.length; i++) {
            $('#' + ids[i]).show();
        }
    }
    navigable = ids;
    curr = -1;
}
function buildTxtPredict(inputBox, rowClass) {
    var ids = [];
    var txt = $(inputBox).val();
    $(rowClass).hide();
    var selPark = parkCodes[parkSet - 1];
    if (txt.trim() == "") {
        $(rowClass).each(function () {
            if ($(this).hasClass(selPark) || $(this).hasClass('noPref'))
            {
                $(this).show();
                ids.push($(this).attr('id'));
            }
        });
    } else {
        $(rowClass).each(function () {
            if (($(this).html().toUpperCase().indexOf(txt.toUpperCase()) != -1 && $(this).hasClass(selPark)) || $(this).hasClass('noPref')) {
                $(this).show();
                ids.push($(this).attr('id'));
            }
        })
    };
    if (ids.length > 7) {
        $(rowClass).hide();
        ids = ids.slice(0, 7);
        for (var i = 0; i < ids.length; i++) {
            $('#' + ids[i]).show();
        }
    }
    navigable = ids;
    curr = -1;
}
function roomTxtPredict(inputBox, rowClass) {
    var ids = [];
    var txt = $(inputBox).val();
    $(rowClass).hide();
    var selType = typeCodes[typeSet - 1];
    if (txt.trim() == "") {
        $(rowClass).each(function () {
            if (($(this).hasClass(selType) && $(this).hasClass(buildID)) || $(this).hasClass('noPref')) {
                $(this).show();
                ids.push($(this).attr('id'));
            }
        });
    } else {
        $(rowClass).each(function () {
            if (($(this).html().toUpperCase().indexOf(txt.toUpperCase()) != -1 && $(this).hasClass(selType) && $(this).hasClass(buildID)) || $(this).hasClass('noPref')) {
                $(this).show();
                ids.push($(this).attr('id'));
            }
        })
    };
    if (ids.length > 7) {
        $(rowClass).hide();
        ids = ids.slice(0, 7);
        for (var i = 0; i < ids.length; i++) {
            $('#' + ids[i]).show();
        }
    }
    navigable = ids;
    curr = -1;
}
function addLect() {
    if (numLects != 3) {
        if ($('.lectTxt').val().trim() == "") {

        } else {
            for (var i = 0; i < lectData.length; i++) {
                if (lectData[i]['Lecturer_ID'] == $('.lectTxt').val().trim()) {
                    var exists = false;
                    $('.lectList span').each(function () {
                        if ($(this).html() == $('.lectTxt').val().trim()) {
                            exists = true;
                        }
                    });
                    if (!exists) {
                        $('.lectList').append('<span>' + $('.lectTxt').val().trim() + '</span>');
                        numLects++;
                        $('.lectTxt').val('');
                    }
                }
            }
        }
    }
}
function subLect() {
    $('.lectList').find("span:last").remove();
    if (numLects != 0) {
        numLects--;
    }
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function prefValid()
{
    var bool = true;
    if($('.studTxt').val().trim() == "")
    {
        bool = false;
        $('.studTit').html('<b>NUMBER OF STUDENTS</b><span class="alert" >&nbsp;You must enter a number of students</span>');
    }
    else if ($('.studTxt').val().trim() == 0)
    {
        bool = false;
        $('.studTit').html('<b>NUMBER OF STUDENTS</b><span class="alert" >&nbsp;You must enter a number greater than 0</span>');
    }
    else
    {
        $('.studTit').html('<b>NUMBER OF STUDENTS</b><span class="alert" ></span>');
    }
    var buildFound = false;
    for(var i = 0; i < buildData.length; i++)
    {
        if(buildData[i]['Building_Name'] == $('.buildTxt').val().trim())
        {
            buildFound = true;
            break;
        }
    }
    if($('.buildTxt').val().trim() == "")
    {
        $('.buildTxt').val('NO PREFERENCE');
    }
    if(!buildFound && $('.buildTxt').val() != 'NO PREFERENCE')
    {
        bool = false;
        $('.buildTit').html('<b>BUILDING</b><span class="alert" >&nbsp;Building doesn\'t exist</span>');
    }
    else
    {
        $('.buildTit').html('<b>BUILDING</b><span class="alert" ></span>');
    }

    var roomFound = false;
    for (var i = 0; i < roomData.length; i++) {
        if (roomData[i]['Room_ID'] == $('.roomCodeTxt').val().trim()) {
            roomFound = true;
            break;
        }
    }
    if ($('.roomCodeTxt').val().trim() == "") {
        $('.roomCodeTxt').val('NO PREFERENCE');
    }
    if (!buildFound && $('.roomCodeTxt').val() != 'NO PREFERENCE') {
        bool = false;
        $('.roomCodeTit').html('<b>ROOM</b><span class="alert" >&nbsp;Room doesn\'t exist</span>');
    }
    else {
        $('.roomCodeTit').html('<b>BUILDING</b><span class="alert" ></span>');
    }

    var wkCount = 0;
    $('.weekCheck').each(function () {
        if ($(this).val() == 1) {
            wkCount++
        }
    });

    if (wkCount == 0 && week == 1)
    {
        bool = false;
        $('.weekTit').html('<b>CHOSEN WEEKS</b><span class="alert" >&nbsp;You must choose a week</span>');
    }
    else if (week == 0)
    {
        $('.weekTit').html('<b>DEFAULT WEEKS</b><span class="alert" ></span>');
    }
    else
    {
        $('.weekTit').html('<b>CHOSEN WEEKS</b><span class="alert" ></span>');
    }
    return bool;
}

function validate()
{
    var bool = true;
    var codeFound = false;
    for (var i = 0; i < modData.length; i++) {
        if ( modData[i]['Module_Code'] == $('.modTxt').val().trim()) {
            codeFound = true;
            break;
        }
    }
    if ($('.modTxt').val().trim() == "") {
        bool = false;
        $('.codeTit').html('<b>MODULE CODE</b><span class="alert" > You must enter a code</span>')
    }
    else if(!codeFound)
    {
        bool = false;
        $('.codeTit').html('<b>MODULE CODE</b><span class="alert" > Module code doesn\'t exist</span>')
    }
    else
    {
        $('.codeTit').html('<b>MODULE CODE</b><span class="alert" ></span>')
    }

    var nameFound = false;
    for (var i = 0; i < modData.length; i++) {
        if (modData[i]['Module_Title'] == $('.nameTxt').val().trim()) {
            nameFound = true;
            break;
        }
    }
    if ($('.nameTxt').val().trim() == "") {
        bool = false;
        $('.nameTit').html('<b>MODULE TITLE</b><span class="alert" > You must enter a title</span>')
    }
    else if (!nameFound) {
        bool = false;
        $('nameTit').html('<b>MODULE TITLE</b><span class="alert" > Module title doesn\'t exist</span>')
    }
    else {
        $('.nameTit').html('<b>MODULE TITLE</b><span class="alert" ></span>')
    }

    var dayFound = false;
    for (var i = 0; i < days.length; i++) {
        if (days[i] == $('.dayTxt').val().trim()) {
            dayFound = true;
            break;
        }
    }
    if ($('.dayTxt').val().trim() == "") {
        bool = false;
        $('.dayTit').html('<b>DAY</b><span class="alert" > You must enter a day</span>')
    }
    else if (!dayFound) {
        bool = false;
        $('.dayTit').html('<b>DAY</b><span class="alert" > Day doesn\'t exist</span>')
    }
    else {
        $('.dayTit').html('<b>DAY</b><span class="alert" ></span>')
    }

    var startFound = false;
    for (var i = 0; i < starts.length; i++) {
        if (starts[i] == $('.startTxt').val().trim()) {
            startFound = true;
            break;
        }
    }
    if ($('.startTxt').val().trim() == "") {
        bool = false;
        $('.startTit').html('<b>START TIME</b><span class="alert" > You must enter a start</span>')
    }
    else if (!startFound) {
        bool = false;
        $('.startTit').html('<b>START TIME</b><span class="alert" > Start time doesn\'t exist</span>')
    }
    else {
        $('.startTit').html('<b>START TIME</b><span class="alert" ></span>')
    }

    var endFound = false;
    for (var i = 0; i < ends.length; i++) {
        if (ends[i] == $('.endTxt').val().trim()) {
            endFound = true;
            break;
        }
    }
    if ($('.endTxt').val().trim() == "") {
        bool = false;
        $('.endTit').html('<b>END TIME</b><span class="alert" > You must enter an end</span>')
    }
    else if (!endFound) {
        bool = false;
        $('.endTit').html('<b>END TIME</b><span class="alert" > End time doesn\'t exist</span>')
    }
    else if($('.endTxt').val().trim() < $('.startTxt').val().trim())
    {
        bool = false;
        $('.endTit').html('<b>END TIME</b><span class="alert" > End before start</span>')
    }
    else {
        $('.endTit').html('<b>END TIME</b><span class="alert" ></span>')
    }

    if ($('.roomTxt').val().trim() == "") {
        bool = false;
        $('.roomTit').html('<b>NUMBER OF ROOMS</b><span class="alert" > You must enter a number</span>')
    }
    else if ($('.roomTxt').val().trim() != 1 && $('.roomTxt').val().trim() != 2 && $('.roomTxt').val().trim() != 3) {
        bool = false;
        $('.roomTit').html('<b>NUMBER OF ROOMS</b><span class="alert" > Room number out of bounds</span>')
    }
    else {
        $('.roomTit').html('<b>NUMBER OF ROOMS</b><span class="alert" ></span>')
    }

    if($('.lectList').children().length == 0)
    {
        bool = false;
        $('.lectTit').html('<b>LECTURER</b><span class="alert" > You must enter a lecturer</span>')
    }
    else
    {
        $('.lectTit').html('<b>LECTURER</b><span class="alert" ></span>')
    }
    if(bool)
    {
        insertData();
    }
}

String.prototype.Capitalise = function()
{ 
    return this.toLowerCase().replace(/\b./g, function(a) { return a.toUpperCase(); });
}

function insertData()
{
    var reqData = {Request_ID: reqId, Module_Code: $('.modTxt').val().trim().toUpperCase(), Day: $('.dayTxt').val().trim().Capitalise(), Start_Time: $('.startTxt').val().trim(), End_Time: $('.endTxt').val().trim(), Priority: pri, Number_Rooms: $('.roomTxt').val().trim()};
    var reqLects =[];
    $('.lectList span').each(function () {
        reqLects.push({ Request_ID: reqId, Lecturer_ID: $(this).html().substring(0, $(this).html().indexOf(' ')).trim() })
    });
    $('.editHolder').html('<span class="loader" ><img src="/Images/processing.gif" width="220" height="20" /></span>');
    /*$.ajax({
        type: "POST",
        url: "EditRequest.aspx/UpdateRequest",
        data: JSON.stringify({requestDets: reqData, reqLects: reqLects, prefData: preferences, weekData: weekData, facData, facData}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("An error occurred. Please try again.");
            window.location.reload();
        },
        success: function (result) {
            $('.main').html('<div class="hdr" ><b>EDIT MODULE</b></div><div class="conf" ><img src="/Images/Done.png" width="30" height="30" /><span>&nbsp;Module has been updated.</span></div>');
            setTimeout(function () {
                window.location.href = "Modules.aspx"; //will redirect to your blog page (an ex: blog.html)
            }, 2000);
        }
    });*/
}