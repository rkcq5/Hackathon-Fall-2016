using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class DbHelper
{
    public static string HackathonConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["hackathon"].ConnectionString;
        }

    }
    public static SqlConnection HackathonConnection
    {
        get
        {
            return new SqlConnection(HackathonConnectionString);
        }

    }

    public static DataTable GetDataTable(string commandText, CommandType commandType, SqlParameter[] parameters)
    {

        DataSet dsTable = new DataSet();
        SqlDataAdapter dataAdapter = new SqlDataAdapter
        {
            SelectCommand = new SqlCommand { CommandText = commandText, CommandType = commandType }
        };

        dataAdapter.SelectCommand.Parameters.Clear();

        if (parameters != null)
        {
            for (int i = 0; i < parameters.Length; i++)
            {
                dataAdapter.SelectCommand.Parameters.Add(parameters[i]);
            }
        }

        SqlConnection connection = HackathonConnection;

        try
        {
            connection.Open();
            dataAdapter.SelectCommand.Connection = connection;
            dataAdapter.Fill(dsTable);
            connection.Close();

            if (dsTable.Tables[0].Rows.Count > 0)
            {
                return dsTable.Tables[0];
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            return null;
        }

    }


    public static int Insert(string commandText, CommandType commandType, SqlParameter[] parameters)
    {
        int rtnVal1 = 0;
        SqlConnection connection = HackathonConnection;
        SqlCommand sqlCommand = new SqlCommand(commandText, connection);
        sqlCommand.CommandType = commandType;

        if (parameters != null)
        {
            for (int i = 0; i < parameters.Length; i++)
            {
                sqlCommand.Parameters.Add(parameters[i]);
            }
            try
            {
                connection.Open();
                rtnVal1 = sqlCommand.ExecuteNonQuery();
                connection.Close();

                return rtnVal1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        return 0;
    }

    public static int ModifyDB(string commandText, CommandType commandType, SqlParameter[] parameters)
    {
        int rtnVal1 = 0;
        SqlConnection connection = HackathonConnection;
        SqlCommand OraCommand = new SqlCommand(commandText, connection);
        OraCommand.CommandType = commandType;

        if (parameters != null)
        {
            for (int i = 0; i < parameters.Length; i++)
            {
                OraCommand.Parameters.Add(parameters[i]);
            }
            try
            {
                connection.Open();
                rtnVal1 = OraCommand.ExecuteNonQuery();
                connection.Close();

                return 1;
            }
            catch (Exception ex)
            {

            }
        }

        return 0;
    }


}