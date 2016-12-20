using Hidistro.Core.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace Hidistro.UI.Common.Controls
{
    public class ProductFeatureDropDownList : DropDownList
    {
        private bool allowNull = true;
        private string nullToDisplay = "";

        public override void DataBind()
        {
            this.Items.Clear();
            if (this.AllowNull)
            {
                base.Items.Add(new ListItem(this.NullToDisplay, string.Empty));
            }

            foreach (var value in Enum.GetValues(typeof(ProductFeature)))
            {
                string description = "";
                object[] objAttrs = value.GetType().GetField(value.ToString()).GetCustomAttributes(typeof(DescriptionAttribute), true);
                if (objAttrs != null && objAttrs.Length > 0)
                {
                    DescriptionAttribute descAttr = objAttrs[0] as DescriptionAttribute;
                    description = descAttr.Description;
                }
                this.Items.Add(new ListItem(value.ToString(), description));
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

        public string NullToDisplay
        {
            get
            {
                return this.nullToDisplay;
            }
            set
            {
                this.nullToDisplay = value;
            }
        }

        new public int SelectedValue
        {
            get
            {
                if (!string.IsNullOrEmpty(base.SelectedValue))
                {
                    return int.Parse(base.SelectedValue, CultureInfo.InvariantCulture);
                }
                return 0;
            }
            set
            {
                base.SelectedIndex = base.Items.IndexOf(base.Items.FindByValue(value.ToString(CultureInfo.InvariantCulture)));

            }
        }
    }
}
