<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication4_0.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#progressbar").progressbar({
                value: 37
            });
        });
    </script>
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
        <h1 align="center">Time until end of Round XX</h1>
        
        <div id="progressbar"></div>

        <div class="updatesHolder">
            <h2 class="white" align="center">Request Results:</h2>
            <p class="white" align="center">There are currently no new request results.</p>
            <br />
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
                        SelectCommand="SELECT TOP 5 * FROM [Requests] ">

                    </asp:SqlDataSource>

                <table id="activityTable">
                    <tr>
                        <th colspan="3"  style="text-align:center;">Recent Activity</th>
                    </tr>
                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <tr>
                                <td>Request for <%#Eval("Module_Code") %> made</td><td></td><td><input type="button" Value="View" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table></td>
            </tr>
        </table>      
        
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
