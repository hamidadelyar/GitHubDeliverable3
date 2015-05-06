<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication4_0.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var details = <%= this.details %>;
        $(document).ready(function() {
            $('.hdr b').html(details[0]['Forename'] + " " + details[0]["Surname"] + '<br />');
            $('.rest').html('Department: ' + details[0]["Dept_Name"] + '<br /><br />Email: <span class="editable" id="ChangeEmail" >' + details[0]["Email"] + ' <img src="Images/Edit.png" height="16" width="16" /></span><br />Password: <span class="editable" id="ChangePassword" >******** <img src="Images/Edit.png" height="16" width="16" /></span>');
            $('.editable').click(function() {
                window.location.href = $(this).prop('id');
            })
        });
    </script>
    <style>
        .pageHolder {
            margin-top: 50px;
            border-radius: 10px;
            width: 95%;
            padding: 2.5%;
            background-color: #FFF;
            margin-bottom: 15px;
        }
        .hdr {
            font-size: 1.4em;
        }
        .rest {
            font-size: 1.2em;
        }
        .editable {
            text-decoration: underline;
            cursor: pointer;
        }
    </style>
    <div class="pageHolder" >
        <span class="hdr" ><b></b></span>
        <span class="rest" ></span>
    </div>
</asp:Content>
