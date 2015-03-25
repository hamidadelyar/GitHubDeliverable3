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
            return result = serializer.Serialize(rows);
        }
        [System.Web.Services.WebMethod]
        public static string SearchRoom(string room, int week, int semester)
        {
            string modSel = "";
            string retData = "";
            for(int i = 1; i < 10; i++)
            {
                for(int j = 1; j < 6; j++)
                {
                    if(week < 13)
                    {
                        if(modSel.Length > 0)
                        {
                            modSel = modSel.Remove(modSel.Length - 1);
                        }
                        retData = Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time", "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + " AND Request_Preferences.Room_ID = '" + room + "' AND Requests.Semester = " + semester + " AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true')", "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID");
                        retData = retData.Substring(1, retData.Length - 2);
                        if (retData == "")
                        {
                            string where = "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + " AND Request_Preferences.Room_ID = '" + room + "' AND Requests.Semester = " + semester + " AND Request_Weeks.Week_ID = " + week;
                            string leftJoin = "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID";
                            if (modSel.Length > 0)
                            {
                                modSel = modSel.Remove(modSel.Length - 1);
                            }
                            retData = Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time", where, leftJoin);
                            retData = retData.Substring(1,retData.Length - 2);
                            if(retData != "")
                            {
                                modSel += "," + retData + "}";
                            }
                            else
                            {
                                modSel += "," + "BLANK";
                            }
                        }
                        else
                        {
                            modSel += "," + retData + "}";
                        }
                        /*
                        using (SqlCommand command = new SqlCommand(roomQuery, conn))
                        {
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                int ReqId = reader.GetInt32(2);
                                string lectQuery = "SELECT Lecturer_Name FROM Lecturers LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID WHERE Request_Lecturers.Request_ID = " + ReqId;
                                string lects = "";
                                string modID = reader.GetString(0);
                                string modName = reader.GetString(1);
                                int length = reader.GetByte(4) - reader.GetByte(3) + 1;
                                reader.Close();
                                using (SqlCommand commandLect = new SqlCommand(lectQuery, conn))
                                {
                                    SqlDataReader readerLect = commandLect.ExecuteReader();
                                    if (readerLect.Read())
                                    {
                                        lects += readerLect.GetString(0) + ",";
                                    }
                                }
                                lects = lects.Remove(lects.Length - 1);
                                modCode += modID + "|" + modName + "|" + lects + "|" + length + ",";
                            }
                            else
                            {
                                string roomQueryTwo = "SELECT Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time FROM Requests LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID WHERE Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + " AND Request_Preferences.Room_ID = '" + room + "' AND Requests.Semester = " + semester + " AND Request_Weeks.Week_ID = " + week;
                                using (SqlCommand commandTwo = new SqlCommand(roomQueryTwo, conn))
                                {
                                    reader.Close();
                                    SqlDataReader readerTwo = commandTwo.ExecuteReader();
                                    if (readerTwo.Read())
                                    {
                                        int ReqId = readerTwo.GetInt32(2);
                                        string lectQuery = "SELECT Lecturer_Name FROM Lecturers LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID WHERE Request_Lecturers.Request_ID = " + ReqId;
                                        string lects = "";
                                        string modID = readerTwo.GetString(0);
                                        string modName = readerTwo.GetString(1);
                                        int length = readerTwo.GetByte(4) - readerTwo.GetByte(3) + 1;
                                        readerTwo.Close();
                                        using (SqlCommand commandLect = new SqlCommand(lectQuery, conn))
                                        {
                                            SqlDataReader readerLect = commandLect.ExecuteReader();
                                            if (readerLect.Read())
                                            {
                                                lects += readerLect.GetString(0) + ",";
                                            }
                                        }
                                        lects = lects.Remove(lects.Length - 1);
                                        modCode += modID + "|" + modName + "|" + lects + "|" + length + ",";
                                    }
                                    else
                                    {
                                        modCode += "Blank,";
                                    }
                                }
                            }
                            */
                    }
                }
            }
        return modSel;
        }
    }
}