using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class verticalmenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserRole"] != null)
        {
            if (Session["UserRole"].ToString() == "Admin")
            {
                liUsers.Visible = true;
                liCompanies.Visible = true;
            }
            else if (Session["UserRole"].ToString() == "Judge")
            {

            }
        }
    }
}