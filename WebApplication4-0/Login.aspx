<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication4_0.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/LoginStyle.css" rel="stylesheet" /> 
    <link href='http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Open+Sans:400,300,600,700' rel='stylesheet' type='text/css' />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login Page</title>
</head>
<body>
  
    <div class="main">
        <div class="user">
            <img src="Images/user.png" alt=""/>
        </div>

        <div class="login">
            <div class="inset">
                <form id="form1" runat="server">
                    <div>
                        <span><label>Username</label></span>
                        <span>
                           <asp:TextBox ID="TextboxUsername" runat="server" class="textbox"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a username" ControlToValidate="TextboxUsername" ForeColor="Red"></asp:RequiredFieldValidator>   
                        </span>
                    </div>
                    <div>
                        <span><label>Password</label></span>
                        <span>
                             <asp:TextBox ID="TextboxPassword" runat="server" TextMode="Password" class="password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter a password" ControlToValidate="TextboxPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                        </span>
                    </div>
                    <div class="sign">
                        <div class="submit">
                            <asp:Button ID="ButtonLogin" runat="server" Text="Login" OnClick="ButtonLogin_Click" />
                        </div>
                    </div>
                    <span class="forget-pass">
                        <a href="#">Forgot Password?</a>
                    </span>
                    <div class="clear"></div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
