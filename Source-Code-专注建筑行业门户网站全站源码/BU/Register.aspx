<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="ZoomLa.WebSite.User.User_Register" ClientIDMode="Static" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="/dist/css/font-awesome.min.css" />
<style>
body { font-family:"STHeiti","Microsoft YaHei","黑体","arial";}
.agr_content {z-index: 1; top: 0; left: 0; color: #fff; background-color: #369;  padding: 12px; opacity: 1;}
.agr_head{margin-top: 5em; border-radius: 15px; height: 28px; width: 100%; background-color: #BBB; color: #282828;margin:10px 0px; text-align: center;}
.border_right { margin:auto; padding-top:20px; padding-bottom:20px; padding-left:30px; padding-right:30px; box-shadow:0 0 5px rgba(0,0,0,0.45); width:360px; border-radius:4px;}
.reg_sub_t { margin-bottom:15px; padding-bottom:10px; font-size:1.2em; font-weight:bold; color:#286bd6; text-align:center; border-bottom:3px solid #286bd6;}
.reg_sub_item li { margin-bottom:10px;}
.login_remind { margin-top:10px; margin-bottom:0;}
.agr_content { margin-top:10px; margin-bottom:10px; }
.reg_info { margin:auto; width:360px;}
.reg_info ul { margin-bottom:0; padding-left:0; list-style:none;}
.reg_info li { margin-bottom:10px;}
.reg_info li span { color:#c00;}
.d_ok { color: green; }
.d_err { color: red; }
.tdbg { background: none !important; }
.login_logo img { display:inline-block; margin-top:30px; margin-right:30px; max-width:10em; }
.login_footer { text-align:center;}
.login_footer a { margin-left:10px;}
#BtnSubmit { border:1px solid #00a3e9; background:#00a3e9;}
@media screen and (max-width:768px){ /*小于768px私有*/
.border_right { margin-top:1em; margin-bottom:1em; margin-left:0; width:100%;}
}
</style>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script src="/dist/js/bootstrap.min.js"></script>
<title>用户注册-<%:Call.SiteName %></title>
</head>
<body>
<form id="form1" runat="server">
<div class="container">
<div class="row">
<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
<div class="login_logo">
<a href="/"><img src="<%Call.Label("{$LogoUrl/}");%>" class="img-responsive" alt="<%Call.Label("{$SiteName/}");%>"/></a>
<img src="/Template/JianTu/style/images/logo2.png" alt="构筑建筑之通途" />
</div>
</div>
<div class="clearfix"></div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 hidden-xs">
<div><img src="/Template/JianTu/style/Images/login.png" class="img-responsive" alt="登录"/></div>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div id="backimg_div">
<div class="user_mimenu" hidden>
<div class="navbar navbar-fixed-top" role="navigation">
<button type="button" class="btn btn-default" id="mimenu_btn">
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<div class="user_mimenu_left">
<ul class="list-unstyled">
<li><a href="/" target="_blank">首页</a></li>
<li><a href="/Home" target="_blank">能力</a></li>
<li><a href="/Index" target="_blank">社区</a></li>
<li><a href="/Ask" target="_blank">问答</a></li>
<li><a href="/Guest" target="_blank">留言</a></li>
<li><a href="/Baike" target="_blank">百科</a></li>
<li><a href="/Office" target="_blank">OA</a></li>
</ul>
</div>
<div class="navbar-header">
<button class="navbar-toggle in" type="button" data-toggle="collapse" data-target=".navbar-collapse">
<span class="sr-only">移动下拉</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
</div>
</div>
</div>
<div id="reg_main">
<asp:Panel ID="PnlRegStep0" runat="server" Visible="false" Width="100%">未开放注册，请和网站管理员联系！</asp:Panel>
<asp:Panel ID="PnlRegStep1" runat="server" Visible="false" Width="100%">
<h1>第一步：服务条款和声明</h1>
<textarea name="textarea" cols="20" rows="2" readonly style="font-weight: normal; font-size: 9pt; width: 99%; line-height: normal; font-style: normal; height: 372px; font-variant: normal"><asp:Literal ID="LitProtocol" runat="server"></asp:Literal></textarea>
<div class="rsubmit">
<asp:Button ID="BtnRegStep1" CssClass="btn btn-primary" runat="server" Text="同意" OnClick="BtnRegStep1_Click" />
<asp:Button ID="BtnRegStep1NotApprove" CssClass="btn btn-primary" runat="server" Text="不同意" OnClick="BtnRegStep1NotApprove_Click" />
</div>

<asp:HiddenField ID="hfUrl" runat="server" />
<!--第二轮开始 -->
<script type="text/javascript">
var secs = 9;
var wait = secs * 1000;
var agreeBtn = document.getElementById("BtnRegStep1");
agreeBtn.disabled = true;

function regload() {
agreeBtn.value = "我同意[" + secs + "]";
for (i = 1; i <= secs; i++) {
window.setTimeout("Update(" + i + ")", i * 1000);
}
window.setTimeout("Timer()", wait);
}

function Update(num) {
if (num != secs) {
printnr = (wait / 1000) - num;
agreeBtn.value = "我同意[" + printnr + "]";
}
}
function Timer() { agreeBtn.disabled = false; agreeBtn.value = "我同意"; }
function endbtn() { agreeBtn.disabled = false; }
</script>
</asp:Panel>
<asp:Panel ID="PnlMRegStep1" runat="server" Visible="false">
<div id="MobileRegis" class="reg_sub" runat="server">
<h1>第一步：手机验证</h1>
<asp:Label ID="lbmob" runat="server"></asp:Label>
<ul>
<li>
<div class="form-group">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-12 text-right padding0">手机号：</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-12 ">
<asp:TextBox ID="TxtMobile1" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="Literal4" runat="server"></asp:Literal>
</div>
<div class="col-sm-3 col-lg-3 col-md-3 col-xs-12 ">
<asp:RequiredFieldValidator ID="rg1" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="手机号码不能为空" SetFocusOnError="false" ControlToValidate="TxtMobile1" />
<asp:RegularExpressionValidator ID="rg4" Display="Dynamic" ForeColor="Red" runat="server" ControlToValidate="TxtMobile1" ErrorMessage="请输入正确的手机号码" ValidationExpression="^1\d{10}$" />
</div>
</div>
<div class="clearfix"></div>
</li>
<li>
<div class="form-group">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-12 text-right padding0">验证码：</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-12 ">
<asp:TextBox ID="MobileCode" placeholder="验证码" MaxLength="6" Style="width: 90%;" runat="server" CssClass="form-control"></asp:TextBox>
<input type="hidden" id="MobileCode_hid" name="MobileCode_hid" />
</div>
<div class="col-sm-3 col-lg-3 col-md-3 col-xs-12 ">
<img id="MobileCode_img" title="点击刷新验证码" class="codeimg" style="height: 34px; width: 100px;" />
</div>
</div>
<div class="clearfix"></div>
</li>
<li>
<div class="form-group">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-12 text-right padding0">短信验证码：</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-12 ">
<asp:TextBox ID="MobileCode_T" runat="server" CssClass="form-control"></asp:TextBox>
</div>
<div class="col-sm-3 col-lg-3 col-md-3 col-xs-12 padding0 text-left">
<button type="button" runat="server" id="send_btn" class="btn btn-info">
获取验证码
</button>
<asp:RequiredFieldValidator ID="RMV1" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="短信验证码不能为空" SetFocusOnError="false" ControlToValidate="MobileCode_T" />
<%--<asp:Button ID="sendBtn" runat="server" Text="获取验证码" OnClick="SendMob_Click" CssClass="btn btn-info" />--%>
</div>
</div>
</li>
<li class="text-center">
<asp:Button ID="Button1" runat="server" Text="下一步" OnClick="BtnMRegStep1_Click" CssClass="btn btn btn-primary" Style="margin-top: 10px;" />
</li>
</ul>
</div>
</asp:Panel>
<asp:Panel ID="PnlRegStep2" runat="server" Visible="false" Width="100%">
<div class="border_right">
<div class="reg_sub">
<!--注册用户--补全信息--注册成功(替换为图片形式)-->
<div class="reg_sub_t">会员注册</div>
<div class="reg_sub_item">
<ul class="list-unstyled">
<li>
<asp:TextBox ID="TxtUserName" CssClass="form-control" runat="server" onblur="CheckUser();" placeholder="请输入用户名" />
<span class="d_err" id="CheckUserNameMessage"></span>
<asp:RegularExpressionValidator ID="R4" runat="server" ControlToValidate="TxtUserName" ErrorMessage="不能包含特殊字符" ValidationExpression="^[^@#$%^&*()'?{}\[\];:]*$" Display="Dynamic" ForeColor="Red" />
<asp:RequiredFieldValidator ID="RUN5" runat="server" ControlToValidate="TxtUserName" ErrorMessage="用户名不能为空" ValidationGroup="userVaid" Display="Dynamic" ForeColor="Red" />
<span id="Span1" runat="server" visible="false"></span>
</li>
<li>
<!--必填字段-->
<table id="TableRegisterMust" runat="server" class="register_modeltable" style="width: 100%; border: none;"></table>
<table class="register_modeltable">
<asp:Literal runat="server" ID="MustHtml_L"></asp:Literal>
</table>
<!--组模型字段 AJAX-->
<table id="ModelFiled_table" class="register_modeltable" border="0" style="width: 100%;"></table>
</li>

<li>
<asp:TextBox ID="TxtPassword" TextMode="Password" runat="server" CssClass="form-control" onfocus=" focusinput();" onkeyup="f_checkrank();" placeholder="密码由6-20位字母，数字和符号组合" />
<asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidatorPassword" ControlToValidate="TxtPassword" ValidationExpression="[\S]{6,}" ValidationGroup="userVaid" ErrorMessage="密码至少6位" Display="Dynamic" ForeColor="Red" />
<asp:RequiredFieldValidator runat="server" ID="ReqTxtPassword" ControlToValidate="TxtPassword" SetFocusOnError="false" ValidationGroup="userVaid" ErrorMessage="密码不能为空" Display="Dynamic" ForeColor="Red" />
<asp:CustomValidator runat="server" ID="CV1" ErrorMessage="密码强度过低" Display="Dynamic" ForeColor="Red" EnableClientScript="true" ClientValidationFunction="PwdCheck" ControlToValidate="TxtPassword" ValidationGroup="userVaid" />
<div id="valPass" style="display:none;">
<span class="spantxt"><a id="idshow" class="atxt"></a></span>
<span class="spantxt"><a id="apass1" class="a_bor visible-xs"></a><a id="apass2" class="a_bor visible-xs"></a><a id="apass3" class="a_bor visible-xs"></a></span>
<span style="margin-left: 10px;"></span>
</div>
</li>
<li>
<asp:TextBox ID="TxtPwdConfirm" TextMode="Password" runat="server" CssClass="form-control" placeholder="请再次输入上面的密码" />
<asp:RequiredFieldValidator ID="req1" runat="server" ControlToValidate="TxtPwdConfirm" ValidationGroup="userVaid" SetFocusOnError="false" Display="Dynamic" ErrorMessage="确认密码不能为空" ForeColor="Red" />
<asp:CompareValidator ID="req2" runat="server" ControlToValidate="TxtPwdConfirm" ControlToCompare="TxtPassword" Operator="Equal" SetFocusOnError="false" ValidationGroup="userVaid" ErrorMessage="两次密码输入不一致" Display="Dynamic" ForeColor="Red" />
</li>
<li>
<div class="input-group">
<asp:TextBox ID="RMobileCode_T" runat="server" CssClass="form-control" placeholder="短信验证码"></asp:TextBox>
<span class="input-group-btn">
<button class="btn btn-info" type="button" id="regsend_btn">获取验证码</button>
</span>
</div><!-- /input-group -->
<asp:RequiredFieldValidator ID="RMV2" runat="server" ControlToValidate="RMobileCode_T" ErrorMessage="短信验证码不能为空" ValidationGroup="userVaid" Display="Dynamic" ForeColor="Red" />
</li>
<li id="regVcodeRegister" runat="server" visible="false">
<div class="col-md-3 col-xs-5">
<label>验证码</label>
</div>
<div class="col-md-6 col-xs-7 padding0">
<div class="form-group" id="trVcodeRegister" runat="server">
<asp:TextBox ID="VCode" placeholder="验证码" MaxLength="6" runat="server" CssClass="form-control codestyle"></asp:TextBox>
</div>
</div>
<div class="col-md-3 col-xs-12 padding5">
<img id="VCode_img" title="点击刷新验证码" class="codeimg img-responsive" style="height: 34px; margin-left: 2px;" />
<input type="hidden" id="VCode_hid" name="VCode_hid" />
</div>
</li>
</ul>
<div class="clearfix"></div>
</div>
<div class="reg_sub_item" hidden>
<div class="reg_sub_t"><i class="fa fa-lock"></i>安全设置</div>
<ul class="list-unstyled">
<li>
<div class="col-md-3 col-xs-5">
<label>密码问题</label>
</div>
<div class="col-md-6 col-xs-7 padding0">
<asp:DropDownList ID="Question_DP" runat="server" CssClass="form-control">
<asp:ListItem>最喜欢的运动是什么？</asp:ListItem>
<asp:ListItem>最喜欢的运动员是谁？</asp:ListItem>
<asp:ListItem>我最喜欢的物品的名称？</asp:ListItem>
<asp:ListItem>我最喜欢的歌曲？</asp:ListItem>
<asp:ListItem>我最喜欢的食物？</asp:ListItem>
<asp:ListItem>我最爱的人的名字？</asp:ListItem>
<asp:ListItem>我最爱的电影？</asp:ListItem>
<asp:ListItem>我妈妈的生日？</asp:ListItem>
<asp:ListItem>我的初恋日期？</asp:ListItem>
</asp:DropDownList>
</div>
<div class="col-md-3 col-xs-12"></div>
<div class="clearfix"></div>
</li>
<li>
<div class="col-md-3 col-xs-5">
<label>问题答案</label>
</div>
<div class="col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtAnswer" runat="server" CssClass="form-control required" Text="111" />
</div>
<div class="col-md-3 col-xs-12 padding5">
<asp:RequiredFieldValidator ID="ReqAnswer" ForeColor="Red" runat="server" ValidationGroup="userVaid" ControlToValidate="TxtAnswer" SetFocusOnError="false" Display="Dynamic" ErrorMessage="问题答案不能为空" />
</div>
<div class="clearfix"></div>
</li>
<li id="regEmail" runat="server">
<div class="col-md-3 col-xs-5">
<label>Email</label>
</div>
<div class="col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtEmail" runat="server" CssClass="form-control" />
</div>
<div class="col-md-3 col-xs-12">
<asp:RequiredFieldValidator ID="ReqTxtEmail" runat="server" ValidationGroup="userVaid" ControlToValidate="TxtEmail" ForeColor="Red" Display="Dynamic" ErrorMessage="Email不能为空" />
<asp:RegularExpressionValidator ID="RE1" runat="server" ControlToValidate="TxtEmail" Display="Dynamic" ForeColor="Red"
ErrorMessage="邮箱地址不规范" ValidationGroup="userVaid" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" />
</div>
</li>
</ul>
<div class="clearfix"></div>
</div>
<div class="reg_sub_item" hidden>
<ul class="list-unstyled">
<li>
<asp:RadioButtonList ID="UserGroup" runat="server" CssClass="register_modeltable" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
</li>
</ul>
</div>
<div class="reg_sub_item sel_reg" hidden>
<div class="reg_sub_t" onclick="SwicthSelectFill();" id="disable_btn" style="cursor: pointer;"><i class="fa fa-leaf"></i>选填信息</div>
<ul class="list-unstyled">
<li>
<table runat="server" id="TableRegisterSelect" style="display: none;" class="selectFill">
<tr id="trSwicthSelectFill" runat="server">
<td style="width: 25%" class="tdbgleft" onclick="SwicthSelectFill()"></td>
<td></td>
</tr>
</table>
<table class="selectFill register_modeltable " style="display: none;">
<asp:Literal runat="server" ID="SelectHtml_L"></asp:Literal>
</table>
</li>
</ul>
</div>
<div>
<!--用户模型字段 S-->
<div hidden>
<table style="border-collapse: collapse; display: none; width: 100%;" id="TableRegisterSelect2" class="selectFill">
<asp:Label ID="reghtml" runat="server"></asp:Label>
<asp:Literal ID="lblHtml" runat="server"></asp:Literal>
</table>
</div>
<!--必填用户字段(模板)从其中取值入TableRegisterMust-->
<table runat="server" id="TableRegister" style="width: 100%; border: none; display: none;">
<tr id="TRParentUserID" runat="server" visible="false">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">推荐人</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtParentUserID" runat="server" CssClass="form-control" onblur="CheckParentUser()"></asp:TextBox>
<asp:Literal ID="musttrParentUserID" runat="server"></asp:Literal>
<br />
<label runat="server" id="CheckParentUserMessage" style="color: red;"></label>
<asp:CustomValidator runat="server" ID="PUR" ControlToValidate="TxtParentUserID" Display="None" ValidateEmptyText="true" ErrorMessage="推荐人不存在!" ForeColor="Red" SetFocusOnError="true" ClientValidationFunction="CheckParent" />
<asp:RequiredFieldValidator ID="ReqTxtParentUserID" runat="server" Display="None" ErrorMessage="推荐人不能为空" SetFocusOnError="false" ControlToValidate="TxtParentUserID" />
</div>
</td>
</tr>
<tr id="TRParentUser" runat="server" visible="false">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">推荐人ID</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtParentUser" runat="server" CssClass="form-control" onblur="CheckParentUserID()"></asp:TextBox>
<asp:Literal ID="musttrParentUser" runat="server"></asp:Literal>
<br />
<label runat="server" id="CheckParentUserIDMessage" style="color: red;"></label>
<asp:RequiredFieldValidator ID="ReqTxtParentUser" runat="server" Display="None" ErrorMessage="推荐人ID不能为空" SetFocusOnError="false" ControlToValidate="TxtParentUserID" />
<asp:RegularExpressionValidator ValidationExpression="\d*" ID="ReqNumTxtParentUser" runat="server" ErrorMessage="推荐人ID必须为有效数字" SetFocusOnError="true" ControlToValidate="TxtParentUserID"></asp:RegularExpressionValidator>
</div>
</td>
</tr>
<tr id="TRInvitCode" runat="server" visible="false">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">邀请码</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtInvitCode" runat="server" CssClass="form-control" onblur="CheckInvitCode()"></asp:TextBox>
<asp:Literal ID="musttrInvitCode" runat="server"></asp:Literal>
<br />
<label runat="server" id="InvitCodeMsg" style="color: red;"></label>
<asp:CustomValidator runat="server" ID="ReqInvitCode" ControlToValidate="TxtInvitCode" Display="None" ValidateEmptyText="true" ErrorMessage="邀请码不存在!" ForeColor="Red" SetFocusOnError="true" ClientValidationFunction="CheckInvite" />
<asp:RequiredFieldValidator ID="ReqTxtInvitCode" runat="server" Display="None" ErrorMessage="邀请码不能为空" SetFocusOnError="false"
ControlToValidate="TxtInvitCode" />
</div>
</td>
</tr>
<tr id="trUserSex" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">性别</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:DropDownList ID="DropSex" runat="server" CssClass="form-control">
<asp:ListItem Text="男" Value="1" Selected="True"></asp:ListItem>
<asp:ListItem Text="女" Value="0"></asp:ListItem>
</asp:DropDownList>
<asp:Literal ID="musttrUserSex" runat="server"></asp:Literal>
</div>
</td>
</tr>
<tr id="trBirthday" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">出生日期</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtBirthday" runat="server" onblur="vaildDate()" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" CssClass="form-control" Text="1985-05-12" />
<asp:Literal ID="musttrBirthday" runat="server"></asp:Literal>
<asp:RequiredFieldValidator ID="ReqTxtBirthday" runat="server" ErrorMessage="出生日期不能为空"
SetFocusOnError="false" ControlToValidate="TxtBirthday" Display="Dynamic" ForeColor="Red" />
</div>
<div class="col-sm-3 col-lg-3 col-md-3 col-xs-12 text-left">
<span id="vaildate" class="d_err"></span>
</div>
</td>
</tr>
<tr id="trHomepage" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">主页</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtHomepage" runat="server" CssClass="form-control">http://</asp:TextBox>
<asp:Literal ID="musttrHomepage" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtHomepage" runat="server" ErrorMessage="主页地址不能为空" SetFocusOnError="false" ControlToValidate="TxtHomepage" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trQQ" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">QQ号码</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtQQ" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrQQ" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtQQ" runat="server" ErrorMessage="QQ号码不能为空" SetFocusOnError="false" ControlToValidate="TxtQQ" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trOfficePhone" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">办公电话</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtOfficePhone" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrOfficePhone" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtOfficePhone" runat="server" ErrorMessage="办公电话不能为空"
SetFocusOnError="false" ControlToValidate="TxtOfficePhone" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trHomePhone" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">家庭电话：</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtHomePhone" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrHomePhone" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtHomePhone" runat="server" ErrorMessage="家庭电话不能为空" SetFocusOnError="false"
ControlToValidate="TxtHomePhone" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trFax" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">传真号码：</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtFax" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrFax" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtFax" runat="server" ErrorMessage="传真号码不能为空" SetFocusOnError="false" ControlToValidate="TxtFax" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trMobile" runat="server">
<td colspan="2">
<asp:TextBox ID="TxtMobile" runat="server" CssClass="form-control" placeholder="请输入手机号码" onblur="CheckUserMobile();"></asp:TextBox>
<span class="d_err" id="CheckUserMobileMessage"></span>

<asp:Literal ID="musttrMobile" runat="server"></asp:Literal>
<asp:RequiredFieldValidator ID="ReqTxtMobile" runat="server" ErrorMessage="手机号码不能为空" SetFocusOnError="false" ControlToValidate="TxtMobile" Display="Dynamic" ForeColor="Red" />
<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtMobile" ErrorMessage="请输入正确的手机号码" ValidationExpression="^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\d{8}$" Display="Dynamic" ForeColor="Red" />
</td>
</tr>
<tr id="trPHS" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">小灵通号码</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtPHS" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrPHS" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtPHS" runat="server" ErrorMessage="小灵通号码不能为空" SetFocusOnError="false" ControlToValidate="TxtPHS" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trAddress" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">联系地址</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtAddress" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrAddress" runat="server"></asp:Literal>
<asp:RequiredFieldValidator ID="ReqTxtAddress" runat="server" ErrorMessage="联系地址不能为空" SetFocusOnError="false"
ControlToValidate="TxtAddress" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trZipCode" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">邮政编码</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtZipCode" runat="server" MaxLength="6" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrZipCode" runat="server"></asp:Literal>
<asp:RequiredFieldValidator ID="ReqTxtZipCode" ValidationGroup="userVaid" runat="server" ErrorMessage="邮政编码不能为空" SetFocusOnError="false" Display="Dynamic" ForeColor="Red" ControlToValidate="TxtZipCode" />
<asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="userVaid" ErrorMessage="请输入正确的邮政编码" ControlToValidate="TxtZipCode" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trTrueName" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">真实姓名</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtTrueName" runat="server" CssClass="form-control" />
<asp:Literal ID="musttrTrueName" runat="server"></asp:Literal>
<asp:RequiredFieldValidator runat="server" ValidationGroup="userVaid" ID="ReqTxtTrueName" ControlToValidate="TxtTrueName" ErrorMessage="真实姓名不能为空" Display="Dynamic" ForeColor="Red" />
</div>
</td>
</tr>
<tr id="trIDCard" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">身份证号码</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtIDCard" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
<asp:Literal ID="musttrIDCard" runat="server"></asp:Literal>
<br />
<label runat="server" id="checkcard" style="color: red;"></label>
必须18位且未在本系统注册过，不足18位请以X替代
<asp:RequiredFieldValidator ValidationGroup="userVaid" runat="server" ControlToValidate="TxtIDCard" ForeColor="Red" ErrorMessage="身份证号码不能为空" ID="ReqTxtIDCard" SetFocusOnError="false" />
<asp:RegularExpressionValidator ValidationGroup="userVaid" runat="server" ControlToValidate="TxtIDCard" ForeColor="Red" ErrorMessage="身份证号码格式不正确" ID="RV3" ValidationExpression="(^\d{15}$)|(^\d{17}([0-9]|X)$)" />
</div>
</td>
</tr>
<tr id="trUserFace" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">头像地址</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 text-left padding0">
<asp:TextBox ID="TxtUserFace" runat="server" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrUserFace" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtUserFace" runat="server" Display="None" ErrorMessage="头像地址不能为空" SetFocusOnError="false" ControlToValidate="TxtUserFace" />
</div>
</td>
</tr>
<tr id="trProvince" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">省市县</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<select name="selprovince" id="selprovince" class="form-control"></select>
<select name="selcity" id="selcity" class="form-control"></select>
<select name="selcoutry" id="selcoutry" class="form-control"></select>
</div>
</td>
</tr>
<tr id="trSign" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">签名档</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:TextBox ID="TxtSign" runat="server" TextMode="MultiLine" Height="60" CssClass="form-control"></asp:TextBox>
<asp:Literal ID="musttrSign" runat="server"></asp:Literal>
<br />
<asp:RequiredFieldValidator ID="ReqTxtSign" runat="server" Display="None" ErrorMessage="签名档不能为空" SetFocusOnError="false" ControlToValidate="TxtSign" />
</div>
</td>
</tr>
<tr id="trPrivacy" runat="server">
<td colspan="2">
<label class="col-sm-3 col-lg-3 col-md-3 col-xs-5">隐私设定</label>
<div class="col-sm-6 col-lg-6 col-md-6 col-xs-7 padding0">
<asp:DropDownList ID="DropPrivacy" runat="server" CssClass="form-control">
<asp:ListItem Text="公开信息" Value="0"></asp:ListItem>
<asp:ListItem Text="只对好友公开" Value="1"></asp:ListItem>
<asp:ListItem Text="完全保密" Value="2"></asp:ListItem>
</asp:DropDownList>
<asp:Literal ID="musttrPrivacy" runat="server"></asp:Literal>
</div>
</td>
</tr>
</table>
<div class="r_red" hidden>以上所有信息除选填项都必须先正确填写后才能成功注册</div>
<div>
<span id="checkAgreement" runat="server">
<asp:CheckBox ID="CheckBox1" runat="server" Text=" 同意并接受" Checked="true" onclick="checkreg(this)" />
<a href="javascript:;" title="点击查看注册协议" onclick="showagr();">《注册协议》</a>
</span>
<asp:Button ID="BtnSubmit" runat="server" Text="注册" CssClass="btn btn-info btn-block" ValidationGroup="userVaid" OnClick="BtnSubmit_Click" />
<p class="login_remind text-center">已有帐号，立即<a href="/User/Login">登录</a></p>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" />
</div>
</div>
</div>
</div>
<%--用于显示勾选时的注册协议--%>
<div class="container">
<div class="agr_content" id="agr_content" style="display:none;" ondblclick="hideagr();">
<div style="margin-bottom:10px;">
<asp:Literal runat="server" ID="Agreement_Lit"></asp:Literal>
</div>
<button type="button" class="btn btn-info btn-block" onclick="hideagr();">点击此处或双击隐藏</button>
</div>
</div>
<%--用于显示勾选时的注册协议--%>
</asp:Panel>
</div>
<asp:Panel ID="PnlStep3" runat="server">
<div class="reg_info">
<div class="reg_sub_t">会员帐号信息</div>
<ul id="userinfo">
<li><asp:Literal ID="LitRegResult" runat="server"></asp:Literal></li>
<li>您的会员名：<span><%= Get(0) %></span></li>
<li>您的密码是：<span><%= Get(2) %></span></li>
<li>注册邮箱是：<span><%= Get(1) %></span></li>
<li>请您妥善保存您的信息，如忘记密码在<a href="/User/GetPassword" target="_blank">密码找回页</a>凭邮箱找回。</li>
<li><a href="<%=ReturnUrl %>" class="btn btn-info btn-block">进入用户中心</a></li>
</ul>
</div>
<div class="clearfix"></div>
</asp:Panel>
<asp:HiddenField ID="hfReturnUrl" runat="server" />

</div>
</div>
</div>
</div>

<div class="container">
<div class="login_footer">
<%Call.Label("{$Copyright/}"); %>
</div>
</div>
<script src="/JS/ICMS/area.js"></script>
<script src="/JS/PassStrong.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/ZL_ValidateCode.js"></script>
<script src="/JS/Controls/ZL_PCC.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/ZL_Content.js"></script>
<script src="/JS/Controls/Control.js"></script>
<script>
var curflag = true;
var pcc = new ZL_PCC("selprovince", "selcity", "selcoutry");
$(function () {
    pcc.ProvinceInit();
    initModelFied();
    //验证码
    $("#VCode").ValidateCode();
    $("#MobileCode").ValidateCode();
    //边栏事件
    $("#mimenu_btn").click(function (e) {
        if ($(".user_mimenu_left").width() > 0) {
            $(".user_mimenu_left ul").fadeOut(100);
            $(".user_mimenu_left").animate({ width: 0 }, 200);
        }
        else {
            $(".user_mimenu_left").animate({ width: 150 }, 300);
            $(".user_mimenu_left ul").fadeIn();
        }
    });

    //短信发送
    $("#send_btn").click(function () {
        Control.Mobile.SendVaildMsg("send_btn", "MobileCode", "MobileCode_hid", $("#TxtMobile1").val());
    });
})
function showagr() {
    $("#agr_content").show();
    $(".border_right").hide();
}
function hideagr() {
    $("#agr_content").hide();
    $(".border_right").show();
}
function code() {
    v = $("#VCode").val();
    var flag = codeIsRight(v);
    if (!flag) {
        $("#VCode").focus();
    }
    else {
        $("#BtnSubmit").trigger("click");
    }
}
function ShowUserModelHtml(html) {
    $("#ModelFiled_table").html(html);
}
//初始化用户组模型字段
function initModelFied() {
    PostToCS("GetModelFied", $("#UserGroup input:checked").val(), ShowUserModelHtml);
    //ModelFiled_table;
    $("#UserGroup input").click(function () {
        if ($(this)[0].checked)
            PostToCS("GetModelFied", $(this).val(), ShowUserModelHtml);
    });
}
//验证出生日期
function vaildDate() {
    $.post("/User/Register", { action: "birthdate", value: $("#TxtBirthday").val() }, function (data) {
        ReceiveServerDataID(data);
    });
}
function ReceiveServerDataID(result) {
    var checkcardmsg = document.getElementById("vaildate");
    switch (result) {
        case "1":
            checkcardmsg.innerHTML = "您超过了150岁？-吉尼斯世界纪录最长寿的人是132岁！";
            checkcardmsg.className = "d_err";
            curflag = false;
            break;
        case "2":
            checkcardmsg.innerHTML = "出生日期不能为空！";
            checkcardmsg.className = "d_err";
            curflag = false;
            break;
        case "0":
            checkcardmsg.innerHTML = "";
            checkcardmsg.className = "d_ok";
            curflag = true;
            break;
    }
}
//-------------------------
var i = 60;//倒计时
var ms = 5;
function gotouser() { console.log("gotouser"); window.setTimeout(function () { location = document.getElementById("hfReturnUrl").value }, 5000); }
function setTimeShow() {
    document.getElementById("spanTime").innerHTML = "还剩" + ms + "秒跳转到登录";
    ms--;
    if (ms <= 0) {
        window.location.href = "/User/Login";
    }
    window.setTimeout("setTimeShow()", 5000);
}
var subBtn = document.getElementById("BtnSubmit");
function checkreg(chk) {
    subBtn.disabled = chk.checked ? false : true;
}
//后台调用
function dispbtn() { setTimeout(function () { subBtn.disabled = true; $(subBtn).css("color", "#808080"); }, 50); }
function PostToCS(a, v, func) {
    $.ajax({
        type: "Post",
        data: { action: a, value: v },
        success: function (data) {
            func(data);
        },
        error: function (data) {
            console.log("错误" + data);
        }
    });
}
function SyncPost(json, callback) {
    //{ action: "ParentUser", value: args.Value }
    $.ajax({
        type: "Post",
        async: false,
        data: json,
        success: function (data) {
            callback(data);
        },
        error: function (data) {
            alert("错误" + data);
        }
    });
}
//----Register User
function CheckUser() {
	var userName = document.getElementById("TxtUserName");
	var checkUserNameMessage = document.getElementById("CheckUserNameMessage");
	checkUserNameMessage.className = "";
	checkUserNameMessage.innerHTML = "";
	if (userName.value.toString().replace(" ", "") != "") {
		var checkUserNameMessage = document.getElementById("CheckUserNameMessage");
		checkUserNameMessage.className = "";
		checkUserNameMessage.innerHTML = '<i class="fa fa-spinner fa-spin"></i>';
		PostToCS("UserIsExist", userName.value, ReceiveServerData);
	}
}
function ReceiveServerData(result) {
    var checkUserNameMessage = document.getElementById("CheckUserNameMessage");
    checkUserNameMessage.innerHTML = "";
    if (result == "true") {
        checkUserNameMessage.innerHTML = "用户名已经被注册了！";
        checkUserNameMessage.className = "d_err";
    }
    if (result == "error") {
        checkUserNameMessage.innerHTML = "用户名长度不符合规定的长度！";
        checkUserNameMessage.className = "d_err";
    }
    if (result == "disabled") {
        checkUserNameMessage.innerHTML = "该用户名禁止注册！";
        checkUserNameMessage.className = "d_err";
    }
    if (result == "false" || result == "Fidtrue2" || result == "Fno" || result == "Fidtrue" || result == "Fyidtrue" || result == "Fcidtrue" || result == "Fxidtrue") {
        if (ZL_Regex.isMobilePhone($("#TxtUserName").val()))
        {
            checkUserNameMessage.innerHTML = "恭喜您，用户名可以使用！";
            checkUserNameMessage.className = "d_ok";
        }
    }
}
function CheckUserMobile(){
	var usermobile = $("#TxtMobile").val();
	if (ZL_Regex.isMobilePhone($("#TxtMobile").val())) {
		$("#CheckUserMobileMessage").html('<i class="fa fa-spinner fa-spin"></i>');
		PostToCS("UserMobileIsExist", usermobile, function(data){
			if(data=="isexist"){
				$("#CheckUserMobileMessage").removeClass("d_ok").addClass("d_err").html("该手机号已被注册！");
			}
			else{
				$("#CheckUserMobileMessage").removeClass("d_err").addClass("d_ok").html("恭喜您，手机号可以使用！");
			}
		});
	}
}
//--------推荐人
function CheckParent(sender, args) {
    SyncPost({ action: "ParentUser", value: args.Value }, function (data) {
        if (data == 0)
            args.IsValid = false;
        else
            args.IsValid = true;
    });
}
function CheckParentUser() {
    var userName = document.getElementById("TxtParentUserID");
    var checkUserNameMessage = document.getElementById("CheckParentUserMessage");
    if (userName != "") {
        var checkUserNameMessage = document.getElementById("CheckUserNameMessage");
        checkUserNameMessage.className = "";
        checkUserNameMessage.innerHTML = "<img src=\"images/loading.gif\" align=\"absmiddle\" />";
        PostToCS("ParentUser", userName.value, ReceiveServerDataParent);
    }
}
function CheckParentUserID() {
    var userName = document.getElementById("TxtParentUser");
    var checkUserNameMessage = document.getElementById("CheckParentUserIDMessage");
    if (userName != "") {
        var checkUserNameMessage = document.getElementById("CheckUserNameMessage");
        checkUserNameMessage.className = "";
        checkUserNameMessage.innerHTML = "<img src=\"images/loading.gif\" align=\"absmiddle\" />";
        PostToCS("ParentUserID", userName.value, ReceiveServerDataParentID);
    }
}
function ReceiveServerDataParent(result) {
    GetParentUserMsg("CheckParentUserMessage", result);
}
function GetParentUserMsg(msgid, result) {
    var checkcardmsg = document.getElementById(msgid);
    if (result == "1") {
        checkcardmsg.innerHTML = "该用户存在有效，请继续注册！";
        checkcardmsg.className = "d_err";
    }
    else if (result == "0") {
        checkcardmsg.innerHTML = "该用户不存在！";
        checkcardmsg.className = "";
    }
    else if (result == "-1") {
        checkcardmsg.innerHTML = "";
        checkcardmsg.className = "";
    }
}
function ReceiveServerDataParentID(result) {
    GetParentUserMsg("CheckParentUserIDMessage", result);
}
//--------邀请码
function CheckInvite(sender, args) {
    SyncPost({ action: "InvitCode", value: args.Value }, function (data) {
        if (data == 0)
            args.IsValid = false;
        else
            args.IsValid = true;
    });
}
function CheckInvitCode() {
    var code = $("#TxtInvitCode").val();
    var msg_labeel = document.getElementById("InvitCodeMsg");
    if (code != "") {
        $("#InvitCodeMsg").removeClass().html("<img src=\"images/loading.gif\" align=\"absmiddle\" />");
        PostToCS("InvitCode", code, ReceiveInvitCode);
    }
    else { ReceiveInvitCode("-1"); }
}
function ReceiveInvitCode(result) {
    var checkcardmsg = document.getElementById("InvitCodeMsg");
    switch (result) {
        case "1":
            checkcardmsg.innerHTML = "邀请码有效！";
            checkcardmsg.className = "d_err";
            break;
        case "0":
            checkcardmsg.innerHTML = "邀请码无效！";
            checkcardmsg.className = "";
            break;
        default:
            checkcardmsg.innerHTML = "";
            checkcardmsg.className = "";
            break;
    }
}
//显示或关闭选填信息
function SwicthSelectFill() {
    $(".selectFill").toggle();
}
function hidenbtn() {
    $(".selectFill").hide();
    document.getElementById("checkSelectFill").checked = false;
}

$("#regsend_btn").click(function(){
	if(ZL_Regex.isMobilePhone($("#TxtMobile").val()))
	{
		$(this).attr("disabled","disabled");
        $.post("/API/Mod/Mobile.ashx", { action: "sendvailmsg1", code: '', hcode: '', mobile: $("#TxtMobile").val() }, function (data) {
			data=JSON.parse(data);
            if (data.retcode == "1") {
				$("#RMobileCode_T").popover({
					animation: true,
					placement: 'top',
					content: '<span style="color:red;">验证码已发送,请注意查收!</span>',
					html: true,
					trigger: 'manual',
					delay: { show: 10000, hide: 100 }
				});
				$("#RMobileCode_T").popover('show');
				setTimeout(function () { $("#RMobileCode_T").popover('destroy'); }, 4000);
				
				var time=120;
				$("#regsend_btn").html("<span id='time'>"+time+"</span>秒后重新获取");
				var timer = setInterval(function () {
					time--;
					if (time <= 0)
					{
						clearInterval(timer);
						$("#regsend_btn").removeAttr("disabled");
						$("#regsend_btn").html("获取验证码");
					}
					$("#time").html(time);
				}, 1000);
            }
			else {
				$("#regsend_btn").removeAttr("disabled");
                $("#RMobileCode_T").popover({
					animation: true,
					placement: 'top',
					content: '<span style="color:red;">发送失败!详情:' + data.retmsg + '</span>',
					html: true,
					trigger: 'manual',
					delay: { show: 10000, hide: 100 }
				});
				$("#RMobileCode_T").popover('show');
				setTimeout(function () { $("#RMobileCode_T").popover('destroy'); }, 4000);
            }
        });
	}
	else
	{
		$("#TxtMobile").popover({
			animation: true,
			placement: 'top',
			content: '<span style="color:red;">请输入正确的手机号！</span>',
			html: true,
			trigger: 'manual',
			delay: { show: 10000, hide: 100 }
		});
		$("#TxtMobile").popover('show');
		setTimeout(function () { $("#TxtMobile").popover('destroy'); }, 4000);
	}
});
</script>
</form>
</body>
</html>