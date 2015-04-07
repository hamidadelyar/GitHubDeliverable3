using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace WebApplication4_0
{
    public partial class FindRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static string Select(string table, string columns, string where, string leftJoin)
        {
            SqlConnection conn;
            DataTable dt = new DataTable();
            string result = "";
            //where "myConnectionString" is the connection string in the web.config file
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            //prepare query
            string roomQuery = "Select " + columns + " FROM " + table + " " + leftJoin + " WHERE " + where;   //deptName is deptCode for some reason in the DB, vice versa
            SqlCommand comm = new SqlCommand(roomQuery, conn);  //1st argument is query, 2nd argument is connection with DB

            SqlDataAdapter da = new SqlDataAdapter(comm);
            da.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            conn.Close();
            return result = serializer.Serialize(rows);
        }
        [System.Web.Services.WebMethod]
        protected string SearchRooms(List<int> parks, int semester, List<int> weeks, List<List<int>> periods, int students, List<int> facs, int roomType)
        {
            string parkRooms = SearchParks(parks);
            return parkRooms;
        }
        protected string SearchParks(List<int> parks)
        {
            string rooms = "";
            List<char> parkList = new List<char>(){'C','E','W'};
            foreach(int parkNum in parks)
            {
                char parkID = parkList[parkNum];
                rooms += Select("Rooms", "Room_ID", "Building.Park_ID = '" + parkID + "'", "LEFT JOIN Buildings ON Rooms.Building_ID = Buildings.Building_ID");
            }
            return rooms;
        }
    }
}