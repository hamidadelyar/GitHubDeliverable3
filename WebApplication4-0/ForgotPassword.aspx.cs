using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        public string userDets = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            userDets = SQLSelect.Select("Users", "Username, Email", "1=1", "");
        }
    }
}