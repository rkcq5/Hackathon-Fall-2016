using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class DataService
{
    public static User isValidUser(string userName, string password)
    {
        SqlParameter[] parameters = new SqlParameter[2];

        SqlParameter op = null;
        User user = new User();

        op = new SqlParameter("userName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = userName;
        parameters[0] = op;
        op = new SqlParameter("password", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = password;
        parameters[1] = op;

        DataTable dtUser = DbHelper.GetDataTable("getValidUser", CommandType.StoredProcedure, parameters);


        if (dtUser != null && dtUser.Rows.Count > 0)
        {
            user.UserId = Convert.ToInt32(dtUser.Rows[0]["UserId"]);
            user.FirstName = dtUser.Rows[0]["FirstName"].ToString();
            user.LastName = dtUser.Rows[0]["LastName"].ToString();
            user.UserName = dtUser.Rows[0]["UserName"].ToString();
            user.UserRole = dtUser.Rows[0]["UserRole"].ToString();

            return user;
        }
        return null;
    }

    public static DataTable getUseCases()
    {
        DataTable dtUseCases = DbHelper.GetDataTable("getusecase", CommandType.StoredProcedure, null);
        return dtUseCases;
    }

    public static DataTable getCompanyList(string LastName)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("LastName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = LastName;
        parameters[0] = op;

        DataTable dtUseCases = DbHelper.GetDataTable("getCompanies", CommandType.StoredProcedure, parameters);
        return dtUseCases;
    }

    public static DataTable EditUseCase()
    {
        return null;
    }

    public static int EditTeam(Team team)
    {
        SqlParameter[] parameters = new SqlParameter[4];

        SqlParameter op = null;


        op = new SqlParameter("TeamName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = team.TeamName;
        parameters[0] = op;

        op = new SqlParameter("TeamCount", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = team.TeamSize;
        parameters[1] = op;

        op = new SqlParameter("Techonology", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = team.Technology;
        parameters[2] = op;

        op = new SqlParameter("UseCaseId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = team.UseCaseId;
        parameters[3] = op;

        return DbHelper.Insert("UpdateTeam", CommandType.StoredProcedure, parameters);
    }



    public static int DeleteUseCase(int id)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("UsecaseId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = id;
        parameters[0] = op;
        return DbHelper.ModifyDB("DeleteUseCase", CommandType.StoredProcedure, parameters);
    }

    public static int DeleteTeam(int id)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("TeamId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = id;
        parameters[0] = op;
        return DbHelper.ModifyDB("DeleteTeam", CommandType.StoredProcedure, parameters);

    }

    public static void AddUser(User user)
    {
        SqlParameter[] parameters = new SqlParameter[5];

        SqlParameter op = null;

        op = new SqlParameter("FirstName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.FirstName;
        parameters[0] = op;

        op = new SqlParameter("LastName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.LastName;
        parameters[1] = op;

        op = new SqlParameter("UserName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.UserName;
        parameters[2] = op;

        op = new SqlParameter("Email", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.Email;
        parameters[3] = op;

        op = new SqlParameter("UserRole", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.UserRole;
        parameters[4] = op;

        DbHelper.Insert("AddUsers", CommandType.StoredProcedure, parameters);
    }

    public static void EditUser(User user)
    {
        SqlParameter[] parameters = new SqlParameter[6];

        SqlParameter op = null;

        op = new SqlParameter("userid", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.UserId;
        parameters[0] = op;

        op = new SqlParameter("FirstName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.FirstName;
        parameters[1] = op;

        op = new SqlParameter("LastName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.LastName;
        parameters[2] = op;

        op = new SqlParameter("UserName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.UserName;
        parameters[3] = op;

        op = new SqlParameter("Email", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.Email;
        parameters[4] = op;

        op = new SqlParameter("UserRole", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = user.UserRole;
        parameters[5] = op;

        DbHelper.ModifyDB("updateusers", CommandType.StoredProcedure, parameters);
    }

    public static int DeleteUser(int userId)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("userId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = userId;
        parameters[0] = op;
        return DbHelper.ModifyDB("DeleteUser", CommandType.StoredProcedure, parameters);

    }

    public static int AddReview(Review review)
    {
        SqlParameter[] parameters = new SqlParameter[4];

        SqlParameter op = null;

        op = new SqlParameter("UserId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = review.UserId;
        parameters[0] = op;

        op = new SqlParameter("TeamId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = review.TeamId;
        parameters[1] = op;

        op = new SqlParameter("Comments", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = review.Comments;
        parameters[2] = op;

        op = new SqlParameter("Marks", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = review.Marks;
        parameters[4] = op;

        return DbHelper.Insert("AddReviews", CommandType.StoredProcedure, parameters);
    }

    public static int AddUseCase()
    {
        return 0;
    }

    public static int AddTeam(Team team)
    {
        SqlParameter[] parameters = new SqlParameter[2];

        SqlParameter op = null;


        op = new SqlParameter("TeamName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = team.TeamName;
        parameters[0] = op;

        op = new SqlParameter("TeamCount", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = team.TeamSize;
        parameters[1] = op;

        op = new SqlParameter("Techonology", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = team.Technology;
        parameters[0] = op;

        op = new SqlParameter("UseCaseId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = team.UseCaseId;
        parameters[1] = op;

        return DbHelper.Insert("AddTeam", CommandType.StoredProcedure, parameters);
    }



    public static DataTable getTeams()
    {
        DataTable dtTeams = DbHelper.GetDataTable("GetTeams", CommandType.StoredProcedure, null);
        return dtTeams;
    }

    public static DataTable getReviews(int teamId)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("teamId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = teamId;
        parameters[0] = op;

        DataTable dtReviews = DbHelper.GetDataTable("getReviews", CommandType.StoredProcedure, parameters);
        return dtReviews;
    }

    public static DataTable getUsers()
    {
        DataTable dtUsers = DbHelper.GetDataTable("getUsers", CommandType.StoredProcedure, null);
        return dtUsers;
    }

    public static DataTable getReports()
    {
        DataTable dtReports = DbHelper.GetDataTable("getReport", CommandType.StoredProcedure, null);
        return dtReports;
    }


    #region Company

    public static DataTable getCompanies()
    {
        DataTable dtCompanies = DbHelper.GetDataTable("getCompanies", CommandType.StoredProcedure, null);
        return dtCompanies;
    }

    public static int AddCompany(Company company)
    {
        SqlParameter[] parameters = new SqlParameter[2];

        SqlParameter op = null;

        op = new SqlParameter("CompanyName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = company.CompanyName;
        parameters[0] = op;

        op = new SqlParameter("CompanyUserId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = company.CompanyUserId;
        parameters[1] = op;

        return DbHelper.Insert("AddCompany", CommandType.StoredProcedure, parameters);


    }

    public static int EditCompany(Company company)
    {
        SqlParameter[] parameters = new SqlParameter[3];

        SqlParameter op = null;

        op = new SqlParameter("CompanyId", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = company.CompanyId;
        parameters[0] = op;

        op = new SqlParameter("CompanyName", SqlDbType.NVarChar);
        op.Direction = ParameterDirection.Input;
        op.Value = company.CompanyName;
        parameters[1] = op;

        op = new SqlParameter("CompanyUserId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = company.CompanyUserId;
        parameters[2] = op;

        return DbHelper.ModifyDB("UpdateCompanies", CommandType.StoredProcedure, parameters);

    }

    public static int DeleteCompany(int id)
    {
        SqlParameter[] parameters = new SqlParameter[1];

        SqlParameter op = null;

        op = new SqlParameter("CompanyId", SqlDbType.Int);
        op.Direction = ParameterDirection.Input;
        op.Value = id;
        parameters[0] = op;
        return DbHelper.ModifyDB("DeleteCompany", CommandType.StoredProcedure, parameters);
    }

    #endregion
}