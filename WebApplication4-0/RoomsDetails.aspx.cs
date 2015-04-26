using System;
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
    public partial class RoomsDetails : System.Web.UI.Page
    {
        public string code = "";
        public string building = "";
        public string capacity = "";
        public string type = "";
        public string park = "";
        public string facs = "";
        public string img = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["roomCode"] != null)
            {
                string data = "";
                string roomCode = Request.QueryString["roomCode"];
                data = Select("Rooms", "Rooms.Room_ID, Buildings.Building_Name, Rooms.Capacity, Room_Types.Type_Name, Parks.Park_Name", "Rooms.Room_ID = '" + roomCode + "'", "LEFT JOIN Buildings ON Buildings.Building_ID = Rooms.Building_ID LEFT JOIN Parks ON Parks.Park_ID = Buildings.Park_ID LEFT JOIN Room_Types ON Room_Types.Room_Type = Rooms.Room_Type");
                facs = Select("Room_Facilities", "Facility_ID", "Room_ID = '" + roomCode + "'", "");
                data = data.Replace("\"", "");
                data = data.Replace("[", "");
                data = data.Replace("]", "");
                string[] fndRooms = data.Split('{');
                for (int n = 0; n < fndRooms.Length; n++)
                {
                    if (fndRooms[n].Length > 0)
                    {
                        fndRooms[n] = fndRooms[n].Substring(0, fndRooms[n].Length - 1);
                        fndRooms[n] = fndRooms[n].Replace("}", "");
                        fndRooms[n] = fndRooms[n].Replace("Room_ID:", "");
                        fndRooms[n] = fndRooms[n].Replace("Building_Name:", "");
                        fndRooms[n] = fndRooms[n].Replace("Capacity:", "");
                        fndRooms[n] = fndRooms[n].Replace("Type_Name:", "");
                        fndRooms[n] = fndRooms[n].Replace("Park_Name:", "");
                        string[] roomDet = fndRooms[n].Split(',');
                        code = roomDet[0];
                        building = roomDet[1];
                        capacity = roomDet[2];
                        type = roomDet[3];
                        park = roomDet[4];
                        img = code.Replace(".", "");
                    }
                }
            }
            else
            {
                code = "Unknown";
                building = "Unknown";
                capacity = "Unknown";
                type = "Unknown";
                park = "Unknown";
                facs = "[]";
            }
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
    }
}