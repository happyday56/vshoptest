<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="web2.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
         <asp:TextBox ID="txtOpenUser" runat="server" Visible="false"></asp:TextBox>
        订单号 <asp:TextBox ID="txtDistribute" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="处理没有返利的" OnClick="Button1_Click" />
    </div>
    </form>
</body>
</html>
