using Hidistro.Core;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace Hidistro.SqlDal.Commodities
{
    public class VendorDao
    {
        private Database database = DatabaseFactory.CreateDatabase();

        public DataTable GetVendors()
        {
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand("SELECT * FROM T_Vendor ORDER BY ID ASC");
            using (IDataReader reader = this.database.ExecuteReader(sqlStringCommand))
            {
                return DataHelper.ConverDataReaderToDataTable(reader);
            }
        }
    }
}
