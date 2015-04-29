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
        var buildName = "";
        var rooms = <%= this.rooms %>;
        var department = <%= this.department %>;
        department = department[0]['Dept_ID'];
        var edit = false;
        var capacity = 0;
        var type = "";
        $(document).ready(function () {
            $('.addEdit').hide();
            $('.buildHolder').hide();
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
            $(document).click(function (event) { // Clear table when anywhere else on page click
                if (event.target.id !== 'buildTxt') {
                    $(".buildRes").html('');
                }
            })
        });
        function validateRoomCode()
        {
            if($('.roomTxt').val() == "")
            {
                $('.roomTit').html('<b>ROOM CODE</b><span class="alert" >&nbsp;You muust eneter a room code.</span>')
            }
            else if($('.roomTxt').val().indexOf('.') == -1)
            {
                $('.roomTit').html('<b>ROOM CODE</b><span class="alert" >&nbsp;Your room code must contain a dot e.g. A.0.01</span>')
            }
            else if(!permission())
            {
                $('.roomTit').html('<b>ROOM CODE</b><span class="alert" >&nbsp;You do not have permission to modify this room.</span>')
            }
            else if(!hasCode())
            {
                $('.roomTit').html('<b>ROOM CODE</b><span class="alert" >&nbsp;Your room code must contain a valid building code at the start. <span class="addBuild" >Add building</span></span>')
                $('.addBuild').click(function(){
                    $('.buildHolder').show();
                    $('.roomHolder').hide();
                });
            }
            else
            {
                if(exists())
                {
                    edit = true;
                    $('.buildTxt').val(buildName);
                    $('.buildTxt').attr('disabled', 'true');
                    $('.roomHolder').hide();
                    $('.addEdit').show();
                    $('.addHdr').html('<b>EDIT '+$('.roomTxt').val().toUpperCase()+'</b>');
                    $('.addBtn').html('<b>UPDATE</b>');
                    $('.noStuds').val(capacity);
                    $('#'+type).addClass('selectRad')
                    typeSet = ('#'+type).val();
                }
                else
                {
                    edit = false;
                    $('.buildTxt').val(buildName);
                    $('.buildTxt').attr('disabled', 'true');
                    $('.roomHolder').hide();
                    $('.addEdit').show();
                }
            }
            
        }
        function permission()
        {
            var subst = $('.roomTxt').val().toUpperCase();
            for(var i = 0; i < rooms.length; i++)
            {
                if(rooms[i]['Room_ID'].toUpperCase() == subst && rooms[i]['Dept_ID'] != department)
                {
                    return false;
                }
            }
            return true;
        }
        function hasCode()
        {
            var subst = $('.roomTxt').val().substring(0, $('.roomTxt').val().indexOf('.')).toUpperCase();
            for(var i = 0; i < buildings.length; i++)
            {
                if(subst == buildings[i]['Building_ID'])
                {
                    buildName = buildings[i]['Building_Name'];
                    return true;
                }
            }
            return false;
        }
        function exists()
        {
            var subst = $('.roomTxt').val().toUpperCase();
            for(var i = 0; i < rooms.length; i++)
            {
                if(rooms[i]['Room_ID'].toUpperCase() == subst)
                {
                    capacity = rooms[i]['Capacity'];
                    type = rooms[i]['Room_Type']
                    return true;
                }
            }
            return false;
        }
        function validateBuilding()
        {
            var buildCode = $('.codeTxt').val().toUpperCase();
            var buildName = $('.nameTxt').val().toUpperCase();
            for(var i = 0; i < buildings.length; i++)
            {
                if(buildings[i]['Building_ID'] == buildCode)
                {
                    $('.codeTit').html('<b>BUILDING CODE</b><span class="alert" >&nbsp;Code already exists</span>');
                }
                if(buildings[i]['Building_Name'].toUpperCase() == buildName)
                {
                    $('.nameTit').html('<b>BUILDING CODE</b><span class="alert" >&nbsp;Name already exists</span>');
                }
            }
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function isLetterKey(evt, t) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if(charCode < 65 /* a */ || charCode > 90 /* z */) {
                if((charCode > 96 && charCode < 123))
                {
                    return true;
                }
                return false;
            }
            return true;
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
        .tools
        {
            width:100%;
            background-color:#F00;
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
        .addBuild
        {
            color:#FFD800;
            text-decoration:underline;
            cursor:pointer;
        }
        .addBuild:hover
        {
            text-decoration:none!important;
            background-color:#3E454D!important;
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
            width:110%;
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
        .roomTxt
        {
            text-transform:uppercase;
        }
        .codetxt
        {
            text-transform:uppercase;
        }
        .nameTxt
        {
            text-transform:capitalize;
            width:400px!important;
        }
        .buildTxt
        {
            background-color:#55595E!important;
            border:1px #55595E solid!important;
            cursor:not-allowed;
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
            text-overflow:ellipsis;
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
    <div class="toolsHolder roomHolder" >
        <div class="hdr" ><b>ADD/EDIT A ROOM</b></div>
        <table class="facChecks" >
            <tr>
                <td class="subHdr roomTit" id="room" colspan="8"><b>ROOM CODE</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="8"><input type="text" class="inp roomTxt" id="roomTxt" /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn" onclick="validateRoomCode()"><b>NEXT</b></span></td>
            </tr>
        </table>
    </div>
    <div class="toolsHolder buildHolder" >
        <div class="hdr" ><b>ADD A BUILDING</b></div>
        <table class="facChecks" >
            <tr>
                <td class="subHdr codeTit" id="buildCode" colspan="3"><b>BUILDING CODE</b><span class="alert" ></span></td>
                <td class="subHdr nameTit" id="buildName" colspan="5"><b>BUILDING NAME</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input type="text" class="inp codeTxt" id="codeTxt" onkeypress="return isLetterKey(event)" onkeyup="this.value = this.value.toUpperCase();" /></td>
                <td colspan="5"><input type="text" class="inp nameTxt" id="nameTxt" /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td colspan="8"><span class="searchBtn" onclick="validateBuilding()"><b>ADD</b></span></td>
            </tr>
        </table>
    </div>
    <div class="toolsHolder addEdit" >
        <div class="hdr addHdr" ><b>ADD A ROOM</b></div>
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
                    <td><b>LECTURE</b></td><td> <span class="outCirc" ></span><span id="T" class="inCirc"  ></span><input class="typeCheck" type="hidden" value="1" /></td>
                    <td><b>SEMINAR</b></td><td> <span class="outCirc" ></span><span id="S" class="inCirc" ></span><input class="typeCheck" type="hidden" value="2" /></td>
                    <td><b>IT LAB</b></td><td> <span class="outCirc" ></span><span id="L" class="inCirc" ></span><input class="typeCheck" type="hidden" value="3" /></td>
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
                    <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn addBtn" onclick="validation()"><b>ADD</b></span></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
