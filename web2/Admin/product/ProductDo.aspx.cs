using Hidistro.ControlPanel.Store;
using Hidistro.Entities.Store;
using Hidistro.SqlDal.VShop;
using Hidistro.UI.ControlPanel.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace web2.Admin.product
{
    [PrivilegeCheck(Privilege.ProductDo)]
    public partial class ProductDo : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string status = "1";
            string msg = "";
            string mode = base.Request["Mode"].ToString();
            switch (mode)
            { 
                case "resetUserBuyNum":

                    int productId = int.Parse(base.Request["productId"]);
                    new UserProductNumDao().clearProductBuyNum( productId);
                    break;
                default :
                    break;
            }

            base.Response.Clear();
            base.Response.ContentType = "application/json";
            base.Response.Write(string.Concat(new string[]
					{
						"{\"Status\":\"",
						status,
						"\",\"msg\":\"",
						msg,
						"\"}"
					}));
            base.Response.End();
        }
    }
}