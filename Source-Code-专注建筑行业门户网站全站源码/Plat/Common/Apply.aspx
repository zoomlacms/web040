<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Apply.aspx.cs" Inherits="ZoomLaCMS.Plat.Common.Apply" MasterPageFile="~/Common/Common.master"  %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>能力申请</title>
<link href="/Template/JianTu/style/global.css?v=20150910" rel="stylesheet" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="home_top">
<div class="container">
<div class="home_top_l">
<span class="pull-left"><a href="/">建途首页</a></span>
<div class="home_top_ls">
<div class="home_top_lsc">
<span class="site_span">局域网</span><span class="site_ch">[切换城市]<span class="caret"></span></span>
</div>
<ul>
<li><strong>热门城市：</strong><a href="/">全国</a><a href="/Class_468/Default.aspx">上海</a><a href="/Class_466/Default.aspx">北京</a><a href="/Class_484/Default.aspx">广东</a><a href="/Class_482/Default.aspx">湖北</a><a href="/Class_486/Default.aspx">四川</a></li>
<li>华北：<a href="/Class_466/Default.aspx">北京</a><a href="/Class_467/Default.aspx">天津</a><a href="/Class_470/Default.aspx">河北</a><a href="/Class_471/Default.aspx">山西</a><a href="/Class_492/Default.aspx">内蒙古</a></li>
<li>华东：<a href="/Class_468/Default.aspx">上海</a><a href="/Class_475/Default.aspx">江苏</a><a href="/Class_476/Default.aspx">浙江</a><a href="/Class_477/Default.aspx">安徽</a><a href="/Class_478/Default.aspx">福建</a><a href="/Class_480/Default.aspx">山东</a></li>
<li>华南：<a href="/Class_484/Default.aspx">广东</a><a href="/Class_493/Default.aspx">广西</a><a href="/Class_485/Default.aspx">海南</a></li>
<li>华中：<a href="/Class_479/Default.aspx">江西</a><a href="/Class_481/Default.aspx">河南</a><a href="/Class_482/Default.aspx">湖北</a><a href="/Class_483/Default.aspx">湖南</a></li>
<li>西南：<a href="/Class_469/Default.aspx">重庆</a><a href="/Class_486/Default.aspx">四川</a><a href="/Class_487/Default.aspx">贵州</a><a href="/Class_488/Default.aspx">云南</a><a href="/Class_494/Default.aspx">西藏</a></li>
<li>西北：<a href="/Class_489/Default.aspx">陕西</a><a href="/Class_490/Default.aspx">甘肃</a><a href="/Class_491/Default.aspx">青海</a><a href="/Class_495/Default.aspx">宁夏</a><a href="/Class_496/Default.aspx">新疆</a></li>
<li>东北：<a href="/Class_472/Default.aspx">辽宁</a><a href="/Class_473/Default.aspx">吉林</a><a href="/Class_474/Default.aspx">黑龙江</a></li>
</ul>
</div>24小时客服热线：<a href="tel:400-6789-314">400-6789-314</a>
</div>
<div class="home_top_r">
<ul class="nav">
<li style="line-height:normal;"><a href="#" style="padding-top:3px; padding-bottom:3px;"><img src="http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/bt_blue_76X24.png" alt="QQ登录"></a></li>
<li class="nav_user">
<a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎您，<span><%=mu.UserName %>!</span></a>
<ul class="dropdown-menu" role="menu">
<li><a href="/User/Login.aspx">会员中心</a></li>
<li class="logon"><a href="/User/Info/UserInfo.aspx">资料维护</a></li>
<li class="logon"><a href="javascript:;" onclick="LogoutFun();">安全退出</a></li>
</ul>
</li>
<li><a href="/Guest">客户服务</a></li>
</ul>
</div>
</div>
</div>
<div class="container myuser_top">
<div class="media">
<div class="media-left"><a href="/User/Info/UserInfo"><img class="media-object" src="<%=mu.UserFace %>" alt="<%=mu.UserName %>" onerror="javascript:this.src='/Images/userface/noface.png';" /></a></div>
<div class="media-body media-middle">
<h4 class="media-heading"><%=mu.UserName %> <span><a href="/User/"><i class="fa fa-home"></i> 我的主页</a></span></h4>
<p>
<span>会员类型：<%=groupMod.GroupName %></span>
<span>加入时间：<%=mu.RegTime.ToString() %></span>
<span>余额：<a href="/User/Info/ConsumeDetail?SType=1" title="点击查看资金明细"><i class="fa fa-rmb"></i> <%=mu.Purse.ToString("f2") %></a> <a href="/PayOnline/SelectPayPlat.aspx">[在线充值]</a> <a href="/User/Money/WithDraw">[申请提现]</a></span>
<span>积分：<a href="/User/Info/ConsumeDetail?SType=3" title="点击查看积分明细"><i class="fa fa-credit-card-alt"></i> <%=mu.UserExp.ToString("f0") %></a></span>
</p>
</div>
</div>
</div>
<div class="u_nav">
<nav class="navbar navbar-default">
<div class="container">
<!-- Brand and toggle get grouped for better mobile display -->
<div class="navbar-header">
<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand visible-xs" href="#">快速导航</a>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav">
<li id="nav_home" class="active"><a href="/User/">首页</a></li>
<li id="nav_content"><a href="/User/Info/UserBase">账户设置</a></li>
<li id="nav_cloud"><a href="/User/Cloud/Index">云盘</a></li>
<li id="nav_oa" style="display:none;"><a href="/Class_79/Default.aspx"><span></span>建途OA</a></li>
</ul>
</div>
</div>
</nav>
</div>


<div class="container myuser_hmain">
<div class="row">
<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12">
<div class="myuser_left">
<ul>
<li><a href="/User/"><i class="fa fa-home"></i> 我的建途</a></li>
<li><a href="/User/Info/UserInfo"><i class="fa fa-user"></i> 账号信息</a></li>
<li><a href="/PayOnline/SelectPayPlat.aspx"><i class="fa fa-money"></i> 充值中心</a></li>
<li><a href="/User/Content/MyFavori?type=1"><i class="fa fa-heart"></i> 我的收藏</a></li>
<li><a href="User/iServer/FiServer"><i class="fa fa-question-circle-o"></i> 有问必答</a></li>
<li><a href="/User/Change/Mobile"><i class="fa fa-mobile"></i> 更改手机</a></li>
<li><a href="/User/Change/Email"><i class="fa fa-envelope"></i> 更改邮箱</a></li>
<li><a href="/User/Change/Pwd"><i class="fa fa-lock"></i> 更改密码</a></li>
</ul>
</div>
</div>

<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12" style="margin-top:20px;">
<ol class="breadcrumb">
<li><a href="@Url.Action("Default","")">会员中心</a></li>
<li class="active">功能引导</li>
</ol>
<div id="Form_Div" runat="server">
<div class="panel panel-default">
<div class="panel-heading"><h2 class="pull-left">开通能力中心服务</h2><div class="clearfix"></div></div>
<div class="panel-body">
<p>请您认真填写下方申请表单以便官方客服为您提供周全服务！</p>
<table class="table">
<tr><td class="td_m">单位名称</td><td><ZL:TextBox runat="server" ID="CompName_T" AllowEmpty="false" class="form-control text_300"/><span class="r_red">*</span></td></tr>
<tr><td>单位简称</td><td><ZL:TextBox runat="server" ID="CompShort_T" AllowEmpty="false" class="form-control text_300" MaxLength="4"/><span class="r_red">*</span></td></tr>
<tr><td>联系人</td><td><ZL:TextBox runat="server" ID="Contact_T" AllowEmpty="false" ValidType="String" class="form-control text_300"/><span class="r_red">*</span></td></tr>
<tr><td>邮箱</td><td><ZL:TextBox runat="server" ID="Email_T" AllowEmpty="false" ValidType="Mail" class="form-control text_300"/><span class="r_red">*</span></td></tr>
<tr><td>联系电话<br />(手机或座机) </td><td><ZL:TextBox runat="server" ID="Mobile_T" AllowEmpty="false" ValidType="MobileOrPhone" class="form-control text_300"/><span class="r_red">*</span></td></tr>
<tr><td>QQ</td><td><ZL:TextBox runat="server" ID="QQ_T" ValidType="Int" class="form-control text_300"/></td></tr>
<tr><td>申请备注</td><td><asp:TextBox runat="server" ID="UserRemind_T" TextMode="MultiLine" class="form-control text_300" MaxLength="100" style="height:120px;resize:none;"></asp:TextBox></td></tr>
<tr><td></td><td>
<asp:Button runat="server" ID="Save_Btn" OnClick="Save_Btn_Click" Text="提交申请" class="btn btn-info" />

</td></tr>
</table>
</div>
</div>
</div>
<div id="Tip_Div" runat="server" class="container userform" visible="false">
<div class="panel panel-default">
<div class="panel-heading" style="font-size:2em;"> 恭喜！</div>
<div class="panel-body text-center" runat="server" id="remind_div">
<p> 您已经成功申请，系统审核后会以电子邮件通知您！</p>
<div>
<a href="/" class="btn btn-info" style="color:#fff;"><i class="fa fa-home"></i> 回到首页</a>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<%Call.Label("{ZL.Label id=\"全站底部\"/}"); %>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script>
$().ready(function () {
    $("body").addClass("myuser_body");
})
//OA权限判断
var oanum="<%Call.Label("{ZL.Label id=\"输出办公角色权限\" /}");%>";
if(oanum>0){
    $(".u_menu a[href='/Plat/Common/Apply.aspx'").parent().parent().remove();
    $(".u_menu a[href='/Plat/common/ApplyJoinComp.aspx'").parent().parent().remove();
    $("#nav_oa").show();
}
else{
    $("#nav_oa").remove();
}
</script>
</asp:Content>