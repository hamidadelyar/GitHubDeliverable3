using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Providers.Entities;
using System.Web.Script.Serialization;

namespace WebApplication4_0.AdminFolder
{
    public partial class Rounds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        /*
            string myScalarQuery = "SELECT * rounds WHERE status = 'open'";
            SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["team02ConnectionString1"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(myScalarQuery, myConnection);
            myCommand.Connection.Open();
            int count = (int)myCommand.ExecuteScalar();
            myConnection.Close();
        
         *             string queryString = "SELECT * Rounds WHERE Status = 'open'";
            string connectionString = "team02ConnectionString1";
            using (SqlConnection connection = new SqlConnection(
                       connectionString))
            {
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Connection.Open();
                count = (int)command.ExecuteScalar();
                command.Connection.Close();
            }
         
         */

        protected String RoundStatusAdd()
        {
            int count = 0;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            string sql = "SELECT count(*) FROM Rounds WHERE Status = 'open'";

            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            count = (int)cmd.ExecuteScalar();
            conn.Close();
            conn.Dispose();

            var status = true; 

            if (count == 0) { // no current open round
                status = false; 
            }
            if (status == true)
            {
                return "";
            }
            else
            {
                return "<input type=\"button\" ID=\"addRound\" Value=\"Add New Round\" onclick = \"document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'\" />";
            }
        }

        protected String RoundStatusAddMessage()
        {
            int count = 0;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            string sql = "SELECT count(*) FROM Rounds WHERE Status = 'open'";

            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            count = (int)cmd.ExecuteScalar();
            conn.Close();
            conn.Dispose();

            var status = true;

            if (count == 0)
            { // no current open round
                status = false;
            }
            if (status == true)
            {
                return "";
            }
            else
            {
                return "No Round Currently in Progress";
            }
        }

        protected String RoundStatusEnd()
        {
            int count = 0;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            string sql = "SELECT count(*) FROM Rounds WHERE Status = 'open'";

            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            count = (int)cmd.ExecuteScalar();
            conn.Close();
            conn.Dispose();

            var status = true;

            if (count == 0)
            { // no current open round
                status = false;
            }

            if (status == true)
            {
                Button2.Visible = true;
                return "";
            }
            else
            {
                Button2.Visible = false;
                return "";
            }
        }
    }
}