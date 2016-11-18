using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static List<Report> getReports()
    {
        DataTable dtReports = DataService.getReports();
        List<Report> dataList = new List<Report>();

        foreach (DataRow dtrow in dtReports.Rows)
        {
            Report report = new Report();
            report.Score = Convert.ToInt32(dtrow["Score"].ToString());
            report.TeamName = dtrow["TeamName"].ToString();
            dataList.Add(report);
        }
        return dataList;
    }
}