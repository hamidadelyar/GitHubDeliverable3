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
            right: 30%;
            width: 40%;
            max-width:370px;
            
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
</style>

<div class="contentHolder">

    <h1 align="center">Rooms</h1>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" SelectCommand="SELECT [Building_ID], [Building_Name] FROM [Buildings] ORDER BY [Building_Name]"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownList1" runat="server" autopostback="True" DataSourceID="SqlDataSource3" DataTextField="Building_Name" DataValueField="Building_ID"></asp:DropDownList>
    <div id="buttonsDiv">
        <input type="button" ID="addRoom" Value="Add Room" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
        <input type="button" ID="addFacility" Value="Add Facility" onclick = "document.getElementById('light2').style.display = 'block'; document.getElementById('fade2').style.display = 'block'" />
    </div>

    <div id="light" class="white_content">
        <h1>New Room</h1>
        Building: <br />
        <asp:TextBox id="TextBox1" runat="server" /><br />
        Room Number: <br />
        <asp:TextBox id="TextBox2" runat="server" /><br />
        Capacity: <br />
        <asp:TextBox id="TextBox5" runat="server" /><br />
        Room Type: <br />
        <asp:TextBox id="TextBox6" runat="server" />

        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" /> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>

    <div id="fade" class="black_overlay">
    </div>

            

    <div id="light2" class="white_content">
        <h1>New Facility</h1>
        Facility Name: <br />
        <asp:TextBox id="TextBox3" runat="server" /><br />
        Facility ID: <br />
        <asp:TextBox id="TextBox4" runat="server" />

        <br />
        <asp:Button ID="Button2" runat="server" Text="Save" /> 
        <input type="button" ID="closeInsert2" value="Close" onclick = "document.getElementById('light2').style.display = 'none'; document.getElementById('fade2').style.display = 'none'" />

    </div>

    <div id="fade2" class="black_overlay">
    </div>




    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Buildings] WHERE [Building_ID] = @Building_ID">
            <selectparameters>
		        <asp:controlparameter controlid="DropDownList1" name="Building_ID" propertyname="SelectedValue" type="String" />
	        </selectparameters>
    </asp:SqlDataSource>





    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
       <ItemTemplate> 

            <div class="buildingHeader" >
                <h2 class="white"><%#Eval("Building_Name") %> - <%#Eval("Park_ID") %></h2> 
            </div>
            <asp:SqlDataSource 
                ID="SqlDataSource2" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT * FROM [Rooms] WHERE [Building_ID] = @Building">
                    <selectparameters>
		                <asp:controlparameter controlid="DropDownList1" name="Building" propertyname="SelectedValue" type="String" />
	                </selectparameters>
            </asp:SqlDataSource>

            <asp:GridView 
                ID="GridView1" 
                runat="server" 
                DataSourceID="SqlDataSource2">
            </asp:GridView>


        </ItemTemplate>
    </asp:Repeater>




         
   


</div> 

    

</asp:Content>
