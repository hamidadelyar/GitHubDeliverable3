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
        protected void Page_Load(object sender, EventArgs e)
        {
            buildings = SQLSelect.Select("Buildings", "Building_Name", "1=1", "");
            facs = SQLSelect.Select("Facilities", "Facility_Name", "1=1", "");
        }
    }
}