$(document).ready(function () {
    var week = 1;
    var pri = 0;
    var typeSet = 1;
    var parkSet = 1;
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