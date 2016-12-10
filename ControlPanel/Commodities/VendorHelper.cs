using Hidistro.SqlDal.Commodities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace ControlPanel.Commodities
{
    public sealed class VendorHelper
    {

        private const string VendorCachekey = "DataCache-Vendor";

        private VendorHelper()
        {

        }

        public static DataTable GetVendors()
        {
            return new VendorDao().GetVendors();
        }
    }
}
