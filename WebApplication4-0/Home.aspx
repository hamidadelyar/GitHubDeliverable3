<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication4_0.Home" %>
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
        .updatesHolder
        {
            margin-top:10px;
            padding-top:10px;
            width:100%;
            background-color:#3E454D;
        }
        #progressbar{
            width:94%;
            margin-left:3%;
            margin-right:3%;
            margin-bottom:15px;
        }

        .ui-progressbar-value{
            background:#79A2B8;
        }

        #newsTable{
            
            margin: 10px 5% 10px 5%;
            width:90%;

        }

        #activityTable{
            
            margin: 10px 5% 10px 5%;
            width:90%;
        }

        .white{
            color:white;
        }

        .leftBorder{
            border-left: 1px solid black; 
        }

        h1{
            margin-bottom:10px;
           
        }

        h2 {
            margin-top:0px;
        }

        #containerTable{
            width:100%;
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
    
    <div class="contentHolder">

     
        <asp:SqlDataSource 
            ID="SqlDataSource6" 
            runat="server" 
            ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
            SelectCommand="SELECT [RoundID], [Year], [Semester], [Round_Name], [Status] FROM [Rounds] WHERE [Status] = 'open'"
            >

        </asp:SqlDataSource>

        <h1 style="margin-top:23px;" align="center">
            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource6" >
                <ItemTemplate>
            
                    Current Round: <%#Eval("Round_Name") %>, Semester <%#Eval("Semester") %> <%#Eval("Year") %>
            
                </ItemTemplate>
            </asp:Repeater>
            <% =RoundStatusAddMessage()%> 
        </h1>

        <div class="updatesHolder">
            <h2 class="white" align="center">Latest Request Results:</h2>
            <asp:SqlDataSource 
                ID="SqlDataSource3" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT TOP 3 * FROM [Requests] INNER JOIN [Modules] ON [Requests].[Module_Code]=[Modules].[Module_Code] WHERE Request_ID IN (SELECT [Request_ID] FROM [Bookings] Where [Confirmed] = 'Allocated') ORDER BY [Request_ID] DESC">

            </asp:SqlDataSource>
            <asp:GridView 
                ID="GridView2" 
                runat="server" 
                AutoGenerateColumns="False" 
                DataKeyNames="Request_ID" 
                DataSourceID="SqlDataSource3"
                ForeColor="White"
                HorizontalAlign="center"
                EmptyDataText="Currently No Request Results." 
                cellpadding="10">
                <Columns>
                    <asp:BoundField DataField="Module_Code" HeaderText="Module Code" SortExpression="Module_Code" />
                    <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day" />
                    <asp:BoundField DataField="Start_Time" HeaderText="Start Period" SortExpression="Start_Time" />
                    <asp:BoundField DataField="End_Time" HeaderText="End Period" SortExpression="End_Time" />
                </Columns>
                </asp:GridView>
             <p class="white" align="center">Head to <a style="color:white;" href="ViewRequest.aspx">View Requests</a> to view.</p>
            <br />
        </div>
        <table id="containerTable">
            <tr>
                <td style="text-align:center;" valign="top">                    
                    
                    <asp:SqlDataSource 
                        ID="SqlDataSource1" 
                        runat="server" 
                        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                        SelectCommand="SELECT * FROM [Announcements]">

                    </asp:SqlDataSource>
                    <table id="newsTable">
                    <tr>
                        <th colspan="3"  style="text-align:center;">News & Announcements</th>
                    </tr>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <tr>
                                <td><%#Eval("Title") %></td><td><%#Eval("postDate") %></td><td><input type="button" ID="respond<%#Eval("announcementID") %>" Value="View" onclick = "document.getElementById('light<%#Eval("announcementID") %>').style.display='block';document.getElementById('fade').style.display='block'" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    </table>
                


                

                </td>
                <td class="leftBorder" valign="top" style="text-align:center;">

                    <asp:SqlDataSource 
                        ID="SqlDataSource2" 
                        runat="server" 
                        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                        SelectCommand="SELECT TOP 5 * FROM [Requests] ORDER BY [Request_ID] DESC ">

                    </asp:SqlDataSource>

                <table id="activityTable">
                    <tr>
                        <th colspan="3"  style="text-align:center;">Recent Activity</th>
                    </tr>
                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <tr>
                                <td>Request for <%#Eval("Module_Code") %> made</td><td></td><td>
                                    <asp:Button ID="Button1" runat="server" Text="View" OnClick="linkRequests" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table></td>
            </tr>
        </table>      
        
            <script runat="server">

        private void linkRequests (object source, EventArgs e)
        {
            Response.Redirect("ViewRequest.aspx");
        }
    </script>

                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <div id="light<%#Eval("announcementID") %>" class="white_content">
                            <h1><%#Eval("Title") %></h1>
                            <%#Eval("Content") %>
                            <br />
                            <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light<%#Eval("announcementID") %>').style.display='none';document.getElementById('fade').style.display='none'" />

                            </div>
                            <div id="fade" class="black_overlay">
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

    </div>
</asp:Content>
