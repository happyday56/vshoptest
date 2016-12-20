using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Hidistro.Core.Enums
{
    /// <summary>
    /// 商品特性
    /// </summary>
    public enum ProductFeature
    {
        /// <summary>
        /// 正常商品
        /// </summary>
        [Description("正常商品")]
        Normal,
        /// <summary>
        /// 秒杀商品
        /// </summary>
        [Description("秒杀商品")]
        Seckill
    }
}
