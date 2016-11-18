using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        User user = DataService.isValidUser(txtFirstName.Text, txtPassword.Text);

        if (user != null)
        {
            Session["loggedInUser"] = user;

            Response.Redirect("Default.aspx");
        }

        Response.Redirect("Default.aspx");
    }

    [WebMethod]
    public static string checkValidUser()
    {
        return string.Empty;

    }
}