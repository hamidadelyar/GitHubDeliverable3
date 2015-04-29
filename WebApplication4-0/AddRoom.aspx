<%@ Page Title="Add Room" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddRoom.aspx.cs" Inherits="WebApplication4_0.AddRoom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var typeSet = -1;
        var parkSet = -1;
        var buildings = <%= this.buildings %>;
        var facs = <%= this.facs %>;
        $(document).ready(function () {
            var cols = 1;
            var facCells = "";
            for(var i = 0; i < facs.length; i++)
            {
                if(cols == 1)
                {
                    facCells += '<tr class="facRw" >'
                }
                facCells += '<td><b>'+facs[i]['Facility_Name'].toUpperCase()+'</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>'
                if(cols == 4)
                {
                    facCells += '</tr>';
                    cols = 0;
                }
                cols++;
            }
            if(facCells.substr(facCells.length - 5) != '<tr/>')
            {
                facCells += '</tr>';
            }
            $(facCells).insertAfter('.facHd');
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
            $('.inCirc').click(function () {
                $('.inCirc').removeClass('selectRad');
                $(this).addClass('selectRad');
                typeSet = $(this).siblings('.typeCheck').val();
            });
            $('.buildTxt').focusin(function(){
                fillBuilds();
            });
            $('.buildTxt').on('input propertychange paste', function () { // Finds suggestion to put in table that match the users input everytime they alter the text
                fillBuilds();
            });
            $(document).click(function (event) { // Clear table when anywhere else on page click
                if (event.target.id !== 'buildTxt') {
                    $(".buildRes").html('');
                }
            })
        });
        function fillBuilds()
        {
            var buildTxt = $('.buildTxt').val().toUpperCase();
            if($('.buildTxt').val() == "")
            {
                $('.buildRes').html('');
                for (var i = 0; i < buildings.length; i++) {
                    $('.buildRes').append("<span class='buildName'>" + buildings[i]['Building_Name'] + "</span>, ");
                }
            }
            else
            {
                $('.buildRes').html('');
                for (var i = 0; i < buildings.length; i++) {
                    var searchTxt = buildings[i]['Building_Name'].toUpperCase();
                    if (searchTxt.indexOf(buildTxt) != -1) {
                        $('.buildRes').append("<span class='buildName'>" + buildings[i]['Building_Name'] + "</span>, ");
                    }
                }
            }
            $('.buildName').click(function()
            {
                $('.buildTxt').val($(this).html());
            });
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
    <style>
        .toolsHolder
        {
            color:#FFF!important;
            margin-top:50px;
            width:100%;
            border-radius:10px;
            background-color:#3E454D;
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
        .tools
        {
            width:95%;
            margin-left:2.5%;
            margin-top:15px;
            text-align:left!important;
            display:inline;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
            padding-top:15px;
        }
        .alert
        {
            margin-top:10px;
            color:#FFD800;
        }
        .spc
        {
            height:15px;
        }
        .smlSpc
        {
            height:5px;
        }
        .facChecks
        {
            margin-top:35px;
            margin-left:2.5%;
            width:105%;
            table-layout:fixed;
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
        .darkLine
        {
            margin-left:5px;
            position:relative;
            top:1px;
            height:13px;
            width:30px;
            background-color:#3E454D;
            border-radius:3px;
            display:inline-block;
        }
        .resTool
        {
            top:6.5px!important;
            left:-37px!important;
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
        .outCirc
        {
            position:relative;
            display:inline-block;
            height:25px;
            width:25px;
            border:1px #FFF solid;
            border-radius:25px;
            top:2px;
            left:-16px;
            cursor:pointer;
        }
        .inCirc
        {
            position:relative;
            display:inline-block;
            height:15px;
            width:15px;
            background-color:#3E454D;
            border-radius:15px;
            top:-4px;
            left:-37px;
            cursor:pointer;
        }
        .selectRad
        {
            background-color:#FF8060;
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
        .spacer
        {
            width:25px;
        }
        .buildRes
        {
            line-height:17.5px;
            border-radius:3px;
            border:1px #3E454D; solid;
            color:#FFF;
            width: -moz-calc(100% - 325px);
            width: -webkit-calc(100% - 325px);
            width: calc(100% - 325px);
            display:inline-block;
            font-size: 1.2em;
            margin-left:25px;
            white-space:nowrap;
            overflow:hidden;
        }
        .buildName
        {
            position:relative;
            text-decoration:underline;
            white-space:nowrap;
            cursor:pointer;
            font-size: 1em;
            line-height:17.5px;
        }
        .comma
        {
            position:relative;
            line-height:17.5px;
            font-size:1em;
            top:5px;
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
        .searchBtn:hover
        {
            background-color:#FF8060;
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
            margin-right:6.66%;
        }
        .clearAllBtn:hover
        {
            background-color:#FF8060;
        }
    </style>
    <div class="toolsHolder" >
        <div class="hdr" ><b>ADD A ROOM</b></div>
        <div class="tools" >
            <table class="facChecks" >
                <tr>
                    <td class="subHdr buildTit" id="build" colspan="8"><b>BUILDING</b></td>
                </tr>
                <tr class="buildRw">
                    <td colspan="8"><input type="text" class="inp buildTxt" id="buildTxt" /><span class="buildRes" ></span></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td class="subHdr" colspan="8"><b>ROOM TYPE</b></td>
                </tr>
                <tr class="facRw">
                    <td><b>LECTURE</b></td><td> <span class="outCirc" ></span><span class="inCirc"  ></span><input class="typeCheck" type="hidden" value="1" /></td>
                    <td><b>SEMINAR</b></td><td> <span class="outCirc" ></span><span class="inCirc" ></span><input class="typeCheck" type="hidden" value="2" /></td>
                    <td><b>IT LAB</b></td><td> <span class="outCirc" ></span><span class="inCirc" ></span><input class="typeCheck" type="hidden" value="3" /></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td class="subHdr studTit" id="studs" colspan="8"><b>CAPACITY</b></td>
                </tr>
                <tr>
                    <td colspan="8"><input type="number" class="noStuds inp" min="1" onkeypress="return isNumberKey(event)" /></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr class="facHd">
                    <td class="subHdr" colspan="8"><b>FACILITIES</b></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn" onclick="validation()"><b>ADD</b></span></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
