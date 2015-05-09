<%@ Page Title="Add User" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="WebApplication4_0.AdminFolder.AddUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <script>
            var depts = <%= this.departments %>;
            var users = <%= this.users %>;
            $(document).ready(function() {
                for (var i = 0; i < depts.length; i++) {
                    $('<tr><td colspan="8"><span class="deptTbl" >' + depts[i]['Dept_ID'] + '</span></td></tr>').insertAfter('.deptRw');
                }
                $('.deptHolderTbl').hide();
                $('.deptTxt').click(function() {
                    var left = $('.deptTxt').position().left;
                    var top = $('.deptTxt').position().top;
                    $('.deptHolderTbl').css('left',left);
                    $('.deptHolderTbl').css('top', top+22);
                    $('.deptHolderTbl').show();
                });
                $(document).click(function(event) { // Clear table when anywhere else on page click
                    if (event.target.id !== 'deptTxt') {
                        $('.deptHolderTbl').hide();
                    }
                });
                $('.deptTbl').click(function() {
                    $('.deptTxt').val($(this).html());
                })
            });
            function validate() {
                var failed = false;
                var re = /\S+@\S+\.\S+/;
                if ($('.emailTxt').val().trim() == "") 
                {
                    $('.emailTit').html('<b>EMAIL</b><span class="alert" >&nbsp;You must enter an email</span>');
                    failed = true;
                }
                else if(!re.test($('.emailTxt').val()))
                {
                    $('.emailTit').html('<b>EMAIL</b><span class="alert" >&nbsp;Invalid email format</span>');
                    failed = true;
                }
                else 
                {
                        $('.emailTit').html('<b>EMAIL</b><span class="alert" ></span>');
                }
                if ($('.foreTxt').val().trim() == "") {
                    $('.foreTit').html('<b>FORENAME</b><span class="alert" >&nbsp;You must enter a forename</span>');
                    failed = true;
                } else {
                    $('.foreTit').html('<b>FORENAME</b><span class="alert" ></span>');
                }
                if ($('.surTxt').val().trim() == "") {
                    $('.surTit').html('<b>SURNAME</b><span class="alert" >&nbsp;You must enter a surname</span>');
                    failed = true;
                } else {
                    $('.surTit').html('<b>SURNAME</b><span class="alert" ></span>');
                }
                if ($('.surTxt').val().trim() == "") {
                    $('.surTit').html('<b>SURNAME</b><span class="alert" >&nbsp;You must enter a surname</span>');
                    failed = true;
                } else {
                    $('.surTit').html('<b>SURNAME</b><span class="alert" ></span>');
                }
                if ($('.deptTxt').val().trim() == "") {
                    $('.deptTit').html('<b>DEPARTMENT</b><span class="alert" >&nbsp;You must enter a department</span>');
                    failed = true;
                } else {
                    $('.deptTit').html('<b>DEPARTMENT</b><span class="alert" ></span>');
                }
                addUser();
            }
            function addUser() {
                var username = generateUserName(0);
                var password = Math.random().toString(36).slice(-8);
                var fore = $('.foreTxt').val();
                var sur = $('.surTxt').val();
                var email = $('.emailTxt').val();
                var dept = $('.deptTxt').val()[0] + $('.deptTxt').val()[1];
                $('.main').html('<span class="loader" ><img src="/Images/processing.gif" width="220" height="20" /></span>');
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/InsertUser",
                    data: JSON.stringify({ username: username, password: password, forename: fore, surname: sur, email: email, dept: dept}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("An error occurred. Please try again.");
                        window.loaction.reload();
                    },
                    success: function (result) {
                        $('.main').html('<div class="hdr" ><b>ADD USER</b></div><div class="conf" ><img src="../Images/Done.png" width="30" height="30" /><span>&nbsp; User has been created. An email has been sent to: '+email+'</span></div>');
                        setTimeout(function () {
                            window.location.href = "Users.aspx"; //will redirect to your blog page (an ex: blog.html)
                        }, 2000);
                    }
                });
            }
            function generateUserName(i) {
                var found = false;
                var concat = "";
                if (i != 0) {
                    concat = i;
                }
                var username = $('.deptTxt').val()[0] + $('.deptTxt').val()[1] + $('.foreTxt').val()[0] + $('.surTxt').val()[0] + concat;
                for (var j = 0; j < users.length; j++) {
                    if (users[j]['Username'].toLowerCase() == username.toLowerCase()) {
                        found = true;
                        break;
                    }
                }
                if (found) {
                    return generateUserName(++i);
                }
                return username.toLowerCase();
            }
        </script>
        <style>
        .main
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
        .emailTxt
        {
            width:400px!important;
        }
        .deptTxt
        {
            width: 400px!important;
            margin-bottom: 0 !important;
            padding-bottom: 6px;
            padding-top: 6px;
            cursor: pointer;
        }
        .facChecks
        {
            margin-top:35px;
            width:110%;
            table-layout:fixed;
            border-collapse: collapse!important;
        }
        .deptHolderTbl {
            position: absolute;
        }
        .deptHolderTbl td {
            padding: 0;
        }
        .deptTbl
        {
            border:1px #2B3036 solid;
            width: 400px!important;
            color: #FFF;
            background-color: #2b3036;
            cursor: pointer;
            text-decoration: underline;
            padding: 5px;
            display: inline-block;
        }
        .deptTbl:hover 
        {
            background-color: #FF8060;

        }
        .triang {
            position: relative;
            display: inline-block;
            left: 190px;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 0 15px 15px 15px;
            border-color: transparent transparent #2b3036 transparent;
            top: 3.5px;
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
    </style>
    <div class="main" >
        <div class="hdr" ><b>ADD USER</b></div>
        <table class="facChecks" >
            <tr>
                <td class="subHdr foreTit" id="forename" colspan="3"><b>FORENAME</b><span class="alert" ></span></td>
                <td class="subHdr surTit" id="surname" colspan="5"><b>SURNAME</b><span class="alert" ></span></td>
            </tr>
            <tr>
                <td colspan="3"><input autocomplete="off" type="text" class="inp foreTxt" id="foreTxt"  /></td>
                <td colspan="5"><input autocomplete="off" type="text" class="inp surTxt" id="surTxt" /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr emailTit" id="email" colspan="8"><b>EMAIL</b><span class="alert" ></span></td>
            </tr>
            <tr>
                <td colspan="8"><input autocomplete="off" type="text" class="inp emailTxt" id="emailTxt"  /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td class="subHdr deptTit" id="dept" colspan="8"><b>DEPARTMENT</b><span class="alert" ></span></td>
            </tr>
            <tr>
                <td colspan="8"><input readonly="readonly" autocomplete="off" type="text" class="inp deptTxt" id="deptTxt"  /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn" onclick="validate()"><b>SUBMIT</b></span></td>
            </tr>
        </table>
    </div>
    <table class="deptHolderTbl">
        <tr class="deptRw">
            <td colspan="8"><span class="triang"></span></td>
        </tr>
    </table>
</asp:Content>
