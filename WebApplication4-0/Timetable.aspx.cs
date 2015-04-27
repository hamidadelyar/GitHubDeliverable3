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

        protected void Page_Load(object sender, EventArgs e)
        {
            data = SQLSelect.Select("Rooms", "Room_ID", "1=1", ""); // runs a select to get all the room ids stored in the DB for use in jquery for room prediction
            if ((Session["LoggedIn"]) != null) {  // checks the user is logged in to remove error of trying to get a null session variable
                modData = SQLSelect.Select("Modules", "Module_Code + ' ' + Module_Title AS Module_Code", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' ' + Lecturer_Name AS Lecturer_ID", "LEFT(Lecturer_ID, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the lecturers from the user's department
            }
            if (Request.QueryString["roomCode"] != null) // checks if the url bar has been sent a roomCode variable
            {
                code = Request.QueryString["roomCode"]; // sets the value of code to the roomCode sent. This will be used in jQuery to set as a value in the room search textbox and for data submital on load so the loaded timetable appears in RoomsDetails.aspx
            }
        }
        [System.Web.Services.WebMethod] // sets up a function as web method so that it can be called by ajax
        public static string SearchRoom(string search, int week, int semester, int type)
        {
            string modSel = "";
            string retData = "";
            string searchColumn = "";
            if(type == 1) // if type is set to 1 this indicates the user is searching rooms
            {
                searchColumn =  " AND Request_Preferences.Room_ID = '" + search + "'"; // sets the searchColumn to search for rooms matching the search
            }
            else if (type == 2) // if type is set to 2 this indicates the user is searching modules
            {
                search = search.Substring(0, search.IndexOf(' ')); // strips the search to only contain the module code not the title too
                searchColumn =  " AND Requests.Module_Code = '" + search + "'"; // sets the searchColumn to search for modules matching the search
            }
            else
            {
                search = search.Substring(0, search.IndexOf(' ')); // strips the search to only contain the lecturer id not their name too
                searchColumn = "AND Request_Lecturers.Lecturer_ID = '" + search + "'"; // sets the searchColumn to search for lecturers matching the search
            }
            for (int i = 1; i < 10; i++) // loop to go through all the periods
            {
                for (int j = 1; j < 6; j++) // loop to go through all the days
                {
                    if (week < 13) // check to see whether it is worth searching for default week set bookings
                    {
                        string where = "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + searchColumn + " AND Requests.Semester = " + semester + " AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true')"; // sets the where to find all bookings that have their booking request set to allocated and match the time and date of this search and have default weeks
                        string leftJoin = "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Lecturers ON Request_Lecturers.Request_ID = Requests.Request_ID"; // sets the left join to include all the tables needed for the search
                        retData = SQLSelect.Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID", where, leftJoin); // runs select to get the details of matching bookings                 
                    }
                    else
                    {
                        retData = "[]"; // sets the search result to blank
                    }
                    if (retData == "[]") // if the select returned nothing
                    {
                        string where = "Bookings.Confirmed = 'Allocated' AND Requests.Start_Time = " + i + " AND Requests.Day = " + j + searchColumn + " AND Requests.Semester = " + semester + " AND Request_Weeks.Week_ID = " + week; // sets the where to find all bookings that have their booking request set to allocated and match the time, date and weeks of this search
                        string leftJoin = "LEFT JOIN Modules ON Requests.Module_Code = Modules.Module_Code LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Lecturers ON Request_Lecturers.Request_ID = Requests.Request_ID"; // sets the left join to include all the tables needed for the search same as above left join but includes week table
                        retData = SQLSelect.Select("Requests", "Requests.Module_Code, Modules.Module_Title, Requests.Request_ID, Requests.Start_Time, Requests.End_Time, Request_Preferences.Room_ID", where, leftJoin); // runs select to get the details of matching bookings
                        if (retData != "[]") // if the select result was non empty
                        {
                            retData = retData.Substring(1, retData.Length - 2); // strips first and last character of the select result
                            string reqID = getValue(retData, 2); // calls get value which splits the data to an array and returns the second element of the sub array found in the element requested
                            string lecData = SQLSelect.Select("Lecturers", "Lecturer_Name, Lecturers.Lecturer_ID", "Request_Lecturers.Request_ID = " + reqID, "LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID"); // selects the details of the lecturer timetabled for the module
                            
                            //this block removes uneenede symbols from lecData
                            lecData = lecData.Replace("[", "");
                            lecData = lecData.Replace("]", "");
                            lecData = lecData.Replace("},", "");
                            lecData = lecData.Replace("}", "");
                            lecData = lecData.Replace("\"", "");

                            string[] lecArr = lecData.Split('{'); // splits the lecturer data into arrays to account for modules with multiple lecturers
                            string lecNames = "";
                            string lecID = "";
                            for(int k = 0; k < lecArr.Length; k++) // loops through all the arrays of lecturers
                            {
                                if (lecArr[k] != "") // checks if they arent blank to avoid out of range exception
                                {
                                    List<string> tmp = lecArr[k].Split(',').ToList<string>(); // splits the lecturer array on comma into two with the first being the lec name and second lec id
                                    List<string> tmp2 = tmp[0].Split(':').ToList<string>(); // splits the string of lec name in two to remove "Lecturer_Name"
                                    List<string> tmp3 = tmp[1].Split(':').ToList<string>(); // splits the string of lec name in two to remove "Lecturer_Name"
                                    lecNames += tmp2[1] + ", "; // adds the lecturers name and a comma to end
                                    lecID += tmp3[1] + ", "; // adds the lecturers id and comma to end
                                }
                            }
                            String lecDets = "\"Lecturer_Name\":\"" + lecNames.Substring(0, lecNames.Length - 2) + "\",\"Lecturer_ID\":\"" + lecID.Substring(0, lecID.Length - 2) + "\""; // creates a new JSON compatible string with all the lect ids and lect names
                            string[] modDataNotLect = retData.Split('{'); // splits retData into array as with multiple lects the string is duplicated e.g {bookingData},{bookingData} for as nany times as there are lects
                            modDataNotLect[1] = modDataNotLect[1].Replace("},", ""); // selects the second element as first is blank and replaces the splitting comma at end as }, appears if more than one lect. Put blank in so concats with lecDets in JSON format
                            modDataNotLect[1] = modDataNotLect[1].Replace("}", ""); // selects the second element as first is blankand replaces the end } with blank so that it concats with lecDets in JSON format
                            string fullData = "[{" + modDataNotLect[1] + "," + lecDets + "}]"; // concats the two sets of data into JSON format for jquery use on main page
                            modSel += "," + fullData; // concats to modSel
                        }
                        else
                        {
                            modSel += "," + "[{}]"; // concats empty to modSel if none found
                        }
                    }
                    else
                    {
                        retData = retData.Substring(1, retData.Length - 2); // strips first and last character of the select result
                        string reqID = getValue(retData, 2); // calls get value which splits the data to an array and returns the second element of the sub array found in the element requested
                        string lecData = SQLSelect.Select("Lecturers", "Lecturer_Name, Lecturers.Lecturer_ID", "Request_Lecturers.Request_ID = " + reqID, "LEFT JOIN Request_Lecturers ON Request_Lecturers.Lecturer_ID = Lecturers.Lecturer_ID"); // selects the details of the lecturer timetabled for the module

                        //this block removes uneenede symbols from lecData
                        lecData = lecData.Replace("[", "");
                        lecData = lecData.Replace("]", "");
                        lecData = lecData.Replace("},", "");
                        lecData = lecData.Replace("}", "");
                        lecData = lecData.Replace("\"", "");

                        string[] lecArr = lecData.Split('{'); // splits the lecturer data into arrays to account for modules with multiple lecturers
                        string lecNames = "";
                        string lecID = "";
                        for (int k = 0; k < lecArr.Length; k++) // loops through all the arrays of lecturers
                        {
                            if (lecArr[k] != "") // checks if they arent blank to avoid out of range exception
                            {
                                List<string> tmp = lecArr[k].Split(',').ToList<string>(); // splits the lecturer array on comma into two with the first being the lec name and second lec id
                                List<string> tmp2 = tmp[0].Split(':').ToList<string>(); // splits the string of lec name in two to remove "Lecturer_Name"
                                List<string> tmp3 = tmp[1].Split(':').ToList<string>(); // splits the string of lec name in two to remove "Lecturer_Name"
                                lecNames += tmp2[1] + ", "; // adds the lecturers name and a comma to end
                                lecID += tmp3[1] + ", "; // adds the lecturers id and comma to end
                            }
                        }
                        String lecDets = "\"Lecturer_Name\":\"" + lecNames.Substring(0, lecNames.Length - 2) + "\",\"Lecturer_ID\":\"" + lecID.Substring(0, lecID.Length - 2) + "\""; // creates a new JSON compatible string with all the lect ids and lect names
                        string[] modDataNotLect = retData.Split('{'); // splits retData into array as with multiple lects the string is duplicated e.g {bookingData},{bookingData} for as nany times as there are lects
                        modDataNotLect[1] = modDataNotLect[1].Replace("},", ""); // selects the second element as first is blank and replaces the splitting comma at end as }, appears if more than one lect. Put blank in so concats with lecDets in JSON format
                        modDataNotLect[1] = modDataNotLect[1].Replace("}", ""); // selects the second element as first is blankand replaces the end } with blank so that it concats with lecDets in JSON format
                        string fullData = "[{" + modDataNotLect[1] + "," + lecDets + "}]"; // concats the two sets of data into JSON format for jquery use on main page
                        modSel += "," + fullData; // concats to modSel
                    }
                }
            }
            modSel = modSel.Remove(0,1); // removes the comma at the start to keep in JSON format
            return "[" + modSel + "]"; // adds square brackets for JSON purposes
        }
        public static string getValue(string variable, int i)
        {
            List<string> newList = variable.Split(',').ToList<string>(); // splits into array on comma
            List<string> elList = newList[i].Split(':').ToList<string>(); // splits desired element into array on colon
            return elList[1]; // returns text after colon in desired element
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
    }
}