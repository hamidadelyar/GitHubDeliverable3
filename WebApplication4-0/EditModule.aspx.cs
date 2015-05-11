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
    public partial class EditModule : System.Web.UI.Page
    {
        public string module = "";
        public string modules = "";
        public string department = "";
        public string programs = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["LoggedIn"]) != null) // checks the user is logged in to remove error of trying to get a null session variable
            {
                modules = SQLSelect.Select("Modules", "Module_Code", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                department = SQLSelect.Select("Users", "Dept_ID", "Username = '" + Session["Username"] + "'", "");
                System.Diagnostics.Debug.WriteLine(department);
                programs = SQLSelect.Select("Degrees", "Program_Code + ' ' + Program_Name AS Program_Code", "Dept_ID = 'CO'", "");
            }
            if (Request.QueryString["modCode"] != null)
            {
                string modCode = Request.QueryString["modCode"];
                module = SQLSelect.Select("Modules", "Module_Code, Module_Title, Degrees.Program_Code + ' ' + Degrees.Program_Name AS Program_Code", "Module_Code = '"+modCode+"'", "LEFT JOIN Degrees on Degrees.Program_Code = Modules.Program_Code");
            }
            else
            {
                Response.Redirect("Modules");
            }
        }
        [System.Web.Services.WebMethod]
        public static bool UpdateModule(string modCode, string modName, string progTit)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "UPDATE Modules SET Module_Title = @modName, Program_Code = @progTit WHERE Module_Code = @modCode";
                    command.Parameters.Add("@modCode", SqlDbType.VarChar, 10).Value = modCode;
                    command.Parameters.Add("@modName", SqlDbType.VarChar, 255).Value = modName;
                    command.Parameters.Add("@progTit", SqlDbType.Char, 6).Value = progTit;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                    return true;
                }
            }
        }
    }
}