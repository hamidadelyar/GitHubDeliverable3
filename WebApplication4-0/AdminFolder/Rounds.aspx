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
</style>

<div class="contentHolder">

    <h1 align="center">Rounds</h1>
    <div id="buttonsDiv">
        <asp:Button ID="addRound" runat="server" Text="Add New Round" />
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
