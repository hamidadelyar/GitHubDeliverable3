using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Providers.Entities;


namespace WebApplication4_0
{
    public partial class Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //automatically fills the modnameInput
        protected void modcodeInput_TextChanged(object sender, EventArgs e)
        {
            
        }

        [System.Web.Services.WebMethod]
        public static string ModcodeToModname(string modcode)
        {
            var modname = "";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "Select Module_Title from [Modules] WHERE Module_Code = '" + modcode + "'";
            SqlCommand comm = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
            if (comm.ExecuteScalar() != null)   //if it does return something
            {
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm.ExecuteScalar().ToString();
                // string result = comm.ExecuteScalar().ToString();
                modname = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0, 2))   //if request is for module from another department
                {
                    modname = "Sorry, you do not have access to this module";
                }
            }
            else //if it doesnt return anything, it means that there is no such module code, hence no such module name
            {
                modname = "";
            }

            conn.Close();
            

            return modname;
        }

      
        [System.Web.Services.WebMethod]
        public static string ModnameToModcode(string modname)
        {
            var modcode = "";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "Select Module_Code from [Modules] WHERE Module_Title = '" + modname + "'";
            SqlCommand comm2 = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
            if (comm2.ExecuteScalar() != null)   //if it does return something
            {
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm2.ExecuteScalar().ToString();
           
                modcode = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0,2))   //if request is for module from another department
                {
                    modcode = "Sorry, you do not have access to this module";
                }

            }
            else //if it doesnt return anything, it means that there is no such module code, hence no such module name
            {
                modcode = "";
            }

            conn.Close();


            return modcode;
        }


        /* This method takes in the value of the input ('term' parameter) that user enters in modInput, i.e. 'Server Side' and finds matching module names
         * on the database, if found returns as an autocomplete option for the user to be able to select, in this example, would return
         'Server Side Programming.
         * Minimum characters that have to be entered before search is carried out is 3. This is set in the javascript section on Request.aspx'*/
        [System.Web.Services.WebMethod]
        public static string[] GetModnames(string term)
        {
            List<string> retCategory = new List<string>();
           
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            {
                string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
                string dep = username.ToLower().Substring(0, 2); //this makes sure only module names from the logged in department come up as autocomplete options
                string query = string.Format("select Module_Title from [Modules] where Module_Code like '" + dep + "%' AND Module_Title Like '%{0}%'", term);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        retCategory.Add(reader.GetString(0));
                    }
                }
                con.Close();
            }
            return retCategory.ToArray();
        }

        /* Does the same as method above, but for modcodeInput. The minimum number of characters that have to be entered to execute this is 2*/
        [System.Web.Services.WebMethod]
        public static string[] GetModcodes(string term)
        {
            List<string> retCategory = new List<string>();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            {
                string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
                string dep = username.ToLower().Substring(0, 2); //this makes sure only module names from the logged in department come up as autocomplete options
                string query = string.Format("select Module_Code from [Modules] where Module_Code like '" + dep + "%' AND Module_Code Like '%{0}%'", term);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        retCategory.Add(reader.GetString(0));
                    }
                }
                con.Close();
            }
            return retCategory.ToArray();
        }

        [System.Web.Services.WebMethod]
        public static string ShowBuildingSelect(bool central, bool east, bool west)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "";
            //different possibilities of queries based on checkboxes checked by user. If user checks central, then central buildings shown.
            if (central == true && east == false && west == false)
            {
                query = "select * from [Buildings] where Park_ID = 'C'";
            }
            if (central == false && east == true && west == false)
            {
                query = "select * from [Buildings] where Park_ID = 'E'";
            }
            if (central == false && east == false && west == true)
            {
                query = "select * from [Buildings] where Park_ID = 'W'";
            }
            //query if multiple checkbox selected
            if (central == true && east == true && west == false)
            {
                query = "select * from [Buildings] where Park_ID != 'W'";
            }
            if (central == true && east == false && west == true)
            {
                query = "select * from [Buildings] where Park_ID != 'E'";
            }
            if (central == false && east == true && west == true)
            {
                query = "select * from [Buildings] where Park_ID != 'C'";
            }
            //query if all checkboxes selected
            if (central == true && east == true && west == true)
            {
                query = "select * from [Buildings]";
            }

            string result = "<option value='0'> - NO BUILDING PREFERENCE - </option>"; 

            if (query != "")
            {
                SqlCommand comm = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    result += "<option value ='" + reader.GetString(0) + "'>" + reader.GetString(1) + " (" + reader.GetString(0) + ")</option>";
                }
            }
           // string result = comm.ExecuteScalar().ToString();
            conn.Close();
            return result;
        }
        
    }
}