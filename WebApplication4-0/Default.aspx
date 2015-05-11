<%@ Page Title="Login Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication4_0._Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <link href="Content/LoginStyle.css" rel="stylesheet" /> 
    <link href='http://fonts.googleapis.com/css?family=Oxygen:400,300,700|Open+Sans:400,300,600,700' rel='stylesheet' type='text/css' />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login Page</title>
</head>
<body>
  
    <p class="rotate">Loughborough University Timetabling System</p>
    <div class="main">
        <div class="user">
            
           <!-- <span style="color:white; font-family:'Open Sans', sans-serif; font-size:1.1em; font-weight:600"> Loughborough University Timetabling System </span> -->
            <img style="border:1px, dashed, white" src="./Images/user.png" alt="userpic"/>
        </div>

        <div class="login">
            <div class="inset">
                <form id="form1" runat="server">
                    <div>
                        <span><label>Username</label></span>
                        <span>
                           <asp:TextBox ID="TextboxUsername" runat="server" class="textbox"></asp:TextBox>
                           <span style="text-align:center">
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a username" ControlToValidate="TextboxUsername" ForeColor="Red"></asp:RequiredFieldValidator>
                           </span>
                        </span>
                    </div>
                    <div>
                        <span><label>Password</label></span>
                        <span>
                            <asp:TextBox ID="TextboxPassword" runat="server" TextMode="Password" class="password"></asp:TextBox>
                            <span style="text-align:center">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter a password" ControlToValidate="TextboxPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                            </span>
                        </span>
                    </div>
                    <div class="sign">
                        <div class="submit">
                            <asp:Button ID="ButtonLogin" runat="server" Text="Login" OnClick="ButtonLogin_Click" />
                        </div>
                    </div>
                    <span class="forget-pass">
                        <a href="ForgotPassword.aspx">Forgot Password?</a>
                    </span>
                    <div class="clear"></div>
                    <p id="LoginErrorMessage" runat="server" style=""></p>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

