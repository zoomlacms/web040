<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default1.aspx.cs" Inherits="User_Default1" ClientIDMode="Static" %><!DOCTYPE html>
<%@ Register Src="~/BU/User/ASCX/DefaultTop.ascx" TagName="UserMenu" TagPrefix="ZL" %><!DOCTYPE html>
<%@ Register Src="~/Manage/I/ASCX/UserInfoBar.ascx" TagPrefix="ZL" TagName="UserBar" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>会员中心</title>
<link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="/dist/css/font-awesome.min.css"/>
<link rel="stylesheet" href="/dist/css/weui.min.css"/>
<link type="text/css" rel="stylesheet" href="/App_Themes/User.css" />
<link href="/Template/JianTu/style/global.css?v=20150910" rel="stylesheet"/>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script src="/JS/ICMS/ZL_Common.js"></script>
<script src="/dist/js/bootstrap.min.js"></script> 
</head>
<body style="background:#f6f6f6;">
<form id="form1" runat="server">
<div class="muser_top">
<div class="media">
<div class="media-left"><a href="/User/Info/UserInfo"><asp:Image ID="imgUserPic" CssClass="media-object" AlternateText="" onerror="shownoface(this);" runat="server" /></a></div>
<div class="media-body media-middle">
<h4 class="media-heading"><asp:Label ID="UserNameLb" runat="server" Text=""></asp:Label></h4>
<p>等级：<asp:Literal id="LvIcon_Li" runat="server"></asp:Literal> <asp:Label ID="UserLvLb" runat="server" Text=""></asp:Label></p>
</div>
</div>
</div>

<div class="muser_order">
<div class="muser_order_t">我的订单<span class="pull-right"><a href="#">查看全部订单 <i class="fa fa-angle-right"></i></a></span></div>
<div class="muser_order_c">
<ul>
<li><a href="/User/Order/OrderList?filter=needpay"><i class="fa fa-money"></i>待付款</a></li>
<li><a href="/User/Order/OrderList?filter=receive"><i class="fa fa-truck"></i>待收货</a></li>
<li><a href="/User/Order/OrderList?filter=comment"><i class="fa fa-check"></i>已收货</a></li>
<li><a href="/User/Order/OrderList?filter=comment"><i class="fa fa-comments-o"></i>售后</a></li>
<div class="clearfix"></div>
</ul>
</div>
</div>

<div class="muser_money">
<div class="muser_money_t">我的钱包<span class="pull-right"><a href="#">查看全部订单 <i class="fa fa-angle-right"></i></a></span></div>
<div class="muser_money_c">
<ul>
<li><a href="info/ConsumeDetail.aspx?SType=1"><span><asp:Label ID="UserYeLb" runat="server" Text=""></asp:Label></span><br/>账户余额</a></li>
<li><a href="#"><span><asp:Label ID="UserJfLb" runat="server" Text=""></asp:Label></span><br/>可用积分</a></li>
<li><a href="#"><span><asp:Label ID="UserJbLb" runat="server" Text=""></asp:Label></span><br/>待定积分</a></li>
<li><a href="#"><span>0.00</span><br/>小金库</a></li>
<div class="clearfix"></div>
</ul>
</div>
</div>

<div class="muser_fenx">
<div class="weui_cells weui_cells_access">
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-sitemap"></i> 分销中心</p>
</div>
<div class="weui_cell_ft">
</div>
</a>
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-users"></i> 合伙人中心</p>
</div>
<div class="weui_cell_ft">
</div>
</a>
</div>
</div>

<div class="muser_info">
<div class="weui_cells weui_cells_access">
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-qrcode"></i> 我的二维码</p>
</div>
<div class="weui_cell_ft">
</div>
</a>
<a class="weui_cell" href="/User/CashCoupon/ArriveManage">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-rmb"></i> 红包优惠券</p>
</div>
<div class="weui_cell_ft"></div>
</a>
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-weixin"></i> 最新消息</p>
</div>
<div class="weui_cell_ft"></div>
</a>
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-map-marker"></i> 我的收货地址</p>
</div>
<div class="weui_cell_ft"></div>
</a>
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-heart"></i> 我的收藏</p>
</div>
<div class="weui_cell_ft"></div>
</a>
<a class="weui_cell" href="javascript:;">
<div class="weui_cell_bd weui_cell_primary">
<p><i class="fa fa-shield"></i> 安全中心</p>
</div>
<div class="weui_cell_ft"></div>
</a>
</div>

</div>

<div style="height:56px;"></div>
<div class="wei_foot navbar-fixed-bottom">
<ul>
<li id="wei_service"><a href="/Class_461/Default.aspx"><div><i class="fa fa-th-large"></i></div><p>建筑服务</p></a></li>
<li id="wei_oa"><a href="/Class_461/NodePage.aspx"><div><i class="fa fa-laptop"></i></div><p>办公平台</p></a></li>
<li id="wei_user" class="active"><a href="/BU/User/Default1.aspx"><div><i class="fa fa-user"></i></div><p>会员</p></a></li>
</ul>
</div>

<div class="u_info" hidden>
<div class="container">
<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-4 u_face">
<ZL:UserBar ID="UserBar_U" runat="server" Width="100" />
</div>
<div class="col-lg-10 col-md-10 col-sm-10 col-xs-8 u_syn">
<ul class="list-unstyled">
<li>
<ul class="list-unstyled">
<li><i class="glyphicon glyphicon-user"></i> 会员名称：</li>
<li><i class="fa fa-certificate"></i> </li>
<li class="hidden-xs"><i class="fa fa-clock-o"></i> 加入时间：<asp:Label ID="UserRegTimeLb" runat="server" Text=""></asp:Label></li>
</ul>
</li>
<li><i class="glyphicon glyphicon-map-marker"></i> 地址：<asp:Label ID="UserAddressLb" runat="server" Text=""></asp:Label></li>
<li class="hidden-xs"><i class="fa fa-edit"></i> 个性签名：<asp:Label ID="UserSignLb" runat="server" Text=""></asp:Label></li>
<li>
<ul class="list-unstyled">
<li>
<i class="glyphicon glyphicon-usd"></i> 余额：<a href="/User/Info/ConsumeDetail?SType=1" title="点击查看资金明细"></a>
<a href="/PayOnline/SelectPayPlat.aspx" target="_blank">[在线充值]</a>
<a href="/User/Money/WithDraw">[申请提现]</a>
</li>
<li class="hidden-xs">银币：</li>
<li><i class="fa fa-credit-card-alt"></i> 积分：</li>
</ul>
</li>
</ul>
</div>
</div>
</div>
</div>
<div class="container u_menu" hidden>
<div class="row padding5">
<asp:Literal ID="UserApp_Li" runat="server" EnableViewState="false"></asp:Literal>
<div class="clearfix"></div>
</div>
</div> 
<div class="u_menu_more text-center" hidden>
<a href="javascript:;" id="more_btn" title="点击显示更多">More <i class="fa fa-angle-double-down"></i></a>
</div>
<div class="user_menu_sub" hidden> 
<ul class="list-unstyled text-center">
<asp:Literal runat="server" ID="onther_lit" EnableViewState="false"></asp:Literal>
</ul>
<div class="clearfix"></div>
</div>  

</form>
</body>
</html>
<script>
var code='<%Call.Label("{$GetRequest(code)$}");%>';
$.get("/wxpage.aspx?code=<%Call.Label("{$GetRequest(code)$}");%>", function(data){
	try
	{
		var userinfo=JSON.parse(data);
		console.log(userinfo)
		$(".muser_top img").attr("src",userinfo.headimgurl).attr("alt",userinfo.nickname);
	}
	catch(e)
	{
		console.log(e);
	}
});
$().ready(function (e) {//菜单颜色配置
	var colorArr=new Array('#c47f3e','#669933','#27a9e3','#f05033','#990066','#9999FF','#E48632','#990000','#22afc2','#6633FF','#9900FF','#1FA67A');
	var count=$(".user_menu_sub li").length;
	for(var i=0; i<count; i++){
		$(".user_menu").eq(i).css("background",colorArr[i%12]);	
	}
    if ($(".user_menu_sub li").length < 1)
        $(".u_menu_more").remove();
})
$("#mimenu_btn").click(function(e) { 
	if($(".user_mimenu_left").width()>0){ 
 		$(".user_mimenu_left ul").fadeOut(100);
		$(".user_mimenu_left").animate({width:0},200); 	
	}
	else{ 
		$(".user_mimenu_left").animate({width:150},300); 
		$(".user_mimenu_left ul").fadeIn();
	}
});
//会员菜单更多显示/隐藏
$("#more_btn").click(function(e) {
	if($(".user_menu_sub").css("display")=="none"){  
	    $(".user_menu_sub").slideDown();
		$(this).find("i").removeClass("fa-angle-double-down");
		$(this).find("i").addClass("fa-angle-double-up");
	}
	else {  
	    $(".user_menu_sub").slideUp(200); 
		$(this).find("i").removeClass("fa-angle-double-up");
		$(this).find("i").addClass("fa-angle-double-down");
	}
});
//会员搜索
$("#sub_btn").click(function(e) { 
    if($("#key").val()=="")
		alert("搜索关键字为空!");
	else
		window.location="/User/SearchResult.aspx?key="+escape($("#key").val());	
});
//搜索回车事件
function IsEnter(obj) {
	if (event.keyCode == 13) {
		$("#sub_btn").click(); return false;
	}
}
</script>