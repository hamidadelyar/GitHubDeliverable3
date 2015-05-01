<%@ Page Title="View Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="WebApplication4_0.ViewRequest" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

<script type="text/css" src="Content/jq.css"></script>
<script type="text/javascript" src="Scripts/jquery-latest.js"></script>
<script type="text/javascript" src="/Scripts/jquery.tablesorter.js"></script> 
<!--<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>-->
<script type="text/javascript">
    $(document).ready(function () {
        $("#requestTable").tablesorter({ sortList: [[0, 0], [1, 0]] });
    }
);

    function deleteRow(x) {
        var row = document.getElementById(x);
        row.parentNode.removeChild(row);

        var but = "button"
        var buttonid = but.concat(x);
        alert(buttonid);
        var button = document.getElementById(buttonid);
        alert(button);
        button.click();
        //return true;
    }
</script>
<hgroup class="header">
    <h1>Your Requests</h1>
</hgroup>
<section class ="tableOfRequests">
<asp:PlaceHolder ID = "PlaceHolder1" runat="server" />
</section>


</asp:Content>
