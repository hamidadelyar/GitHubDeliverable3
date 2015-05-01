<%@ Page Title="Previous Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveRequest.aspx.cs" Inherits="WebApplication4_0.PreviousRequest" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

<script type="text/css" src="Content/jq.css"></script>
<hgroup class="header">
    <h1>Previous Requests</h1>
</hgroup>
<section class ="tableOfRequests">
<asp:PlaceHolder ID = "PlaceHolder1" runat="server" />
    
<!--<asp:Table ID="Table1" runat="server" GridLines="Both">
        <asp:TableRow>
            <asp:TableCell>Semester</asp:TableCell>
            <asp:TableCell>Day</asp:TableCell>
            <asp:TableCell>Week(s)</asp:TableCell>
            <asp:TableCell>Time</asp:TableCell>
            <asp:TableCell>Group Size</asp:TableCell>
            <asp:TableCell>Module Code</asp:TableCell>
            <asp:TableCell>Area</asp:TableCell>
            <asp:TableCell>Building</asp:TableCell>
            <asp:TableCell>No. of Rooms</asp:TableCell>
            <asp:TableCell>Room(s) Specified</asp:TableCell>
            <asp:TableCell>Priority</asp:TableCell>
            <asp:TableCell>Status</asp:TableCell>
            <asp:TableCell>Special Requirements</asp:TableCell>
            <asp:TableCell>Edit</asp:TableCell>
            <asp:TableCell>Delete</asp:TableCell>
        </asp:TableRow>
    </asp:Table>-->
</section>
   <script type="text/javascript" src="Scripts/jquery-latest.js"></script>
<script type="text/javascript" src="/Scripts/jquery.tablesorter.js"></script> 
<!--<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>-->
<script type="text/javascript">
    $(document).ready(function ()
    {
        $("#requestTable").tablesorter({ sortList: [[0, 0], [1, 0]] });
    }
);
</script>

</asp:Content>

