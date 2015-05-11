using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class ArchiveRequest : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SqlDataSource2(object sender, CommandEventArgs e)
        {

        }

        protected void SqlDataSource14Filter(object sender, EventArgs e)
        {

        }

        protected void ArchiveRequests_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = ArchiveRequests.SelectedRow;
            string value = row.Cells[0].Text;
            
        }
    }
}