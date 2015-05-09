<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveRequest.aspx.cs" Inherits="WebApplication4_0.ArchiveRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Archive Requests</h1>
    <asp:GridView ID="ArchiveRequests" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellPadding="10" CellSpacing="10" HorizontalAlign="Center">
        <Columns>
            <asp:BoundField DataField="Module_Code" HeaderText="Module_Code" SortExpression="Module_Code" />
            <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day" />
            <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time" />
            <asp:BoundField DataField="End_Time" HeaderText="End_Time" SortExpression="End_Time" />
            <asp:BoundField DataField="Semester" HeaderText="Semester" ReadOnly="True" SortExpression="Semester" />
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Number_Rooms" HeaderText="Number_Rooms" SortExpression="Number_Rooms" />
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource14Filter" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Module_Code], [Day], [Start_Time], [End_Time], [Semester], [Year], [Number_Rooms] FROM [Requests] WHERE ([Year] = @Year)">
        <SelectParameters> 
            <asp:Parameter DefaultValue="2014" Name="Year" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Module_Code], [Day], [Start_Time], [End_Time], [Semester] +1 AS [Semester], [Year], [Number_Rooms] FROM [Requests] WHERE ([Year] = @Year)">
        <SelectParameters>
            <asp:Parameter DefaultValue="2015" Name="Year" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
