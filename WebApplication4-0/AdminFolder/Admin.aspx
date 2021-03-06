﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication4_0.Admin" MasterPageFile="~/AdminFolder/AdminSite.master" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="css/AdminStyle.css">
  	
    <style>
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
            right: 40%;
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
        #TableDiv{
            float:left;
            margin-left:5%;
        }
    </style>


    <div class="contentHolder">
        <h1 align="center">Welcome, Admin.</h1>

        <div class="updatesHolder">
            <h2 class="white" align="center">Latest Requests:
                
            </h2>
            <asp:SqlDataSource 
                ID="SqlDataSource2" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT TOP 3 * FROM [Requests] INNER JOIN [Bookings] ON [Requests].[Request_ID] = [Bookings].[Request_ID] INNER JOIN [Days] ON [Requests].[Day] = [Days].[Day_ID] WHERE [Confirmed] = 'Pending' ORDER BY [Requests].[Request_ID] DESC">

            </asp:SqlDataSource>
            <asp:GridView 
                ID="GridView2" 
                runat="server" 
                AutoGenerateColumns="False" 
                DataKeyNames="Request_ID" 
                DataSourceID="SqlDataSource2"
                ForeColor="White"
                HorizontalAlign="center"
                EmptyDataText="Currently no pending requests." 
                cellpadding="10">
                <Columns>
                    <asp:BoundField DataField="Module_Code" HeaderText="Module Code" SortExpression="Module_Code" />
                    <asp:BoundField DataField="Day_Name" HeaderText="Day" SortExpression="Day_Name" />
                    <asp:BoundField DataField="Start_Time" HeaderText="Start Time" SortExpression="Start_Time" />
                    <asp:BoundField DataField="End_Time" HeaderText="End Time" SortExpression="End_Time" />
                    <asp:BoundField DataField="Dept_ID" HeaderText="Department" SortExpression="Dept_ID" />
                </Columns>
                </asp:GridView>
            <p class="white" align="center">Head to <a style="color:white;" href="Requests.aspx">Requests</a> to respond.</p>
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
        UpdateCommand="UPDATE [Announcements] SET [title]=@title, [content]=@content, [postDate]=GETDATE() WHERE [announcementID] = @announcementID"
        DeleteCommand="DELETE FROM Announcements WHERE announcementID = @announcementID"
        InsertCommand="INSERT INTO Announcements (title, content, postDate) VALUES (@titleDB,@contentDB,GETDATE())">
            <InsertParameters>
                <asp:ControlParameter name="titleDB" ControlId="TextBox1" PropertyName="Text" />
                <asp:ControlParameter name="contentDB" ControlId="TextBox2" PropertyName="Text" />
            </InsertParameters>

    </asp:SqlDataSource>
    <div id="TableDiv">
    <asp:GridView 
        ID="GridView1" 
        runat="server" 
        AutoGenerateColumns="False" 
        DataKeyNames="announcementID"
        DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." 
        AllowSorting="True">

        <Columns>
            <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
            <asp:BoundField DataField="content" HeaderText="Content" SortExpression="content" />
            <asp:BoundField DataField="postDate" HeaderText="Date" SortExpression="postDate" ReadOnly="true"/>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
    </asp:GridView>  
    <hr />    
          
    
        <input type="button" ID="addNews" Value="Add New Announcement" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
    </div>
    <div id="light" class="white_content">
        <h1>New Announcement</h1>
        Announcement Title: <br />
        <asp:TextBox id="TextBox1" runat="server" /><br />
        Announcement Details: <br />
        <asp:TextBox id="TextBox2" runat="server" />

        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" OnClick="NewAnnouncement" /> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>
    <div id="fade" class="black_overlay">
    </div>

    <script runat="server">
        private void NewAnnouncement (object source, EventArgs e) {
          SqlDataSource1.Insert();
          WebApplication4_0.Admin.SendEmail(TextBox1.Text, TextBox2.Text);
        }
    </script>
            
    </div>

</asp:Content>