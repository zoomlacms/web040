using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.Plat;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.Model.Plat;
using ZoomLa.SQLDAL;

namespace ZoomLaCMS.Manage.Plat
{
    public partial class AuditApply : System.Web.UI.Page
    {
        B_Plat_Comp compBll = new B_Plat_Comp();
        B_Plat_Group gpBll = new B_Plat_Group();
        B_User buser = new B_User();
        B_User_Plat upBll = new B_User_Plat();
        B_Common_UserApply ualyBll = new B_Common_UserApply();
        public int ZStatus { get { return DataConvert.CLng(Request.QueryString["s"]); } }
        private string ztype = "plat_applyopen";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MyBind();
                Call.SetBreadCrumb(Master, "<li><a href='" + CustomerPageAction.customPath2 + "I/Main.aspx'>工作台</a></li><li><a href='" + Request.RawUrl + "'>能力中心</a></li><li><a href='PlatInfoManage.aspx'>信息管理</a></li><li><a href='" + Request.RawUrl + "'>申请管理</a></li>");
            }
        }
        public void MyBind()
        {
            EGV.DataSource = ualyBll.Search(ztype, "", "", ZStatus, 0);
            EGV.DataBind();
            switch (ZStatus)
            {
                case (int)ZLEnum.ConStatus.UnAudit:
                    break;
                //case (int)ZLEnum.ConStatus.Audited:
                //    break;
                //case (int)ZLEnum.ConStatus.Reject:
                //    break;
                default:
                    BatReject_Btn.Visible = false;
                    BatAgree_Btn.Visible = false;
                    break;
            }
        }
        protected void EGV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            EGV.PageIndex = e.NewPageIndex;
            MyBind();
        }
        protected void EGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "agree":
                    break;
                case "reject":
                    break;
            }
            MyBind();
        }
        protected void EGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row != null && e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    DataRowView dr = e.Row.DataItem as DataRowView;
            //    e.Row.Attributes.Add("ondblclick", "location='AddEnglishQuestion.aspx?ID=" + dr["ID"] + "'");
            //}
        }
        protected void BatAgree_Btn_Click(object sender, EventArgs e)
        {
            string ids = Request.Form["idchk"];
            //修改公司状态,并更正名称
            DataTable dt = ualyBll.Search(ztype, ids, "", (int)ZLEnum.ConStatus.UnAudit, 0);
            foreach (DataRow dr in dt.Rows)
            {
                M_Common_UserApply ualyMod = new M_Common_UserApply().GetModelFromReader(dr);
                M_UserInfo mu = buser.SelReturnModel(ualyMod.UserID);
                //-------------创建公司和用户
                M_User_Plat upMod = upBll.NewUser(mu);
                M_Plat_Comp compMod = compBll.CreateByUser(upMod);
                compMod.CompName = ualyMod.CompName;
                compMod.CompShort = ualyMod.Info1;
                compMod.Telephone = ualyMod.Mobile;
                compMod.Mobile = ualyMod.Mobile;
                compMod.Status = 1;
                compBll.UpdateByID(compMod);
                upBll.Insert(upMod);
                //-------------创建部门
                DataTable userDT = GetUserDT();
                NewByUserDT(compMod, userDT);
            }
            ualyBll.ChangeByIDS(ids, (int)ZLEnum.ConStatus.Audited);
            function.WriteSuccessMsg("批量同意完成");
        }
        protected void BatReject_Btn_Click(object sender, EventArgs e)
        {
            string ids = Request.Form["idchk"];
            ualyBll.ChangeByIDS(ids, (int)ZLEnum.ConStatus.Reject);
            function.WriteSuccessMsg("批量拒绝完成");
        }
        private DataTable GetUserDT()
        {
            string[] groups = "证照管理,行政人事,经营管理,项目管理,财务部".Split(',');
            string name = function.GetRandomString(6, 3).ToLower();
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("gname", typeof(string)));
            dt.Columns.Add(new DataColumn("uname", typeof(string)));
            dt.Columns.Add(new DataColumn("honey", typeof(string)));
            for (int i = 0; i < groups.Length; i++)
            {
                DataRow dr = dt.NewRow();
                dr["gname"] = groups[i];
                dr["uname"] = name + "_0" + i;
                dr["honey"] = "";
                dt.Rows.Add(dr);
            }
            return dt;
        }
        public void NewByUserDT(M_Plat_Comp compMod, DataTable userDT)
        {
            B_Plat_Group gpBll = new B_Plat_Group();
            for (int i = 0; i < userDT.Rows.Count; i++)
            {
                string gname = userDT.Rows[i]["gname"].ToString();
                string uname = userDT.Rows[i]["uname"].ToString();
                string honey = userDT.Rows[i]["honey"].ToString();
                if (string.IsNullOrEmpty(uname)) { continue; }
                M_UserInfo newmu = buser.NewUser(uname, "111111");
                //企业会员
                newmu.GroupID = 7;
                newmu.HoneyName = honey;
                newmu.UserID = buser.Add(newmu);
                M_Uinfo basemu = buser.NewBase(newmu);
                buser.AddBase(basemu);
                //----能力相关信息
                M_Plat_Group gpMod = gpBll.NewGroup(gname, compMod.ID, newmu.UserID);
                M_User_Plat upMod = NewUser(newmu, compMod);
                gpMod.ID = gpBll.Insert(gpMod);
                upMod.Gid = gpMod.ID.ToString();
                Insert(upMod);
            }
        }
        public M_User_Plat NewUser(M_UserInfo mu, M_Plat_Comp compMod)
        {
            M_User_Plat upMod = new M_User_Plat();
            upMod.UserID = mu.UserID;
            upMod.UserFace = mu.UserFace;
            upMod.UserName = mu.UserName;
            upMod.TrueName = mu.HoneyName;
            upMod.UserPwd = mu.UserPwd;
            upMod.Plat_Role = "";
            upMod.Plat_Group = "";
            upMod.Status = 1;
            //--------------------------
            upMod.CompID = compMod.ID;
            upMod.CompName = compMod.CompName;
            upMod.CreateTime = DateTime.Now;
            return upMod;
        }
        public int Insert(M_User_Plat model)
        {
            SyncUB(model);
            model.PK = "";
            return Sql.insert("ZL_User_Plat", model.GetParameters(), BLLCommon.GetParas(model), BLLCommon.GetFields(model));
        }
        public void SyncUB(M_User_Plat model)
        {
            M_Uinfo ubMod = buser.GetUserBaseByuserid(model.UserID);
            ubMod.UserId = model.UserID;
            ubMod.Position = model.Post;
            ubMod.Mobile = model.Mobile;
            ubMod.UserFace = model.UserFace;
            ubMod.TrueName = model.TrueName;
            if (ubMod.IsNull)
            {
                buser.AddBase(ubMod);
            }
            else
            {
                buser.UpdateBase(ubMod);
            }
        }

    }
}