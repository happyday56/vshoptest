using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Hidistro.Entities.VShop
{
    /// <summary>
    /// 用户购买的数量（活动结束后清空）
    /// </summary>
   public class UserProductNumInfo
    {
       public int UserId { get; set; }
       public int ProductId { get; set; }
       public int BuyNum { get; set; }
   }
}
