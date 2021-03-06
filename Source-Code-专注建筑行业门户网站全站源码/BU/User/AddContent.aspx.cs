﻿namespace ZoomLa.WebSite.User.Content
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data;
    using System.Web;
    using ZoomLa.BLL;
    using ZoomLa.BLL.Helper;
    using ZoomLa.BLL.Plat;
    using ZoomLa.Common;
    using ZoomLa.Components;
    using ZoomLa.Model;
    using ZoomLa.Model.Plat;
    using ZoomLa.SQLDAL;

    //与后台分开维护edit与add共用
    public partial class AddContentpage : System.Web.UI.Page
    {
        B_User buser = new B_User();
        B_Content contentBll = new B_Content();
        B_Content_WordChain wordBll = new B_Content_WordChain();
        B_Model modelBll = new B_Model();
        B_ModelField mfieldBll = new B_ModelField();
        B_Node nodeBll = new B_Node();
        B_Spec spbll = new B_Spec();
        B_KeyWord keyBll = new B_KeyWord();
        public string Tips { get; set; }
        public int NodeID
        {
            get { return DataConvert.CLng(ViewState["NodeID"]); }
            set { ViewState["NodeID"] = value; }
        }
        public int ModelID
        {
            get { return DataConvert.CLng(ViewState["ModelID"]); }
            set { ViewState["ModelID"] = value; }
        }
        public int GeneralID { get { return DataConvert.CLng(Request.QueryString["GeneralID"]); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                M_CommonData commdata = new M_CommonData();
                if (GeneralID > 0)
                {
                    commdata = contentBll.GetCommonData(this.GeneralID);
                    NodeID = commdata.NodeID;
                    ModelID = commdata.ModelID;
                }
                else
                {
                    NodeID = DataConvert.CLng(Request.QueryString["NodeID"]);
                    ModelID = DataConvert.CLng(Request.QueryString["ModelID"]);
                }
                if ((ModelID < 1 && NodeID < 1) && GeneralID < 1) { function.WriteErrMsg("参数错误"); }
                if (!string.IsNullOrEmpty(Request.QueryString["Source"])) { function.Script(this, "SetContent();"); }
                //-------------------------------------------
                DataTable ds = mfieldBll.SelByModelID(ModelID, true);
                bt_txt.Text = B_Content.GetFieldAlias("Title", ds);
                gjz_txt.Text = B_Content.GetFieldAlias("Tagkey", ds);
                Label4.Text = B_Content.GetFieldAlias("Subtitle", ds);
                py.Text = B_Content.GetFieldAlias("PYtitle", ds);
                //-------------------------------------------
                M_ModelInfo model = modelBll.GetModelById(ModelID);
                string optionstr = GeneralID > 0 ? "修改" : "添加";
                Label1.Text = optionstr + model.ItemName;
                EBtnSubmit.Text = optionstr + model.ItemName;
                //-------------------------------------------
                if (spbll.GetSpecList().Rows.Count > 0)
                { SpecInfo_Li.Text = "<button type='button' class='btn btn-info btn-sm' onclick='ShowSpDiag()'>添加至专题</button>"; }
                else
                { SpecInfo_Li.Text = "<div style='margin:5px;' class='btn btn-default disabled'><span class='fa fa-info-circle'></span> 尚未定义专题</div>"; }
                //-------------------------------------------
                M_Node nodeMod = nodeBll.SelReturnModel(NodeID);
                CreateHTML.Visible = nodeMod.ListPageHtmlEx < 3;
                Tips = "向 <a href='/User/Content/MyContent.aspx?NodeId=" + nodeMod.NodeID + "'>[" + nodeMod.NodeName + "]</a> 节点" + optionstr + model.ItemName;
                if (GeneralID > 0)
                {
                    MyBind(commdata);
                }
                else
                {
                    ModelHtml.Text = mfieldBll.InputallHtml(ModelID, NodeID, new ModelConfig()
                    {
                        Source = ModelConfig.SType.UserContent
                    });
                }
                if (nodeMod.Contribute != 1) { function.Script(this, "ShowSys();"); }
            }
        }
        public void MyBind(M_CommonData Cdata)
        {
            M_UserInfo mu = buser.GetLogin();
            if (mu.UserName != Cdata.Inputer) { function.WriteErrMsg("不能编辑不属于自己输入的内容!"); }
            txtTitle.Text = Cdata.Title;
            Keywords.Text = Cdata.TagKey;
            PYtitle.Text = Cdata.PYtitle;
            DataTable dtContent = contentBll.GetContent(this.GeneralID);
            ModelHtml.Text = mfieldBll.InputallHtml(Cdata.ModelID, Cdata.NodeID, new ModelConfig()
            {
                Source = ModelConfig.SType.UserContent,
                ValueDT = dtContent
            });

        }
        protected void EBtnSubmit_Click(object sender, EventArgs e)//添加文章
        {
            M_UserInfo mu = buser.GetLogin();
            M_Node nodeMod = nodeBll.SelReturnModel(NodeID);
            IList<string> content = new List<string>();
            M_CommonData CData = new M_CommonData();
            DataTable dt = mfieldBll.SelByModelID(ModelID, false);
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState, content);
            if (GeneralID > 0) { CData = contentBll.GetCommonData(GeneralID); }
            else
            {
                CData.NodeID = NodeID;
                CData.ModelID = ModelID;
                CData.TableName = modelBll.GetModelById(CData.ModelID).TableName;
            }
            CData.Title = txtTitle.Text.Trim();
            CData.EliteLevel = 0;
            CData.InfoID = "";
            CData.UpDateType = 2;
            CData.TagKey = Request.Form["tabinput"];
            CData.Status = nodeMod.SiteContentAudit;
            CData.DefaultSkins = 0;
            string parentTree = "";
            CData.FirstNodeID = nodeBll.SelFirstNodeID(NodeID, ref parentTree);
            CData.ParentTree = parentTree;
            CData.TitleStyle = ThreadStyle.Value;
            //CData.TopImg = Request.Form["selectpic"];//首页图片
            CData.Subtitle = Subtitle.Text;
            CData.PYtitle = PYtitle.Text;
            CData.RelatedIDS = RelatedIDS_Hid.Value;
            CData.IsComm = 1;
            if (GeneralID > 0)//修改内容
            {
                contentBll.UpdateContent(table, CData);
            }
            else
            {
                CData.Inputer = mu.UserName;
                CData.GeneralID = contentBll.AddContent(table, CData);//插入信息给两个表，主表和从表:CData-主表的模型，table-从表
            }
            if (GeneralID <= 0)//添加时增加积分
            {
                //积分
                if (SiteConfig.UserConfig.InfoRule > 0)
                {
                    buser.ChangeVirtualMoney(mu.UserID, new M_UserExpHis()
                    {
                        UserID = mu.UserID,
                        detail = "添加内容:" + txtTitle.Text + "增加积分",
                        score = SiteConfig.UserConfig.InfoRule,
                        ScoreType = (int)M_UserExpHis.SType.Point
                    });
                }
            }
            if (true)//nodeMod.CUName.Equals("能力中心")
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
            }
            function.WriteSuccessMsg("操作成功!", "MyContent.aspx?NodeID=" + NodeID);
        }


        //草稿
        protected void DraftBtn_Click(object sender, EventArgs e)
        {
            M_UserInfo mu = buser.GetLogin();
            DataTable dt = mfieldBll.GetModelFieldList(ModelID);
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState);
            M_CommonData CData = new M_CommonData();
            if (GeneralID > 0) { CData = contentBll.GetCommonData(GeneralID); }
            else
            {
                CData.NodeID = NodeID;
                CData.ModelID = ModelID;
                CData.TableName = modelBll.GetModelById(ModelID).TableName;
            }
            CData.Title = txtTitle.Text.Trim();
            CData.Status = (int)ZLEnum.ConStatus.Draft;
            CData.Inputer = mu.UserName;
            CData.InfoID = "";
            CData.PdfLink = "";
            CData.TagKey = Request.Form["tabinput"];
            CData.Subtitle = Subtitle.Text;
            CData.PYtitle = PYtitle.Text;
            CData.TitleStyle = Request.Form["ThreadStyle"];
            string parentTree = "";
            CData.FirstNodeID = nodeBll.SelFirstNodeID(NodeID, ref parentTree);
            CData.ParentTree = parentTree;
            if (GeneralID > 0) { contentBll.UpdateContent(table, CData); }
            else { contentBll.AddContent(table, CData); }
            Response.Redirect("MyContent.aspx?NodeID=" + CData.NodeID);
        }
        //显示前台浏览按钮
        public string GetOpenView()
        {
            string outstr = "", strurl = string.Empty;
            strurl = "Class_" + NodeID + "/Default.aspx";
            outstr = " <a href='/" + strurl + "'  target='_blank' title='前台浏览'><span class='fa fa-eye'></span></a>";
            return outstr;
        }
        //----------------------------Tools
    }
}