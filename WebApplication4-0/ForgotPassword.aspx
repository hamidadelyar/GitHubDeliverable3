<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="WebApplication4_0.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var userDets = <%= this.userDets %>;
        $(document).ready(function () {
            $('#menu').remove();
            $('li').remove();
        });
        function validate()
        {
            var userExists = false;
            var matching = false;
            var failed = false;
            for(var i = 0; i < userDets.length; i++)
            {
                if(userDets[i]['Username'] == $('.userTxt').val())
                {
                    userExists = true;
                    if(userDets[i]['Email'] == $('.emailTxt').val())
                    {
                        matching = true;
                    }
                }
            }
            if(!userExists)
            {
                $('.userTit').html('<b>USERNAME</b><span class="alert" >&nbsp;Username does not exist.</span>');
                failed = true;
            }
            else
            {
                $('.userTit').html('<b>USERNAME</b><span class="alert" ></span>');
            }
            if(!matching)
            {
                $('.emailTit').html('<b>EMAIL</b><span class="alert" >&nbsp;Email does not match username.</span>');
                failed = true;
            }
            else
            {
                $('.emailTit').html('<b>EMAIL</b><span class="alert" ></span>');
            }
            var re = /\S+@\S+\.\S+/;
            if(!re.test($('.emailTxt').val()))
            {
                $('.emailTit').html('<b>EMAIL</b><span class="alert" >&nbsp;Invalid email format</span>');
                failed = true;
            }
            if($('.userTxt').val().trim() == "")
            {
                $('.userTit').html('<b>USERNAME</b><span class="alert" >&nbsp;You must enter a username.</span>');
                failed = true;
            }
            if($('.emailTxt').val() == "")
            {
                $('.emailTit').html('<b>EMAIL</b><span class="alert" >&nbsp;You must enter an email.</span>');
                failed = true;
            }
            if(!failed)
            {
                resetPassword($('.userTxt').val(),$('.emailTxt').val());
            }
        }
        function resetPassword(user,email)
        {
            var password = Math.random().toString(36).slice(-8);
            $('.main').html('<span class="loader" ><img src="/Images/processing.gif" width="220" height="20" /></span>');
            $.ajax({
                type: "POST",
                url: "ForgotPassword.aspx/ChangePass",
                data: JSON.stringify({ username: user, email: email, password: password}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("An error occurred. Please try again.");
                    window.location.reload();
                },
                success: function (result) {
                    $('.main').html('<div class="hdr" ><b>FORGOT PASSWORD</b></div><div class="conf" ><img src="/Images/Done.png" width="30" height="30" /><span>&nbsp;A new password has been sent to: '+email+'</span></div>');
                    setTimeout(function () {
                        window.location.href = "Default.aspx"; //will redirect to your blog page (an ex: blog.html)
                    }, 2000);
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
        .emailTxt
        {
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
    </style>
    <div class="main" >
        <div class="hdr" ><b>FORGOT PASSWORD</b></div>
        <table class="facChecks" >
            <tr>
                <td class="subHdr userTit" id="username" colspan="3"><b>USERNAME</b><span class="alert" ></span></td>
                <td class="subHdr emailTit" id="email" colspan="5"><b>EMAIL</b><span class="alert" ></span></td>
            </tr>
            <tr class="roomRw">
                <td colspan="3"><input autocomplete="off" type="text" class="inp userTxt" id="userTxt"  /></td>
                <td colspan="5"><input autocomplete="off" type="text" class="inp emailTxt" id="emailTxt" /></td>
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