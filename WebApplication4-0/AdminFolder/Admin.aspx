﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication4_0.Admin" MasterPageFile="~/AdminFolder/AdminSite.master" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 
  	
    <style>
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
            left: 30%;
            width: 40%;
            height: 40%;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
        }
        #buttonsDiv{
            float:right;
            margin-right:5%;
        }
    </style>


    <div class="contentHolder">
        <h1 align="center">Welcome, Admin.</h1>

        <div class="updatesHolder">
            <h2 class="white" align="center">New Requests:</h2>
            <p class="white" align="center">There are currently no new requests.</p>
            <br />
            <br />
        </div>


    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        DataSourceMode="DataSet"
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:team02ConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [announcementID], [postDate], [title], [content] FROM [Announcements]"
        UpdateCommand="UPDATE Announcements SET title=@title, content=@content, postDate=GETDATE() WHERE announcementID = @announcementID"
        DeleteCommand="DELETE FROM Announcements WHERE announcementID = @announcementID"
        InsertCommand="INSERT INTO Announcements (title, content, postDate) VALUES (@titleDB,@contentDB,GETDATE())">
            <InsertParameters>
                <asp:ControlParameter name="titleDB" ControlId="TextBox1" PropertyName="Text" />
                <asp:ControlParameter name="contentDB" ControlId="TextBox2" PropertyName="Text" />
            </InsertParameters>

    </asp:SqlDataSource>

    <asp:GridView 
        ID="GridView1" 
        runat="server" 
        AutoGenerateColumns="False" 
        DataKeyNames="announcementID"
        DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." 
        AllowSorting="True">

        <Columns>
            <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
            <asp:BoundField DataField="content" HeaderText="content" SortExpression="content" />
            <asp:BoundField DataField="postDate" HeaderText="postDate" SortExpression="postDate" />
            <asp:CommandField ShowEditButton="True" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>  
        
          
    <div id="buttonsDiv">
        <input type="button" ID="addNews" Value="Add New Announcement" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
    </div>
    <div id="light" class="white_content">
        <asp:TextBox id="TextBox1" runat="server" />
        <asp:TextBox id="TextBox2" runat="server" />

        <br />
        <asp:Button ID="Button1" runat="server" Text="New Announcement" OnClick="NewAnnouncement" /> 
        <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">Close</a>

    </div>
    <div id="fade" class="black_overlay">
    </div>

    <script runat="server">
        private void NewAnnouncement (object source, EventArgs e) {
          SqlDataSource1.Insert();
        }
    </script>
            
    </div>

</asp:Content>