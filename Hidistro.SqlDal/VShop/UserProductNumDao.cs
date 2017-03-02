using Hidistro.Core;
using Hidistro.Core.Entities;
using Hidistro.Core.Enums;
using Hidistro.Entities;
using Hidistro.Entities.VShop;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data;
using System.Data.Common;
namespace Hidistro.SqlDal.VShop
{
    public class UserProductNumDao
    {
        private Database database = DatabaseFactory.CreateDatabase();

        public UserProductNumInfo Get(int UserId, int ProductId)
        {
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand("SELECT * FROM Hishop_UserProductNum WHERE UserId=@UserId and ProductId=@ProductId");
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, ProductId);
            this.database.AddInParameter(sqlStringCommand, "UserId", DbType.Int32, UserId);
            using (IDataReader reader = this.database.ExecuteReader(sqlStringCommand))
            {
                return ReaderConvert.ReaderToModel<UserProductNumInfo>(reader);
            }
        }

        /// <summary>
        /// 获得用户允许购买的数量
        /// </summary>
        /// <param name="UserId"></param>
        /// <param name="ProductId"></param>
        /// <returns></returns>
        public int GetUserAllowBuyNum(int UserId, int ProductId)
        {
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand(@"select p.OneBuyNum-isnull(u.BuyNum,0) num from Hishop_Products p
left join Hishop_UserProductNum u on p.ProductId=u.ProductId and u.UserId=@UserId
where p.ProductId=@ProductId and p.OneBuyNum>0");
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, ProductId);
            this.database.AddInParameter(sqlStringCommand, "UserId", DbType.Int32, UserId);
            object result = this.database.ExecuteScalar(sqlStringCommand);
            if (result == null) return int.MaxValue;
            else return int.Parse(result.ToString());
        }

        public int updateBuyNum(int UserId, int ProductId, int BuyNum)
        {
            string strsql = @"if(exists(select 1 from Hishop_UserProductNum where UserId=@UserId and ProductId=@ProductId))
begin
	update Hishop_UserProductNum set BuyNum=BuyNum+@BuyNum where UserId=@UserId and ProductId=@ProductId;
end
else
begin
  insert Hishop_UserProductNum (UserId,ProductId,BuyNum) values (@UserId,@ProductId,@BuyNum);
end";
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand(strsql);
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, ProductId);
            this.database.AddInParameter(sqlStringCommand, "UserId", DbType.Int32, UserId);
            this.database.AddInParameter(sqlStringCommand, "BuyNum", DbType.Int32, BuyNum);
            return this.database.ExecuteNonQuery(sqlStringCommand);

        }

        /// <summary>
        /// 重置商品的用户购买次数
        /// </summary>
        /// <param name="productId"></param>
        /// <returns></returns>
        public int clearProductBuyNum(int productId)
        {
            string strsql = @"update Hishop_UserProductNum set BuyNum=0 where ProductId=@ProductId";
            DbCommand sqlStringCommand = this.database.GetSqlStringCommand(strsql);
            this.database.AddInParameter(sqlStringCommand, "ProductId", DbType.Int32, productId);
            return this.database.ExecuteNonQuery(sqlStringCommand);
        }
    }
}
