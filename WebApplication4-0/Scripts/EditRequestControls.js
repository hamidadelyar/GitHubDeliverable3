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
    $('.prefBtn').click(function () {
        $('.editHolder').hide();
        $('.roomOneHolder').show();
    })
    for (var i = 0; i < facs.length; i++) {
        if (cols == 1) {
            facCells += '<tr class="facRw" >'
        }
        facCells += '<td><b>' + facs[i]['Facility_Name'].toUpperCase() + '</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>'
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
        week = 0;
    });
    $('.week').click(function () {
        var currVal = $(this).next('.weekCheck').val();
        $(this).next('.weekCheck').val(Math.abs(currVal - 1));
        if (currVal == 0) {
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
    });
    $('.parkCirc').click(function () {
        $('.parkCirc').removeClass('selectRad');
        $(this).addClass('selectRad');
        parkSet = $(this).siblings('.parkCheck').val();
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
    dropDowns();
});
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
            $('.codeTxt').val(modData[i]['Module_Code'])
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