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
        DataTable dtCompanies = DataService.getCompanies();

        StringBuilder group = new StringBuilder();

        if (dtCompanies != null)
        {
            group.Append("<div>" +
                         "<table id='myTable' class='table table-striped table-hover'  width='100%'>" +
                         "<thead style='border-collapse:collapse;text-align:center;'>" +
                          "<th>Company ID</th>" +
                         "<th>Comapany Name</th>" +
                           "<th>Representer Name</th>" +
                         "<th style='text-align:center;'>Actions</th>" +
                         "</thead>" +
                         "<tbody id=''>");


            if (dtCompanies != null)
            {
                foreach (DataRow dr in dtCompanies.Rows)
                {
                    group.Append("<tr>");

                    group.Append("<td>").Append(dr["CompanyId"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["CompanyName"].ToString()).Append("</td>");
                    group.Append("<td>").Append(dr["LastName"].ToString()).Append("</td>");
                    //  group.Append("<td>").Append(dr["LastName"].ToString()).Append("</td>");

                    group.Append("<td style='text-align: left'> " +
                                 "<a href='#' onClick='EditCompany(" + dr["CompanyId"].ToString() + ",\"" + dr["CompanyName"].ToString() + "\",\"" + dr["LastName"].ToString() + "\")'>Edit</a>" + " | " +
                                 "<a href='#' onClick='DeleteCompany(" + (dr["CompanyId"].ToString()) + ")'>Delete</a></td>");

                    group.Append("</tr>");

                }
            }
        }
        else
        {
            group.Append("<tr>");
            group.Append("<td>").Append("No Companies Registered").Append("</td>");
            group.Append("</tr>");
        }

        group.Append("</tbody>");
        group.Append("</table>");
        group.Append("</div> <br/> <br/>");

        divCompanies.InnerHtml = group.ToString();
        //}
        //else
        //{
        //    Response.Redirect("/Login.aspx");
        //}
    }

    [WebMethod]
    public static void AddCompany()
    {
        Company company = new Company();

        DataTable dt = DataService.getUsers();
        company.CompanyName = HttpContext.Current.Request.QueryString["CompanyName"];
        string rep = HttpContext.Current.Request.QueryString["rep"];
        if (dt != null)
        {
            company.CompanyUserId = Convert.ToInt32(dt.Select("lastname='" + rep + "'")[0]["UserId"]);
            DataService.AddCompany(company);
        }

    }

    [WebMethod]
    public static void EditCompany()
    {
        Company company = new Company();
        DataTable dt = DataService.getUsers();
        company.CompanyId = Convert.ToInt32(HttpContext.Current.Request.QueryString["companyId"]);
        company.CompanyName = HttpContext.Current.Request.QueryString["companyName"];
        string rep = HttpContext.Current.Request.QueryString["rep"];
        if (dt != null)
        {
            company.CompanyUserId = Convert.ToInt32(dt.Select("lastname='" + rep + "'")[0]["UserId"]);
            DataService.EditCompany(company);
        }
    }

    [WebMethod]
    public static int DeleteCompany()
    {
        int companyId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);

        int result = DataService.DeleteCompany(companyId);

        return result;
    }

    [WebMethod]
    public static string[] GetCompaniesList(string name)
    {
        DataTable viewResult = DataService.getCompanyList(name);

        if (viewResult != null && viewResult.Rows.Count > 0)
        {
            string[] Names = new string[viewResult.Rows.Count];
            for (int i = 0; i < viewResult.Rows.Count; i++)
            {
                Names[i] = viewResult.Rows[i]["LastName"].ToString();
            }
            return Names.ToArray();
        }
        return null;
    }

    [WebMethod]
    public static bool isValidLastName()
    {
        string lastName = HttpContext.Current.Request.QueryString["lastName"];

        DataTable dtUsers = DataService.getUsers();

        if (dtUsers != null && dtUsers.Rows.Count > 0)
        {
            if (dtUsers.Select("LastName ='" + lastName + "'").Count() > 0)
            {
                return true;
            }
        }
        return false;
    }

}