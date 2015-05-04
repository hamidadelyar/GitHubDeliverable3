<%@ Page Title="Archive Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveModules.aspx.cs" Inherits="WebApplication4_0.ArchiveModules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
    <script src="Scripts/dist/jquery.floatThead.js" ></script>
    <script>
        var modules = <%= this.modules %>;
        var years = <%= this.years %>;
        var showing = false;
        $(document).ready(function(){
            $('.delMultHolder').hide();
            $('.confirmDel').hide();
            $('.dark').hide();
            for(var i = 0; i < modules.length; i++)
            {
                $('.modTbl').append('<tr class="modules tblRw showing" ><td class="smlPadLeft rightLines"><input class="rwCheck" type="checkbox" /></td><td class="modTd padLeft rightLines" ><b>'+modules[i]['Module_Code']+'</b></td><td class="rightLines padLeft" >'+modules[i]['Module_Title']+'</b></td><td class="padLeft" ><span class="impBtn" >IMPORT</span></tr>');
            }
            var yrCells = "";
            var cols = 1;
            for (var i = 0; i < years.length; i++) {
                if (cols == 1) {
                    yrCells += '<tr class="yrRw" >'
                }
                yrCells += '<td><b>' + years[i]['Archive_Year'] + '</b></td><td> <span class="line" ></span><span class="sel circ"></span><input id="'+years[i]['Archive_Year']+'" class="filtCheck" type="hidden" value="1" /></td>'
                if (cols == 4) {
                    yrCells += '</tr>';
                    cols = 0;
                }
                cols++;
            }
            if (yrCells.substr(yrCells.length - 5) != '<tr/>') {
                yrCells += '</tr>';
            }
            $(yrCells).insertAfter('.yr');
            if(cols != 5)
            {
                $('.yrRw:last').append('<td colspan="'+(5-cols)*2+'"></td>')
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
        });
        function hideRows(obj)
        {
            var id = $(obj).siblings('input').attr('id').substring(2,4);
            $('.modules').each(function(){
                var modCode = $(this).children('td').eq(1).html().split('');
                if(modCode[3] == id[0] && modCode[4] == id[1])
                {
                    $(this).children('td:first').children('input').prop('checked', false);
                    $(this).removeClass('showing');
                    $(this).hide();
                }
            });
        }
        function showRows(obj)
        {
            var id = $(obj).siblings('input').attr('id').substring(2,4);
            $('.modules').each(function(){
                var modCode = $(this).children('td').eq(1).html().split('');
                if(modCode[3] == id[0] && modCode[4] == id[1])
                {
                    $(this).addClass('showing');
                    $(this).show();
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
            table-layout:fixed;
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
        .impBtn
        {
            text-decoration:underline;
            line-height:30px;
            cursor:pointer;
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
            <div class="archiveMods" onclick="window.location.href = 'Module'" >MODULES</div>
        </div><br />
        <div class="resTools" >
            <table class="resToolTbl" >
                <tr class="filt">
                    <td class="" colspan="8"><b class="filtHd">FILTERS</b><span class="plusSymbol showHide"><span>+</span></span></td>
                </tr>
                <tr class="yr">
                    <td class="subHdr" colspan="8"><b>YEAR</b></td>
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
    <</div>
</asp:Content>
