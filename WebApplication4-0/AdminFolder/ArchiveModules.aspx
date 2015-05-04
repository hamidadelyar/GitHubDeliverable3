<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="ArchiveModules.aspx.cs" Inherits="WebApplication4_0.AdminFolder.ArchiveModules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function() {
            $('.archBtn').click(function () {
                alert("Hello");
                $.ajax({
                    type: "POST",
                    url: "ArchiveModules.aspx/Archive",
                    dataType: 'json',
                    contentType: 'application/json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("An error occurred. Please try again.");
                        window.location.reload();
                    },
                    success: function (result) {
                        alert('Modules Archived');
                        window.location.reload();
                    }
                });
            });
        });
    </script>
    <style>
        .archBtn
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
        .archBtn:hover
        {
            background-color:#2B3036;
        }
    </style>
    <div class="archBtn" >ARCHIVE MODULES</div>
</asp:Content>
