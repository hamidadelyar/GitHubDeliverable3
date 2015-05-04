using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
    }
}