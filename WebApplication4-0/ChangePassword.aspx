<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="WebApplication4_0.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
        <script>
            function validate() {
                var failed = false;
                if ($('.emailTxt').val() == "") {
                    $('.emailTit').html('<b>NEW PASSWORD</b><span class="alert" >&nbsp;You must enter a password.</span>');
                    failed = true;
                }
                else {
                    $('.emailTit').html('<b>NEW PASSWORD</b><span class="alert" ></span>');
                }
                if ($('.userTxt').val().trim() == "") {
                    $('.userTit').html('<b>PASSWORD</b><span class="alert" >&nbsp;You must enter a password.</span>');
                    failed = true;
                } else {
                    $('.userTit').html('<b>PASSWORD</b><span class="alert" ></span>');
                }
                if (!failed) {
                    checkPassword();
                }
            }
            function checkPassword() {
                $.ajax({
                    type: "POST",
                    url: "ChangePassword.aspx/CheckPassword",
                    data: JSON.stringify({ password: $('.userTxt').val(), username: $('#LoginDetails').html().match(/\(([^)]+)\)/)[1] }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("An error occurred. Please try again.");
                        window.location.reload();
                    },
                    success: function (result) {
                        if (result.d) {
                            changePass();
                        }
                        else {
                            $('.userTit').html('<b>PASSWORD</b><span class="alert" >&nbsp; Incorrect password.</span>');
                        }
                    }
                });
            }
            function changePass() {
                var pass = $('.emailTxt').val()
                $('.main').html('<span class="loader" ><img src="./Images/processing.gif" width="220" height="20" /></span>');
                $.ajax({
                    type: "POST",
                    url: "ChangePassword.aspx/UpdatePassword",
                    data: JSON.stringify({ username: $('#LoginDetails').html().match(/\(([^)]+)\)/)[1], password: pass}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("An error occurred. Please try again.");
                        window.location.reload();
                    },
                    success: function (result) {
                        if (result.d) {
                            $('.main').html('<div class="hdr" ><b>CHANGE PASSWORD</b></div><div class="conf" ><img src="./Images/Done.png" width="30" height="30" /><span>&nbsp; Password changed confirmation has been sent to your email.</span></div>');
                            setTimeout(function () {
                                window.location.href = "Profile.aspx"; //will redirect to your blog page (an ex: blog.html)
                            }, 2000);
                        }
                    }
                });
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
    </style>
    <div class="main" >
        <div class="hdr" ><b>CHANGE PASSWORD</b></div>
        <table class="facChecks" >
            <tr>
                <td class="subHdr userTit" id="username" colspan="3"><b>PASSWORD</b><span class="alert" ></span></td>
                <td class="subHdr emailTit" id="email" colspan="5"><b>NEW PASSWORD</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="password" class="inp userTxt" id="userTxt"  /></td>
                <td colspan="5"><input autocomplete="off" type="password" class="inp emailTxt" id="emailTxt" /></td>
            </tr>
            <tr>
                <td colspan="8" class="spc"></td>
            </tr>
            <tr>
                <td colspan="8"><span class="clearAllBtn" onclick="location.reload()"><b>CLEAR ALL</b></span><span class="searchBtn" onclick="validate()"><b>SUBMIT</b></span></td>
            </tr>
        </table>
    </div>
</asp:Content>
