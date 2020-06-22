using System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ZoomLa.BLL;
using ZoomLa.BLL.Content;
using ZoomLa.BLL.Helper;
using ZoomLa.BLL.Plat;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;
using ZoomLa.Model.Plat;
using ZoomLa.SQLDAL;
using ZoomLa.SQLDAL.SQL;

namespace ZoomLa.Sns
{
    public class ZLPlugController:Controller
    {
        B_Favorite favBll = new B_Favorite();
        B_Content conBll = new B_Content();
        B_Node nodeBll = new B_Node();
        B_Model modBll = new B_Model();
        B_ModelField fieldBll = new B_ModelField();
        B_UserPromotions upBll = new B_UserPromotions();
        B_Comment cmtBll = new B_Comment();

        public B_User buser = new B_User();
        public int Success = 1;
        public int Failed = -1;
        public M_UserInfo mu { get { if (ViewBag.mu == null) { ViewBag.mu = buser.GetLogin(); } return ViewBag.mu; } }
        public int Mid
        {
            get { if (ViewBag.Mid == null) { ViewBag.Mid = DataConverter.CLng(Request["ID"]); } return ViewBag.Mid; }
            set { ViewBag.Mid = value; }
        }
        public int PSize
        {
            get
            {
                return DataConverter.CLng(Request["psize"]);
            }
        }
        public int CPage
        {
            get { int _cpage = DataConverter.CLng(Request["cpage"]); if (_cpage < 1) { _cpage = 1; } return _cpage; }
        }
        public int NodeID
        {
            get
            {
                if (ViewBag.NodeID == null) { ViewBag.NodeID = DataConvert.CLng(Request["NodeID"]); }
                return DataConvert.CLng(ViewBag.NodeID);
            }
            set { ViewBag.NodeID = value; }
        }
        public int ModelID
        {
            get
            {
                if (ViewBag.ModelID == null) { ViewBag.ModelID = DataConvert.CLng(Request["ModelID"]); }
                return DataConvert.CLng(ViewBag.ModelID);
            }
            set { ViewBag.ModelID = value; }
        }
        [HttpPost]
        [ValidateInput(false)]
        public void Content_Add()
        {
            M_Node nodeMod = nodeBll.SelReturnModel(NodeID);
            M_CommonData CData = new M_CommonData();
            if (Mid > 0)
            {
                CData = conBll.GetCommonData(Mid);
                if (!CData.Inputer.Equals(mu.UserName)) { function.WriteErrMsg("你无权修改该内容"); }
            }
            else
            {
                CData.NodeID = NodeID;
                CData.ModelID = ModelID;
                CData.TableName = modBll.GetModelById(CData.ModelID).TableName;
            }
            DataTable dt = fieldBll.SelByModelID(CData.ModelID, false);
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromMVC(dt, Request);
            CData.Title = Request.Form["title"];
            CData.Subtitle = Request["Subtitle"];
            CData.PYtitle = Request["PYtitle"];
            CData.TagKey = Request.Form["tagkey"];
            CData.Status = nodeMod.SiteContentAudit;
            string parentTree = "";
            CData.FirstNodeID = nodeBll.SelFirstNodeID(CData.NodeID, ref parentTree);
            CData.ParentTree = parentTree;
            CData.TitleStyle = Request.Form["TitleStyle"];
            //CData.TopImg = Request.Form["selectpic"];//首页图片
            if (Mid > 0)//修改内容
            {
                conBll.UpdateContent(table, CData);
            }
            else
            {
                CData.DefaultSkins = 0;
                CData.EliteLevel = 0;
                CData.UpDateType = 2;
                CData.InfoID = "";
                CData.RelatedIDS = "";
                CData.Inputer = mu.UserName;
                CData.GeneralID = conBll.AddContent(table, CData);//插入信息给两个表，主表和从表:CData-主表的模型，table-从表
            }
            if (Mid <= 0)//添加时增加积分
            {
                //积分
                if (SiteConfig.UserConfig.InfoRule > 0)
                {
                    buser.ChangeVirtualMoney(mu.UserID, new M_UserExpHis()
                    {
                        UserID = mu.UserID,
                        detail = "添加内容:" + CData.Title + "增加积分",
                        score = SiteConfig.UserConfig.InfoRule,
                        ScoreType = (int)M_UserExpHis.SType.Point
                    });
                }
            }
            string url = "MyContent?NodeID=" + CData.NodeID;
            if (nodeMod.CUName == "能力中心")//nodeMod.CUName.Equals("能力中心")
            {
                M_Blog_Msg msgMod = new M_Blog_Msg();
                M_User_Plat upMod = B_User_Plat.GetLogin();
                //M_Common_Notify comMod = new M_Common_Notify();
                B_Blog_Msg msgBll = new B_Blog_Msg();
                //B_Common_Notify comBll = new B_Common_Notify();
                RegexHelper regHelper = new RegexHelper();
                string msg = "#" + nodeMod.NodeName + "#[" + upMod.TrueName + "]发布了[<a href='/Item/" + CData.GeneralID + ".aspx' title='点击访问'>" + CData.Title + "</a>]";
                string deftopic = "#插入话题#";
                if (msg.Contains("#"))
                {
                    msg = msg.Replace(deftopic, "");
                    string tlp = "<a href='/Plat/Blog?Skey={0}' title='话题浏览'>{1}</a>";
                    Dictionary<string, string> itemDic = new Dictionary<string, string>();
                    for (int i = 0; !string.IsNullOrEmpty(regHelper.GetValueBySE(msg, "#", "#", false)) && i < 5; i++)//最多不能超过5个话题
                    {
                        string topic = "#" + regHelper.GetValueBySE(msg, "#", "#", false) + "#";
                        msg = msg.Replace(topic, "{" + i + "}");
                        topic = topic.Replace(" ", "").Replace(",", "");
                        itemDic.Add("{" + i + "}", string.Format(tlp, Server.UrlEncode(topic), topic));
                        msgMod.Topic += topic + ",";
                    }
                    foreach (var item in itemDic)
                    {
                        msg = msg.Replace(item.Key, item.Value);
                    }
                }
                msgMod.MsgType = 1;
                msgMod.Status = 1;
                msgMod.CUser = upMod.UserID;
                msgMod.CUName = upMod.TrueName;
                msgMod.CompID = upMod.CompID;
                msgMod.ProID = 0;
                msgMod.pid = 0;
                msgMod.ReplyID = 0;
                msgMod.GroupIDS = "";
                msgMod.ColledIDS = "";
                msgMod.MsgContent = msg;
                msgMod.Title = CData.Title;
                msgMod.ID = msgBll.Insert(msgMod);
                url = "/Plat/Blog/";
            }
            function.WriteSuccessMsg("操作成功!", url);
        }
        public ActionResult AddContent1()
        {
            B_User.CheckIsLogged(HttpUtility.UrlEncode(Request.RawUrl));
            M_CommonData Cdata = new M_CommonData();
            NodeID = DataConvert.CLng(Request.QueryString["NodeID"]);
            ModelID = DataConvert.CLng(Request.QueryString["ModelID"]);
            if (Mid > 0)
            {
                Cdata = conBll.GetCommonData(Mid);
                NodeID = Cdata.NodeID;
                ModelID = Cdata.ModelID;
            }
            if ((ModelID < 1 && NodeID < 1) && Mid < 1) { function.WriteErrMsg("参数错误"); }
            M_ModelInfo model = modBll.GetModelById(ModelID);
            M_Node nodeMod = nodeBll.SelReturnModel(NodeID);
            if (Mid > 0)
            {
                if (mu.UserName != Cdata.Inputer) { function.WriteErrMsg("不能编辑不属于自己输入的内容!"); }
                DataTable dtContent = conBll.GetContent(Mid);
                ViewBag.modelhtml = fieldBll.InputallHtml(Cdata.ModelID, Cdata.NodeID, new ModelConfig()
                {
                    Source = ModelConfig.SType.UserContent,
                    ValueDT = dtContent
                });
            }
            else
            {
                ViewBag.modelhtml = fieldBll.InputallHtml(ModelID, NodeID, new ModelConfig()
                {
                    Source = ModelConfig.SType.UserContent
                });
            }
            ViewBag.ds = fieldBll.SelByModelID(ModelID, true);
            ViewBag.op = (Mid < 1 ? "添加" : "修改") + model.ItemName;
            ViewBag.tip = "向 <a href='MyContent?NodeId=" + nodeMod.NodeID + "'>[" + nodeMod.NodeName + "]</a> 节点" + ViewBag.op;
            return View(Cdata);
        }
        [HttpPost]
        [ValidateInput(false)]
        public void Content_Add1()
        {
            M_Node nodeMod = nodeBll.SelReturnModel(NodeID);
            M_CommonData CData = new M_CommonData();
            if (Mid > 0)
            {
                CData = conBll.GetCommonData(Mid);
                if (!CData.Inputer.Equals(mu.UserName)) { function.WriteErrMsg("你无权修改该内容"); }
            }
            else
            {
                CData.NodeID = NodeID;
                CData.ModelID = ModelID;
                CData.TableName = modBll.GetModelById(CData.ModelID).TableName;
            }
            DataTable dt = fieldBll.SelByModelID(CData.ModelID, false);
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromMVC(dt, Request);
            CData.Title = Request.Form["title"];
            CData.Subtitle = Request["Subtitle"];
            CData.PYtitle = Request["PYtitle"];
            CData.TagKey = Request.Form["tagkey"];
            CData.Status = nodeMod.SiteContentAudit;
            string parentTree = "";
            CData.FirstNodeID = nodeBll.SelFirstNodeID(CData.NodeID, ref parentTree);
            CData.ParentTree = parentTree;
            CData.TitleStyle = Request.Form["TitleStyle"];
            //CData.TopImg = Request.Form["selectpic"];//首页图片
            
            if (Mid > 0)//修改内容
            {
                conBll.UpdateContent(table, CData);
            }
            else
            {
                CData.DefaultSkins = 0;
                CData.EliteLevel = 0;
                CData.UpDateType = 2;
                CData.InfoID = "";
                CData.RelatedIDS = "";
                CData.Inputer = mu.UserName;
                CData.GeneralID = conBll.AddContent(table, CData);//插入信息给两个表，主表和从表:CData-主表的模型，table-从表
            }
            //if (Mid <= 0)//添加时增加积分
            //{
            //    //积分
            //    if (SiteConfig.UserConfig.InfoRule > 0)
            //    {
            //        buser.ChangeVirtualMoney(mu.UserID, new M_UserExpHis()
            //        {
            //            UserID = mu.UserID,
            //            detail = "添加内容:" + CData.Title + "增加积分",
            //            score = SiteConfig.UserConfig.InfoRule,
            //            ScoreType = (int)M_UserExpHis.SType.Point
            //        });
            //    }
            //}
            function.WriteSuccessMsg("操作成功!", "MyContent?NodeID=" + CData.NodeID);
        }
    }
}