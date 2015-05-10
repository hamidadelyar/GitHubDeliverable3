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

        protected String RoundStatusAdd()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            string sql = "SELECT * rounds WHERE status = 'open'";
            var status = false;
            if (status == true)
            {
                return "";
            }
            else
            {
                return "<input type=\"button\" ID=\"addRound\" Value=\"Add New Round\" onclick = \"document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'\" />";
            }
        }

        protected bool RoundStatusEnd()
        {
            var status = false;
            if (status == true)
            {
                Button2.Visible = true;
                return true;
            }
            else
            {
                Button2.Visible = false;
                return false;
            }
        }
    }
}