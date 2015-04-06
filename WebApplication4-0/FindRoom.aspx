<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="WebApplication4_0.Timetable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.24.min.js" type="text/javascript"></script>
    <script>
        var typeSet = 0;
        $(document).ready(function () {
            $('.circ').click(function () {
                var currVal = $(this).siblings('.facCheck').val();
                $(this).siblings('.facCheck').val(Math.abs(currVal - 1));
                if (currVal == 0)
                {
                    $(this).animate({
                        backgroundColor: '#FF8060',
                        left: "+=30"
                    }, 500, function () {
                        //Animation Complete
                    });
                }
                else
                {
                    $(this).animate({
                        backgroundColor: '#999',
                        left: "-=30"
                    }, 500, function () {
                        //Animation Complete
                    });
                }
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
                    if(i%2 == 0)
                    {
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
                    else
                    {
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
            $('.defBtn').click(function () {
                $('.week').each(function (i) {
                    if (i < 12) {
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
        });
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
        .week
        {
            width:35px;
            line-height:35px;
            border-radius:3px;
            background-color:#999;
            display:inline-block;
            text-align:center;
            cursor:pointer;
        }
        .week:hover
        {
            background-color:#FF8060;
        }
        .weekBtn
        {
            margin-top:10px;
            line-height:35px;
            width:74px;
            background-color:#2B3036;
            cursor:pointer;
            display:inline-block;
            text-align:center;
            border-radius:3px;
        }
        .weekBtn:hover
        {
            background-color:#FF8060;
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
        .switchView
        {
            float:right;
            padding:10px;
            margin-top:35px;
            color:#FFFFFF;
            background-color:#3E454D;
            border-radius:10px;
            font-weight:bold;
            cursor:pointer;
        }
        .switchView:hover
        {
            background-color:#2B3036;
        }
    </style>
    <div class="toolsHolder" >
        <div class="hdr" ><b>TOOLS</b></div>
        <div class="tools" >
            <table class="facChecks" >
                <tr>
                    <td class="subHdr" colspan="8"><b>PARK</b></td>
                </tr>
                <tr class="parkRw">
                    <td><b>CENTRAL PARK</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>WEST PARK</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>EAST PARK</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td class="subHdr" colspan="8"><b>WEEKS</b></td>
                </tr>
                <tr>
                    <td colspan="8" class="smlSpc"></td>
                </tr>
                <tr>
                    <td colspan="8" >
                            <span class="week" >1</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >2</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >3</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >4</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >5</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >6</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >7</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >8</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >9</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >10</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >11</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >12</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >13</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >14</span><input class="weekCheck" type="hidden" value="0" />
                            <span class="week" >15</span><input class="weekCheck" type="hidden" value="0" />
                    </td>
                </tr>
                <tr>
                    <td colspan="8" >
                        <span class="weekBtn allBtn" >ALL</span>
                        <span class="weekBtn defBtn" >1-12</span>
                        <span class="weekBtn oddBtn" >ODD</span>
                        <span class="weekBtn evenBtn" >EVEN</span>
                        <span class="weekBtn clrBtn" >CLEAR</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td class="subHdr" colspan="8"><b>FACILITIES</b></td>
                </tr>
                <tr class="facRw">
                    <td><b>COMPUTER</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>MEDIA PLAYER</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>MICROPHONE</b></td><td > <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>DATA PROJECTOR</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                </tr>
                <tr class="facRw">
                    <td><b>PLASMA SCREEN</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>VISUALISER</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>PA</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>DUAL DATA PROJECTION</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                </tr>
                <tr class="facRw">
                    <td><b>WHEELCHAIR</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>WHITEBOARD</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>REVIEW</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
                    <td><b>INDUCTION LOOP</b></td><td> <span class="line" ></span><span class="circ"></span><input class="facCheck" type="hidden" value="0" /></td>
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
                    <td><b>NO PREFERENCE</b></td><td> <span class="outCirc" ></span><span class="inCirc selectRad" ></span><input class="typeCheck" type="hidden" value="0" /></td>
                </tr>
                 <tr>
                    <td colspan="8" class="spc"></td>
                </tr>
                <tr>
                    <td colspan="8"><span class="searchBtn"><b>SEARCH </b><img src="/Images/RightArrow.png" height="11" width="6" /></span></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="switchView" onclick="window.location.href = 'Timetable.aspx'" >VIEW TIMETABLES <img src="/Images/RightArrow.png" height="11" width="6" /></div>
</asp:Content>