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
        public string id = "";
        public string request = "";
        public string selLects = "";
        public string weekData = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["LoggedIn"] != null)
            {
                if (Request.QueryString["ID"] != null)
                {
                    id = Request.QueryString["ID"];
                }
                else
                {
                    Response.Redirect("ViewRequest.aspx");
                }
                modData = SQLSelect.Select("Modules", "Module_Code, Module_Title", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' - ' + Lecturer_Name AS Lecturer_ID", "LEFT(Lecturer_ID, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the lecturers from the user's department
                request = SQLSelect.Select("Requests", "*", "Request_ID = '" + id + "'", "");
                selLects = SQLSelect.Select("Request_Lecturers", "Lecturers.Lecturer_ID, Lecturers.Lecturer_Name", "Request_ID = '" + id + "'", "LEFT JOIN Lecturers ON Lecturers.Lecturer_ID = Request_Lecturers.Lecturer_ID");
                //weekData = SQLSelect.Select("Week_ID")
            }
        }
    }
}