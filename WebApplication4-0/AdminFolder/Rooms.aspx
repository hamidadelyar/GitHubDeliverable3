<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Rooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

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
            margin-left:auto;
            margin-right:auto;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }

        .white_content_facilities {
            display: none;
            position: absolute;
            top: 30%;
            left: 33%;
            width:650px;
            margin-left:auto;
            margin-right:auto;
            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }


    .buildingHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
        clear:both;
    }

    .roomInfoTable{
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

    th {
        padding-right:15px;
    }

    td {
        
        padding-right:15px;
    }
</style>

<div class="contentHolder">

    <h1 align="center">Rooms</h1>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" SelectCommand="SELECT [Building_ID], [Building_Name] FROM [Buildings] ORDER BY [Building_Name]"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownList1" runat="server" autopostback="True" DataSourceID="SqlDataSource3" DataTextField="Building_Name" DataValueField="Building_ID" CssClass="margin5"></asp:DropDownList>
    <div id="buttonsDiv">
        <input type="button" ID="addRoom" Value="Add Room" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
        <input type="button" ID="addFacility" Value="Facilities" onclick = "document.getElementById('light2').style.display = 'block'; document.getElementById('fade2').style.display = 'block'" />
    </div>

    <asp:SqlDataSource 
        ID="SqlDataSource5" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Rooms]">
    </asp:SqlDataSource>

    <script runat="server">
        private void NewRoom (object source, EventArgs e) {
            SqlDataSource1.Insert();
        }

        private void NewFacility(object source, EventArgs e)
        {
            SqlDataSource6.Insert();
        }
    </script>

    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" SelectCommand="SELECT * FROM [Room_Types]"></asp:SqlDataSource>

    <div id="light" class="white_content">
        <h1>New Room</h1>
        Building: <br />
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="Building_Name" DataValueField="Building_ID" ></asp:DropDownList><br />
        Room ID: <br />
        <asp:TextBox id="TextBox2" runat="server" /><br />
        Capacity: <br />
        <asp:TextBox id="TextBox5" runat="server" /><br />
        Room Type: <br />
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource7" DataTextField="Type_Name" DataValueField="Room_Type" ></asp:DropDownList>

        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" onclick="NewRoom"/> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>

    <div id="fade" class="black_overlay">
    </div>

            

    <div id="light2" class="white_content_facilities">
        <div style="float:left;">
            <asp:GridView 
                ID="GridView1" 
                runat="server" 
                AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource6" 
                DataKeyNames="Facility_ID">
                <Columns>
                    <asp:BoundField DataField="Facility_ID" HeaderText="Facility ID"  />
                    <asp:BoundField DataField="Facility_Name" HeaderText="Facility Name" />
                    <asp:CommandField ShowDeleteButton="True"/>
                </Columns>
            </asp:GridView>
        </div>
        <div style="float:right;">
        <h1>New Facility</h1>
        Facility Name: <br />
        <asp:TextBox id="TextBox3" runat="server" /><br />
        Facility ID: <br />
        <asp:TextBox id="TextBox4" runat="server" />

        <br />
        <asp:Button ID="Button2" runat="server" Text="Save" onclick="NewFacility"/> 
        <input type="button" ID="closeInsert2" value="Close" onclick = "document.getElementById('light2').style.display = 'none'; document.getElementById('fade2').style.display = 'none'" />
        </div>
    </div>

    <div id="fade2" class="black_overlay">
    </div>

    <asp:SqlDataSource 
        ID="SqlDataSource6" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Facilities]"
        InsertCommand="INSERT INTO Facilities (Facility_ID, Facility_Name) VALUES (@FID, @FName)"
        DeleteCommand="DELETE FROM Facilities WHERE Facility_ID = @Facility_ID">

            <InsertParameters>
                <asp:ControlParameter name="FName" ControlId="TextBox3" PropertyName="Text" />
                <asp:ControlParameter name="FID" ControlId="TextBox4" PropertyName="Text" />

            </InsertParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Buildings] INNER JOIN [Parks] ON [Buildings].[Park_ID] = [Parks].[Park_ID] WHERE [Building_ID] = @Building_ID"
        InsertCommand="INSERT INTO [Rooms] ([Room_ID], [Capacity], [Room_Type], [Building_ID], [Pool]) VALUES (@roomDB, @capacityDB, @typeDB, @buildingDB, 'true')">
            <selectparameters>
		        <asp:controlparameter controlid="DropDownList1" name="Building_ID" propertyname="SelectedValue" type="String" />
	        </selectparameters>
            <InsertParameters>
                <asp:ControlParameter name="buildingDB" ControlId="DropDownList2" PropertyName="Text" />
                <asp:ControlParameter name="roomDB" ControlId="TextBox2" PropertyName="Text" />
                <asp:ControlParameter name="capacityDB" ControlId="TextBox5" PropertyName="Text" />
                <asp:ControlParameter name="typeDB" ControlId="DropDownList3" PropertyName="Text" />
            </InsertParameters>
    </asp:SqlDataSource>





    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
       <ItemTemplate> 

            <div class="buildingHeader" >
                <h2 class="white"><%#Eval("Building_Name") %> - <%#Eval("Park_Name") %> Park</h2> 
            </div>
            <asp:SqlDataSource 
                ID="SqlDataSource2" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT * FROM [Rooms] INNER JOIN [Room_Types] ON [Rooms].[Room_Type] = [Room_Types].[Room_Type] WHERE [Building_ID] = @Building">
                    <selectparameters>
		                <asp:controlparameter controlid="DropDownList1" name="Building" propertyname="SelectedValue" type="String" />
	                </selectparameters>
            </asp:SqlDataSource>
            
            <table  Class="margin5">
                <tr>
                    <th>Room ID</th><th>Capacity</th><th>Room Type</th><th></th>
                </tr>
                
                    <asp:Repeater 
                        ID="Repeater2" 
                        runat="server"
                        DataSourceID="SqlDataSource2"
                        >
                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("Room_ID") %></td><td><%#Eval("Capacity") %></td><td><%#Eval("Type_Name") %></td><td><a href="../RoomsDetails.aspx?roomCode=<%#Eval("Room_ID") %>">View</a></td><td><a href="../AddRoom.aspx?ID=<%#Eval("Room_ID") %>">Edit</a></td>
                                </tr>
                            </ItemTemplate>
                    </asp:Repeater>
                
            </table>
        </ItemTemplate>
    </asp:Repeater>

        <script runat="server">
        private void EditRoom (object source, EventArgs e) 
        {
            Response.Redirect("AddRoom.aspx.aspx");
        }
    </script>

            <asp:SqlDataSource 
                ID="SqlDataSource4" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT * FROM [Rooms] WHERE [Building_ID] = @Building">
                    <selectparameters>
		                <asp:controlparameter controlid="DropDownList1" name="Building" propertyname="SelectedValue" type="String" />
	                </selectparameters>
            </asp:SqlDataSource>
            
                   <asp:Repeater 
                        ID="Repeater3" 
                        runat="server"
                        DataSourceID="SqlDataSource4">
                            <ItemTemplate>
                                <div id="light<%#Eval("Room_ID") %>" class="white_content">
                                    <h1> <%#Eval("Room_ID") %> </h1> <div style="float:right;">Capacity: </div>
                                    <p></p>
                                    <div class="buildingHeader"><h1 class="white">Facilities</h1></div>
                                    <asp:Button ID="Button2" runat="server" Text="Save" /> 
                                    <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light<%#Eval("Room_ID") %>').style.display='none';document.getElementById('fade').style.display='none'" />

                                </div>
                                <div id="fade" class="black_overlay">
                                </div>
                            </ItemTemplate>
                    </asp:Repeater>
         
   


</div> 

    

</asp:Content>
