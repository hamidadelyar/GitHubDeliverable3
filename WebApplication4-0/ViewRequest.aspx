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

        var result = confirm('Are you sure you want to delete this request?');

        if(result)
        {
            obj = { id: x };
            obj.myself = obj;

            seen = [];

            /*
            }*/
            
            //var userid = document.getElementById(id);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ViewRequest.aspx/Delete",
                data: JSON.stringify(obj, function (key, val) {
                    if (typeof val == "object") {
                        if (seen.indexOf(val) >= 0)
                            return undefined;
                        seen.push(val);
                    }
                    return val;
                }),
                dataType: "json",
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("There has been an error with your request \n\nRequest: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (data) {
                    //alert('success');
                    if (data.d == 'true') {
                        location.reload();
                    }
                }


            }
                );
        }

        //var row = document.getElementById(x);
        //row.parentNode.removeChild(row);

        //var but = "button"
        //var buttonid = but.concat(x);
        //alert(buttonid);
        //var button = document.getElementById(buttonid);
        //alert(button);
        //button.click();
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
