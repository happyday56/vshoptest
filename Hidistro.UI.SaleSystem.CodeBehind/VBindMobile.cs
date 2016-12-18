using Hidistro.Entities.Members;
using Hidistro.SaleSystem.Vshop;
using Hidistro.UI.Common.Controls;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
 

namespace Hidistro.UI.SaleSystem.CodeBehind
{
    [ParseChildren(true), WeiXinOAuth(Common.Controls.WeiXinOAuthPage.VBindMobile)]
    public class VBindMobile : VWeiXinOAuthTemplatedWebControl
    {


        protected override void AttachChildControls()
        {
            string url = this.Page.Request.QueryString["returnUrl"]==null?"": this.Page.Request.QueryString["returnUrl"];
         
            HtmlInputText btn1 = (HtmlInputText)this.FindControl("returnUrl");
            btn1.Value = url;
            PageTitle.AddSiteNameTitle("完善个人信息");
        }

        protected override void OnInit(EventArgs e)
        {
            if (this.SkinName == null)
            {
                this.SkinName = "Skin-vBindMobile.html";
            }
            base.OnInit(e);
        }
    }
}
