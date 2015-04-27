<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomsDetails.aspx.cs" Inherits="WebApplication4_0.RoomsDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var facs = <%= this.facs %>;
        $(document).ready(function(){
            $('.noImg').hide();
            for(var i = 0; i < facs.length; i++)
            {
                $('#'+facs[i]['Facility_ID']).addClass('selected')
            }
        });
        function imgError(image)
        {
            image.onerror = "";
            $('.dataHolder img').hide();
            $('.noImg').show();
            $('.noImg img').show();
            return true;
        }
    </script>
    <style>
        .dataHolder
        {
            color:#FFF!important;
            margin-top:50px;
            width:95%;
            padding:2.5%;
            border-radius:10px;
            background-color:#FFF;
            min-width:800px;
            height:173px;
        }
        .dataHolder img
        {
            float:left;
            display:inline;
            height:173px;
            width:250px;
            margin-right:25px;
        }
        .noImg
        {
            float:left;
            display:inline;
            height:173px;
            width:250px;
            margin-right:25px;
            background-color:#999;
        }
        .noImg img
        {
            position:relative;
            top:50%;
            margin-top:-32px;
            left:50%;
            margin-left:-32px;
            height:64px;
            width:64px;
        }
        .detHolder
        {
            display:inline-block;
            margin-top:-7px;
            color:#999;
        }
        .hdr
        {
            color:#FF8060;
            font-size:1.4em;
        }
        .facHolder
        {
            margin-top:50px;
            width:95%;
            background-color:#3E454D;
            border-radius:10px;
            padding:0.5% 2.5% 2% 2.5%;
            min-width:800px;
        }
        .facChecks
        {
            width:105%;
            color:#FFF;
        }
        .subHdr
        {
            color:#FF8060;
            font-size:1.2em;
        }
        .line
        {
            position:relative;
            left:7px;
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
            left:-35px;
            height:25px;
            width:25px;
            background-color:#999;
            border-radius:35px;
            display:inline-block;
            cursor:default;
        }
        .selected
        {
            left:-7px;
            background-color:#FF8060;
        }
        .timeHolder
        {
            margin-top:50px;
            width:100%;
            height:600px;
            overflow:hidden;
            min-width:800px;
        }
        .timetbl
        {
            width:1024px;
            height:768px;
            border:0;
            margin-left:-37px;
        }
    </style>
        <div class="dataHolder" >
            <img src="Images/Room Pictures/<%= this.img %>.jpg" onerror="imgError(this)"/>
            <span class="noImg" ><img src="Images/Room Pictures/noImage.png" /></span>
            <span class="detHolder" >
                <b class="hdr" >ROOM: <%= this.code %></b><br /><br />
                <b>BUILDING: <%= this.building %></b><br />
                <b>CAPACITY: <%= this.capacity %></b><br />
                <b>TYPE: <%= this.type %></b><br />
                <b>PARK: <%= this.park %></b><br />
            </span>
        </div>
        <div class="facHolder" >
            <table class="facChecks">
                <tr>
                    <td class="subHdr" colspan="8"><b>FACILITIES</b></td>
                </tr>
                <tr class="facRw">
                    <td><b>COMPUTER</b></td><td> <span class="line" ></span><span class="circ" id="C"></span></td>
                    <td><b>MEDIA PLAYER</b></td><td> <span class="line" ></span><span class="circ" id="MP"></span></td>
                    <td><b>MICROPHONE</b></td><td > <span class="line" ></span><span class="circ" id="RM"></span></td>
                    <td><b>DATA PROJECTOR</b></td><td> <span class="line" ></span><span class="circ" id="DP"></span></td>
                </tr>
                <tr class="facRw">
                    <td><b>PLASMA SCREEN</b></td><td> <span class="line" ></span><span class="circ" id="PS"></span></td>
                    <td><b>VISUALISER</b></td><td> <span class="line" ></span><span class="circ" id="V"></span></td>
                    <td><b>PA</b></td><td> <span class="line" ></span><span class="circ" id="PA"></span></td>
                    <td><b>DUAL DATA PROJECTION</b></td><td> <span class="line" ></span><span class="circ" id="DDP"></span></td>
                </tr>
                <tr class="facRw">
                    <td><b>WHEELCHAIR</b></td><td> <span class="line" ></span><span class="circ" id="W"></span></td>
                    <td><b>WHITEBOARD</b></td><td> <span class="line" ></span><span class="circ" id="WB"></span></td>
                    <td><b>REVIEW</b></td><td> <span class="line" ></span><span class="circ" id="RLC"></span></td>
                    <td><b>INDUCTION LOOP</b></td><td> <span class="line" ></span><span class="circ" id="I"></span></td>
                </tr>
            </table>
        </div>
        <div class="timeHolder" >
            <iframe class="timetbl" id="ab" onload="document.getElementById('ab').contentWindow.scrollTo(0, 174)" scrolling="no" src="Timetable.aspx?roomCode=<%= this.code %>"></iframe>
        </div>
</asp:Content>
