﻿<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSendNote.aspx.cs" Inherits="Hidistro.UI.Web.Admin.sales.ManageSendNote" %>
<%@ Import Namespace="Hidistro.Core" %>
<%@ Import Namespace="Hidistro.Entities.Sales" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="validateHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentHolder" runat="server">
    <!--选项卡-->
    <div class="dataarea mainwidth databody">
        <!--搜索-->
        <div class="title">
            <em>
                <img src="../images/05.gif" width="32" height="32" /></em>
            <h1>
               发货单</h1>
            <span>对发货单进行管理</span>
        </div>
        <div class="datalist">
            <div class="searcharea clearfix br_search">
                <ul>
                    <li><span>订单编号：</span><span>
                        <asp:TextBox ID="txtOrderId" runat="server" CssClass="forminput" /><asp:Label ID="lblStatus"
                            runat="server" Style="display: none;"></asp:Label>
                    </span></li>
                    
                    <li><span>物流单号：</span> <span>
                        <asp:TextBox ID="txtExpressNo" CssClass="forminput" runat="server" /></span>
                    </li>
                    <li><span>收货人：</span> <span>
                        <asp:TextBox ID="txtShipTo" CssClass="forminput" runat="server" /></span>
                    </li>
                    <li><span>发货时间：</span> <span>
                        <UI:WebCalendar runat="server"   CssClass="forminput1" ID="txtStartTime" Width="100" />-</span>
                        <span> 
                        <UI:WebCalendar runat="server"   CssClass="forminput1" ID="txtEndTime" Width="100"/>
                        </span>
                    </li>
                    <li>
                        <asp:Button ID="btnSearchButton" runat="server" class="searchbutton" Text="查询" />
                    </li>
                    <li>
                        <asp:LinkButton ID="btnCreateReport" runat="server" Text="导出" />
                    </li>
                </ul>
            </div>
            <!--结束-->
            <div class="functionHandleArea clearfix m_none">
                <!--分页功能-->
                <div class="pageHandleArea">
                    <ul>
                        <li class="paginalNum"><span>每页显示数量：</span><UI:PageSize runat="server" ID="hrefPageSize" />
                        </li>
                    </ul>
                </div>
                <div class="pageNumber">
                    <div class="pagination">
                        <UI:Pager runat="server" ShowTotalPages="false" ID="pager1" />
                    </div>
                </div>
                <!--结束-->
                <div class="blank8 clearfix">
                </div>
                <div class="batchHandleArea">
                    <ul>
                        <li class="batchHandleButton"><span class="signicon"></span><span class="allSelect">
                            <a href="javascript:void(0)" onclick="SelectAll()">全选</a></span> <span class="reverseSelect">
                                <a href="javascript:void(0)" onclick=" ReverseSelect()">反选</a></span> <span class="delete">
                                    <Hi:ImageLinkButton ID="lkbtnDeleteCheck" runat="server" Text="删除" IsShow="true" />
                                </span></li>
                    </ul>
                </div>
            </div>
            <input type="hidden" id="hidOrderId" runat="server" />
            <!--数据列表区域-->
            <div class="datalist">
                <asp:DataList ID="dlstSendNote" runat="server" DataKeyField="NoteId" Width="100%">
                    <HeaderTemplate>
                        <table width="0" border="0" cellspacing="0">
                            <tr class="table_title">
                                <td width="5%" class="td_right td_left">
                                    选择
                                </td>
                                <td width="10%" class="td_right td_left">
                                    订单号
                                </td>
                                <td width="8%" class="td_right td_left">
                                    订单金额(元)
                                </td>
                                <td>
                                    发货时间
                                </td>
                                <td width="8%" class="td_right td_left">
                                    会员昵称
                                </td>
                                <td>
                                    物流公司                                    
                                </td>
                                <td width="10%" class="td_right td_left">
                                    物流单号
                                </td>
                                <td>
                                    收货人                                    
                                </td>
                                <td>
                                    联系电话
                                </td>
                                <td>
                                    收货地址                                    
                                </td>
                                <td>
                                    操作员
                                </td>
                                
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <input name="CheckBoxGroup" type="checkbox" value='<%#Eval("NoteId") %>' />
                            </td>
                            <td>
                                <%# Eval("OrderId") %>
                            </td>
                            <td>
                                <Hi:FormatedMoneyLabel ID="lblOrderTotal" Money='<%#Eval("OrderTotal") %>' runat="server" />
                            </td>  
                            <td>
                                <%# Eval("ShippingDate")%>
                            </td>
                            <td>
                                <%# Eval("Username")%>
                            </td>
                            <td>
                                <%# Eval("ExpressCompanyName")%>
                            </td>
                            <td>
                                <%# Eval("ShipOrderNumber")%>
                            </td>
                            <td>
                                <%# Eval("ShipTo")%>
                            </td>
                            <td>
                                <%# Eval("CellPhone")%>
                            </td>
                            <td>
                                <%# Eval("ShippingRegion")%>&nbsp;<%# Eval("Address")%>
                            </td>
                            <td>
                                <%# Eval("Operator")%>
                            </td>
                            
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:DataList>
                <div class="blank5 clearfix">
                </div>
            </div>
        </div>
        <!--数据列表底部功能区域-->
        <div class="page">
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
    </div>
</asp:Content>
