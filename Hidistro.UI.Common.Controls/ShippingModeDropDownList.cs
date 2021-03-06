﻿namespace Hidistro.UI.Common.Controls
{
    using Hidistro.ControlPanel.Sales;
    using Hidistro.Entities.Sales;
    using System;
    using System.Runtime.CompilerServices;
    using System.Web.UI.WebControls;

    public class ShippingModeDropDownList : DropDownList
    {
        private bool allowNull = true;

        public override void DataBind()
        {
            base.Items.Clear();
            if (this.AllowNull)
            {
                base.Items.Add(new ListItem(this.NullToDisplay, string.Empty));
            }
            foreach (ShippingModeInfo info in SalesHelper.GetShippingModes())
            {
                base.Items.Add(new ListItem(info.Name, info.ModeId.ToString()));
            }
        }

        public bool AllowNull
        {
            get
            {
                return this.allowNull;
            }
            set
            {
                this.allowNull = value;
            }
        }

        public string NullToDisplay { get; set; }

        new public int? SelectedValue
        {
            get
            {
                if (string.IsNullOrEmpty(base.SelectedValue))
                {
                    return null;
                }
                return new int?(int.Parse(base.SelectedValue));
            }
            set
            {
                if (!value.HasValue)
                {
                    base.SelectedValue = string.Empty;
                }
                else
                {
                    base.SelectedValue = value.ToString();
                }
            }
        }
    }
}

