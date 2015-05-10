<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Requests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

<style>
     .contentHolderRequest
        {
            margin-top:50px;
            width:100%;
            border-top-left-radius:10px;
            border-top-right-radius:10px;
            border-bottom-left-radius:10px;
            border-bottom-right-radius:10px;
            background-color:#FFF;
            float:left;
        }
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

     .black_overlay{
            display: none;
            position: fixed;
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
            height: 300px;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }
</style>

<div class="contentHolderRequest">
    <h1 align="center">Requests</h1>
    

    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Requests] INNER JOIN [Modules] ON [Requests].[Module_Code]=[Modules].[Module_Code] WHERE Request_ID IN (SELECT [Request_ID] FROM [Bookings] Where [Confirmed] = 'Pending')">

    </asp:SqlDataSource>
    <br />
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>

            <div class="requestHeader">
                <h2 class="white"><%#Eval("Module_Code") %> - <%#Eval("Module_Title") %></h2> 
            </div>

            <table class="requestInfoTable">
                <tr>
                    <th>Day</th><th>Start Period</th><th>End Period</th><th>Students</th>
                </tr>
                <tr>
                    <td><%#Eval("Day") %></td><td><%#Eval("Start_Time") %></td><td><%#Eval("End_Time") %></td><td><%#Eval("Number_Students") %></td><td>
                        <a href="../EditRequest.aspx?ID=<%#Eval("Request_ID") %>" />Respond</a></td>
                </tr>
            </table>


                
            <div id="light<%#Eval("Request_ID") %>" class="white_content">
                <h1><%#Eval("Module_Code") %> - <%#Eval("Module_Title") %></h1>
                Announcement Title: <br />
                <asp:TextBox id="TextBox1" runat="server" /><br />
                Announcement Details: <br />
                <asp:TextBox id="TextBox2" runat="server" />

                <br />
                <asp:Button ID="Button2" runat="server" Text="Save" /> 
                <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light<%#Eval("Request_ID") %>').style.display='none';document.getElementById('fade').style.display='none'" />

            </div>
            <div id="fade" class="black_overlay">
            </div>

            <!--<input type="button" ID="respond<%#Eval("Request_ID") %>" Value="Respond" onclick = "document.getElementById('light<%#Eval("Request_ID") %>').style.display='block';document.getElementById('fade').style.display='block'" />-->
        </ItemTemplate>
    </asp:Repeater>





</div> 


</asp:Content>