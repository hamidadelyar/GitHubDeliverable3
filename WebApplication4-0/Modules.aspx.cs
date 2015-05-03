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
    public partial class Modules1 : System.Web.UI.Page
    {
        public string modules = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["LoggedIn"]) != null) // checks the user is logged in to remove error of trying to get a null session variable
            {
                modules = SQLSelect.Select("Modules", "Module_Code, Module_Title", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
            }
        }
        [System.Web.Services.WebMethod]
        public static bool DeleteModule(string modCode)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "DELETE FROM Modules WHERE Module_Code = @modCode";
                    command.Parameters.Add("@modCode", SqlDbType.VarChar, 10).Value = modCode;
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
        public static bool DeleteMult(string modCode)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<string> modCodes = json.Deserialize<List<string>>(modCode);
            string where = "";
            for (int i = 0; i < modCodes.Count; i++)
            {
                where += "Module_Code = '" + modCodes[i] + "' OR ";
            }
            where = where.Substring(0, where.Length - 4);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "DELETE FROM Modules WHERE " +  where;
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