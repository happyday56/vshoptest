<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"    Inherits="Hidistro.UI.Web.Admin.product.EditVirtualPointRate" %>
<%@ Import Namespace="Hidistro.Core"%>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="validateHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentHolder" runat="server">
<div class="dataarea mainwidth databody">
	<div class="title"> <em><img src="../images/01.gif" width="32" height="32" /></em>
	    <h1 class="title_line">批量修改商品金贝使用率</h1>
	    <span class="font">您可以对已选的这些商品的金贝使用率直接改成某个值，或增加/减少某个值，也可以手工输入您想要的金贝使用率后在页底处保存设置</span>
    </div>

    <div class="searcharea clearfix">
        <ul>
            <li>将原金贝使用率改为：<asp:TextBox ID="txtTagetVirtualPointRate" runat="server" Width="80px" /></li>
            <li><asp:Button ID="btnTargetOK" runat="server" Text="确定" CssClass="searchbutton"/></li>
            <li>将原金贝使用率增加(输入负数为减少)：<asp:TextBox ID="txtAddVirtualPointRate" runat="server" Width="80px" /></li>
			<li><asp:Button ID="btnOperationOK" runat="server" Text="确定" CssClass="searchbutton"/></li>
		</ul>
     </div>

    <div class="datalist">
	        <UI:Grid ID="grdSelectedProducts" DataKeyNames="ProductId" runat="server" ShowHeader="true" AutoGenerateColumns="false" HeaderStyle-CssClass="table_title" CssClass="goods-list" GridLines="None" Width="100%">
                <Columns>    
                     <asp:TemplateField HeaderText="商品图片" ItemStyle-Width="5%" HeaderStyle-CssClass="td_right td_left">
                        <ItemTemplate>
                               <a href='<%#"/vshop/ProductDetails.aspx?productId="+Eval("ProductId")%>' target="_blank">
                                        <Hi:ListImage ID="ListImage1"  runat="server" DataField="ThumbnailUrl40"/>      
                                 </a> 
                        </ItemTemplate>
                    </asp:TemplateField>             
                    <asp:TemplateField HeaderText="商品名称" ItemStyle-Width="30%" HeaderStyle-CssClass="td_right td_left">
                        <ItemTemplate>
                            <%#Eval("ProductName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="商家编码" ItemStyle-Width="10%" HeaderStyle-CssClass="td_right td_left">
                        <ItemTemplate>  
                             <%#Eval("ProductCode") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="金贝使用率" HeaderStyle-Width="10%" HeaderStyle-CssClass="td_right td_left">
                        <ItemTemplate>
                            <asp:TextBox ID="txtVirtualPointRate" runat="server" Width="80px" Text = '<%#Eval("VirtualPointRate") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>   
                    </Columns>
                </UI:Grid>
    </div>        
              
     <div class="Pg_15 Pg_010" style="text-align:center;"><asp:Button ID="btnSaveVirtualPointRate" runat="server" OnClientClick="return PageIsValid();" Text="保存设置"  CssClass="submit_DAqueding"/></div>
</div>
    <script>
        function CloseWindow() {
            var win = art.dialog.open.origin; //来源页面
            // 如果父页面重载或者关闭其子对话框全部会关闭
            win.location.reload();
        }

        //return false;
</script>
</asp:Content>
