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
    

    <div id="leftDiv">
        <h1 style="margin-top:23px;">Current Round: 3, Semester 2 2014/2015</h1>
    </div>
    <div id="buttonsDiv">
         <input type="button" ID="endRound" Value="End Current Round" />
         <input type="button" ID="addRound" Value="Add New Round" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'" />
         

    </div>

    <asp:SqlDataSource ID="SqlDataSource3" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Announcements]">

    </asp:SqlDataSource>

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
        private void NewRound (object source, EventArgs e) {
          SqlDataSource2.Insert();
        }
    </script>

    <asp:SqlDataSource 
        ID="SqlDataSource2" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT DISTINCT [Year], [Semester] FROM [Rounds]"        
        InsertCommand="INSERT INTO [Rounds] ([Year],[Semester],[Round_Name],[Start_Date],[End_Date],[Status]) VALUES (@yearDB,@semesterDB,@RoundDB,GETDATE(),'','closed')">
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

            <table class="roundInfoTable">
                <tr>
                    <th>Round No</th><th>Start Date</th><th>End Date</th>
                </tr>
                <tr>
                    <td>1</td><td>12/10/2014</td><td>12/11/2014</td><td>Edit</td><td>Remove</td>
                </tr>
                <tr>
                    <td>2</td><td>14/11/2014</td><td>21/12/2014</td><td>Edit</td><td>Remove</td>
                </tr>
            </table>

        </ItemTemplate>

    </asp:Repeater>

    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        SelectCommand="SELECT * FROM [Rounds]">

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

</div> 

</asp:Content>
