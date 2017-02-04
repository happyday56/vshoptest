using Hidistro.ControlPanel.Store;
using Hidistro.Entities.Store;
using Hidistro.UI.ControlPanel.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Hidistro.UI.Web.Admin
{
    [PrivilegeCheck(Privilege.AddProducts)]
    public class SelectCategories : AdminPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            
        }
    }
}
