using Hidistro.ControlPanel.Store;
using Hidistro.Core;
using Hidistro.Entities.Store;
using Hidistro.UI.ControlPanel.Utility;
using System;
using System.Globalization;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
namespace Hidistro.UI.Web.Admin
{
	[PrivilegeCheck(Privilege.PictureMange)]
	public class ImageFtp : AdminPage
	{
		protected System.Web.UI.WebControls.Button btnSaveImageFtp;
		protected ImageDataGradeDropDownList dropImageFtp;
		protected System.Web.UI.WebControls.FileUpload FileUpload;
		protected ImageTypeLabel ImageTypeID;
		private void btnSaveImageFtp_Click(object sender, System.EventArgs e)
		{
			string str = Globals.GetStoragePath() + "/gallery";
			int categoryId = System.Convert.ToInt32(this.dropImageFtp.SelectedItem.Value);
			int num2 = 0;
			int num3 = 0;
			new System.Text.StringBuilder();
			System.Web.HttpFileCollection files = base.Request.Files;
			for (int i = 0; i < files.Count; i++)
			{
				System.Web.HttpPostedFile postedFile = files[i];
				if (postedFile.ContentLength > 0)
				{
					num2++;
					try
					{
						string str2 = System.Guid.NewGuid().ToString("N", System.Globalization.CultureInfo.InvariantCulture) + System.IO.Path.GetExtension(postedFile.FileName);
						string str3 = postedFile.FileName.Substring(postedFile.FileName.LastIndexOf("\\") + 1);
						string photoName = str3.Substring(0, str3.LastIndexOf("."));
						string str4 = System.DateTime.Now.ToString("yyyyMM").Substring(0, 6);
						string virtualPath = str + "/" + str4 + "/";
						int contentLength = postedFile.ContentLength;
						string path = base.Request.MapPath(virtualPath);
						string photoPath = "/Storage/master/gallery/" + str4 + "/" + str2;
						System.IO.DirectoryInfo info = new System.IO.DirectoryInfo(path);
						if (ResourcesHelper.CheckPostedFile(postedFile))
						{
							if (!info.Exists)
							{
								info.Create();
							}
							postedFile.SaveAs(base.Request.MapPath(virtualPath + str2));
							if (GalleryHelper.AddPhote(categoryId, photoName, photoPath, contentLength))
							{
								num3++;
							}
						}
					}
					catch
					{
					}
				}
			}
			if (num2 == 0)
			{
				this.ShowMsg("至少需要选择一个图片文件！", false);
			}
			else
			{
				this.ShowMsg("成功上传了" + num3.ToString() + "个文件！", true);
			}
		}
		protected void Page_Load(object sender, System.EventArgs e)
		{
			this.btnSaveImageFtp.Click += new System.EventHandler(this.btnSaveImageFtp_Click);
			if (!this.Page.IsPostBack)
			{
				this.dropImageFtp.DataBind();
			}
		}
	}
}
