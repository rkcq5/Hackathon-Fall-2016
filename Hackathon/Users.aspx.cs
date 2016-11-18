using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Text;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["loggedInUser"] != null)
        //{
        DataTable dtUsers = DataService.getUsers();

        StringBuilder group = new StringBuilder();

        if (dtUsers != null)
        {
            group.Append("<div>" +
                         "<table id='myTable' class='table table-striped table-hover'  width='100%'>" +
                         "<thead style='border-collapse:collapse;text-align:center;'>" +
                          "<th>FirstName</th>" +
                         "<th>Last Name</th>" +
                           "<th>User Name</th>" +
                           "<th>Email</th>" +
                           "<th>User Role</th>" +
                         "<th style='text-align:center;'>Actions</th>" +
                         "</thead>" +
                         "<tbody id=''>");


            if (dtUsers != null)
            {
                foreach (DataRow dr in dtUsers.Rows)
                {
                    group.Append("<tr>");

                    group.Append("<td>").Append(dr["FirstName"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["LastName"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["UserName"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["Email"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["UserRole"].ToString()).Append("</td>");

                    group.Append("<td style='text-align: left'> " +
                                 "<a href='#' onClick='EditUser(" + dr["UserId"].ToString() + ",\"" + dr["FirstName"].ToString() + "\",\"" + dr["LastName"].ToString() + "\",\"" + dr["Email"].ToString() + "\",\"" + dr["Email"].ToString() + "\",\"" + dr["UserRole"].ToString() + "\")'>Edit</a>" + " | " +
                                 "<a href='#' onClick='DeleteUser(" + dr["UserId"].ToString() + ",\"" + dr["FirstName"].ToString() + "\")'>Delete</a></td>");

                    group.Append("</tr>");

                }
            }
        }
        else
        {
            group.Append("<tr>");
            group.Append("<td>").Append("No users in the Application").Append("</td>");
            group.Append("</tr>");
        }

        group.Append("</tbody>");
        group.Append("</table>");
        group.Append("</div> <br/> <br/>");

        divUsers.InnerHtml = group.ToString();
        //}
        //else
        //{
        //    Response.Redirect("/Login.aspx");
        //}
    }

    [WebMethod]
    public static void AddUser()
    {
        User user = new User();
       
        user.FirstName = HttpContext.Current.Request.QueryString["FN"];
        user.LastName = HttpContext.Current.Request.QueryString["LN"];
        user.Email = HttpContext.Current.Request.QueryString["EM"];
        user.UserRole = HttpContext.Current.Request.QueryString["UR"];
        user.UserName = "John";
        DataService.AddUser(user);
    }

    [WebMethod]
    public static void EditUser()
    {
        User user = new User();
        user.UserId = 6;
        user.FirstName = HttpContext.Current.Request.QueryString["FN"];
        user.LastName = HttpContext.Current.Request.QueryString["LN"];
        user.UserRole = HttpContext.Current.Request.QueryString["UR"];
        user.UserName = HttpContext.Current.Request.QueryString["UN"];
        user.Email = "test@email.com";
        DataService.EditUser(user);
    }

    [WebMethod]
    public static void DeleteUser()
    {
        int userId = Convert.ToInt32(HttpContext.Current.Request.QueryString["Id"]);
        DataService.DeleteUser(userId);
    }

    public static bool isUNAvailable()
    {

        string userName = HttpContext.Current.Request.QueryString["UN"];
        if (DataService.getUsers().Select("UserName =" + userName).Count() > 0)
        {
            return false;
        }
        return true;
    }
}
