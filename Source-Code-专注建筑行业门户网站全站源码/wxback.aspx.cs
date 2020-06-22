using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.User.Addon;
using ZoomLa.BLL.WxPayAPI;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.Model.User;
using ZoomLa.SQLDAL;

public partial class wxback : System.Web.UI.Page
{
    //进入该页即开始推广,自动创建用户,关联APPID
    protected void Page_Load(object sender, EventArgs e)
    {
        B_User buser = new B_User();
        B_UserAPP appBll = new B_UserAPP();
        int puid = DataConverter.CLng(Session["WX_PUserID"]);
        string rurl = DataConvert.CStr(Session["WX_R"]);
        if (string.IsNullOrEmpty(rurl)) { rurl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx5f4c9abaac2af4d6&redirect_uri=http%3a%2f%2fwww.jt314.com%2fUser%2fDefault.aspx&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"; }
        //if (puid < 1) { function.WriteErrMsg("推荐用户不存在"); }
        M_WX_APPID appMod = new M_WX_APPID();//自行置入缓存,使用时取出
        appMod.APPID = WxPayConfig.APPID;//"wx674f7f7116d71f52";
        appMod.Secret = WxPayConfig.APPSECRET;//1ea6ecc8a53028019f604097379d3b21
        WxAPI wxapi = WxAPI.Code_Get(1);
        //wxapi.AppId = appMod;
        string code = Request["code"];
        string access_token = APIHelper.GetWebResult("https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appMod.APPID + "&secret=" + appMod.Secret + "&code=" + code + "&grant_type=authorization_code");
        JObject obj = (JObject)JsonConvert.DeserializeObject(access_token);
        JObject userobj = (JObject)JsonConvert.DeserializeObject(APIHelper.GetWebResult("https://api.weixin.qq.com/sns/userinfo?access_token=" + obj["access_token"] + "&openid=" + obj["openid"] + "&lang=zh_CN"));
        string openID = obj["openid"].ToString();
        Appinfo umod = appBll.SelModelByOpenID(openID, "wechat");
        M_UserInfo mu = new M_UserInfo();
        if (umod != null)
        {
            mu = buser.SelReturnModel(umod.UserID);
            buser.SetLoginState(mu);
            Response.Redirect(rurl);
        }
        else //新用户则注册
        {
            umod = new Appinfo();
            mu.UserName = "wx" + DateTime.Now.ToString("yyyyMMddHHmmss") + function.GetRandomString(2).ToLower();
            mu.UserPwd = StringHelper.MD5(function.GetRandomString(6));
            mu.Email = function.GetRandomString(10) + "@wx.com";
            mu.Question = function.GetRandomString(5);
            mu.Answer = function.GetRandomString(5);
            mu.ParentUserID = puid.ToString();
            mu.TrueName = userobj["nickname"].ToString();
			mu.GroupID=1;
            mu.UserID = buser.Add(mu);

            umod.UserID = mu.UserID;
            umod.SourcePlat = "wechat";
            umod.OpenID = openID;
            appBll.Insert(umod);
            M_Uinfo mubase = new M_Uinfo();
            mubase.UserId = mu.UserID;
            buser.AddBase(mubase);
            //推广人得积分
            if (puid > 0)
            {
                M_UserInfo pmu = buser.SelReturnModel(puid);
                if (!pmu.IsNull)
                {
                    //DataTable dt = SqlHelper.ExecuteTable(CommandType.Text, "select * from ZL_User where ParentUserID=" + pmu.UserID, null);
                    //if (dt.Rows.Count >= 7&&pmu.GroupID<6)
                    //{
                    //    pmu.GroupID = 6;
                    //    buser.UpdateByID(pmu);
                    //}
                    buser.ChangeVirtualMoney(pmu.UserID, new M_UserExpHis()
                    {
                        score = 20,
                        ScoreType = (int)M_UserExpHis.SType.Point,
                        detail = "新用户[" + mu.UserName + "]注册,获得推广积分:" + 20
                    });
                }
            }
            buser.SetLoginState(mu);
            Response.Redirect(rurl);
        }
    }
}