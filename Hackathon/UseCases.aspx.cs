using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Services;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["loggedInUser"] != null)
        //{
        HttpContext.Current.Session["UserRole"] = "Anonymous";

        DataTable dtUseCases = DataService.getUseCases();

        StringBuilder group = new StringBuilder();

        if (dtUseCases != null)
        {
            group.Append("<div>" +
                         "<table id='myTable' class='table table-striped table-hover '  width='100%'>" +
                         "<thead style='border-collapse:collapse;text-align: center'>" +
                //"<th>UseCase Id</th>" +
                         "<th>Name</th>" +
                          "<th width='70%'>Description</th>" +
                          "<th>Presented By</th>" +

                          "<th style='text-align:center;'>Actions</th>" +
                         "</thead>" +
                         "<tbody id='' style='text-align: justify'>");

            if (dtUseCases != null)
            {
                foreach (DataRow dr in dtUseCases.Rows)
                {
                    group.Append("<tr>");

                    //group.Append("<td>").Append(dr["UsecaseId"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["UsecaseName"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["Description"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["CompanyName"].ToString()).Append("</td>");
                    group.Append("<td style='text-align: left'> " +
                               "<a href='#' onClick='editUseCase(" + dr["UsecaseId"].ToString() + ",\"" + dr["UsecaseName"].ToString() + "\",\"" + dr["Description"].ToString() + "\",\"" + dr["CompanyName"].ToString() + "\")'>Edit</a>" + " | " +
                               "<a href='#' onClick='deleteUseCase(" + (dr["UsecaseId"].ToString()) + ")'>Delete</a></td>");

                    group.Append("</tr>");

                    group.Append("</tr>");
                }
            }
        }
        else
        {
            group.Append("<tr>");
            group.Append("<td>").Append("No UseCases Registered").Append("</td>");
            group.Append("</tr>");
        }

        group.Append("</tbody>");
        group.Append("</table>");
        group.Append("</div> <br/> <br/>");

        divUseCases.InnerHtml = group.ToString();
        //}
        //else
        //{
        //    Response.Redirect("/Login.aspx");
        //}
    }
    [WebMethod]
    public static int DeleteUseCase()
    {
        int useCaseId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);

        int result = DataService.DeleteUseCase(useCaseId);

        return result;
    }

    [WebMethod]
    public static bool UserLogin()
    {
        string username = HttpContext.Current.Request.QueryString["UN"];
        string password = HttpContext.Current.Request.QueryString["PW"];

        User user = DataService.isValidUser(username, password);
        if (user != null)
        {
            HttpContext.Current.Session["loggedInUser"] = user;
            HttpContext.Current.Session["UserRole"] = user.UserRole;

            return true;
        }

        HttpContext.Current.Session["UserRole"] = "Anonymous";
        return false;
    }
}