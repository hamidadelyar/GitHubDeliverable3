using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class AddRoom : System.Web.UI.Page
    {
        public string buildings = "";
        public string facs = "";
        public string rooms = "";
        public string department = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            buildings = SQLSelect.Select("Buildings", "Building_Name, Building_ID", "1=1", "");
            facs = SQLSelect.Select("Facilities", "Facility_Name", "1=1", "");
            rooms = SQLSelect.Select("Rooms", "Rooms.Room_ID, Capacity, Room_Type, Building_ID, Dept_ID", "1=1", "LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID");
            if(Session["LoggedIn"] != null)
            {
                department = SQLSelect.Select("Users", "Dept_ID", "Username = '" + Session["Username"] + "'", "");
            }
        }
    }
}