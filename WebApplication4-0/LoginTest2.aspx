<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginTest2.aspx.cs" Inherits="WebApplication4_0.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/LoginStyle.css" rel="stylesheet" /> 
    <title>Login</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 234px;
        }
        .auto-style3 {
            width: 234px;
            text-align: right;
        }
        .auto-style4 {
            width: 275px;
        }
    </style>
</head>
<body>


 
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">Username:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="TextboxUsername" runat="server" OnTextChanged="TextBox1_TextChanged" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextboxUsername" ErrorMessage="Please enter a username" style="color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Password:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="TextboxPassword" runat="server" OnTextChanged="TextBox2_TextChanged" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextboxPassword" ErrorMessage="Please enter a password" style="color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="ButtonLogin" runat="server" OnClick="ButtonLogin_Click" Text="Login" Width="99px" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
      

        <p id="Result" runat="server"></p>

      


    
</body>
</html>
