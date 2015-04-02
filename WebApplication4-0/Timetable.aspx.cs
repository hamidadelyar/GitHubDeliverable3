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
    public partial class Timetable : System.Web.UI.Page
    {
        static SqlConnection conn;
        public String data = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            data = Select("Rooms", "Room_ID", "1=1", "");
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
            string roomQuery = "Select "+columns+" FROM "+table+" "+leftJoin+" WHERE "+where;   //deptName is deptCode for some reason in the DB, vice versa
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
        public static string SearchRoom(string room, int week, int semester, int type)
        {
            string modSel = "";
            string retData = "";
            string searchColumn = "";
            string lectColumn = "";
            if(type == 1)
            {
                searchColumn =  " AND Request_Preferences.Room_ID = '" + room + "'";
                lectColumn = "";
            }
            else if(type == 2)
            {
                searchColumn =  " AND Requests.Module_Code = '" + room + "'";
                lectColumn = "";
            }
            else
            {
                searchColumn = "AND Request_Lecturers.Lecturer_ID = '" + room + "'";
            }
            for (int i = 1; i < 10; i++)
            {
                for (int j = 1; j < 6; j++)
                {
                    if (week < 13)
                    {
                        retData = Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID", "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + searchColumn + " AND Requests.Semester = " + semester + " AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true')", "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Lecturers ON Request_Lecturers.Request_ID = Requests.Request_ID");
                        if (retData == "[]")
                        {
                            string where = "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + searchColumn + " AND Requests.Semester = " + semester + " AND Request_Weeks.Week_ID = " + week;
                            string leftJoin = "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Lecturers ON Request_Lecturers.Request_ID = Requests.Request_ID";
                            retData = Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID", where, leftJoin);
                            if (retData != "[]")
                            {
                                retData = retData.Substring(1, retData.Length - 2);
                                string reqID = getValue(retData, 2);
                                string lecData = Select("Lecturers", "Lecturer_Name", "Request_Lecturers.Request_ID = " + reqID, "LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID");
                                string fullData = "[" + retData.Substring(0, retData.Length - 1) + "," + lecData.Substring(2, lecData.Length - 3) + "]";
                                modSel += "," + fullData;
                            }
                            else
                            {
                                modSel += "," + "[{}]";
                            }
                        }
                        else
                        {
                            retData = retData.Substring(1, retData.Length - 2);
                            string reqID = getValue(retData, 2);
                            string lecData = Select("Lecturers", "Lecturer_Name", "Request_Lecturers.Request_ID = " + reqID, "LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID");
                            string fullData = "[" + retData.Substring(0, retData.Length - 1) + "," + lecData.Substring(2, lecData.Length - 3) + "]";
                            modSel += "," + fullData;
                        }
                    }
                }
            }
            modSel = modSel.Remove(0,1);
            return "[" + modSel + "]";
        }
        public static string getValue(string variable, int i)
        {
            List<string> newList = variable.Split(',').ToList<string>();
            List<string> elList = newList[i].Split(':').ToList<string>();
            return elList[1];
        }
    }
}