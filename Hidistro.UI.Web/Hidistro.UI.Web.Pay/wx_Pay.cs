using Hidistro.Core;
using Hidistro.Core.Entities;
using Hidistro.Entities.Members;
using Hidistro.Entities.Orders;
using Hidistro.Messages;
using Hidistro.SaleSystem.Vshop;
using Hishop.Weixin.Pay;
using Hishop.Weixin.Pay.Notify;
using System;
using System.Web.UI;
using NewLife.Log;

namespace Hidistro.UI.Web.Pay
{
	public class wx_Pay : System.Web.UI.Page
	{
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
           OrderInfo Order;
		    string OrderId;
            XTrace.WriteLine("΢�Żص�back");
			SiteSettings masterSettings = SettingsManager.GetMasterSettings(false);
			PayNotify payNotify = new NotifyClient(masterSettings.WeixinAppId, masterSettings.WeixinAppSecret, masterSettings.WeixinPartnerID, masterSettings.WeixinPartnerKey, masterSettings.WeixinPaySignKey).GetPayNotify(base.Request.InputStream);
            
			if (payNotify != null)
			{
                //XTrace.WriteLine("֪ͨ����");
				OrderId = payNotify.PayInfo.OutTradeNo;
				Order = ShoppingProcessor.GetOrderInfo(OrderId);
				if (Order == null)
				{
					base.Response.Write("success");
				}
				else
				{
                    //XTrace.WriteLine(OrderId + "������Ϊ��");
					Order.GatewayOrderId = payNotify.PayInfo.TransactionId;
                    this.UserPayOrder(Order);
				}
			}
		}
        private void UserPayOrder(OrderInfo Order)
		{
            //XTrace.WriteLine(Order.OrderId + "��ǰ����״̬ " + Order.OrderStatus);
			if (Order.OrderStatus == OrderStatus.BuyerAlreadyPaid)
			{
				base.Response.Write("success");
			}
			else
			{
                //XTrace.WriteLine(Order.OrderId + "׼����ʼ����");
				if (Order.CheckAction(OrderActions.BUYER_PAY) && MemberProcessor.UserPayOrder(Order))
				{
                    //if (this.Order.UserId != 0 && this.Order.UserId != 1100)
                    //{
                    //    MemberInfo member = MemberProcessor.GetMember(this.Order.UserId);
                    //    if (member != null)
                    //    {
                    //        Messenger.OrderPayment(member, this.OrderId, this.Order.GetTotal());
                    //        XTrace.WriteLine("֧��΢��֪ͨ1");
                    //    }
                    //}
					Order.OnPayment();
					base.Response.Write("success");
				}
			}
		}
	}
}
