<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginTest.aspx.cs" Inherits="WebApplication4_0.LoginTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: right;
            width: 296px;
        }
        .auto-style3 {
            width: 296px;
        }
        .auto-style4 {
            width: 197px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
    
        <h1>Login</h1>
    
    </div>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">Username&nbsp;&nbsp;&nbsp; </td>
                <td class="auto-style4">
                    <asp:TextBox ID="TextboxUsername" runat="server" OnTextChanged="TextBox1_TextChanged" style="text-align: center" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextboxUsername" ErrorMessage="Please enter a username" style="color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Password&nbsp;&nbsp;&nbsp; </td>
                <td class="auto-style4">
                    <asp:TextBox ID="TextboxPassword" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextboxPassword" ErrorMessage="Please enter a password" style="color: #FF0000"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" style="text-align: center" Text="Button" Width="97px" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
