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

namespace WebApplication4_0
{
    public partial class Timetable : System.Web.UI.Page
    {
        public String data = "";
        public String modData = "";
        public String lectData = "";
        public string code = "";
        public string programs = "";

        protected void Page_PreInit(object sender, EventArgs e)
        {
            try
            {
                if (Session["LoggedIn"] != null)
                {
                    if (Session["Username"].ToString() == "admin")
                    {
                        this.Page.MasterPageFile = "~/AdminFolder/AdminSite.master";
                    }
                    else
                    {
                        this.Page.MasterPageFile = "~/Site.master";
                    }
                }

            }
            catch (Exception ex)
            {

            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            data = SQLSelect.Select("Rooms", "Room_ID", "1=1", ""); // runs a select to get all the room ids stored in the DB for use in jquery for room prediction
            if ((Session["LoggedIn"]) != null) {  // checks the user is logged in to remove error of trying to get a null session variable
                modData = SQLSelect.Select("Modules", "Module_Code + ' ' + Module_Title AS Module_Code", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' ' + Lecturer_Name AS Lecturer_ID", "LEFT(Lecturer_ID, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the lecturers from the user's department
                programs = SQLSelect.Select("Degrees", "Program_Code + ' ' + Program_Name AS Program_Code", "Dept_ID = '" + Session["Username"].ToString().Substring(0, 2) + "'", "");
            }
            if (Request.QueryString["roomCode"] != null) // checks if the url bar has been sent a roomCode variable
            {
                code = Request.QueryString["roomCode"]; // sets the value of code to the roomCode sent. This will be used in jQuery to set as a value in the room search textbox and for data submital on load so the loaded timetable appears in RoomsDetails.aspx
            }
        }
        [System.Web.Services.WebMethod]
        public static string SearchAll(string search, int semester, int type, string part)
        {
            string weekData = "";
            string searchColumn = "";
            List<List<string>> retData = new List<List<String>>();
            List<Modules> modList = new List<Modules>();

            if (type == 1) // if type is set to 1 this indicates the user is searching rooms
            {
                searchColumn = "AND Request_Preferences.Request_ID IN (SELECT Request_ID FROM Request_Preferences WHERE Request_Preferences.Room_ID = '" + search + "')"; // sets the searchColumn to search for modules in rooms matching the search
            }
            else if (type == 2) // if type is set to 2 this indicates the user is searching modules
            {
                search = search.Substring(0, search.IndexOf(' ')); // strips the search to only contain the module code not the title too
                searchColumn = " AND Requests.Module_Code = '" + search + "'"; // sets the searchColumn to search for modules matching the search
            }
            else if(type == 3)
            {
                search = search.Substring(0, search.IndexOf(' ')); // strips the search to only contain the lecturer id not their name too
                searchColumn = "AND Request_Preferences.Request_ID IN (SELECT Request_ID FROM Request_Lecturers WHERE Request_Lecturers.Lecturer_ID = '" + search + "')"; // sets the searchColumn to search for lecturers matching the search
            }
            else
            {
                search = search.Substring(0, search.IndexOf(' ')); // strips the search to only contain the lecturer id not their name too
                searchColumn = "AND Modules.Program_Code = '"+search+"' AND SUBSTRING(Modules.Module_Code, 3,1) = '" + part + "'"; // sets the searchColumn to search for programs matching the search

            }
            string where = "Bookings.Confirmed = 'Allocated' " + searchColumn + " AND Requests.Semester = " + semester; // sets the where to find all bookings that have their booking request set to allocated and match the time and date of this search
            string leftJoin = "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Lecturers ON Request_Lecturers.Request_ID = Requests.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Lecturers ON Lecturers.Lecturer_ID = Request_Lecturers.Lecturer_ID"; // sets the left join to include all the tables needed for the search
            retData = SQLSelect.SelectList("Requests", "DISTINCT Requests.Module_Code, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID, Request_Preferences.Weeks, Request_Weeks.Week_ID, Request_Lecturers.Lecturer_ID, Lecturers.Lecturer_Name, Requests.Day, Modules.Module_Title", where, leftJoin); // runs select to get the details of matching bookings         
            int lastNum = -1;
            for(int j = 0; j < retData.Count; j++) // loops through all the rows of returned data
            {
                for (int i = 1; i < 16; i++) // loops through all the weeks
                {
                    if(i < 13) // check if the currewnt week is one of the default weeks
                    {
                        if (retData[j][4] == "True" || retData[j][4] == "1") // checks whether the room is set to having default weeks 
                        {
                            if (modList.Count == 0) // if the list of modules is empty
                            {
                                Modules newMod = new Modules(retData[j][0], retData[j][1], retData[j][2], retData[j][3], i, retData[j][6], retData[j][7], retData[j][8], retData[j][9]);
                                modList.Add(newMod); // create and add a new module to the list of modules
                            }
                            else
                            {
                                for (int k = 0; k < modList.Count; k++)
                                {
                                    if (modList[k].modCode == retData[j][0] && modList[k].start == retData[j][1] && modList[k].end == retData[j][2] && modList[k].roomCode == retData[j][3] && modList[k].lectCode == retData[j][6])
                                    {
                                        if(lastNum != i)
                                        {
                                            modList[k].addWeek(i);
                                            lastNum = i;
                                        }
                                        break;
                                    }
                                    else if (k == modList.Count - 1)
                                    {
                                        Modules newMod = new Modules(retData[j][0], retData[j][1], retData[j][2], retData[j][3], i, retData[j][6], retData[j][7], retData[j][8], retData[j][9]);
                                        modList.Add(newMod);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (retData[j][4] == "False")
                    {
                        if (modList.Count == 0)
                        {
                            Modules newMod = new Modules(retData[j][0], retData[j][1], retData[j][2], retData[j][3], i, retData[j][6], retData[j][7], retData[j][8], retData[j][9]);
                            modList.Add(newMod);
                        }
                        else
                        {
                            for (int k = 0; k < modList.Count; k++)
                            {
                                if (modList[k].modCode == retData[j][0] && modList[k].start == retData[j][1] && modList[k].end == retData[j][2] && modList[k].roomCode == retData[j][3] && retData[j][5] == i.ToString() && modList[k].lectCode == retData[j][6])
                                {
                                    if (lastNum != i)
                                    {
                                        modList[k].addWeek(i);
                                        lastNum = i;
                                    }
                                    break;
                                }
                                else if (k == modList.Count - 1 && retData[j][5] == i.ToString())
                                {
                                    Modules newMod = new Modules(retData[j][0], retData[j][1], retData[j][2], retData[j][3], i, retData[j][6], retData[j][7], retData[j][8], retData[j][9]);
                                    modList.Add(newMod);
                                    break;
                                }
                            }
                        }
                    }
                }
                lastNum = -1;
            }
            return new JavaScriptSerializer().Serialize(modList);
        }
        public static string getValue(string variable, int i)
        {
            List<string> newList = variable.Split(',').ToList<string>(); // splits into array on comma
            List<string> elList = newList[i].Split(':').ToList<string>(); // splits desired element into array on colon
            return elList[1]; // returns text after colon in desired element
        }
    }
    public class Modules // object to store all the data about a module when they are turned up in the search
    {
        public string modCode = "";
        public string modName = "";
        public string start = "";
        public string end = "";
        public string roomCode = "";
        public List<int> week = new List<int>();
        public string lectCode = "";
        public string lectName = "";
        public string day = "";
        public Modules(string modCode, string start, string end, string roomCode, int week, string lectCode, string lectName, string day, string modName)
        {
            this.modCode = modCode;
            this.start = start;
            this.end = end;
            this.roomCode = roomCode;
            this.week.Add(week);
            this.lectCode = lectCode;
            this.lectName = lectName;
            this.day = day;
            this.modName = modName;
        }

        public void addWeek(int i)
        {
            week.Add(i); // function to add a week to the list of weeks a module has
        }
    }
    public class SQLSelect
    {
        public SQLSelect()
        {

        }
        public static string Select(string table, string columns, string where, string leftJoin) //Accepts all the parts of a select statement
        {
            SqlConnection conn;
            DataTable dt = new DataTable();
            string result = "";
            //where "myConnectionString" is the connection string in the web.config file
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            //prepare query
            string roomQuery = "Select " + columns + " FROM " + table + " " + leftJoin + " WHERE " + where;   //produces a select statement from the parameters passed to the function
            SqlCommand comm = new SqlCommand(roomQuery, conn);  //1st argument is query, 2nd argument is connection with DB
            System.Diagnostics.Debug.WriteLine(roomQuery);
            SqlDataAdapter da = new SqlDataAdapter(comm);
            da.Fill(dt);
            JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows) //loops through each row of the data returned by the select
            {
                row = new Dictionary<string, object>(); // creates a variable to store all the data of the columns returned
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row); //pushes the row data to the list of all rows
            }
            conn.Close();
            return result = serializer.Serialize(rows); // turns the list returned into a JSON array
        }

        public static List<List<string>> SelectList(string table, string columns, string where, string leftJoin)
        {
            SqlConnection conn;
            List<List<string>> result = new List<List<string>>();
            //where "myConnectionString" is the connection string in the web.config file
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            //prepare query
            string roomQuery = "Select " + columns + " FROM " + table + " " + leftJoin + " WHERE " + where;   //produces a select statement from the parameters passed to the function
            SqlCommand comm = new SqlCommand(roomQuery, conn);  //1st argument is query, 2nd argument is connection with DB
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                List<string> rowData = new List<string>();
                // Iterate over each of the fields (columns) in the datareader's current record
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    String value = reader[i].ToString();
                    rowData.Add(value);
                }
                result.Add(rowData);
            }
            conn.Close();//Close the connection
            return result;
        }
    }
}