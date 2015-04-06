<%@ Page Title="Room Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomData.aspx.cs" Inherits="WebApplication4_0.RoomData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

    <style>
        .map
        {
            margin-top:50px;
            width:100%;
        }
    </style>
    <div>
        <object data="http://maps.lboro.ac.uk/" width="600" height="400">
            <embed src="http://maps.lboro.ac.uk/" width="600" height="400" />
            Error: Embedded data could not be displayed.
        </object>

    </div>
</asp:Content>
