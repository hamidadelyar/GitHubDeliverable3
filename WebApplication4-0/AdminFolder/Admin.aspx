<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication4_0.Admin" MasterPageFile="~/AdminFolder/AdminSite.master" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="css/AdminStyle.css"> 

    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>

	
    <link rel="stylesheet" href="css/style.css"> 
    <!-- Resource style -->
	
    <script src="js/modernizr.js"></script> 
    <!-- Modernizr -->
  	


    <div class="contentHolder">
        <h1 align="center">Welcome, Admin.</h1>

        <div class="updatesHolder">
            <h2 class="white" align="center">New Requests:</h2>
            <p class="white" align="center">There are currently no new requests.</p>
            <br />
            <br />
        </div>
                <table id="newsTable">
                    <tr>
                        <th colspan="4"  style="text-align:center;">News & Announcements</th>
                    </tr>
                    <tr>
                        <td>Round 1 Has Started</td><td>13/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                    <tr>
                        <td>AD Hoc Round Has Started</td><td>10/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                    <tr>
                        <td>Tips for Creating Requests</td><td>04/03/2015</td><td>Edit</td><td>Remove</td>
                    </tr>
                </table>
            
    <script runat="server">
        private void NewAnnouncement (object source, EventArgs e) {
          SqlDataSource1.Insert();
        }
    </script>


    <asp:SqlDataSource 
        ID="SqlDataSource1" 
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:team02ConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:team02ConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [announcementID], [postDate], [title], [content] FROM [Announcements]"
        InsertCommand="INSERT INTO Announcements (title, content, postDate) VALUES (@titleDB,@contentDB,GETDATE())">
            <InsertParameters>
                <asp:FormParameter name="titleDB" FormField="titleInput" />
                <asp:FormParameter name="contentDB" FormField="contentInput" />
            </InsertParameters>
    </asp:SqlDataSource>

    <br />
    <asp:TextBox ID="titleInput" runat="server"></asp:TextBox>

    <asp:RequiredFieldValidator
        id="RequiredFieldValidator1"
        runat="server"
        ControlToValidate="titleInput"
        Display="Static"
        ErrorMessage="Please Enter a Title"/>

    <br />
    <asp:TextBox ID="contentInput" runat="server"></asp:TextBox>

    <asp:RequiredFieldValidator
        id="RequiredFieldValidator2"
        runat="server"
        ControlToValidate="contentInput"
        Display="Static"
        ErrorMessage="Please Enter some Content"/>

    <br />
    <asp:Button ID="Button1" runat="server" Text="New Announcement" OnClick="NewAnnouncement" />


            
    </div>

</asp:Content>