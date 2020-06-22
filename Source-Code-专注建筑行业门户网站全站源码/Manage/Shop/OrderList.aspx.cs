using System;
using System.Data;
using System.IO;
using ZoomLa.BLL;
using ZoomLa.BLL.Shop;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.SQLDAL;
using ZoomLa.SQLDAL.SQL;
using Winista.Text.HtmlParser.Visitors;
using ZoomLa.BLL.Helper;
using Winista.Text.HtmlParser.Filters;
using System.Web;

/*
 * 商城,店铺,积分订单
 */

namespace ZoomLaCMS.Manage.Shop
{
    public partial class OrderList : CustomerPageAction
    {
        B_OrderList orderBll = new B_OrderList();
        B_Product Pll = new B_Product();
        B_CartPro Cll = new B_CartPro();
        OrderCommon orderCom = new OrderCommon();
        public string OrderStatus { get { return Request.QueryString["orderstatus"] ?? ""; } }
        public string PayStatus { get { return Request.QueryString["PayStatus"] ?? ""; } }
        public int StoreID { get { return DataConvert.CLng(Request.QueryString["StoreID"]); } }
        public string uids { get { return Request.QueryString["uids"] ?? ""; } }
        //订单类型
        public string OrderType
        {
            get
            {
                string _orderType = "0,4";
                if (!string.IsNullOrEmpty(Request.QueryString["OrderType"]))
                    _orderType = Request.QueryString["OrderType"];
                return _orderType;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!B_ARoleAuth.Check(ZLEnum.Auth.shop, "OrderList"))
            {
                function.WriteErrMsg("没有权限进行此项操作");
            }
            if (!IsPostBack)
            {
                string bread = "<li><a href='ProductManage.aspx'>" + Resources.L.商城管理 + "</a></li><li><a href='OrderList.aspx'>" + Resources.L.订单管理 + "</a></li><li class='active'><a href='OrderList.aspx'>" + Resources.L.订单列表 + "</a>";
                if (OrderType.Equals("9") || OrderType.Equals("7")) { }
                else { bread += "[<a href='AddOrder.aspx?" + Request.QueryString + "' >添加订单</a>]"; }
                bread += "</li>" + Call.GetHelp(41);
                Call.SetBreadCrumb(Master, bread);
                MyBind();
            }
        }
        protected void MyBind()
        {
            DataTable dt = GetTable();
            TotalSum_Hid.Value = DataConvert.CDouble(dt.Compute("SUM(ordersamount)", "")).ToString("f2");
            switch (OrderType)
            {
                case "1"://酒店
                case "3"://旅游
                    function.Script(this, "ShowElement('hotel_tb');");
                    Hotel_RPT.DataSource = dt;
                    Hotel_RPT.DataBind();
                    break;
                default:
                    function.Script(this, "ShowElement('store_tb');");
                    Store_RPT.DataSource = dt;
                    Store_RPT.DataBind();
                    break;
            }
        }
        private DataTable GetTable()
        {
            int quick = Convert.ToInt32(QuickSearch_DP.SelectedValue);
            int skeyType = Convert.ToInt32(SkeyType_DP.SelectedValue);
            return orderBll.SearchByQuickAndSkey(OrderType, OrderStatus, PayStatus, quick, skeyType, Skey_T.Text, StoreID, uids, SDate_T.Text, EDate_T.Text);
        }
        public string GetTotalSum() { return TotalSum_Hid.Value; }
        //订单,支付,物流状态
        public string formatzt(string zt, string selects)
        {
            string result = "";
            int status = DataConverter.CLng(zt);
            int type = DataConverter.CLng(selects);
            string url = "OrderList.aspx?OrderType=" + OrderType + "&StoreID=" + StoreID;
            switch (type)
            {
                case 0:
                    result = "<a href='" + url + "&OrderStatus=" + status + "' title='按订单状态筛选'>" + OrderHelper.GetOrderStatus(status, Convert.ToInt32(Eval("Aside")), 0) + "</a>";
                    break;
                case 1:
                    result = "<a href='" + url + "&PayStatus=" + status + "' title='按支付状态筛选'>" + OrderHelper.GetPayStatus(status) + "</a>";
                    break;
                case 2:
                    result = OrderHelper.GetExpStatus(status);
                    break;
                default:
                    result = "未知请求";
                    break;
            }
            return result;
        }
        public string GetOrderNo()
        {
            int aside = Convert.ToInt32(Eval("Aside"));
            return orderCom.GetOrderNo(Convert.ToInt32(Eval("ID")), aside, Eval("OrderNo").ToString());
        }
        //实际金额
        public string GetPriceStr(string id)
        {
            M_OrderList orders = orderBll.GetOrderListByid(Convert.ToInt32(id));
            return OrderHelper.GetPriceStr(orders);
        }
        public string IsNeedInvo()
        {
            switch (Eval("Developedvotes", ""))
            {
                case "0":
                    return "<i class='fa fa-close' style='color:red;'></i>";
                default:
                    return "<i class='fa fa-check' style='color:green;'></i>";
            }
        }
        public string GetChkStatus()
        {
            string result = "";
            int payStatus = Convert.ToInt32(Eval("Paymentstatus"));
            if (payStatus >= (int)M_OrderList.PayEnum.HasPayed)
            {
                result = "<input name=\"idchk\"  disabled=\"disabled\" type=\"checkbox\"/>";
            }
            else
            {
                result = "<input name=\"idchk\" type=\"checkbox\" value=\"" + Eval("ID") + "\"/>";
            }
            return result;
        }
        //------------------------------事件处理
        protected void Sure_Btn_Click(object sender, EventArgs e)
        {
            string CID = Request.Form["idchk"];//订单ID列表
            if (!String.IsNullOrEmpty(CID))
            {
                DataTable Ode = orderBll.GetOrderbyOrderlist(CID);//获得订单列表

                int odcount = Ode.Rows.Count;

                for (int p = 0; p < odcount; p++)
                {
                    int CartproOrderid = DataConverter.CLng(Ode.Rows[p]["id"]); //订单ID
                    string str = "OrderStatus=1";
                    orderBll.UpOrderinfo(str, CartproOrderid);
                }
                function.WriteSuccessMsg("确认订单成功", "OrderList.aspx");
            }
        }
        protected void BatDel_Btn_Click(object sender, EventArgs e)
        {
            string CID = Request.Form["idchk"];//订单ID列表
            if (!String.IsNullOrEmpty(CID))
            {
                DataTable Ode = orderBll.GetOrderbyOrderlist(CID);//获得订单列表
                int odcount = Ode.Rows.Count;
                for (int p = 0; p < odcount; p++)
                {
                    int CartproOrderid = DataConverter.CLng(Ode.Rows[p]["id"]); //订单ID

                    //历遍清单所有商品数量，查找库存///////////////////
                    DataTable Unew = Cll.GetCartProOrderID(CartproOrderid); //获得详细清单列表

                    for (int s = 0; s < Unew.Rows.Count; s++)
                    {
                        int Onum = DataConverter.CLng(Unew.Rows[s]["Pronum"]);
                        int Opid = DataConverter.CLng(Unew.Rows[s]["ProID"]);

                        M_Product pdin = Pll.GetproductByid(Opid);//获得商品信息

                        if (pdin.JisuanFs == 1)
                        {
                            int pstock = pdin.Stock + Onum;//库存结果,返回的商品数量
                            Pll.ProUpStock(Opid, pstock);
                        }
                    }
                    //////////////////////////////////////////////////////
                }
                orderBll.Delorderlist(CID);
                function.WriteSuccessMsg("删除成功", "OrderList.aspx");
            }
        }
        protected void QuickSearch_DP_SelectedIndexChanged(object sender, EventArgs e)
        {
            MyBind();
        }
        protected void Skey_Btn_Click(object sender, EventArgs e)
        {
            MyBind();
        }

        protected void DownDetails_B_Click(object sender, EventArgs e)
        {
            int quick = Convert.ToInt32(QuickSearch_DP.SelectedValue);
            int skeyType = Convert.ToInt32(SkeyType_DP.SelectedValue);
            Session["OrderType"] = OrderType;
            Session["OrderStatus"] = OrderStatus;
            Session["PayStatus"] = PayStatus;
            Session["Quick"] = quick;
            Session["SkeyType"] = skeyType;
            Session["Skey"] = Skey_T.Text;
            Session["StoreID"] = StoreID;
            Session["SDate"] = SDate_T.Text;
            Session["EDate"] = EDate_T.Text;

            HtmlHelper htmlHelp = new HtmlHelper();
            StringWriter sw = new StringWriter();
            Server.Execute("OrderlistToExcel.aspx", sw);
            string html = sw.ToString();
            HtmlPage page = htmlHelp.GetPage(html);
            html = page.Body.ExtractAllNodesThatMatch(new HasAttributeFilter("id", "orderlist"), true).ToHtml();

            string name = DateTime.Now.ToString("yyyyMMdd") + "订单详单";
            name = HttpUtility.UrlPathEncode(name);
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel.numberformat:@";
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");//设置输出流为简体中文  
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + name + ".xls");
            Response.Write(html);
            Response.End();
            //SafeSC.DownStr(helper.ExportExcel(newDt, colnames), DateTime.Now.ToString("yyyyMMdd") + "订单详单.xls");
        }
    }
}