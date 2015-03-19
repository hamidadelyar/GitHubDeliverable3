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
            
            testpara.InnerHtml = "blah";
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

       
        
    }
}