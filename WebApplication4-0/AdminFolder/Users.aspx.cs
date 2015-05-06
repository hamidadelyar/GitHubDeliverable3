using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0.AdminFolder
{
    public partial class Users : System.Web.UI.Page
    {
        public string users = "";
        public string departments = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            users = SQLSelect.Select("Users", "Username, Forename, Surname, Email", "1=1", "") ;
            departments = SQLSelect.Select("Departments", "*", "1=1", "");
        }
        [System.Web.Services.WebMethod]
        public static bool DeleteModule(string username)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "DELETE FROM Users WHERE Username = @user";
                    command.Parameters.Add("@user", SqlDbType.VarChar, 50).Value = username;
                    System.Diagnostics.Debug.WriteLine(command.CommandText);
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine(recordsAffected);
                    conn.Close();
                    return true;
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static bool DeleteMult(string username)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<string> modCodes = json.Deserialize<List<string>>(username);
            string where = "";
            for (int i = 0; i < modCodes.Count; i++)
            {
                where += "Username = '" + modCodes[i] + "' OR ";
            }
            where = where.Substring(0, where.Length - 4);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "DELETE FROM Users WHERE " + where;
                    System.Diagnostics.Debug.WriteLine(command.CommandText);
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine(recordsAffected);
                    conn.Close();
                }
            }
            return true;
        }
    }
}