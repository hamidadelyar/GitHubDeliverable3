<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveRequest1.aspx.cs" Inherits="WebApplication4_0.ArchiveRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .contentHolder
        {
            margin-top:50px;
            width:100%;
            height:600px;
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
    </style>

    <div class="contentHolder">
    <h1 align="center">Archive Requests</h1>
      <p align="center">Show requests from the following year: 
                <asp:DropDownList
                id="DropDownList1"
                runat="server"
                AutoPostBack="True">
                <asp:ListItem Selected="True">2014</asp:ListItem>
                <asp:ListItem>2013</asp:ListItem>
            </asp:DropDownList></p>
         
            
    <asp:GridView ID="ArchiveRequests" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellPadding="10" CellSpacing="10" HorizontalAlign="Center" DataKeyNames="Request_ID" OnSelectedIndexChanged="ArchiveRequests_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="Request_ID" HeaderText="Request ID" SortExpression="Request_ID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="Module_Code" HeaderText="Module Code" SortExpression="Module_Code" />
            <asp:BoundField DataField="Start_Time" HeaderText="Start Time" SortExpression="Start_Time" />
            <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day" />
            <asp:BoundField DataField="End_Time" HeaderText="End Time" SortExpression="End_Time" />
            <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester" />
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Number_Rooms" HeaderText="Number of Rooms" SortExpression="Number_Rooms" />
             <asp:TemplateField>
                <ItemTemplate>
                     <a href="../EditRequest.aspx?ID=<%#Eval("Request_ID") %>" />Edit/Resubmit</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:GridView>
     </div>
    <asp:SqlDataSource 
        ID="SqlDataSource1"
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT [Request_ID], [Module_Code], [Start_Time], [Day], [End_Time], [Semester] +1 AS [Semester], [Year], [Number_Rooms] FROM [Requests]" 
        FilterExpression="Year='{0}'">  
        <FilterParameters>
                 <asp:ControlParameter Name="Year" ControlId="DropDownList1" PropertyName="SelectedValue"/>
        </FilterParameters>
    </asp:SqlDataSource>
</asp:Content>

