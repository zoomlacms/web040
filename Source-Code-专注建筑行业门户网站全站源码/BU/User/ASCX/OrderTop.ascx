﻿<%@ control language="C#" autoeventwireup="true" inherits="User_ASCX_OrderTop, App_Web_esj1selh" %>
<div class="btn-group btn_green">
<a href="OrderList.aspx?menu=Orderinfo&ordertype=1" class="btn btn-info btn-lg"><i class="fa fa-gift"></i> 实物商品订单</a>
<a href="OrderList.aspx?menu=Orderinfo&ordertype=8" class="btn btn-info btn-lg"><i class="fa fa-credit-card-alt "></i> 虚拟商品订单</a>
<a href="OrderList.aspx?menu=Orderinfo&ordertype=4" class="btn btn-info btn-lg"><i class="fa fa-database"></i> 积分商品订单</a>
<div class="btn-group">
<button type="button" class="btn btn-info btn-lg dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-server"></i> IDC订单 <span class="caret"></span></button>
<ul class="dropdown-menu" role="menu">
<li><a href="OrderList.aspx?menu=Orderinfo&ordertype=7">订单列表</a></li>
<li><a href="OrderList.aspx?menu=Orderinfo&ordertype=9">续费列表</a></li>
</ul>
</div>
<a href="TripOrder.aspx?menu=Cartinfo" class="btn btn-info btn-lg"><i class="fa fa-plane"></i> 旅游订单</a>
<a href="HotelOrder.aspx?menu=Cartinfo" class="btn btn-info btn-lg"><i class="fa fa-building"></i> 酒店订单</a>
</div>