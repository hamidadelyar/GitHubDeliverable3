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

namespace WebApplication4_0
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
    }
}