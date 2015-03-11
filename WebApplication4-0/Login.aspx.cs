using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4_0
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            //where "myConnectionString" is the connection string in the web.config file
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            //prepare query
            string checkuser = "Select count(*) FROM [User] WHERE deptName = '" + TextboxUsername.Text + "'";   //deptName is deptCode for some reason in the DB, vice versa
            SqlCommand comm = new SqlCommand(checkuser, conn);  //1st argument is query, 2nd argument is connection with DB
            int temp = Convert.ToInt32(comm.ExecuteScalar().ToString());
            // string result = comm.ExecuteScalar().ToString();
            conn.Close();

        
        }
    }
}