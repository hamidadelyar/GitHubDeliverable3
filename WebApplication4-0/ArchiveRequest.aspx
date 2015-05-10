<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArchiveRequest.aspx.cs" Inherits="WebApplication4_0.ArchiveRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Archive Requests</h1>
    <%-- Dropdown to filter archived requests--%>
        <p>Show requests from the following year: 
            <asp:DropDownList 
                id="DropDownList1"
                runat="server"
                AutoPostBack="True">
                <asp:ListItem Selected="True">2014</asp:ListItem>
                <asp:ListItem>2013</asp:ListItem>
            </asp:DropDownList></p> 
    <%-- Gridview used to display the results of the SQL query --%>
    <asp:GridView ID="ArchiveRequests" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellPadding="10" CellSpacing="10" HorizontalAlign="Center">
        <Columns>
            <asp:BoundField DataField="Module_Code" HeaderText="Module Code" SortExpression="Module_Code" />
            <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day" />
            <asp:BoundField DataField="Start_Time" HeaderText="Start Time" SortExpression="Start_Time" />
            <asp:BoundField DataField="End_Time" HeaderText="End Time" SortExpression="End_Time" />
            <asp:BoundField DataField="Semester" HeaderText="Semester" ReadOnly="True" SortExpression="Semester" />
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Number_Rooms" HeaderText="Number Rooms" SortExpression="Number_Rooms" />
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:GridView>
     <%-- SQL statement used to fill gridview  --%>
    <asp:SqlDataSource 
        ID="SqlDataSource1"
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT [Module_Code], [Day], [Start_Time], [End_Time], [Semester] +1 AS [Semester], [Year], [Number_Rooms] FROM [Requests]" 
        FilterExpression="Year='{0}'">  
         <SelectParameters> 
            <asp:Parameter DefaultValue="2015" Name="Year" Type="Int32" />
        </SelectParameters>
        <FilterParameters>
                 <asp:ControlParameter Name="Year" ControlId="DropDownList1" PropertyName="SelectedValue"/> <%-- Results filtered by the year chosen by the user in the dropdown --%>
        </FilterParameters>
    </asp:SqlDataSource>
</asp:Content>
