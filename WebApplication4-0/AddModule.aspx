<%@ Page Title="Add Module" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddModule.aspx.cs" Inherits="WebApplication4_0.AddModule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var modules = <%= this.modules %>;
        var department = <%= this.department %>;
        var programs = <%= this.programs %>;
        department = department[0]['Dept_ID'];
        $(document).ready(function(){
            for (var i = 0; i < programs.length; i++) {
                $('<tr><td colspan="8"><span tabindex="' + i + '" class="progTbl" id="prog' + i + '" >' + programs[i]['Program_Code'] + '</span></td></tr>').insertAfter('.progRw');
            }
            $('.progHolderTbl').hide();
            $(document).click(function(){
                $('.progHolderTbl').hide();
                if (event.target.id == 'progTxt') {
                    $('.progHolderTbl').show();
                }
            })
            $('.progTxt').focusin(function() {
                var left = $('.progTxt').position().left;
                var top = $('.progTxt').position().top;
                var width = $('.progTxt').width();
                $('.progHolderTbl').css('left', left);
                $('.progHolderTbl').css('top', top + 22);
                $('.progHolderTbl').show();
                $('.progHolderTbl').css('width', width + 12);
                $('.progHolderTbl').css('max-height', '400px');
                $('.progTxt').css('width', '100%!important')
                $('.progHolderTbl').children('.triang').css('left', width / 2);
                txtPredict($(this), '.progTbl');
            });
            $('.progTxt').on('input propertychange paste', function() {
                txtPredict($(this), '.progTbl');
            });
            $('.progTbl').click(function() {
                $('.progTxt').val($(this).html());
                $('.progTxt').focus();
                $(this).css('background-color:', '#2b3036');
            });
            $(document).on('keyup', function(e) {
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
        })
        function validate()
        {
            var failed = false;
            var codeClr = true;
            if($('.codeTxt').val().trim() == "")
            {
                $('.codeTit').html('<b>MODULE CODE</b><span class="alert" >&nbsp;You must input a module code.</span>');
                failed = true;
                codeClr = false;
            }
            else if($('.codeTxt').val().length != 6 && $('.codeTxt').val().length != 10)
            {
                $('.codeTit').html('<b>MODULE CODE</b><span class="alert" >&nbsp;Module code in incorrect format.</span>');
                failed = true;
                codeClr =  false;
            }
            else
            {
                for(var i = 0; i < modules.length; i++)
                {
                    if($('.codeTxt').val() == modules[i]['Module_Code'])
                    {
                        $('.codeTit').html('<b>MODULE CODE</b><span class="alert" >&nbsp;Module code already exists</span>');
                        failed = true;
                        codeClr = false;
                        break;
                    }
                }
            }
            if(codeClr)
            {
                $('.codeTit').html('<b>MODULE CODE</b><span class="alert" ></span>');
            }
            if($('.nameTxt').val().trim() == "")
            {
                $('.nameTit').html('<b>MODULE NAME</b><span class="alert" >&nbsp;You must input a module name.</span>');
                failed = true;
            }
            else
            {
                $('.nameTit').html('<b>MODULE NAME</b><span class="alert" ></span>');
            }
            if($('.progTxt').val().trim() == "")
            {
                $('.progTit').html('<b>PROGRAM CODE</b><span class="alert" >&nbsp;You must input a program code.</span>');
                failed = true;
            }
            else
            {
                $('.progTit').html('<b>PROGRAM CODE</b><span class="alert" ></span>');
            }
            if(!failed)
            {
                addRoom();
            }
        }
        String.prototype.Capitalise = function()
        { 
            return this.toLowerCase().replace(/^.|\s\S/g, function(a) { return a.toUpperCase(); });
        }
        function addRoom()
        {
            var modCode = $('.codeTxt').val().toUpperCase().trim();
            var modName = $('.nameTxt').val().Capitalise().trim();
            var progCode = $('.progTxt').val().trim().substring(0, 6);
            $('.main').html('<span class="loader" ><img src="./Images/processing.gif" width="220" height="20" /></span>');
            $.ajax({
                type: "POST",
                url: "AddModule.aspx/InsertModule",
                data: JSON.stringify({ modCode: modCode,  modName: modName, progCode: progCode}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("An error occurred. Please try again.");
                    window.location.reload();
                },
                success: function (result) {
                    $('.main').html('<div class="hdr" ><b>ADD MODULE</b></div><div class="conf" ><img src="./Images/Done.png" width="30" height="30" /><span>&nbsp;Module has been added.</span></div>');
                    setTimeout(function () {
                        window.location.href = "Modules.aspx"; //will redirect to your blog page (an ex: blog.html)
                    }, 2000);
                }
            });
        }
        function maskInp(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            var codeTxt = $('.codeTxt').val();
            if(codeTxt.length == 0 && (charCode == department.charCodeAt(0) || charCode == department.toLowerCase().charCodeAt(0)))
            {
                $('.codeTxt').val().toUpperCase();
                return true
            }
            else if(codeTxt.length == 1 && (charCode == department.charCodeAt(1) || charCode == department.toLowerCase().charCodeAt(1)))
            {
                $('.codeTxt').val().toUpperCase();
                return true
            }
            else if(codeTxt.length == 2)
            {
                if(charCode < 65 /* a */ || charCode > 90 /* z */) {
                    if((charCode > 96 && charCode < 123))
                    {
                        $('.codeTxt').val().toUpperCase();
                        return true;
                    }
                }
            }
            else if(codeTxt.length == 3 || codeTxt.length == 4 || codeTxt.length == 5)
            {
                if (charCode <= 31 || (charCode >= 48 && charCode <= 57))
                    return true;
            }
            else if(codeTxt.length == 6 && (charCode == 109 || charCode == 77))
            {
                return true;
            }
            else if(codeTxt.length == 7 && (charCode == 101 || charCode == 69))
            {
                return true;
            }
            else if(codeTxt.length == 8 && (charCode == 116 || charCode == 84))
            {
                return true;
            }
            else if(codeTxt.length == 9 && (charCode == 97 || charCode == 65))
            {
                return true;
            }
            return false;
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
    </script>
    <style>
        .toolsHolder
        {
            color:#FFF!important;
            margin-top:50px;
            width:95%;
            border-radius:10px;
            background-color:#3E454D;
            padding:2.5%;
        }
        .hdr
        {
            margin-top:10px;
            font-size:1.4em;
            color:#FFF;
            float:left;
            text-align:center;
            width:95%;
            margin-left:2.5%;
        }
        .alert
        {
            margin-top:10px;
            color:#FFD800;
        }
        .searchBtn:hover
        {
            background-color:#FF8060;
        }
        .searchBtn
        {
            margin-top:10px;
            line-height:40px;
            width:100px;
            background-color:#2B3036;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            float:right;
            margin-right:6.66%;
        }
        .clearAllBtn
        {
            margin-top:10px;
            line-height:40px;
            width:100px;
            background-color:#2B3036;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
            float:left;
        }
        .clearAllBtn:hover
        {
            background-color:#FF8060;
        }
        .spc
        {
            height:15px;
        }
        .smlSpc
        {
            height:5px;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
            padding-top:15px;
        }
        .inp
        {
            line-height:17.5px;
            width:200px;
            background-color:#2B3036;
            border-radius:3px;
            border:1px #2B3036 solid;
            color:#FFF;
        }
        .codeTxt
        {
            text-transform:uppercase;
        }
        .nameTxt
        {
            text-transform:capitalize;
            width:400px!important;
        }
        .facChecks
        {
            margin-top:35px;
            width:110%;
            table-layout:fixed;
        }
        .conf img
        {
            margin-top:15px;
        }
        .conf span
        {
            position:relative;
            top:-9px;
            font-size:1.2em;
        }
        .loader
        {
            position:relative;
            left:50%;
            margin-left:-110px;
        }
        .loader img 
        {
            margin-top: 3px;
        }
        .progTxt
        {
            width:400px!important;
        }
        .triang {
            position: relative;
            display: inline-block;
            left: 90px;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 0 15px 15px 15px;
            border-color: transparent transparent #2b3036 transparent;
            top: 3.5px;
        }
        .progTbl
        {
            border:1px #2B3036 solid;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            width:400px;
            display: inline-block;
        }
        .progTbl:hover 
        {
            background-color: #FF8060;

        }
        .progHolderTbl {
            position: absolute;
            width:400px;
        }
        .progHolderTbl td {
            padding: 0;
        }
    </style>
    <div class="toolsHolder roomHolder main" >
            <div class="hdr" ><b>ADD A MODULE</b></div>
            <table class="facChecks" >
                <tr>
                    <td class="subHdr codeTit" id="modCode" colspan="3"><b>MODULE CODE</b><span class="alert" ></span></td>
                    <td class="subHdr nameTit" id="modName" colspan="5"><b>MODULE NAME</b><span class="alert" ></span></td>
                </tr>
                <tr class="roomRw">
                    <td colspan="3"><input autocomplete="off" type="text" class="inp codeTxt" id="codeTxt" onkeypress="return maskInp(event)" onkeyup="this.value = this.value.toUpperCase();" /></td>
                    <td colspan="5"><input autocomplete="off" type="text" class="inp nameTxt" id="nameTxt" /></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td class="subHdr partTit" id="partCode" colspan="9"><b>PROGRAM CODE</b><span class="alert" ></span></td>
                </tr>
                <tr class="roomRw">
                    <td colspan="9"><input autocomplete="off" type="text" class="inp progTxt" id="progTxt" /></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn" onclick="validate()"><b>ADD</b></span></td>
                </tr>
            </table>
        <table class="progHolderTbl" >
                <tr class="progRw">
                    <td colspan="8"><span class="triang"></span></td>
                </tr>
            </table>
        </div>
</asp:Content>
