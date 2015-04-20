<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Rounds.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Rounds" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

<style>
    .semesterHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
        clear:both;
    }

    .roundInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }

    #buttonsDiv{
        float:right;
        margin-right:5%;
    }

        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=80);
        }
        .white_content {
            display: none;
            position: absolute;
            top: 30%;
            right: 30%;
            width: 40%;
            max-width:370px;
            height: 250px;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }

</style>

<div class="contentHolder">

    <h1 align="center">Rounds</h1>
    <div id="buttonsDiv">
         <input type="button" ID="addRound" Value="Add New Round" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />

    </div>



    <div id="light" class="white_content">
        <h1>New Round</h1>
        Round Number: <br />
        <asp:TextBox id="TextBox1" runat="server" /><br />
        Start Date: <br />
        <asp:TextBox id="TextBox2" runat="server" />
        End Date: <br />
        <asp:TextBox id="TextBox3" runat="server" />

        <br />
        <asp:Button ID="Button1" runat="server" Text="Save"  /> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>
    <div id="fade" class="black_overlay">
    </div>




    <div class="semesterHeader" >
        <h2 class="white">Semester 2 - 2014/2015</h2> 
    </div>

    <table class="roundInfoTable">
        <tr>
            <th>Round No</th><th>Start Date</th><th>End Date</th>
        </tr>
        <tr>
            <td>1</td><td>12/02/2015</td><td>13/03/2015</td><td>Edit</td><td>Remove</td>
        </tr>
        <tr>
            <td>2</td><td>15/03/2015</td><td>20/04/2015</td><td>Edit</td><td>Remove</td>
        </tr>
        <tr>
            <td>3</td><td>22/04/2015</td><td>09/05/2015</td><td>Edit</td><td>Remove</td>
        </tr>
    </table>

    <div class="semesterHeader" >
        <h2 class="white">Semester 1 - 2014/2015</h2> 
    </div>

    <table class="roundInfoTable">
        <tr>
            <th>Round No</th><th>Start Date</th><th>End Date</th>
        </tr>
        <tr>
            <td>1</td><td>12/10/2014</td><td>12/11/2014</td><td>Edit</td><td>Remove</td>
        </tr>
        <tr>
            <td>2</td><td>14/11/2014</td><td>21/12/2014</td><td>Edit</td><td>Remove</td>
        </tr>
    </table>

</div> 

</asp:Content>
