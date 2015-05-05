using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0.AdminFolder
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["LoggedIn"] != null)
            {
                if(((string) Session["username"]) != "admin")
                {
                    System.Diagnostics.Debug.WriteLine(Session["username"]);
                    Response.Write("<script>alert('You do not have permission to view this page.');</script>");
                    Response.Redirect("../Timetable.aspx");
                }
            }
        }
    }
}