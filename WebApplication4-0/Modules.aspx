<%@ Page Title="Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="WebApplication4_0.Modules1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
    <script src="Scripts/dist/jquery.floatThead.js" ></script>
    <script>
        var modules = <%= this.modules %>;
        var showing = false;
        $(document).ready(function(){
            $('.delMultHolder').hide();
            $('.confirmDel').hide();
            $('.dark').hide();
            for(var i = 0; i < modules.length; i++)
            {
                $('.modTbl').append('<tr class="modules tblRw showing" ><td class="smlPadLeft rightLines"><input class="rwCheck" type="checkbox" /></td><td class="modTd padLeft rightLines" ><b>'+modules[i]['Module_Code']+'</b></td><td class="rightLines padLeft" >'+modules[i]['Module_Title']+'</b></td><td class="padLeft" ><span class="delBtn" >DELETE</span><span class="editBtn" >EDIT</span></td></tr>');
            }
            $('.resToolTbl tr').hide();
            $('.filt').show();
            var $table = $('.modTbl');
            $table.floatThead();
            $('.showHide').click(function () {
                if (showing)
                {
                    $('.resToolTbl tr').hide();
                    $('.filt').show();
                    $('.plusSymbol span').html('+')
                }
                else
                {
                    var all = 0;
                    $('.resToolTbl tr').show();
                    $('.plusSymbol span').html('-');
                    $('.CentFilt').show();
                    $('.WestFilt').show();
                    $('.EastFilt').show();
                }
                showing = !showing
            })
            $('.circ').click(function () {
                var currVal = $(this).siblings('input').val();
                $(this).siblings('input').val(Math.abs(currVal - 1));
                if (currVal == 0)
                {
                    $(this).animate({
                        backgroundColor: '#FF8060',
                        left: "+=30"
                    }, 500, function () {
                        showRows(this);
                    });
                }
                else
                {
                    $(this).animate({
                        backgroundColor: '#999',
                        left: "-=30"
                    }, 500, function () {
                        hideRows(this)
                    });
                }
            });
            var checked = false;
            $('.selectAll').click(function()
            {
                if(checked)
                {
                    $('.selectAll').prop('checked', false);
                    $('.showing').each(function(){
                        $(this).children('td:first').children('input').prop('checked', false)
                    })
                    checked = false;
                }
                else
                {
                    $('.selectAll').prop('checked', true);
                    $('.showing').each(function(){
                        $(this).children('td:first').children('input').prop('checked', true)
                    })
                    checked = true;
                }
            });
            $('.editBtn').click(function(){
                window.location.href = "EditModule?modCode=" + $(this).parent().siblings('.modTd').children('b').html();
            });
            var delCode = "";
            var delType = 0;
            $('.delBtn').click(function(){
                $('.modHolder').addClass('blurHolder');
                $('.confirmDel').show();
                $('.dark').show();
                delType = 0;
                delCode = $(this).parent().siblings('.modTd').children('b').html();
            });
            $('.cclDel').click(function(){
                $('.modHolder').removeClass('blurHolder');
                $('.confirmDel').hide();
                $('.txt').html('<b>Deleting this module will remove all references to the module from the database. <br /> Are you sure you wish to proceed?</b>');
                $('.dark').hide();
                delCode = "";
            });
            $('.dark').click(function(){
                $('.modHolder').removeClass('blurHolder');
                $('.confirmDel').hide();
                $('.txt').html('<b>Deleting this module will remove all references to the module from the database. <br /> Are you sure you wish to proceed?</b>');
                $('.dark').hide();
                delCode = "";
            });
            $('.subDel').click(function(){
                if(delType == 0)
                {
                    $.ajax({
                        type: "POST",
                        url: "Modules.aspx/DeleteModule",
                        data: JSON.stringify({ modCode: delCode}),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert("An error occurred. Please try again.");
                            window.location.reload();
                        },
                        success: function (result) {
                            window.location.reload();
                        }
                    });
                }
                else
                {
                    var selCodes = [];
                    $('.rwCheck').each(function(){
                        if($(this).prop('checked'))
                        {
                            selCodes.push($(this).parent().siblings('.modTd').children('b').html());
                        }
                    })
                    $.ajax({
                        type: "POST",
                        url: "Modules.aspx/DeleteMult",
                        data: JSON.stringify({ modCode: JSON.stringify(selCodes)}),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert("An error occurred. Please try again.");
                            window.location.reload();
                        },
                        success: function (result) {
                            window.location.reload();
                        }
                    });
                }
            });
            $('.delMult').click(function(){
                $('.modHolder').addClass('blurHolder');
                $('.confirmDel').show();
                delType = 1;
                $('.txt').html('<b>Deleting these modules will remove all references to the modules from the database. <br /> Are you sure you wish to proceed?</b>');
                $('.dark').show();
                delCode = $(this).parent().siblings('.modTd').children('b').html();
            });
            $('input').click(function(){
                $('.delMultHolder').css('width', $('.modTbl').width());
                $('.delMultHolder').css('left', '50%');
                $('.delMultHolder').css('margin-left', '-'+$('.modTbl').width()/2+'px');
                if ($(".rwCheck:checked").length == 0)
                {
                    $('.selectAll').prop('checked', false);
                    $('.delMultHolder').hide();
                }
                else
                {
                    $('.delMultHolder').show();
                }
            });
        });
        function hideRows(obj)
        {
            var id = $(obj).siblings('input').attr('id');
            $('.modules').each(function(){
                var modCode = $(this).children('td').eq(1).html().split('');
                if(modCode[5] == id)
                {
                    $(this).children('td:first').children('input').prop('checked', false);
                    $(this).removeClass('showing');
                    $(this).hide();
                }
                if(id == 'O')
                {
                    if(modCode[5] != 'A' && modCode[5] != 'B' && modCode[5] != 'C' && modCode[5] != 'D' && modCode[5] != 'F' && modCode[5] != 'P')
                    {
                        $(this).children('td:first').children('input').prop('checked', false);
                        $(this).removeClass('showing');
                        $(this).hide();
                    }
                }
            });
        }
        function showRows(obj)
        {
            var id = $(obj).siblings('input').attr('id');
            $('.modules').each(function(){
                var modCode = $(this).children('td').eq(1).html().split('');
                if(modCode[5] == id)
                {
                    $(this).addClass('showing');
                    $(this).show();
                }
                if(id == 'O')
                {
                    if(modCode[5] != 'A' && modCode[5] != 'B' && modCode[5] != 'C' && modCode[5] != 'D' && modCode[5] != 'F' && modCode[5] != 'P')
                    {
                        $(this).addClass('showing');
                        $(this).show();
                    }
                }
            });
        }
    </script>
    <style>
        .modHolder
        {
            margin-top:50px;
            border-radius:10px;
            width:95%;
            background-color:#FFF;
            text-align:center;
            padding:2.5%;
        }
        .rightLines
        {
            border-right:#FF8060 solid 1pt;
        }
        .padLeft
        {
            padding-left:35px;
        }
        .smlPadLeft
        {
            padding-left:15px;
        }
        input[type='checkbox']
        {
            padding-left:0;
            padding-right:0;
            margin-right:0;
            margin-left:0;
            background-color:#F00;
        }
        .hdr
        {
            font-size:1.4em;
            text-align:center;
        }
        .circ
        {
            position:relative;
            top:2.5px;
            left:-42px;
            height:25px;
            width:25px;
            background-color:#999;
            border-radius:35px;
            display:inline-block;
            cursor:pointer;
        }
        .sel
        {
            left:-12px;
            background-color:#FF8060;
        }
        .line
        {
            margin-left:-5px;
            position:relative;
            top:-3px;
            height:13px;
            width:30px;
            background-color:#FFF;
            border-radius:3px;
            display:inline-block;
        }
        .resTools
        {
            margin-top:35px;
            margin-left:2.5%;
            width:92%;
            background-color:#3E454D;
            border-radius:5px;
            padding:0 1.5% 0.5% 1.5%;
            color:#FFF;
        }
        .filtHd
        {
            position:relative;
            top:5px;
        }
        .plusSymbol
        {
            float:right;
            margin-top:0.5%;
            margin-right:-3.7%;
            border:1pt solid #FFF;
            padding:2px;
            border-radius:25px;
            background-color:#3E454D;
            color:#FFF;
            width:15px;
            text-align:center;
            line-height:15px;
            font-size:1.4em;
            cursor:pointer;
        }
        .plusSymbol span
        {
            position:relative;
            top:-2px;
            left:-0.5px;
            cursor:pointer;
        }
        .resToolTbl
        {
            width:100%;
            text-align:left;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
            padding-top:15px;
        }
        .modTblHolder
        {
            margin-top:35px;
            margin-left:2.5%;
            width:95%;
        }
        .modTbl
        {
            width:100%;
            text-align:left;
        }
        .tblHd
        {
            padding-top:5px;
            padding-bottom:5px;
            background-color:#FF8060;
            color:#FFF;
        }
        .modTbl td
        {
            padding-top:5px;
            padding-bottom:5px;
            border-bottom:#FF8060 solid 1pt;
        }
        .modTbl td:first-child
        {
            padding-right:10px;
        }
        .modTbl tr:last-child td
        {
            border-bottom:none;
        }
        .tblRw:hover
        {
            background-color:#CCC;
        }
        .delBtn
        {
            text-decoration:underline;
            line-height:30px;
            float:right;
            cursor:pointer;
        }
        .editBtn
        {
            text-decoration:underline;
            line-height:30px;
            float:left;
            cursor:pointer;
        }
        .arr
        {
            position:relative;
            display:inline-block;
            -ms-transform: rotate(90deg); /* IE 9 */
            -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
            transform: rotate(90deg);
            font-size:1.4em;
            margin-left:15px;
            top:5px;
            font-weight: normal
        }
        .selectAll
        {
            font-size:1em;
            font-weight:normal;
            margin-left:10px;
        }
        .selRow
        {
            background-color:#FFF;
        }
        .blurHolder
        {
            -webkit-filter: blur(5px);
            -moz-filter: blur(5px);
            -o-filter: blur(5px);
            -ms-filter: blur(5px);
            filter: blur(5px);
            opacity: 0.4;
        }
        .confirmDel
        {
            position:fixed;
            padding:2.5%;
            width:45%;
            left:50%;
            margin-left:-25%;
            top:200px;
            background-color:#2B3036;
            border-radius:10px;
        }
        .txt
        {
            color:#FFF;
        }
        .cclDel
        {
            margin-top:25px;
            line-height:40px;
            width:100px;
            background-color:#3E454D;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            float:left;
            color:#FFF;
        }
        .cclDel:hover
        {
            background-color:#FF8060;
        }
        .subDel
        {
            margin-top:25px;
            line-height:40px;
            width:100px;
            background-color:#FF8060;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            float:right;
            color:#FFF;
        }
        .subDel:hover
        {
            background-color:#FF8060;
        }
        .dark
        {
            position:fixed;
            top:0px;
            left:0px;
            width:100%;
            height:100%;
            background-color:#2B3036;
            opacity:0.4;
        }
        .delMultHolder
        {
            position:fixed;
            bottom:0;
            border:1pt #3E454D solid;
            padding-top:15px;
            padding-bottom:15px;
            background-color:#3E454D;
            color:#FFF;
        }
        .msg
        {
            float:left;
            margin-left:2.5%;
        }
        .delMult
        {
            float:right;
            margin-right:2.5%;
            line-height:30px;
            width:75px;
            background-color:#FF8060;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            padding:0px;
            color:#FFF;
        }
        .menu
        {
            position:relative;
            top:35px;
            width:97.5%;
            margin-bottom:60px;
        }
        .addMods
        {
            float:right;
            padding:10px;
            color:#FFFFFF;
            background-color:#3E454D;
            border-radius:10px;
            font-weight:bold;
            cursor:pointer;
        }
        .addMods:hover
        {
            background-color:#2B3036;
        }
        .archiveMods
        {
            float:right;
            padding:10px;
            margin-right:15px;
            color:#FFFFFF;
            background-color:#3E454D;
            border-radius:10px;
            font-weight:bold;
            cursor:pointer;
        }
        .archiveMods:hover
        {
            background-color:#2B3036;
        }
    </style>
    <div class="modHolder" >
        <span class="hdr" ><b>MODULES</b></span>
        <div class="menu" >
            <div class="addMods" onclick="window.location.href = 'AddModule'" >ADD MODULE</div>
            <div class="archiveMods" onclick="window.location.href = 'ArchiveModules'" >ARCHIVE MODULES</div>
        </div><br />
        <div class="resTools" >
            <table class="resToolTbl" >
                <tr class="filt">
                    <td class="" colspan="8"><b class="filtHd">FILTERS</b><span class="plusSymbol showHide"><span>+</span></span></td>
                </tr>
                <tr>
                    <td class="subHdr" colspan="8"><b>PART</b></td>
                </tr>
                <tr class="typeRw">
                    <td class="aFilt"><b>PART A</b></td><td class="aFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="A" class="partCheck" type="hidden" value="1" /></td>
                    <td class="bFilt"><b>PART B</b></td><td class="bFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="B" class="partCheck" type="hidden" value="1" /></td>
                    <td class="cFilt"><b>PART C</b></td><td class="cFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="C" class="partCheck" type="hidden" value="1" /></td>
                    <td class="dFilt"><b>PART D</b></td><td class="dFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="D" class="partCheck" type="hidden" value="1" /></td>
                </tr>
                <tr class="typeRw">
                    <td class="fFilt"><b>FOUNDATION</b></td><td class="aFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="F" class="partCheck" type="hidden" value="1" /></td>
                    <td class="pFilt"><b>POSTGRAD</b></td><td class="bFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="P" class="partCheck" type="hidden" value="1" /></td>
                    <td class="dFilt"><b>OTHER</b></td><td class="cFilt"> <span class="line" ></span><span class="sel circ filtCirc"></span><input id="O" class="partCheck" type="hidden" value="1" /></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td class="smlSpc" colspan="8"></td>
                </tr>
            </table>
        </div>
        <div class="modTblHolder" >
            <table class="modTbl" >
                <thead>
                    <tr class="selRow">
                        <th colspan="4"><span class="arr" >&#8627;</span><span class="selectAll" >Select All</span></th>
                    </tr>
                    <tr>
                        <th class="tblHd smlPadLeft rightLines"><input class="selectAll" type="checkbox" /></th><th class="tblHd padLeft rightLines">MODULE CODE</th><th class="tblHd rightLines padLeft">MODULE NAME</th><th class="tblHd"></th>
                    </tr>
                </thead>
            </table>
        </div>
        <div class="delMultHolder" >
            <span class="msg">You have selected modules. Do you wish to delete these? </span><span class="delMult" >DELETE</span>
        </div>
    </div>
    <div class="dark" >

    </div>
    <div class="confirmDel" >
        <span class="subHdr" ><b>Delete Module?</b></span><br /><br />
        <span class="txt" ><b>Deleting this module will remove all references to the module from the database. <br /> Are you sure you wish to proceed?</b></span><br />
        <span class="cclDel" ><b>CANCEL</b></span><span class="subDel"><b>DELETE</b></span>
    </div>
</asp:Content>
