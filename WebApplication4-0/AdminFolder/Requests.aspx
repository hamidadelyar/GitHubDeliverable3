<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Requests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

<style>
    .requestHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
    }

    .requestInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }
</style>

<div class="contentHolder">
    <h1 align="center">Requests</h1>
    

    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Requests] INNER JOIN [Modules] ON [Requests].[Module_Code]=[Modules].[Module_Code]">

    </asp:SqlDataSource>
    <br />
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>

            <div class="requestHeader">
                <h2 class="white"><%#Eval("Module_Code") %> - <%#Eval("Module_Title") %></h2> 
            </div>

            <table class="requestInfoTable">
                <tr>
                    <th>Day</th><th>Start Time</th><th>End Time</th><th>Weeks</th><th>Students</th>
                </tr>
                <tr>
                    <td><%#Eval("Day") %></td><td><%#Eval("Start_Time") %></td><td><%#Eval("End_Time") %></td><td>####</td><td><%#Eval("Number_Students") %></td><td>
                        <asp:Button ID="Button1" runat="server" Text="Respond" /></td>
                </tr>
            </table>


            
        </ItemTemplate>
    </asp:Repeater>





</div> 


</asp:Content>