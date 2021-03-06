﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DistributorSaleStatistics.aspx.cs" Inherits="Hidistro.UI.Web.Admin.DistributorSaleStatistics" %>

<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>

<%@ Register TagPrefix="Kindeditor" Namespace="kindeditor.Net" Assembly="kindeditor.Net" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentHolder" runat="server">

    <div class="dataarea mainwidth databody">
        <div class="title">
            <em>
                <img src="../images/04.gif" width="32" height="32" /></em>
            <h1>分销商销售统计</h1>
            <span></span>
        </div>
        <div class="searcharea clearfix br_search">
            <li><span>日期：</span><span><UI:WebCalendar ID="calendarStart" runat="server" class="forminput" /></span><span class="Pg_1010">至</span><span><UI:WebCalendar ID="calendarEnd" runat="server" class="forminput" IsStartTime="false" /></span></li>
            <li><span>分销等级：</span>
                <abbr class="formselect">
                    <Hi:DistributorGradeDropDownList ID="DrGrade" runat="server" AllowNull="true" NullToDisplay="全部" />
                </abbr>
                </span></li>
            <li><span>店铺名称：</span> <span>
                <asp:TextBox ID="txtStoreName" CssClass="forminput" runat="server" /></span>
            </li>
            <li><span>店主名称：</span> <span>
                <asp:TextBox ID="txtUserName" CssClass="forminput" runat="server" /></span>
            </li>

            <li>
                <asp:Button ID="btnSearch" runat="server" class="searchbutton" Text="查询" /></li>
            <li>
        </div>
        <!--搜索-->
        <div class="btn">
            <h3>按年统计</h3>
        </div>
        <!--结束-->
        <div>
            <!--数据列表区域-->
            <div class="datalist">
                <div class="searcharea clearfix br_search">
                    <ul class="a_none_left">
                        <li><span>请选择：</span>
                            <abbr class="formselect">
                                <Hi:YearDropDownList ID="dropYearForYear" runat="server" />
                            </abbr>
                            <samp class="colorR">&nbsp;年</samp>
                        </li>
                        <li>
                            <asp:Button ID="btnQueryYearSaleTotal" runat="server" class="searchbutton" Text="查询" /></li>
                        <li>
                            <li>
                                <p>
                                    <asp:LinkButton ID="btnCreateReportOfYear" runat="server" Text="导出数据" />
                                </p>
                            </li>
                    </ul>
                </div>
                <UI:Grid ID="grdYearSaleTotalStatistics" runat="server" ShowHeader="true" AutoGenerateColumns="false" HeaderStyle-CssClass="table_title" GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField HeaderText="年份" DataField="OrderYear" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店铺名称" DataField="StoreName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主名称" DataField="UserName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主等级" DataField="DistributorGradeName" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售金额" DataField="Amount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="优惠金额" DataField="DiscountAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="金币抵扣" DataField="RedPagerAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="实际付款金额" DataField="OrderTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="成本金额" DataField="OrderCostPrice" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="利润" DataField="OrderProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="佣金" DataField="CommTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售佣金" DataField="NormalIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="推荐佣金" DataField="RecommendIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="毛利" DataField="GrossProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="新增店铺数" DataField="StoreCnt" HeaderStyle-CssClass="td_right td_left" />
                    </Columns>
                </UI:Grid>
            </div>
        </div>

        <div class="btn">
            <h3>按月统计</h3>
        </div>
        <!--结束-->
        <div>
            <!--数据列表区域-->
            <div class="datalist">
                <div class="searcharea clearfix br_search">
                    <ul class="a_none_left">
                        <li><span>请选择：</span>
                            <abbr class="formselect">
                                <Hi:YearDropDownList ID="dropMonthForYaer" runat="server" />
                            </abbr>
                            <samp class="colorR">&nbsp;年</samp>
                        </li>

                        <li>
                            <asp:Button ID="btnQueryMonthSaleTotal" runat="server" class="searchbutton" Text="查询" /></li>
                        <li>
                            <p>
                                <asp:LinkButton ID="btnCreateReportOfMonth" runat="server" Text="导出数据" />
                            </p>
                        </li>
                    </ul>
                </div>
                <UI:Grid ID="grdMonthSaleTotalStatistics" runat="server" ShowHeader="true" AutoGenerateColumns="false" HeaderStyle-CssClass="table_title" GridLines="None" Width="100%">
                    <Columns>

                        <asp:BoundField HeaderText="月份" DataField="OrderMonth" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店铺名称" DataField="StoreName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主名称" DataField="UserName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主等级" DataField="DistributorGradeName" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售金额" DataField="Amount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="优惠金额" DataField="DiscountAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="金币抵扣" DataField="RedPagerAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="实际付款金额" DataField="OrderTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="成本金额" DataField="OrderCostPrice" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="利润" DataField="OrderProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="佣金" DataField="CommTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售佣金" DataField="NormalIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="推荐佣金" DataField="RecommendIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="毛利" DataField="GrossProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="新增店铺数" DataField="StoreCnt" HeaderStyle-CssClass="td_right td_left" />
                    </Columns>
                </UI:Grid>

            </div>
        </div>
        <div>
            <div class="btn">
                <h3>按日统计</h3>
            </div>
            <!--数据列表区域-->
            <div class="datalist">
                <div class="searcharea clearfix br_search">
                    <ul class="a_none_left">
                        <li><span>请选择：</span></li>
                        <li>
                            <abbr class="formselect">
                                <Hi:YearDropDownList ID="dropDayForYear" runat="server" />
                            </abbr>
                            <samp class="colorR">年</samp>
                        </li>
                        <li>
                            <abbr class="formselect">
                                <Hi:MonthDropDownList ID="dropMoth" runat="server" />
                            </abbr>
                            <samp class="colorR">月</samp></li>
                        <li>
                            <asp:Button ID="btnQueryDaySaleTotal" runat="server" Text="查询" class="searchbutton" />
                        </li>
                        <li>
                            <p>
                                <asp:LinkButton ID="btnCreateReportOfDay" runat="server" Text="导出数据" />
                            </p>
                        </li>
                    </ul>
                </div>
                <asp:GridView ID="grdDaySaleTotalStatistics" runat="server" ShowHeader="true" AutoGenerateColumns="false" HeaderStyle-CssClass="table_title" GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField HeaderText="日" DataField="OrderDay" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店铺名称" DataField="StoreName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主名称" DataField="UserName" HeaderStyle-CssClass="td_right td_left" />
                        <asp:BoundField HeaderText="店主等级" DataField="DistributorGradeName" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售金额" DataField="Amount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="优惠金额" DataField="DiscountAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="金币抵扣" DataField="RedPagerAmount" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="实际付款金额" DataField="OrderTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="成本金额" DataField="OrderCostPrice" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="利润" DataField="OrderProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="佣金" DataField="CommTotal" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="销售佣金" DataField="NormalIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="推荐佣金" DataField="RecommendIncome" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="毛利" DataField="GrossProfit" HeaderStyle-CssClass="td_right td_left" />
                        <Hi:MoneyColumnForAdmin HeaderText="新增店铺数" DataField="StoreCnt" HeaderStyle-CssClass="td_right td_left" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>
    </div>
    <div class="databottom"></div>
    <div class="bottomarea testArea">
        <!--顶部logo区域-->
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="validateHolder" runat="server">
</asp:Content>

