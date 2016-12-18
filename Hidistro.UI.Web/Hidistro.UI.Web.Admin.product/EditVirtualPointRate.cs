using ASPNET.WebControls;
using Hidistro.ControlPanel.Commodities;
using Hidistro.ControlPanel.Store;
using Hidistro.Entities.Store;
using Hidistro.UI.Common.Controls;
using Hidistro.UI.ControlPanel.Utility;
using System;
using System.Data;
using System.Web.UI.WebControls;
namespace Hidistro.UI.Web.Admin.product
{
    [PrivilegeCheck(Privilege.EditProducts)]
    public class EditVirtualPointRate : AdminPage
    {
        protected System.Web.UI.WebControls.Button btnOperationOK;
        protected System.Web.UI.WebControls.Button btnSaveVirtualPointRate;
        protected System.Web.UI.WebControls.Button btnTargetOK;
        protected Grid grdSelectedProducts;
        private string productIds = string.Empty;
        protected System.Web.UI.WebControls.TextBox txtAddVirtualPointRate;
        protected System.Web.UI.WebControls.TextBox txtTagetVirtualPointRate;
        private void BindProduct()
        {
            string str = this.Page.Request.QueryString["ProductIds"];
            if (!string.IsNullOrEmpty(str))
            {
                this.grdSelectedProducts.DataSource = ProductHelper.GetProductBaseInfo(str);
                this.grdSelectedProducts.DataBind();
            }
        }
        private void btnOperationOK_Click(object sender, System.EventArgs e)
        {
            if (string.IsNullOrEmpty(this.productIds))
            {
                this.ShowMsg("没有要修改的商品", false);
            }
            else
            {
                decimal result = 0;
                if (!decimal.TryParse(this.txtAddVirtualPointRate.Text, out result))
                {
                    this.ShowMsg("请输入正确的金贝使用率格式", false);
                }
                else
                {
                    if (ProductHelper.AddVirtualPointRate(this.productIds, result))
                    {
                        this.BindProduct();
                        this.ShowMsg("修改商品的金贝使用率成功", true);
                    }
                    else
                    {
                        this.ShowMsg("修改商品的金贝使用率失败", false);
                    }
                }
            }
        }
        private void btnSaveVirtualPointRate_Click(object sender, System.EventArgs e)
        {
            System.Collections.Generic.Dictionary<string, decimal> skuVirtualPointRates = null;
            if (this.grdSelectedProducts.Rows.Count > 0)
            {
                skuVirtualPointRates = new System.Collections.Generic.Dictionary<string, decimal>();
                foreach (System.Web.UI.WebControls.GridViewRow row in this.grdSelectedProducts.Rows)
                {
                    decimal result = 0;
                    System.Web.UI.WebControls.TextBox box = row.FindControl("txtVirtualPointRate") as System.Web.UI.WebControls.TextBox;
                    if (decimal.TryParse(box.Text, out result))
                    {
                        int key = (int)this.grdSelectedProducts.DataKeys[row.RowIndex].Value;
                        
                        skuVirtualPointRates.Add(key.ToString(), result);
                    }
                }
                if (skuVirtualPointRates.Count > 0)
                {
                    if (ProductHelper.UpdateVirtualPointRate(skuVirtualPointRates))
                    {
                        this.CloseWindow();
                    }
                    else
                    {
                        this.ShowMsg("批量修改金贝使用率失败", false);
                    }
                }
                this.BindProduct();
            }
        }
        private void btnTargetOK_Click(object sender, System.EventArgs e)
        {
            if (string.IsNullOrEmpty(this.productIds))
            {
                this.ShowMsg("没有要修改的商品", false);
            }
            else
            {
                decimal result = 0;
                if (!decimal.TryParse(this.txtTagetVirtualPointRate.Text, out result))
                {
                    this.ShowMsg("请输入正确的金贝使用率格式", false);
                }
                else
                {
                    if (result < 0)
                    {
                        this.ShowMsg("商品金贝使用率不能小于0", false);
                    }
                    else
                    {
                        if (ProductHelper.UpdateVirtualPointRate(this.productIds, result))
                        {
                            this.BindProduct();
                            this.ShowMsg("修改商品的金贝使用率成功", true);
                        }
                        else
                        {
                            this.ShowMsg("修改商品的金贝使用率失败", true);
                        }
                    }
                }
            }
        }
        protected void Page_Load(object sender, System.EventArgs e)
        {
            this.productIds = this.Page.Request.QueryString["productIds"];
            this.btnSaveVirtualPointRate.Click += new System.EventHandler(this.btnSaveVirtualPointRate_Click);
            this.btnTargetOK.Click += new System.EventHandler(this.btnTargetOK_Click);
            this.btnOperationOK.Click += new System.EventHandler(this.btnOperationOK_Click);
            if (!this.Page.IsPostBack)
            {
                this.BindProduct();
            }
        }
    }
}
