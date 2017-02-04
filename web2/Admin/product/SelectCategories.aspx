<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"  Inherits="Hidistro.UI.Web.Admin.SelectCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="server">
    <link id="cssLink" rel="stylesheet" href="../css/style.css" type="text/css" media="screen" />
    <style type="text/css">
        .results_pos{position:relative;overflow:hidden;background:red;float:left;width:891px;background:#e5f0ff;border:1px solid #c7deff;border-left:0;height:298px;}
        .results_ol{position:absolute;display:block;overflow:hidden;width:2250px;clear:both;left:0px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentHolder" runat="server">
<div class="dataarea mainwidth td_top_ccc">
<div class="advanceSearchArea clearfix"></div>
<div class="toptitle"> <em><img src="../images/03.gif" width="32" height="32" /></em>
  <h1 class="title_height">请选择投放的分类</h1>
</div>
 
      
    <div class="results">
        <div class="results_main">
            
            <div class="results_pos">
                <ol class="results_ol">
                </ol>
            </div>
           
        </div>
    </div>
    <div class="results_img"></div>
    <div class="results_bottom">
        <span class="spanE">你当前选择的是：</span>
        <span id="fullName"></span>
    </div>
 </div>   
 <div class="databottom"></div>
	<div class="bntto">
	  <input type="submit" name="button2" id="btnNext" value="确定" class="submit_DAqueding"/>

         <input type="submit" name="button2" id="btnClose" value="关闭" class="submit_DAqueding"/>

      <input id="categoryId" value="" type="hidden"/>
        <input id="categoryPath" value="" type="hidden"/>
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="validateHolder" runat="server">
    <script type="text/javascript" src="category.helper.js"></script>
</asp:Content>
