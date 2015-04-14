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
            List<Periods> times = new List<Periods>();
         
            List<Rooms> parkRooms = SearchParks(parks, roomType, students);
            List<Rooms> takenRooms = SearchPeriods(semester, weeks, periods, times);
            List<Rooms> facRooms = SearchFacs(facs);
            List<Rooms> possRooms = new List<Rooms>();
            for (int i = 0; i < facRooms.Count; i++)
            {
                for (int j = 0; j < parkRooms.Count; j++)
                {
                    if(parkRooms[j].getNum() == facRooms[i].getNum())
                    {
                        possRooms.Add(parkRooms[j]);
                    }
                }
            }

            possRooms = possRooms.Distinct().ToList();

            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> weekData = json.Deserialize<List<int>>(weeks);

            List<FreeRoom> rooms = new List<FreeRoom>();
            //Loop through each week they've selected, then each period selected that week, then remove rooms not availible.
            for (int i = 0; i < weekData.Count; i++)
            {
                if(weekData[i] == 1)
                {
                    for (int j = 0; j < times.Count; j++)
                    {
                        List<Rooms> tmpRooms = new List<Rooms>();
                        for (int q = 0; q < possRooms.Count; q++)
                        {
                            tmpRooms.Add(possRooms[q]);
                        }
                            System.Diagnostics.Debug.WriteLine("Length: " + tmpRooms.Count);
                        for(int k = 0; k < takenRooms.Count; k++)
                        {
                            Periods takenRoom = takenRooms[k].getPer();
                            if(takenRoom.getDay() == times[j].getDay() && takenRoom.getEnd() == times[j].getEnd() && takenRoom.getStart() == times[j].getStart() && takenRooms[k].getWeek() == i+1)
                            {
                                for(int l = 0; l < tmpRooms.Count; l++)
                                {
                                    if (tmpRooms[l].getNum() == takenRooms[k].getNum())
                                    {
                                        tmpRooms.RemoveAt(l);
                                    }
                                }
                            }
                        }
                        for (int m = 0; m < tmpRooms.Count; m++)
                        {
                            FreeRoom newRoom = new FreeRoom(tmpRooms[m].getNum(), i + 1, times[j].getDay(), times[j].getStart(), times[j].getEnd());
                            rooms.Add(newRoom);
                        }
                    }
                }
            }
            rooms = rooms.OrderBy(x => x.week).ThenBy(x => x.day).ThenBy(x => x.start).ToList();
            for(int i = 0; i < rooms.Count; i++)
            {
                System.Diagnostics.Debug.WriteLine("Rooms: " + rooms[i].room + ", Day: " + rooms[i].day + ", Start: " + rooms[i].start + ", End: " + rooms[i].end + ", Week: " + rooms[i].week);
            }
            return json.Serialize(rooms);
        }
        private static List<Rooms> SearchParks(string parkData, string typeData, string students)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> parks = json.Deserialize<List<int>>(parkData);
            int type = Convert.ToInt32(typeData);
            string retRooms = "";
            List<char> parkList = new List<char>(){'C','E','W'};
            List<string> typeList = new List<string>() { "[TSL]", "T", "S", "L" };
            List<Rooms> rooms = new List<Rooms>();
            string typeC = typeList[type];
            for (int i = 0; i < parks.Count; i++ )
            {
                if(parks[i] == 1)
                {
                    char parkID = parkList[i];
                    retRooms += Select("Rooms", "Room_ID", "Buildings.Park_ID = '" + parkID + "' AND Rooms.Room_Type LIKE '" + typeC + "' AND Rooms.Capacity >= " + students , "LEFT JOIN Buildings ON Rooms.Building_ID = Buildings.Building_ID");
                    retRooms = retRooms.Replace("{", "");
                    retRooms = retRooms.Replace("}", "");
                    retRooms = retRooms.Replace("\"Room_ID\":", "");
                    retRooms = retRooms.Replace("\"", "");
                    retRooms = retRooms.Replace("[", "");
                    retRooms = retRooms.Replace("]", "");
                    string[] fndRooms = retRooms.Split(',');
                    for (int n = 0; n < fndRooms.Length; n++)
                    {
                        Rooms newBook = new Rooms(fndRooms[n]);
                        rooms.Add(newBook);
                    }
                }
            }
            rooms = rooms.OrderBy(x => x.roomNum).ToList();
            return rooms;
        }
        private static List<Rooms> SearchPeriods(string semester, string weekData, string periodData, List<Periods> times)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> weeks = json.Deserialize<List<int>>(weekData);
            List<List<int>> periods = json.Deserialize<List<List<int>>>(periodData);
            semester = semester + 1;
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
                            Periods newPer = new Periods(i, startTime, length);
                            times.Add(newPer);
                            startTime = 0;
                            length = 0;
                        }
                    }
                    else if (length != 0)
                    {
                        Periods newPer = new Periods(i, startTime, length);
                        times.Add(newPer);
                        startTime = 0;
                        length = 0;
                    }
                }
            }
            string leftJoin;
            string where;
            string retRooms;
            List<Rooms> bookedRooms = new List<Rooms>();
            for (int i = 1; i < weeks.Count + 1; i++)
            {
                if (weeks[i-1] == 1)
                {
                    for (int j = 1; j < times.Count + 1; j++)
                    {
                        int startTime = times[j - 1].getStart();
                        int endTime = times[j - 1].getEnd();
                        int day = times[j - 1].getDay();
                        if (weeks[i - 1] < 13)
                        {
                            leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID";
                            where = "Requests.Day = " + day + " AND Requests.Semester = " + semester + " AND (Requests.Start_Time = " + startTime + " OR (Requests.Start_Time < " + startTime + " AND Requests.End_Time > " + startTime + ") OR (Requests.Start_Time < " + endTime + " AND Requests.End_Time > " + endTime + ") OR Requests.End_Time = " + endTime + ") AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true') AND Bookings.Confirmed = 'Allocated'";
                            retRooms = Select("Requests", "Request_Preferences.Room_ID", where, leftJoin);
                        }
                        else
                        {
                            retRooms = "[]";
                        }
                        if (retRooms == "[]")
                        {
                            leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID";
                            where = "Requests.Day = " + day + " AND Requests.Semester = " + semester + " AND (Requests.Start_Time = " + startTime + " OR (Requests.Start_Time < " + startTime + " AND Requests.End_Time > " + startTime + ") OR (Requests.Start_Time < " + endTime + " AND Requests.End_Time > " + endTime + ") OR Requests.End_Time = " + endTime + ") AND Request_Weeks.Week_ID = " + i + " AND Bookings.Confirmed = 'Allocated'";
                            retRooms = Select("Requests", "Request_Preferences.Room_ID", where, leftJoin);
                            if (retRooms != "[]")
                            {
                                retRooms = retRooms.Replace("{", "");
                                retRooms = retRooms.Replace("}", "");
                                retRooms = retRooms.Replace("\"Room_ID\":", "");
                                retRooms = retRooms.Replace("\"", "");
                                retRooms = retRooms.Replace("[", "");
                                retRooms = retRooms.Replace("]", "");
                                string[] fndRooms = retRooms.Split(',');
                                for (int n = 0; n < fndRooms.Length; n++)
                                {
                                    Rooms newBook = new Rooms(fndRooms[n], times[j - 1], i);
                                    bookedRooms.Add(newBook);
                                }
                            }
                        }
                        else
                        {
                            retRooms = retRooms.Replace("{", "");
                            retRooms = retRooms.Replace("}", "");
                            retRooms = retRooms.Replace("\"Room_ID\":", "");
                            retRooms = retRooms.Replace("\"", "");
                            retRooms = retRooms.Replace("[", "");
                            retRooms = retRooms.Replace("]", "");
                            string[] fndRooms = retRooms.Split(',');
                            for (int n = 0; n < fndRooms.Length; n++)
                            {
                                Rooms newBook = new Rooms(fndRooms[n], times[j-1], i);
                                bookedRooms.Add(newBook);
                            }
                        }
                    }
                }
            }
            return bookedRooms;
        }
        private static List<Rooms> SearchFacs(string facs)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> reqFacs = json.Deserialize<List<int>>(facs);
            List<Rooms> possRooms = new List<Rooms>();
            List<Rooms> rooms = new List<Rooms>();
            string retRooms;
            string where;
            string leftJoin;
            List<string> facilities = new List<string>() { "C", "MP", "RM", "DP", "PS", "V", "PA", "DDP", "W", "WB", "RLC", "I" };
            int numRequests = 0;
            if (facs.Contains("1"))
            {
                for (int i = 0; i < reqFacs.Count; i++)
                {
                    if (reqFacs[i] == 1)
                    {
                        numRequests++;
                        leftJoin = "";
                        where = "Room_Facilities.Facility_ID = '" + facilities[i] + "'";
                        retRooms = Select("Room_Facilities", "Room_Facilities.Room_ID", where, leftJoin);
                        if (retRooms != "[]")
                        {
                            retRooms = retRooms.Replace("{", "");
                            retRooms = retRooms.Replace("}", "");
                            retRooms = retRooms.Replace("\"Room_ID\":", "");
                            retRooms = retRooms.Replace("\"", "");
                            retRooms = retRooms.Replace("[", "");
                            retRooms = retRooms.Replace("]", "");
                            string[] fndRooms = retRooms.Split(',');
                            for (int n = 0; n < fndRooms.Length; n++)
                            {
                                Rooms newBook = new Rooms(fndRooms[n]);
                                possRooms.Add(newBook);
                            }
                        }
                    }
                }
                possRooms = possRooms.OrderBy(x => x.roomNum).ToList();
                int counter = 1;
                for (int i = 0; i < possRooms.Count; i++)
                {
                    if (i != 0 && possRooms[i].getNum() == possRooms[i - 1].getNum())
                    {
                        counter++;
                    }
                    else
                    {
                        if (i != 0 && counter == numRequests)
                        {
                            rooms.Add(possRooms[i - 1]);
                        }
                        else if (i == 0 && counter == numRequests && possRooms[i].getNum() != possRooms[i + 1].getNum())
                        {
                            rooms.Add(possRooms[i]);
                        }
                        counter = 1;
                    }
                }
            }
            else
            {
                leftJoin = "";
                where = "1=1";
                retRooms = Select("Room_Facilities", "Room_Facilities.Room_ID", where, leftJoin);
                if (retRooms != "[]")
                {
                    retRooms = retRooms.Replace("{", "");
                    retRooms = retRooms.Replace("}", "");
                    retRooms = retRooms.Replace("\"Room_ID\":", "");
                    retRooms = retRooms.Replace("\"", "");
                    retRooms = retRooms.Replace("[", "");
                    retRooms = retRooms.Replace("]", "");
                    string[] fndRooms = retRooms.Split(',');
                    for (int n = 0; n < fndRooms.Length; n++)
                    {
                        Rooms newBook = new Rooms(fndRooms[n]);
                        rooms.Add(newBook);
                    }
                }
            }
                return rooms;
        }
    }
    public class Periods
    {
        private int day;
        private int start;
        private int end;

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

    public class FreeRoom
    {
        public string room;
        public int week;
        public int day;
        public int start;
        public int end;

        public FreeRoom(string room, int week, int day, int start, int end)
        {
            this.room = room;
            this.week = week;
            this.day = day;
            this.start = start;
            this.end = end;
        }
    }
    
    public class Rooms
    {
        public string roomNum;
        private Periods periodBooked;
        private int week;

        public Rooms(String roomNum)
        {
            this.roomNum = roomNum;
            this.periodBooked = null;
            this.week = -1;
        }

        public Rooms(String roomNum, Periods periodBooked, int week)
        {
            this.roomNum = roomNum;
            this.periodBooked = periodBooked;
            this.week = week;
        }

        public string getNum()
        {
            return roomNum;
        }

        public Periods getPer()
        {
            return periodBooked;
        }
        public int getWeek()
        {
            return week;
        }
    }
}