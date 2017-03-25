using Hidistro.Core;
using Hidistro.Core.Entities;
using Hidistro.Core.Enums;
using Hidistro.Entities.Commodities;
using Hidistro.Entities.Members;
using Hidistro.Entities.Orders;
using Hidistro.SaleSystem.Vshop;
using Hidistro.SqlDal.Commodities;
using NewLife.Log;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace web2
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write(ProductFeature.Seckill.ToInt());

            //ProductDao dao2 = new ProductDao();
            //ProductInfo productDetails = dao2.GetProductDetails(18);
            //productDetails.SaleCounts += 1;
            //productDetails.ShowSaleCounts += 1;
            //dao2.UpdateProduct(productDetails, null);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //SiteSettings masterSettings = SettingsManager.GetMasterSettings(false);
            //HttpCookie cookie = new HttpCookie("Vshop-Member", txtOpenUser.ToString());
            //HttpContext.Current.Request.Cookies.Set(cookie);


            //int UserId = int.Parse(txtDistribute.Text);
            //MemberInfo member = MemberProcessor.GetMember(UserId);
            //int ReferralUserId = member.ReferralUserId;
            //DistributorsInfo distributorsInfo = new DistributorsInfo()
            //{
            //    UserId = UserId,
            //    GradeId = 1,
            //    ReferralUserId = ReferralUserId,
            //    ParentUserId = ReferralUserId,
            //    RequestAccount = "",
            //    StoreName = "测试" + InviteBrowser.getRandomizer(4, false, false, true, false) + "的XXX",
            //    StoreDescription = "",
            //    BackImage = "",
            //    Logo = "",
            //    UserName = "测试人",
            //    RealName = "真是姓名",
            //    CellPhone = "",
            //    DistriGradeId = DistributorGradeBrower.GetIsDefaultDistributorGradeInfo().GradeId,
            //    InvitationNum = masterSettings.DefaultMinInvitationNum,
            //    CreateTime = DateTime.Now,
            //    IsTempStore = 0,
            //    DecasualizationTime = DateTime.Now
            //};
            //var t = DistributorsBrower.AddDistributors(distributorsInfo);
            //XTrace.WriteLine(t.ToString());
            //Response.Write("nice");

            string orderId = txtDistribute.Text;
            if (string.IsNullOrEmpty(orderId)) { Response.Write("请输入订单号"); }
            else
            {
                OrderInfo orderInfo = ShoppingProcessor.GetOrderInfo(orderId);
                if (null != orderInfo)
                {
                    // 订单付款完成后计算提成
                    //DistributorsBrower.CalcCommissionByBuy(orderInfo);
                    XTrace.WriteLine("开始计算订单佣金SubmitCalCommission------订单ID：" + orderId);
                    DistributorsBrower.UpdateCalculationCommissionNew(orderInfo);

                    Response.Write(orderId + "订单处理完成");
                }

            }

        }
    }
}