using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;

namespace WebApplication4_0
{
    public partial class AddDegree : System.Web.UI.Page
    {
        public string degrees;
        public string department;
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["LoggedIn"]) != null) // checks the user is logged in to remove error of trying to get a null session variable
            {
                degrees = SQLSelect.Select("Degrees", "Program_Code", "Dept_ID = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the degree codes that are from the user's department
                department = SQLSelect.Select("Users", "Dept_ID", "Username = '" + Session["Username"] + "'", "");
            }
        }
        [System.Web.Services.WebMethod]
        public static bool InsertDegree(string degCode, string degName)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "INSERT INTO Degrees (Program_Code, Program_Name, Dept_ID) VALUES (@degCode, @degName, LEFT(@degCode, 2))";
                    command.Parameters.Add("@degCode", SqlDbType.VarChar, 10).Value = degCode;
                    command.Parameters.Add("@degName", SqlDbType.VarChar, 255).Value = degName;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                    return true;
                }
            }
        }
    }
}