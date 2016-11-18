using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserRole"] != null)
        {
            DataTable dtTeams = DataService.getTeams();

            StringBuilder group = new StringBuilder();

            if (dtTeams != null)
            {
                group.Append("<div>" +
                             "<table id='myTable' class='table table-striped table-hover'  width='100%'>" +
                             "<thead style='border-collapse:collapse;text-align:center;'>" +
                              "<th>Team Name</th>" +
                             "<th>Team Count</th>" +
                             "<th>UseCase Name</th>" +
                             "<th>Technology</th>" +
                             "<th>Reviews</th>");
                if (Session["UserRole"].ToString() != "Anonymous")
                {
                    group.Append("<th style='text-align:center;'>Actions</th>");
                }
                group.Append("</thead>" +
                       "<tbody id=''>");

                if (dtTeams != null)
                {
                    foreach (DataRow dr in dtTeams.Rows)
                    {
                        group.Append("<tr>");

                        group.Append("<td>").Append(dr["TeamName"].ToString()).Append("</td>");
                        group.Append("<td>").Append(dr["TeamCount"].ToString()).Append("</td>");
                        group.Append("<td>").Append(dr["Usecasename"].ToString()).Append("</td>");
                        group.Append("<td>").Append(dr["Technology"].ToString()).Append("</td>");

                        if (Session["UserRole"].ToString() != "Anonymous")
                        {
                            group.Append("<td style='text-align: left'> " +
                               "<a href='#' onClick='AddReview(" + dr["TeamId"].ToString() + ")'>Add Review</a>" + " | ");
                            group.Append("<a href='#' onClick='ViewReviews(" + dr["TeamId"].ToString() + ",\"" + dr["TeamName"].ToString() + "\")'>View Reviews</a></td>");

                            group.Append("<td style='text-align: left'> " +
                                       "<a href='#' onClick='editTeam(" + dr["TeamId"].ToString() + ",\"" + dr["TeamName"].ToString() + "\",\"" + dr["TeamCount"].ToString() + "\",\"" + dr["Technology"].ToString() + "\")'>Edit</a>" + " | " +
                                       "<a href='#' onClick='deleteTeam(" + dr["TeamId"].ToString() + ")'>Delete</a></td>");

                        }
                        else
                        {
                            linkAddUser.Visible = true;
                            group.Append("<td>").Append("<a href='#' onClick='ViewReviews(" + dr["TeamId"].ToString() + ",\"" + dr["TeamName"].ToString() + "\")'>View Reviews</a></td>");
                        }
                        group.Append("</tr>");
                    }
                }
            }
            else
            {
                group.Append("<tr>");
                group.Append("<td>").Append("No Teams Registered").Append("</td>");
                group.Append("</tr>");
            }

            group.Append("</tbody>");
            group.Append("</table>");
            group.Append("</div> <br/> <br/>");

            divTeams.InnerHtml = group.ToString();
            //}
            //else
            //{
            //    Response.Redirect("/Login.aspx");
            //}
        }
        else
        {
            Response.Redirect("UseCases.aspx");
        }
    }

    [WebMethod]
    public static int DeleteTeam()
    {
        return DataService.DeleteTeam(Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]));
    }

    [WebMethod]
    public static void AddTeam()
    {
        Team team = new Team();

        team.TeamName = HttpContext.Current.Request.QueryString["TN"];
        team.TeamSize = Convert.ToInt32(HttpContext.Current.Request.QueryString["TC"]);
        team.Technology = HttpContext.Current.Request.QueryString["Tech"];
        string UseCase = HttpContext.Current.Request.QueryString["UN"];

        team.UseCaseId = Convert.ToInt32(DataService.getUseCases().Select("UseCaseName" + UseCase)[0]["UseCaseId"]);

        DataService.AddTeam(team);
    }

    [WebMethod]
    public static void EditTeam()
    {
        Team team = new Team();

        team.TeamName = HttpContext.Current.Request.QueryString["TN"];
        team.TeamSize = Convert.ToInt32(HttpContext.Current.Request.QueryString["TC"]);
        team.Technology = HttpContext.Current.Request.QueryString["Tech"];
        string UseCase = HttpContext.Current.Request.QueryString["UN"];
        team.UseCaseId = Convert.ToInt32(DataService.getUseCases().Select("UseCaseName" + UseCase)[0]["UseCaseId"]);

        DataService.EditTeam(team);
    }

    [WebMethod]
    public static void AddReview()
    {
        Review review = new Review();

        User user = (User)HttpContext.Current.Session["loggedInUser"];
        if (user != null)
        {
            review.Marks = Convert.ToInt32(HttpContext.Current.Request.QueryString["Score"]);
            review.Comments = HttpContext.Current.Request.QueryString["Comments"];
            review.UserId = user.UserId;
            review.TeamId = Convert.ToInt32(HttpContext.Current.Request.QueryString["teamId"]);

            DataService.AddReview(review);
        }
        //to add an alert to user session inactove
        HttpContext.Current.Response.Redirect("Login.aspx");

    }

    [WebMethod]
    public static string getReviews()
    {
        int TeamId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);
        string sb = " ";
        DataTable dtComments = DataService.getReviews(TeamId);
        if (dtComments != null)
        {

            foreach (DataRow dr in dtComments.Rows)
            {
                sb += "<div class='ibox-content'><div class='table-responsive'><div class='col-md-10'>";
                sb += "<div class='row'><div class='col-md-5'><b>Reviewer:</b></div><div class='col-md-5'><b>" + dr["LastName"].ToString() + "</b></div></div>";
                sb += "<div class='row'><p><div class='col-md-5'>Score:</div><div class='col-md-5'>" + dr["Marks"].ToString() + "</div></p></div>";
                sb += "<div class='row'><div class='col-md-5'>Comments:</div><div class='col-md-5'>" + dr["Comments"].ToString() + "</div></div>";
                sb += "</div></div></div>";
            }

            return sb;
        }
        return string.Empty;
    }

}

