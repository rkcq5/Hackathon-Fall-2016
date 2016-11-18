using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class horizontalmenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["UserRole"].ToString() == "Anonymous")
        {
            divLog.Visible = true;
      
        }
        else
        {
            divLog.Visible = false;
            linkLogout.Visible = true;

        }

    }
    //[WebMethod]
    //public static void UserLogin()
    //{
    //    string username = HttpContext.Current.Request.QueryString["UN"];
    //    string password = HttpContext.Current.Request.QueryString["PW"];

    //    User user = DataService.isValidUser(username, password);

    //}
}