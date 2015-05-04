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
    public partial class ArchiveModules : System.Web.UI.Page
    {
        public string modules = "";
        public string years = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["LoggedIn"]) != null) // checks the user is logged in to remove error of trying to get a null session variable
            {
                modules = SQLSelect.Select("Archive_Modules", "Module_Code, Module_Title", "SUBSTRING(Module_Code,3, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                years = SQLSelect.Select("Archive_Modules", "DISTINCT Archive_Year", "SUBSTRING(Module_Code, 3, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", "");
            }
        }
        [System.Web.Services.WebMethod]
        public static bool ImportModule(string modCode)
        {
            List<List<string>> listTit = SQLSelect.SelectList("Archive_Modules", "Module_Title", "Module_Code = '" + modCode + "'", "");
            string modTit = listTit[0][0];
            modCode = modCode.Remove(0, 2);
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
                }
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "INSERT INTO Modules VALUES(@modCode, @modTit)";
                    command.Parameters.Add("@modCode", SqlDbType.VarChar, 10).Value = modCode;
                    command.Parameters.Add("@modTit", SqlDbType.VarChar, 255).Value = modTit;
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