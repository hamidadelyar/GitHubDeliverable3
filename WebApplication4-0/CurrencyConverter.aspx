<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CurrencyConverter.aspx.cs" Inherits="WebApplication4_0.CurrencyConverter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Currency Converter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
          Convert: &nbsp;
        <input type ="text" id = "US" runat = "server" value="3"/> &nbsp; U.S. dollars to <span id="Curren" runat="server"></span> <br /> <br />

        <select id="Currency" runat="server" />
        <input type = "submit" value = "OK" id = "Convert" runat = "server"  />
        <p style ="font-weight: bold" id="Result" runat = "server"></p>
        <input type ="submit" value="show graph" id="ShowGraph" runat="server"/>
       



    
    </div>
    </form>
</body>
</html>
