using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class EditRequest : System.Web.UI.Page
    {
        public string modData = "";
        public string lectData = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["LoggedIn"] != null)
            {
                modData = SQLSelect.Select("Modules", "Module_Code, Module_Title", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' - ' + Lecturer_Name AS Lecturer_ID", "LEFT(Lecturer_ID, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the lecturers from the user's department
            }
        }
    }
}