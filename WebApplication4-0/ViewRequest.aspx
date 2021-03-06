﻿<%@ Page Title="View Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="WebApplication4_0.ViewRequest" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

<link rel="stylesheet" href="Content/jq.css"/>
<script type="text/javascript" src="./Scripts/jquery-latest.js"></script>
<script type="text/javascript" src="./Scripts/jquery.tablesorter.js"></script>
<script type="text/javascript" src="./Scripts/parser-date-weekday.js"></script>
<link rel="stylesheet" href="Content/PopupBlur.css" /> 
<!--<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>-->
<style>
    .pop{
  display:none;
  position:fixed;
  top:20%;
  left:7.5%;
  width:50%;
  height:60%;
  border-radius:8px;
  background:#ff8060;
  color:white;
  font-family: "Segoe UI",Verdana,Helvetica,sans-serif;
  
}

    tr 
    {
        cursor:pointer;
    }
.tablesorter {
		background-color:#ffffff;
		border: 1px solid #ff7f00;
		width: 100%;
		height: 100%;
}
.tablesorter th{
		padding-left: 10px;
		padding-right: 10px;
}
.tablesorter td{
		padding-left: 10px;
		padding-right: 10px;
}
			

</style>
<script type="text/javascript">

    $(document).ready(function () {
        /*
        $('tr.header').click(function () {

            $(this).nextUntil('tr.header').css('display', function (i, v) {
                return this.style.display === 'table-row' ? 'none' : 'table-row';
            });
        });
        */

        /*$.tablesorter.addParser({
            // set a unique id 
            id: 'days',
            is: function (s) {
                // return false so this parser is not auto detected 
                return false;
            },
            format: function (s) {
                // format your data for normalization 
                //var rows = document.getElementById("#requestTable").getElementsByTagName("tr").length;
            },
            // set type, either numeric or text 
            type: 'numeric'
        });*/

        $('#requestTable tr').click(function () {
            window.location.href = "./EditRequest.aspx?ID=" + $(this).children('td:first').html();
        });

        $(function () {
            $("#requestTable").tablesorter({
					//sortList: [[0,0], [1,0]] 
                }
            

        
        );

        $("#closePopupDetails").click(function () { //onclick, fades out
            $('#popupDetails').fadeOut(1000);
            //$('#requestContainer').removeClass('blur-in');
            $('#requestTable').addClass('blur-out');
            $('#requestTable').removeClass('blur-in');

            //unblurs the text in the footer
            $('footer .float-left').addClass('blur-out');
            $('footer .float-left').removeClass('blur-in');

            $('footer #accessBar').addClass('blur-out');
            $('footer #accessBar').removeClass('blur-in');

            //unblurs header content
            $('header').addClass('blur-out');
            $('header').removeClass('blur-in');

            $('.header').addClass('blur-out');
            $('.header').removeClass('blur-in');
        });
    });
	});

    function deleteRow(x, y) {

        var result = confirm('Are you sure you want to delete this request?');

        if(result)
        {
            //alert(x);
            //alert(y);
            obj = { id: x, pref_id: y };
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

    function deleteRow2(x, y1, y2) {

        var result = confirm('Are you sure you want to delete this request?');

        if (result) {
            //alert(x);
            //alert(y);
            obj = { id: x, pref_id: y1, pref_id2: y2 };
            obj.myself = obj;

            seen = [];

            /*
            }*/

            //var userid = document.getElementById(id);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ViewRequest.aspx/Delete2",
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

    function deleteRow3(x, y1, y2, y3) {

        var result = confirm('Are you sure you want to delete this request?');

        if (result) {
            //alert(x);
            //alert(y);
            obj = { id: x, pref_id: y1, pref_id2: y2, pref_id3: y3 };
            obj.myself = obj;

            seen = [];

            /*
            }*/

            //var userid = document.getElementById(id);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ViewRequest.aspx/Delete3",
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

    function showDetails() {

        $('#popupDetails').fadeIn(1000);
        $('#requestTable').removeClass('blur-out');
        $('#requestTable').addClass('blur-in');

        //only blurs the text in the footer
        $('footer .float-left').removeClass('blur-out');
        $('footer .float-left').addClass('blur-in');

        $('footer #accessBar').removeClass('blur-out');
        $('footer #accessBar').addClass('blur-in');

        //blurs header content, i.e. navigation
        $('header').removeClass('blur-out');
        $('header').addClass('blur-in');

        $('.header').removeClass('blur-out');
        $('.header').addClass('blur-in');

    }
	

    
</script>
<hgroup class="header">
    <h1>Your Requests</h1>
    <h1></h1>
</hgroup>
<section class ="tableOfRequests">
    <asp:PlaceHolder ID = "PlaceHolder1" runat="server" />
</section>
<section class="detailsTable">
    <asp:PlaceHolder ID = "PlaceHolder2" runat="server" />
</section>


</asp:Content>
