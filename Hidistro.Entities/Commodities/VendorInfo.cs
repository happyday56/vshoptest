using Hishop.Components.Validation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Hidistro.Entities.Commodities
{
    public class VendorInfo
    {
        public int ID { get; set; }

        [StringLengthValidator(1, 30, Ruleset="ValVendor", MessageTemplate="供应商名称不能为空，长度限制在30个字符以内")]
        public string VendorName { get; set; }

        public DateTime CreateDate { get; set; }
    }
}
