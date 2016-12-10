
using Hidistro.Core;
using Hidistro.Core.Entities;
using Hidistro.Entities.Members;
using Hidistro.SaleSystem.Vshop;
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Web;
using ThoughtWorks.QRCode.Codec;

namespace Hidistro.UI.Web.API
{
    public class GetQRCode : IHttpHandler
    {
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        public static Image DownloadImage(string httpImg)
        {
            WebRequest req = WebRequest.Create(httpImg);

            var rsp = req.GetResponse();
            Stream stream = rsp.GetResponseStream();
            System.Drawing.Image img = null;
            using (MemoryStream ms = new MemoryStream())
            {
                int b;
                while ((b = stream.ReadByte()) != -1)
                {
                    ms.WriteByte((byte)b);
                }
                img = System.Drawing.Image.FromStream(ms);
            }

            if (null != stream)
            {
                stream.Close();
            }
            if (null != rsp)
            {
                rsp.Close();
            }

            return img;
        }

        public static Image CombinImage(Image imgBack, Image img, string userName, string userImg, bool isOneBuy, string siteFlag = "")
        {
            if (siteFlag.EqualIgnoreCase("las"))
            {
                if (img.Height != 65 || img.Width != 65)
                {
                    img = GetQRCode.KiResizeImage(img, 152, 152, 0);//250
                }
                Graphics graphic = Graphics.FromImage(imgBack);
                graphic.DrawImage(imgBack, 0, 0, imgBack.Width, imgBack.Height);
                //graphic.DrawImage(img, imgBack.Width / 2 - img.Width / 2 + 10, imgBack.Width / 2 - img.Width / 2 + 85, 136, 136);
                if (isOneBuy)
                {
                    if (!string.IsNullOrEmpty(userName))
                    {
                        Font font = new Font("宋体", 28);
                        SolidBrush brush = new SolidBrush(Color.White);
                        graphic.DrawString(userName, font, brush, new PointF(80, 510));
                    }

                    graphic.DrawImage(img, 312, 215, 186, 186);
                }
                else
                {
                    graphic.DrawImage(img, imgBack.Width / 2 - img.Width / 2 + 10, imgBack.Width / 2 - img.Width / 2 + 85, 136, 136);
                }
                GC.Collect();
            }
            else if (siteFlag.EqualIgnoreCase("ls"))
            {
                if (img.Height != 65 || img.Width != 65)
                {
                    img = GetQRCode.KiResizeImage(img, 152, 152, 0);
                }
                Graphics graphic = Graphics.FromImage(imgBack);
                graphic.DrawImage(imgBack, 0, 0, imgBack.Width, imgBack.Height);
                if (!string.IsNullOrEmpty(userName))
                {
                    Font font = new Font("宋体", 18);
                    SolidBrush brush = new SolidBrush(Color.Red);
                    graphic.DrawString(userName, font, brush, new PointF(230, 510));
                }
                if (!string.IsNullOrEmpty(userImg))
                {
                    Image imgUser = DownloadImage(userImg);
                    if (null != imgUser)
                    {
                        graphic.DrawImage(imgUser, 46, 488, 85, 85);
                    }
                }
                graphic.DrawImage(img, 167, 670, 145, 145);
                GC.Collect();
            }
            else
            {
                if (img.Height != 65 || img.Width != 65)
                {
                    img = GetQRCode.KiResizeImage(img, 152, 152, 0);
                }
                Graphics graphic = Graphics.FromImage(imgBack);
                graphic.DrawImage(imgBack, 0, 0, imgBack.Width, imgBack.Height);
                graphic.DrawImage(img, 0, 0, 152, 152);
                GC.Collect();
            }
            return imgBack;
        }

        public static Image KiResizeImage(Image bmp, int newW, int newH, int Mode)
        {
            Image image;
            try
            {
                Image bitmap = new Bitmap(newW, newH);
                Graphics graphic = Graphics.FromImage(bitmap);
                graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphic.DrawImage(bmp, new Rectangle(0, 0, newW, newH), new Rectangle(0, 0, bmp.Width, bmp.Height), GraphicsUnit.Pixel);
                graphic.Dispose();
                image = bitmap;
            }
            catch
            {
                image = null;
            }
            return image;
        }

        public void ProcessRequest(HttpContext context)
        {
            string item = context.Request["code"];
            string referralId = context.Request["ReferralUserId"];
            string productId = context.Request["ProductId"];
            string ptTypeId = context.Request["PTTypeId"];
            int currUserId = 0;
            string currUserName = "";
            string currUserImg = "";
            bool isOneBuy = false;
            if (context.Request["PTTypeId"] == "4")
            {
                Bitmap image = GetImages(context);
                MemoryStream memoryStream = new MemoryStream();
                image.Save(memoryStream, ImageFormat.Png);
                context.Response.ClearContent();
                context.Response.ContentType = "image/png";
                context.Response.BinaryWrite(memoryStream.ToArray());
                memoryStream.Dispose();

            }
            else
            {
                if (!string.IsNullOrEmpty(referralId))
                {
                    currUserId = int.Parse(referralId);
                    MemberInfo currMember = MemberProcessor.GetMember(currUserId);
                    if (null != currMember)
                    {
                        currUserName = currMember.UserName;
                        currUserImg = currMember.UserHead;
                    }
                    referralId = "&ReferralUserId=" + referralId;

                }
                if (!string.IsNullOrEmpty(productId))
                {
                    productId = "&ProductId=" + productId;
                }
                if (!string.IsNullOrEmpty(ptTypeId))
                {
                    if (ptTypeId.Equals("2"))
                    {
                        isOneBuy = true;
                    }
                    ptTypeId = "&PTTypeId=" + ptTypeId;
                }
                if (!string.IsNullOrEmpty(item))
                {
                    SiteSettings masterSettings = SettingsManager.GetMasterSettings(false);

                    QRCodeEncoder qRCodeEncoder = new QRCodeEncoder()
                    {
                        QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE,
                        QRCodeScale = 4,
                        QRCodeVersion = 8,
                        QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M
                    };
                    item += referralId + productId + ptTypeId;
                    Image image = qRCodeEncoder.Encode(item);
                    MemoryStream memoryStream = new MemoryStream();
                    image.Save(memoryStream, ImageFormat.Png);
                    //string str = context.Server.MapPath("/Storage/master/QRcord" + masterSettings.SiteFlag + ".jpg");
                    string str = context.Server.MapPath("/Storage/master/QRcord.jpg");
                    if (masterSettings.SiteFlag.EqualIgnoreCase("las"))
                    {
                        if (isOneBuy)
                        {
                            str = context.Server.MapPath("/Storage/master/QRcord" + masterSettings.SiteFlag + ".jpg");
                        }
                    }
                    else
                    {
                        str = context.Server.MapPath("/Storage/master/QRcord" + masterSettings.SiteFlag + ".jpg");
                    }
                    Image image1 = Image.FromFile(str);
                    MemoryStream memoryStream1 = new MemoryStream();
                    if (masterSettings.SiteFlag.EqualIgnoreCase("las"))
                    {
                        if (isOneBuy)
                        {
                            GetQRCode.CombinImage(image1, image, currUserName, currUserImg, isOneBuy, masterSettings.SiteFlag).Save(memoryStream1, ImageFormat.Png);
                        }
                        else
                        {
                            GetQRCode.CombinImage(image1, image, currUserName, currUserImg, isOneBuy, "").Save(memoryStream1, ImageFormat.Png);
                        }
                    }
                    else if (masterSettings.SiteFlag.EqualIgnoreCase("ls"))
                    {
                        GetQRCode.CombinImage(image1, image, currUserName, currUserImg, isOneBuy, masterSettings.SiteFlag).Save(memoryStream1, ImageFormat.Png);
                    }
                    else
                    {
                        GetQRCode.CombinImage(image1, image, currUserName, currUserImg, isOneBuy, "").Save(memoryStream1, ImageFormat.Png);
                    }

                    context.Response.ClearContent();
                    context.Response.ContentType = "image/png";
                    context.Response.BinaryWrite(memoryStream1.ToArray());
                    memoryStream.Dispose();
                    memoryStream1.Dispose();
                }
            }
            context.Response.Flush();
            context.Response.End();
            //context.Response.Close();
        }

        public Bitmap Create_ImgCode(string codeNumber, int size)
        {
            //创建二维码生成类  
            QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
            //设置编码模式  
            qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            //设置编码测量度  
            qrCodeEncoder.QRCodeScale = size;
            //设置编码版本  
            qrCodeEncoder.QRCodeVersion = 7;
            //设置编码错误纠正  
            qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            //生成二维码图片  
            System.Drawing.Bitmap image = qrCodeEncoder.Encode(codeNumber);

            var width = image.Width / 10;
            var dwidth = width * 2;
            Bitmap bmp = new Bitmap(image.Width + dwidth, image.Height + dwidth);
            Graphics g = Graphics.FromImage(bmp);
            var c = System.Drawing.Color.White;
            g.FillRectangle(new SolidBrush(c), 0, 0, image.Width + dwidth, image.Height + dwidth);
            g.DrawImage(image, width, width);
            g.Dispose();
            // return bmp;

            return image;
        }
        public System.Drawing.Image CombinImage(System.Drawing.Image imgBack, string destImg)
        {

            System.Drawing.Image img = System.Drawing.Image.FromFile(destImg);        //照片图片    
            if (img.Height != 50 || img.Width != 50)
            {
                img = KiResizeImage(img, 50, 50, 0);
            }
            Graphics g = Graphics.FromImage(imgBack);

            g.DrawImage(imgBack, 0, 0, imgBack.Width, imgBack.Height);      //g.DrawImage(imgBack, 0, 0, 相框宽, 相框高);   

            //g.FillRectangle(System.Drawing.Brushes.White, imgBack.Width / 2 - img.Width / 2 - 1, imgBack.Width / 2 - img.Width / 2 - 1,1,1);//相片四周刷一层黑色边框  

            //g.DrawImage(img, 照片与相框的左边距, 照片与相框的上边距, 照片宽, 照片高);  

            g.DrawImage(img, imgBack.Width / 2 - img.Width / 2, imgBack.Width / 2 - img.Width / 2, img.Width, img.Height);
            GC.Collect();
            return imgBack;
        }
        public Bitmap GetProductQrCode(HttpContext context)
        {

            Bitmap qrcode = Create_ImgCode(System.Web.HttpUtility.UrlDecode(context.Request["code"].ToString()), 5);

            CombinImage(qrcode, context.Server.MapPath("/Storage/master/logo.png"));

            return qrcode;
        }

        public Bitmap GetImages(HttpContext context)
        {
            int productId = 0;
            int.TryParse(context.Request["productId"], out productId);
            int ReferralId = 0;
            int.TryParse(context.Request["ReferralId"], out ReferralId);
            string folder = context.Server.MapPath("/Storage/master/product/qrcode/");

            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            if (File.Exists(folder + string.Format("img-{0}-{1}.jpg", productId, ReferralId)))
            {
                return new Bitmap(Image.FromFile(folder + string.Format("img-{0}-{1}.jpg", productId, ReferralId)));
            }
            else
            {

                int maxWd = 650;
                int maxHt = 905;

                Bitmap bgColor = new Bitmap(maxWd, maxHt);
                //清楚背景
                Graphics g = Graphics.FromImage(bgColor);
                g.Clear(Color.GhostWhite);
                try
                {
                    var storeName = string.Empty;
                    var productName = string.Empty;
                    var productPrice = string.Empty;
                    var productMarketPrice = string.Empty;
                    var productLogo = string.Empty;
                    var distor = DistributorsBrower.GetCurrentDistributors(ReferralId);
                    if (distor != null)
                    {
                        storeName = distor.StoreName;
                    }
                    var product = ProductBrowser.GetProduct(MemberProcessor.GetCurrentMember(), productId);
                    if (product != null)
                    {
                        productName = product.ProductName;
                        productPrice = product.MinSalePrice.ToString("F2");
                        if (product.MarketPrice.HasValue)
                        {
                            productMarketPrice = Convert.ToDecimal( product.MarketPrice.ToString()).ToString("F2");
                        }
                        else
                        {
                            productMarketPrice = product.MinSalePrice.ToString("F2");
                        }
                        productLogo = product.ImageUrl1;
                    }


                    //生成主图
                    if (!string.IsNullOrEmpty(productLogo))
                    {
                        Image imgMain = Image.FromFile(context.Server.MapPath(productLogo));
                        // Image.FromFile(@"D:\SVN\trunk\01.Src\wfx3.0\web\Storage\master\product\images\ee3016e14a664260b9e259e3f849563d.jpg");
                        g.DrawImage(imgMain, 20, 20, maxWd - 20 * 2, 610);
                        //生成二维码
                        Bitmap qrcode = Create_ImgCode(System.Web.HttpUtility.UrlDecode(context.Request["code"].ToString()), 5);
                        CombinImage(qrcode, context.Server.MapPath("/Storage/master/logo.png"));
                        g.DrawImage(qrcode, 20, 670, 216, 216);

                        //生成文本信息
                        FontFamily yahei = new FontFamily("微软雅黑");
                        Font titleFt = new Font(yahei, 22, FontStyle.Regular);
                        Font priceFt = new Font(yahei, 22, FontStyle.Regular);
                        Font marketPriceFt = new Font(yahei, 16, FontStyle.Strikeout);
                        Font descFt = new Font(yahei, 15, FontStyle.Regular);
                        Brush brs = new SolidBrush(Color.Black);
                        Brush orgbrs = new SolidBrush(Color.Red);
                        Brush strikebrs = new SolidBrush(Color.Gray);

                        //产品名称
                        g.DrawString(productName, titleFt, brs, new RectangleF()
                        {
                            Location = new PointF(250, 672),
                            Size = new SizeF(maxWd - 250 - 20, 80)
                        });
                        //价格
                        g.DrawString("￥" + productPrice, priceFt, orgbrs, 250, 755);
                        g.DrawString("￥" + productMarketPrice, marketPriceFt, strikebrs, 400, 765);
                        //提示
                        g.DrawString("长按识别二维码或扫一扫购买", descFt, brs, 250, 814);

                        g.DrawString(storeName + "的店铺", descFt, brs, 250, 850);

                        bgColor.Save(context.Server.MapPath(@"/Storage/master/product/qrcode/") + string.Format("img-{0}-{1}.jpg", productId, ReferralId), System.Drawing.Imaging.ImageFormat.Jpeg);
                        //bgColor.Save(@"D:\C_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                }
                catch (Exception)
                {

                }
                return bgColor;
            }
        }

    }
}