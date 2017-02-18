﻿using Hidistro.Core;
using Hidistro.Core.Entities;
using Hidistro.Core.Enums;
using Hidistro.Entities.Members;
using Hidistro.SaleSystem.Vshop;
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

          

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SiteSettings masterSettings = SettingsManager.GetMasterSettings(false);
            HttpCookie cookie = new HttpCookie("Vshop-Member", txtOpenUser.ToString());
            HttpContext.Current.Request.Cookies.Set(cookie);


            int UserId = int.Parse(txtDistribute.Text);
            MemberInfo member = MemberProcessor.GetMember(UserId);
            int ReferralUserId = member.ReferralUserId;
            DistributorsInfo distributorsInfo = new DistributorsInfo()
            {
                UserId = UserId,
                GradeId = 1,
                ReferralUserId = ReferralUserId,
                ParentUserId = ReferralUserId,
                RequestAccount = "",
                StoreName = "测试" + InviteBrowser.getRandomizer(4, false, false, true, false) + "的XXX",
                StoreDescription = "",
                BackImage = "",
                Logo = "",
                UserName = "测试人",
                RealName = "真是姓名",
                CellPhone = "",
                DistriGradeId = DistributorGradeBrower.GetIsDefaultDistributorGradeInfo().GradeId,
                InvitationNum = masterSettings.DefaultMinInvitationNum,
                CreateTime = DateTime.Now,
                IsTempStore = 0,
                DecasualizationTime = DateTime.Now
            };
            var t = DistributorsBrower.AddDistributors(distributorsInfo);
            XTrace.WriteLine(t.ToString());
            Response.Write("nice");
        }
    }
}