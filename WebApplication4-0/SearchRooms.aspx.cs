using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class SearchRooms : System.Web.UI.Page
    {
        public string data = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            data = SQLSelect.Select("Rooms", "Room_ID", "1=1", "");
        }
    }
}