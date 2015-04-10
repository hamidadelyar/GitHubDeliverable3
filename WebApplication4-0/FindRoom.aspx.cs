using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;

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
            JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
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
        public static string SearchRooms(string parks, string semester,  string weeks, string periods, string students, string facs, string roomType)
        {
            string parkRooms = SearchParks(parks);
            string takenRooms = SearchPeriods(semester, weeks, periods);
            return takenRooms;
        }
        private static string SearchParks(string parkData)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> parks = json.Deserialize<List<int>>(parkData);
            string rooms = "";
            List<char> parkList = new List<char>(){'C','E','W'};
            for (int i = 0; i < parks.Count; i++ )
            {
                if(parks[i] == 1)
                {
                    char parkID = parkList[i];
                    rooms += Select("Rooms", "Room_ID", "Buildings.Park_ID = '" + parkID + "'", "LEFT JOIN Buildings ON Rooms.Building_ID = Buildings.Building_ID");
                    rooms = rooms.Substring(1, rooms.Length - 2);
                    rooms = rooms.Replace("[", ",");
                }
            }
            return rooms;
        }
        private static string SearchPeriods(string semester, string weekData, string periodData)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> weeks = json.Deserialize<List<int>>(weekData);
            List<List<int>> periods = json.Deserialize<List<List<int>>>(periodData);
            List<Periods> times = new List<Periods>();
            string rooms = "";
            for (int i = 1; i < periods.Count + 1; i++)
            {
                int length = 0;
                int startTime = 0;
                for (int j = 1; j < periods[i-1].Count + 1; j++)
                {
                    if (periods[i - 1][j - 1] == 1)
                    {
                        if (startTime == 0)
                        {
                            startTime = j;
                        }
                        length++;
                        if(j == periods[i-1].Count)
                        {
                            rooms += "New Period(Day: " + i + " Start: " + startTime + " Length: " + length + ")\n";
                            Periods newPer = new Periods(i, startTime, length);
                            times.Add(newPer);
                            startTime = 0;
                            length = 0;
                        }
                    }
                    else if (length != 0)
                    {
                        rooms += "New Period(Day: "+i+" Start: "+startTime+" Length: "+length+")\n";
                        Periods newPer = new Periods(i, startTime, length);
                        times.Add(newPer);
                        startTime = 0;
                        length = 0;
                    }
                }
            }
            /*
            for( int i = 1; i < weeks.Count+1; i++)
            {
                for( int j = 1; j < 6; j++)
                {
                    for(int k = 1; k < 10; k++)
                    {
                        if(periods[j-1][k-1] == 1)
                        {
                            string where = "";
                            string leftJoin = "";
                            string retRooms = "";
                            if (weeks[i - 1] < 13)
                            {
                                leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID";
                                where = "Requests.Day = day AND Requests.Semester = semester AND (Requests.Start_Time = startTime OR (Requests.Start_Time < startTime AND Requests.End_Time > startTime) OR (Requests.Start_Time < endTime AND Requests.End_Time > endTime) OR Requests.End_Time = endTime) AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true') AND Bookings.Confirmed = 'Allocated'";
                                retRooms = Select("Requests", "Request_Preferences.Room_ID", where, leftJoin);
                            }
                            else
                            {
                                retRooms = "[]";
                            }
                            if (retRooms == "[]")
                            {
                                leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID";
                                where = "Requests.Day = day AND Requests.Semester = semester AND (Requests.Start_Time = startTime OR (Requests.Start_Time < startTime AND Requests.End_Time > startTime) OR (Requests.Start_Time < endTime AND Requests.End_Time > endTime) OR Requests.End_Time = endTime) AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true') AND Bookings.Confirmed = 'Allocated'";
                                retRooms = Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID", where, leftJoin);
                                if (rooms != "[]")
                                {
                                    rooms += retRooms;
                                    rooms = rooms.Substring(1, rooms.Length - 2);
                                    rooms = rooms.Replace("[", ",");
                                }
                            }
                            else
                            {
                                rooms += retRooms;
                                rooms = rooms.Substring(1, rooms.Length - 2);
                                rooms = rooms.Replace("[", ",");
                            }
                        }
                    }
                }
            }
            */
            return rooms;
        }
    }
    public class Periods
    {
        public int day;
        public int start;
        public int end;

        public Periods(int day, int start, int length)
        {
            this.day = day;
            this.start = start;
            this.end = start + length - 1;
        }
        public int getDay()
        {
            return day;
        }
        public int getStart()
        {
            return start;
        }
        public int getEnd()
        {
            return end;
        }
    }
}