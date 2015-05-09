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
        public string facs = "";
        public string buildings = "";
        public string rooms = "";
        public string preferences = "";
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
                facs = SQLSelect.Select("Facilities", "Facility_Name", "1=1", "");
                buildings = SQLSelect.Select("Buildings", "Building_Name, Building_ID, Park_ID", "1=1", "");
                rooms = SQLSelect.Select("Rooms", "Room_ID, Building_ID, Room_Type", "1=1", "");
                preferences = SQLSelect.Select("Request_Preferences", "Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks", "Request_ID = '" + id + "'", "");
            }
        }
    }
}