﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Admin.Master" Inherits="Hidistro.UI.Web.Admin.sales.Refund" Codebehind="Refund.aspx.cs" %>

<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>

<%@ Register TagPrefix="Kindeditor" Namespace="kindeditor.Net" Assembly="kindeditor.Net" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>
<%@ Import Namespace="Hidistro.Core" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server">
    <script src="order.helper.js" type="text/javascript"></script>
      <script type="text/javascript">
          function InitValidators() {
              initValid(new InputValidator('ctl00_contentHolder_lblOrderTotal', 1, 10, false, '^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$', '必须是正数'));
              initValid(new InputValidator('ctl00_contentHolder_lblAuditOrderTotal', 1, 10, false, '^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$', '必须是正数'));
          }
          $(document).ready(function () { InitValidators(); });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentHolder" runat="server">
    <!--选项卡-->
    <div class="dataarea mainwidth databody">
        <!--搜索-->
        <div class="title">
            <em>
                <img src="../images/05.gif" width="32" height="32" /></em>
            <h1>
                退款处理</h1>
            <span>对退款申请单进行退款操作</span>
        </div>
        <div class="datalist">
            <div class="searcharea clearfix br_search">
                <ul>
                    <li><span>订单编号：</span><span>
                        <asp:TextBox ID="txtOrderId" runat="server" CssClass="forminput" /><asp:Label ID="lblStatus"
                            runat="server" Style="display: none;"></asp:Label>
                    </span></li>
                    <li><span>处理状态：</span><span>
                        <abbr class="formselect">
                            <asp:DropDownList runat="server" ID="ddlHandleStatus">
                                <asp:ListItem Value="-1">所有状态</asp:ListItem>
                                <asp:ListItem Value="6">未退款</asp:ListItem>
                                <asp:ListItem Value="2">已退款</asp:ListItem>
                                 <asp:ListItem Value="8">拒绝退款</asp:ListItem>
                            </asp:DropDownList>
                        </abbr>
                    </span></li>                    
                    <li><span>退款时间：</span> <span>
                        <UI:WebCalendar runat="server" CssClass="forminput1" ID="txtStartTime" Width="100" />-</span>
                        <span> 
                        <UI:WebCalendar runat="server" CssClass="forminput1" ID="txtEndTime" Width="100"/>
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
            <input type="hidden" id="hidReturnsId" runat="server" />
             <input type="hidden" id="hidOrderId" runat="server" />
             <input type="hidden" id="hidProductId" runat="server" /> 
             <input type="hidden" id="hidStatus" runat="server" />
            <!--数据列表区域-->
            <div class="datalist">
                <asp:DataList ID="dlstRefund" runat="server" DataKeyField="ReturnsId" Width="100%">
                    <HeaderTemplate>
                        <table border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed">
                            <tr class="table_title">
                                <td width="4%" class="td_right td_left">
                                    选择
                                </td>
                                <td width="10%" class="td_right td_left">
                                    订单编号
                                </td>
                                <td width="6%" class="td_right td_left">
                                    会员名
                                </td>
                                <td width="90" class="td_right td_left">
                                    退款金额(元)
                                </td>
                                <td width="90" class="td_right td_left">
                                    订单金额(元)
                                </td>
                                <td width="90" class="td_right td_left">
                                    订单状态
                                </td>
                                <td width="8%" class="td_right td_left">
                                    申请时间
                                </td>
                                <td width="14%" class="td_right td_left">
                                    申请备注
                                </td>
                                <td width="80" class="td_right td_left">
                                    处理状态
                                </td>
                                <td width="8%" class="td_right td_left">
                                    处理时间
                                </td>
                                <td width="8%" class="td_right td_left">
                                    退款时间
                                </td>
                                <td width="12%" class="td_right td_left">
                                    管理员备注
                                </td> 
                                <td width="12%" class="td_right td_left">
                                    操作人员
                                </td>
                                <td width="8%" class="td_left td_right">
                                    操作
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <input name="CheckBoxGroup" type="checkbox" value='<%#Eval("ReturnsId") %>' />
                            </td>
                            <td>
                                &nbsp;<%# Eval("OrderId") %>
                            </td>
                            <td>
                                &nbsp;
                                <%# Eval("Username") %>
                            </td>
                            <td>
                                <Hi:FormatedMoneyLabel ID="lblOrderTotal" Money='<%#Eval("RefundMoney") %>' runat="server" />
                            </td>
                            <td>
                                <Hi:FormatedMoneyLabel ID="lblOrderTotalTwo" Money='<%#Eval("OrderTotal") %>' runat="server" />
                            </td>
                            <td>
                                <Hi:OrderStatusLabel ID="lblOrderStatus" OrderStatusCode='<%# Eval("OrderStatus") %>' runat="server" />
                            </td>
                            <td>
                                &nbsp;<%# Eval("ApplyForTime","{0:d}") %>
                            </td>
                            <td style="word-wrap: break-word">
                                &nbsp;<%# Eval("Comments")%>
                            </td>
                            <td>
                                <asp:Label ID="lblHandleStatus" runat="server" Text='<%# Eval("HandleStatus")%>'></asp:Label>
                            </td>
                            <td>
                                &nbsp;<%# Eval("HandleTime","{0:d}")%>
                            </td>
                            <td>
                                &nbsp;<%# Eval("RefundTime","{0:d}")%>
                            </td>
                            <td>
                                &nbsp;<%# Eval("AdminRemark")%>
                            </td>
                            <td>
                                &nbsp;<%# Eval("OperatorName")%>
                            </td>
                            <td>
                                <a href='<%# "ReturnsapplyDetail.aspx?ReturnsId="+Eval("ReturnsId") %>'>详情</a>
               
                                 <a href="javascript:void(0)"  style='<%# Eval("HandleStatus").ToString()=="5"||Eval("HandleStatus").ToString()=="6"?"":"display:none" %>'
                                    onclick="return CheckRefund('<%# Eval("ReturnsId") %>','<%# Eval("RefundMoney","{0:F2}") %>','<%# Eval("Comments")%>','<%# Eval("ProductId")%>','<%# Eval("OrderId")%>','<%# Eval("HandleStatus")%>')"  id="lkbtnCheckRefund"
                                     >退款</a>
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
    <!--审核-->
 <div id="CheckAudit" style="display: none;">
        <div class="frame-content" style="margin-top: -20px;">
          
            <table cellpadding="0" cellspacing="0" width="100%" border="0" class="fram-retreat">
                <tr>
                    <td align="right" width="30%">
                        退款号:
                    </td>
                    <td align="left" class="bd_td">
                        &nbsp;<asp:Label ID="lblAuditReturnsId" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        金额:
                    </td>
                    <td align="left" class="bd_td">
                        <%--<asp:Label ID="lblAuditOrderTotal" runat="server" />--%>
                          <asp:TextBox ID="lblAuditOrderTotal" runat="server" CssClass="forminput"></asp:TextBox>
                          <p id="ctl00_contentHolder_lblAuditOrderTotalTip" style="width:60px;">必须是正数</p>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        退款原因:
                    </td>
                    <td align="left" class="bd_td">
                        &nbsp;<asp:Label ID="lblAuditRefundRemark" runat="server"></asp:Label>
                    </td>
                </tr>
                
            </table>
          
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" id="Button1" onclick="javascript:auditRefund();" class="submit_DAqueding"
                    value="通过审核" />
                &nbsp;
                <input type="button" id="Button4" onclick="javascript:auditrefuseRefund();" class="submit_DAqueding"
                    value="不通过审核" />
            </div>
        </div>
    </div>
    <!--确认退款--->
    <div id="CheckRefund" style="display: none;">
        <div class="frame-content" style="margin-top: -20px;">
            <p>
                <em>执行本操作前确保：<br />
                    1.买家已付款完成，并确认无误； 2.确认买家的信息。</em></p>
            <table cellpadding="0" cellspacing="0" width="100%" border="0" class="fram-retreat">
                <tr>
                    <td align="right" width="30%">
                        退款号:
                    </td>
                    <td align="left" class="bd_td">
                        &nbsp;<asp:Label ID="lblReturnsId" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        金额:
                    </td>
                    <td align="left" class="bd_td">
                        <asp:TextBox ID="lblOrderTotal" runat="server" CssClass="forminput"></asp:TextBox>
                          <p id="ctl00_contentHolder_lblOrderTotalTip" style="width:60px;">必须是正数</p>
                      <%--  <asp:Label ID="lblOrderTotal" runat="server" />--%>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        退款原因:
                    </td>
                    <td align="left" class="bd_td">
                        &nbsp;<asp:Label ID="lblRefundRemark" runat="server"></asp:Label>
                    </td>
                </tr>
                
            </table>
            <p>
                <span class="frame-span frame-input100" style="margin-right: 10px;">管理员备注:</span>
                <span>
                    <asp:TextBox ID="txtAdminRemark" runat="server" CssClass="forminput" Width="243" /></span></p>
            <div style="text-align: center; padding-top: 10px;">
                <input type="button" id="Button2" onclick="javascript:acceptRefund();" class="submit_DAqueding"
                    value="确认退款" />
                &nbsp;
                <input type="button" id="Button3" onclick="javascript:refuseRefund();" class="submit_DAqueding"
                    value="拒绝退款" />
            </div>
        </div>
    </div>
    <div style="display: none">
        <input type="hidden" id="hidOrderTotal" runat="server" />
        <input type="hidden" id="hidRefundType" runat="server" />
        <input type="hidden" id="hidRefundMoney" runat="server" />
        <input type="hidden" id="hidAdminRemark" runat="server" /> <input type="hidden" id="hidRefundM" runat="server" />
        <input type="hidden" id="hidAuditM" runat="server" />
        <asp:Button ID="btnAcceptRefund" runat="server" CssClass="submit_DAqueding" Text="确认退款" />
        <asp:Button ID="btnRefuseRefund" runat="server" CssClass="submit_DAqueding" Text="拒绝退款" />

        <asp:Button ID="btnAuditAcceptRefund" runat="server" CssClass="submit_DAqueding" Text="确认审核" />
        <asp:Button ID="btnAuditRefuseRefund" runat="server" CssClass="submit_DAqueding" Text="拒绝审核" />
    </div>
</asp:Content>
