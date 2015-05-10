<%@ Page Title="" Language="C#" MasterPageFile="~/AdminFolder/AdminSite.master" AutoEventWireup="true" CodeBehind="Rounds.aspx.cs" Inherits="WebApplication4_0.AdminFolder.Rounds" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

<style>
    .semesterHeader{
        margin-top:10px;
        padding-top:10px;
        width:100%;
        background-color:#3E454D;
        clear:both;
    }

    .roundInfoTable{
        margin: 10px 5% 10px 5%;
        width:90%;
    }

    h2 {
        margin-left:5%;
    }

    #leftDiv{
        float:left;
        margin-left:5%;
    }

    #buttonsDiv{
        float:right;
        margin-right:5%;
        margin-top:23px;
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

            padding: 16px;
            background-color: white;
            z-index:1002;
            overflow: auto;
            border: 2px solid;
            border-radius: 25px;
        }

</style>

<div class="contentHolder">
    <!--
    <script>
        @{
            var db = Database.Open("Northwind");
            var commandText = @"SELECT CategoryId FROM Categories WHERE CategoryName = @0";
            var result = db.QueryValue(commandText, "Beverages");
            commandText = @"SELECT ProductName FROM Products WHERE CategoryId = @0";
            var products = db.Query(commandText, result);
        }

        @if(products.Count > 0){
            <div>Query returned @products.Count records</div>
        }
    </script>
    -->



    <asp:SqlDataSource 
        ID="SqlDataSource6" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT [RoundID], [Year], [Semester], [Round_Name], [Status] FROM [Rounds] WHERE [Status] = 'open'"
        >

    </asp:SqlDataSource>
    
    <div id="leftDiv">
        <h1 style="margin-top:23px;">
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource6" >
                <ItemTemplate>
            
                    Current Round: <%#Eval("Round_Name") %>, Semester <%#Eval("Semester") %> <%#Eval("Year") %>
            
                </ItemTemplate>
            </asp:Repeater>
        </h1>

    </div>
    
    <% =RoundStatusEnd()%> 

    <asp:Button ID="Button2" runat="server" Text="End Current Round" OnClick="EndRound"  />

    <div id="buttonsDiv">
         
    <% =RoundStatusAdd()%>    

    </div>
    <br />
    
    <br />
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" SelectCommand="SELECT DISTINCT [Year] FROM [Rounds] ORDER BY [Year] DESC"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownList1" runat="server" autopostback="True" DataSourceID="SqlDataSource4" DataTextField="Year" DataValueField="Year"></asp:DropDownList>

    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" SelectCommand="SELECT DISTINCT [Semester] FROM [Rounds] ORDER BY [Semester] DESC"></asp:SqlDataSource>

    <asp:DropDownList ID="DropDownList2" runat="server" autopostback="True" DataSourceID="SqlDataSource5" DataTextField="Semester" DataValueField="Semester"></asp:DropDownList>



    <div id="light" class="white_content">
        <h1>New Round</h1>
        Round Number: <br />
        <asp:TextBox id="TextBox1" runat="server" /><br />
        Academic Year: <br />
        <asp:TextBox id="TextBox2" runat="server" /><br />
        Semester: <br />
        <asp:TextBox id="TextBox3" runat="server" /><br />


        <br />
        <asp:Button ID="Button1" runat="server" Text="Save" OnClick="NewRound" /> 
        <input type="button" ID="closeInsert" value="Close" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" />

    </div>
    <div id="fade" class="black_overlay">
    </div>

    <script runat="server">
        private void NewRound (object source, EventArgs e) 
        {
          SqlDataSource2.Insert();
        }

        private void EndRound (object source, EventArgs e)
        {
            SqlDataSource2.Update();
        }
    </script>

    <asp:SqlDataSource 
        ID="SqlDataSource2" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT DISTINCT [Year], [Semester] FROM [Rounds] WHERE [year] = @year AND [semester] = @semester"        
        InsertCommand="INSERT INTO [Rounds] ([Year],[Semester],[Round_Name],[Start_Date],[End_Date],[Status]) VALUES (@yearDB,@semesterDB,@RoundDB,GETDATE(),'','open')"
        UpdateCommand="UPDATE [rounds] SET [status] = 'closed' WHERE [status] = 'open'">
            <selectparameters>
		        <asp:controlparameter controlid="DropDownList1" name="year" propertyname="SelectedValue" type="String" />
                <asp:controlparameter controlid="DropDownList2" name="semester" propertyname="SelectedValue" type="String" />
	        </selectparameters>
            <InsertParameters>
                <asp:ControlParameter name="RoundDB" ControlId="TextBox1" PropertyName="Text" />
                <asp:ControlParameter name="yearDB" ControlId="TextBox2" PropertyName="Text" />
                <asp:ControlParameter name="semesterDB" ControlId="TextBox3" PropertyName="Text" />
            </InsertParameters>
    </asp:SqlDataSource>
    
    
    <asp:Repeater 
        ID="Repeater1" 
        runat="server" 
        DataSourceID="SqlDataSource2">

        <ItemTemplate>

            <div class="semesterHeader" >
                <h2 class="white">Semester <%#Eval("Semester") %> - <%#Eval("Year") %></h2> 
            </div>
            
            <asp:SqlDataSource 
                ID="SqlDataSource1" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
                SelectCommand="SELECT * FROM [Rounds]  WHERE [year] = @year2 AND [semester] = @semester2">
                    <selectparameters>
		                <asp:controlparameter controlid="DropDownList1" name="year2" propertyname="SelectedValue" type="String" />
                        <asp:controlparameter controlid="DropDownList2" name="semester2" propertyname="SelectedValue" type="String" />
	                </selectparameters>
            </asp:SqlDataSource>
            <asp:GridView 
                ID="GridView1" 
                runat="server" 
                AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="RoundID" HeaderText="RoundID" InsertVisible="False" ReadOnly="True" SortExpression="RoundID" />
                    <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                    <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester" />
                    <asp:BoundField DataField="Round_Name" HeaderText="Round_Name" SortExpression="Round_Name" />
                    <asp:BoundField DataField="Start_Date" HeaderText="Start_Date" SortExpression="Start_Date" />
                    <asp:BoundField DataField="End_Date" HeaderText="End_Date" SortExpression="End_Date" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                </Columns>
            </asp:GridView>

        </ItemTemplate>

    </asp:Repeater>

    

</div> 

</asp:Content>
