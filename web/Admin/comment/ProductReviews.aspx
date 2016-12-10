﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Hidistro.UI.Web.Admin.ProductReviews" MasterPageFile="~/Admin/Admin.Master" %>
<%@ Import Namespace="Hidistro.Core"%>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>

<%@ Register TagPrefix="Kindeditor" Namespace="kindeditor.Net" Assembly="kindeditor.Net" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentHolder" runat="server">

    <div class="dataarea mainwidth databody">
  <div class="title">
  <em><img src="../images/07.gif" width="32" height="32" /></em>
  <h1>商品评论管理</h1>
  <span>管理店铺的所有商品评论，您可以查询或删除商品评论 </span>
</div>

		<!--数据列表区域-->
		<div class="datalist">
				<!--搜索-->
		<div class="searcharea clearfix br_search">
			<ul>
				<li><span>商品名称：</span><span>
				  <asp:TextBox ID="txtSearchText" runat="server"  CssClass="forminput" />
			  </span></li>
				<li>
					<abbr class="formselect">
					  商品分类：<Hi:ProductCategoriesDropDownList ID="dropCategories" runat="server"  style="padding:5px 0px; width:153px;"/>
					</abbr>
				</li>
				<li>
				<span>商家编码：</span><span><asp:TextBox ID="txtSKU"  CssClass="forminput" runat="server"></asp:TextBox></span></li>
				<li><asp:Button ID="btnSearch" runat="server" class="searchbutton" Text="搜索" /></li>
			</ul>
	</div>
		<!--结束-->
		<div class="functionHandleArea m_none">
		  <!--分页功能-->
		  <div class="pageHandleArea">
		    <ul>
				<li class="paginalNum"><span>每页显示数量：</span><UI:PageSize runat="server" ID="hrefPageSize" /></li>
			</ul>
	      </div>
		<div class="pageNumber">
			<div class="pagination">
				<UI:Pager runat="server" ShowTotalPages="false" ID="pager1" />
				</div>
			</div>	
		  <!--结束-->
		  <div class="blank8 clearfix"></div>
		  
		  
    </div>
		   <asp:DataList ID="dlstPtReviews" runat="server" DataKeyField="ReviewId" Style="width:100%;" >
                <HeaderTemplate>
                    <table cellspacing="0px" border="0"  >
                        <tr class="table_title">
                            <td width="200" class="td_right td_left"> 评论商品 </td>
                            <td width="100" class="td_right td_left"> 评论人</td>
                            <td class="td_right td_left"> 评论内容</td>
                            <td width="130" class="td_right td_left"> 评论时间 </td>
                            <td width="50" class="td_left td_right_fff"> 操作 </td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                      <td ><span class="Name"><a href='<%#string.Format("../../vshop/ProductDetails.aspx?productId={0}",Eval("productId"))%>' target="_blank"><asp:Literal ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>' /></a></span></td>
                      <td><span  class="Name"> <a href="javascript:DialogFrame('<%# Globals.GetAdminAbsolutePath(string.Format("/member/MemberDetails.aspx?userId={0}",Eval("UserId"))) %>','查看会员详细信息',null,null)"><asp:Label ID="lblName" runat="server" Text='<%# Eval("UserName") %>' /></a></span></td>
                      <td >
                          <asp:Label ID="lblText" runat="server" Text='<%#  Eval("ReviewText") %>' CssClass="line" style="display:block;width:100%"></asp:Label> 
                          <span class="p" style="text-align:left"><strong class="colorE">回复：</strong><asp:Label ID="Label1" runat="server" Text='<%# Eval("ReplyText") %>' CssClass="line"></asp:Label></span><span style="text-align:left">回复时间：<Hi:FormatedTimeLabel ID="FormatedTimeLabel1" Time='<%# Eval("ReplyDate") %>'
                                    runat="server"></Hi:FormatedTimeLabel> </span>
                      </td>
                      <td><Hi:FormatedTimeLabel ID="ConsultationDateTime" Time='<%# Eval("ReviewDate") %>' runat="server" /></td>
                      <td>
                          <span class="submit_fuihu"><a href="javascript:DialogFrame('<%# Globals.GetAdminAbsolutePath(string.Format("/comment/ReplyProductReviews.aspx?ReviewId={0}", Eval("ReviewId")))%>','回复客户评价',null,null)">回复</a></span>
                          <span class="submit_shanchu"><Hi:ImageLinkButton ID="btnReviewDelete" runat="server" CommandName="Delete" IsShow="true" CommandArgument='<%# Eval("ReviewId")%>' Text="删除" /></span>
                      </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:DataList>
		  <div class="blank12 clearfix"></div>
		</div>
        
		<!--数据列表底部功能区域-->  
		<!--翻页-->
	 <div class="page">
		<div class="bottomPageNumber clearfix">
			<div class="pageNumber">
				<div class="pagination">
				<UI:Pager runat="server" ShowTotalPages="true" ID="pager" />
			</div>
			</div>
		</div>
		</div>
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="validateHolder" runat="server"></asp:Content>

