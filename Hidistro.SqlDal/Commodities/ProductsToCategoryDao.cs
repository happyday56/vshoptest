using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace Hidistro.SqlDal.Commodities
{

    public class ProductsToCategoryDao
    {
        private Database database = DatabaseFactory.CreateDatabase();

        public List<int> getCategoriesByProductId(int productId)
        {
            List<int> list = new List<int>();
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand("select CategoryId from Hishop_ProductsToCategory where ProductId=@ProductId");
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, productId);
            using (IDataReader reader = this.database.ExecuteReader(sqlStringCommand))
            {
                while (reader.Read())
                {
                    list.Add((int)reader["CategoryId"]);
                }
            }
            return list;
        }
            
        /// <summary>
        /// 保存商品分类
        /// </summary>
        /// <param name="productId"></param>
        /// <param name="categories"></param>
        public void save(int productId, string categories)
        {
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand("delete from Hishop_ProductsToCategory where ProductId=@ProductId");
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, productId);
            this.database.ExecuteNonQuery(sqlStringCommand);

            foreach (string categoryId in categories.Split(','))
            {
                sqlStringCommand = this.database.GetSqlStringCommand("insert   Hishop_ProductsToCategory (CategoryId,ProductId) values (" + categoryId + "," + productId + ")");
                this.database.ExecuteNonQuery(sqlStringCommand);
            }
        }

        public bool delete(int productId, int categoryId)
        {
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand("delete from Hishop_ProductsToCategory where ProductId=@ProductId and CategoryId=@CategoryId");
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, productId);
            this.database.AddInParameter(sqlStringCommand, "CategoryId", DbType.Int32, categoryId);
           return  this.database.ExecuteNonQuery(sqlStringCommand)==1;
        }

    }
}
