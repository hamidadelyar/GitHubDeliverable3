<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
</script>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title></title>    
    <style type="text/css">
        #form1 {
            text-align: center;
        }
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 214px;
        }
        .auto-style3 {
            width: 214px;
            text-align: right;
        }
        .auto-style4 {
            width: 214px;
            text-align: right;
            height: 26px;
        }
        .auto-style5 {
            height: 26px;
            width: 260px;
        }
        .auto-style6 {
            height: 26px;
            width: 174px;
        }
        .auto-style7 {
            width: 174px;
        }
        .auto-style8 {
            width: 260px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">   
        Blank<table class="auto-style1">
            <tr>
                <td class="auto-style4">UserName</td>
                <td class="auto-style6">
                    <asp:TextBox ID="TextboxUsername" runat="server" style="text-align: center" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style5">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextboxUsername" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Password</td>
                <td class="auto-style7">
                    <asp:TextBox ID="TextboxPassword" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style8">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextboxPassword" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style8">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style8">&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
