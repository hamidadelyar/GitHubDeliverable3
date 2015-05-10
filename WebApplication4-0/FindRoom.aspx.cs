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
        public string tblFacs = "";
        public string department = "";

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
            tblFacs = SQLSelect.Select("Facilities", "Facility_Name", "1=1", "");
            if (Session["LoggedIn"] != null)
            {
                string username = Session["Username"].ToString();
                department = SQLSelect.Select("Users", "Dept_ID", "Username = '"+username+"'","");
            }
        }
        [System.Web.Services.WebMethod]
        public static string SearchRooms(string parks, string semester,  string weeks, string periods, string students, string facs, string roomType, string department) //Accepts all the data needed to outline what type and time of room the user needs
        {
            List<Periods> times = new List<Periods>();
 
            List<Rooms> parkRooms = SearchParks(parks, roomType, students, department); // Calls the function to find all the rooms that match the park, type and capacity request of the students.
            List<Rooms> takenRooms = SearchPeriods(semester, weeks, periods, times, department); // Calls the function which finds all the rooms taken on the times and weeks that the user wants.
            List<Rooms> facRooms = SearchFacs(facs, department); // Calls the function to find all the rooms that have all the facilities the user has said they need
            
            List<Rooms> possRooms = new List<Rooms>();

            for (int i = 0; i < facRooms.Count; i++) //loop through the rooms that match the facilities
            {
                for (int j = 0; j < parkRooms.Count; j++) //loop through the rooms that match the park, type and capacity
                {
                    if(parkRooms[j].getNum() == facRooms[i].getNum()) // if a room is found that matches both the facilities and the park etc
                    {
                        possRooms.Add(parkRooms[j]); // push the matching room to the list of possible rooms
                    }
                }
            }

            possRooms = possRooms.Distinct().ToList(); // remove any possible duplicates

            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> weekData = json.Deserialize<List<int>>(weeks); // convert the JSON of weeks required passed by the user to a c# list
            int weekCount = 0;
            List<FreeRoom> rooms = new List<FreeRoom>();
           
            for (int i = 0; i < weekData.Count; i++) // loop thorugh the week data 
            {
                if(weekData[i] == 1) // if value is set to one then that week is one the user selected 
                {
                    weekCount = weekCount + 1; // Add one to weekCount to keep tabs on the number of weeks the user selected
                    for (int j = 0; j < times.Count; j++) // loop through all the periods that the user passed
                    {
                        List<Rooms> tmpRooms = new List<Rooms>(); // create a list to store rooms temporarily
                        for (int q = 0; q < possRooms.Count; q++)
                        {
                            tmpRooms.Add(possRooms[q]); // Add all the possible rooms to the temporary list
                        }
                        for(int k = 0; k < takenRooms.Count; k++) // loop thorugh all the rooms that were found to be taken at the times the user desired
                        {
                            Periods takenRoom = takenRooms[k].getPer(); // create a new period object for the current period of the taken room
                            if(takenRoom.getDay() == times[j].getDay() && takenRoom.getEnd() == times[j].getEnd() && takenRoom.getStart() == times[j].getStart() && takenRooms[k].getWeek() == i+1) 
                            {
                                for (int l = 0; l < tmpRooms.Count; l++) // if the current taken room is on the same day, same start and end, and the same week as the time period we are currently looping through loop through the temporary list
                                {
                                    if (tmpRooms[l].getNum() == takenRooms[k].getNum()) // if the current taken room we are on matches the room num of the tmp room remove that room
                                    {
                                        tmpRooms.RemoveAt(l);
                                    }
                                }
                            }
                        }
                        for (int m = 0; m < tmpRooms.Count; m++) // convert each of the remaining room in the temporary room list to a FreeRoom object
                        {
                            FreeRoom newRoom = new FreeRoom(tmpRooms[m].getNum(), i + 1, times[j].getDay(), times[j].getStart(), times[j].getEnd(), tmpRooms[m].getPark(), tmpRooms[m].getType(), false);
                            rooms.Add(newRoom); // add the new FreeRoom to the list of all the free rooms
                        }
                    }
                }
            }
            List<FreeRoom> unqRooms = rooms.Distinct().ToList(); // create a duplicate list of FreeRooms
            for (int i = 0; i < times.Count; i++) // loop through all the time periods the user gave
            {
                int counter = 0; // set the counter to keep track of the current rooms number of occurances for a given time
                for (int j = 0; j < unqRooms.Count; j++) // loop through the unique list of rooms
                {
                    if (unqRooms[j].day == times[i].getDay() && unqRooms[j].start == times[i].getStart()) // if the current FreeRoom matches the time period
                    {
                        for (int k = 0; k < rooms.Count; k++) // loop through the list of free rooms we made earlier
                        {
                            if (unqRooms[j].room == rooms[k].room && rooms[k].day == times[i].getDay() && rooms[k].start == times[i].getStart()) // if the selected room in the rooms loop matches that in the unqRooms loop as well as the current time period
                            {
                                counter++; // add one to the counter of times the room occurs at the period
                                if(counter == weekCount) // if the number of times the room appears at the current time period is the same as the number of week sthe user has requested
                                {
                                    rooms[k].all = true; // set the value of all in the current room to true to mark it is free for all weeks
                                }
                            }
                        }
                        counter = 0; // reset counter for the next loop
                    }
                }
            }
            rooms = rooms.OrderBy(x => x.week).ThenBy(x => x.day).ThenBy(x => x.start).ThenBy(x => x.park).ThenBy(x => x.room).ToList(); // order the rooms into week, day, start, park and finally alphabetical order for easier use in javascript
            return json.Serialize(rooms); // return a json of the list
        } 
        private static List<Rooms> SearchParks(string parkData, string typeData, string students, string department) // Function to find the rooms that are in the right park, of the right type and have the needed capacity
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> parks = json.Deserialize<List<int>>(parkData); // turn the json of user selected parks to a list of ints
            int type = Convert.ToInt32(typeData); // turn the string of type to an int
            string retRooms = "";
            List<char> parkList = new List<char>(){'C','W','E'}; // creates a list of the park id's used in the database
            List<string> typeList = new List<string>() { "[TSL]", "T", "S", "L" }; // creates a list of the type ids used in the database. [TSL] will match any of the room types for if the user selected no pref
            List<Rooms> rooms = new List<Rooms>();
            string typeC = typeList[type]; // create a string of the selected type the user has by getting it from the list.
            for (int i = 0; i < parks.Count; i++ ) // loop through the park list
            {
                if(parks[i] == 1) // if the element is set to 1 then the user has selected that park
                {
                    char parkID = parkList[i]; // create a char of the current selected park e.g C for central
                    
                    retRooms = SQLSelect.Select("Rooms", "Rooms.Room_ID, Room_Type, Park_ID", "Buildings.Park_ID = '" + parkID + "' AND Rooms.Room_Type LIKE '" + typeC + "' AND Rooms.Capacity >= " + students + " AND (Rooms.Pool = 1 OR Private_Rooms.Dept_ID = '" + department + "')" , "LEFT JOIN Buildings ON Rooms.Building_ID = Buildings.Building_ID LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID");
                    //Runs a select statement using left joins to get the rooms that match the park, type, has a capacity greater than or equal to what the user needs and are pool or the departments private rooms
                    
                    //This block removes the uneeded symbols that are produced when the select returns as string as JSON
                    retRooms = retRooms.Replace("\"", "");
                    retRooms = retRooms.Replace("[", "");
                    retRooms = retRooms.Replace("]", "");
                    
                    string[] fndRooms = retRooms.Split('{'); // create a string array by splitting the string from the select on its { elements as in each bracket is a new array
                    for (int n = 0; n < fndRooms.Length; n++) // loop through all the arrays found by splitting
                    {
                        if(fndRooms[n].Length > 0) // if the array is non empty
                        {
                            //This block removes the uneeded symbols from the current element that are produced when the select returns as string as JSON
                            fndRooms[n] = fndRooms[n].Substring(0, fndRooms[n].Length - 1);
                            fndRooms[n] = fndRooms[n].Replace("}", "");
                            fndRooms[n] = fndRooms[n].Replace("Room_ID:", "");
                            fndRooms[n] = fndRooms[n].Replace("Park_ID:", "");
                            fndRooms[n] = fndRooms[n].Replace("Room_Type:", "");

                            string[] roomDet = fndRooms[n].Split(','); // split the current element into a string array
                            Rooms newBook = new Rooms(roomDet[0], roomDet[1][0], roomDet[2][0]); // create a new room object [0] cotains the room_id, [1] the park_id and [2] the room type
                            rooms.Add(newBook); // push the new object to the end of the list
                        }
                    }
                }
            }
            rooms = rooms.OrderBy(x => x.roomNum).ToList(); // order the rooms list into alphabetical order on the room code.
            return rooms;
        }
        private static List<Rooms> SearchPeriods(string semester, string weekData, string periodData, List<Periods> times, string department)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> weeks = json.Deserialize<List<int>>(weekData); // turn the string of passed weeks to a list
            List<List<int>> periods = json.Deserialize<List<List<int>>>(periodData); // turn the string of selected periods to a list of a list fo ints. The outer list is a day and the inner list a formation of 0 and 1 to show which time slots were selected that day
            semester = semester + 1; // semester is set on the webpage as 0 or 1 and in the database as 1 or 2 so need to add 1 to selected value
            
            // this for block finds all the times the user has selected they want a room in
            for (int i = 1; i < periods.Count + 1; i++) // loop through all the periods (the number of lists in the list)
            {
                int length = 0;
                int startTime = 0;
                for (int j = 1; j < periods[i-1].Count + 1; j++)// loop through all the data in the inner list stored in the
                {
                    if (periods[i - 1][j - 1] == 1) // if the current element is a 1 then the user has selected it
                    {
                        if (startTime == 0) // if the start time is yet to have been changed set it yto j
                        {
                            startTime = j;
                        }
                        length++; // add one to the length so if two in a row were set to 1 then length becomes to to show that the period is 2 hours in length
                        if(j == periods[i-1].Count) // if j is the last element of the inner list create a new period object and push to end of list
                        {
                            Periods newPer = new Periods(i, startTime, length);
                            times.Add(newPer);
                            startTime = 0;
                            length = 0;
                        }
                    }
                    else if (length != 0) // if the value is a zero and length is greater than 0 then a period has been selected before and stopped now e.g if periods 1-2 were selected 3 is set to 0 so signifies the end of the selected period
                    {
                        Periods newPer = new Periods(i, startTime, length); // create new period object and push to list of selected periods
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

            // this for block finds all the rooms that a booked at the time of the users request
            for (int i = 1; i < weeks.Count + 1; i++) // loop through the weeks array
            {
                if (weeks[i-1] == 1) // if set to 1 then the user has selected that week
                {
                    for (int j = 1; j < times.Count + 1; j++) // loop through the list of times generated by the previous loop block
                    {
                        int startTime = times[j - 1].getStart(); // set the int start time to the start time of the current period element
                        int endTime = times[j - 1].getEnd(); // set the int end time to the end time of the current period element
                        int day = times[j - 1].getDay(); // set the int day to the day of current period element
                        if (weeks[i - 1] < 13) // if the week is less than 13 we look for default weeks
                        {
                            leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Rooms ON Rooms.Room_ID = Request_Preferences.Room_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID";
                            where = "Requests.Day = " + day + " AND Requests.Semester = " + semester + " AND (Requests.Start_Time = " + startTime + " OR (Requests.Start_Time < " + startTime + " AND Requests.End_Time > " + startTime + ") OR (Requests.Start_Time < " + endTime + " AND Requests.End_Time > " + endTime + ") OR Requests.End_Time = " + endTime + ") AND (Request_Preferences.Weeks = 1 OR Request_Preferences.Weeks = 'true') AND Bookings.Confirmed = 'Allocated' AND (Rooms.Pool = 1 OR Private_Rooms.Dept_ID = '" + department + "')";
                            retRooms = SQLSelect.Select("Requests", "Request_Preferences.Room_ID", where, leftJoin); // select the room id of all rooms that have a booking at the same start time, are on during the start time selected or start before the selected period stops, have default weeks set and are either pool or private rooms
                        }
                        else
                        {
                            retRooms = "[]"; // set it to an empty array
                        }
                        if (retRooms == "[]") // if nothing has been returned  search for those that dont have booking for default weeks e.g a booking may be made for one week only
                        {
                            leftJoin = "LEFT JOIN Request_Preferences ON Requests.Request_ID = Request_Preferences.Request_ID LEFT JOIN Rooms ON Rooms.Room_ID = Request_Preferences.Room_ID LEFT JOIN Bookings ON Bookings.Request_ID = Requests.Request_ID LEFT JOIN Request_Weeks ON Request_Weeks.Pref_ID = Request_Preferences.Pref_ID LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID";
                            where = "Requests.Day = " + day + " AND Requests.Semester = " + semester + " AND (Requests.Start_Time = " + startTime + " OR (Requests.Start_Time < " + startTime + " AND Requests.End_Time > " + startTime + ") OR (Requests.Start_Time < " + endTime + " AND Requests.End_Time > " + endTime + ") OR Requests.End_Time = " + endTime + ") AND Request_Weeks.Week_ID = " + i + " AND Bookings.Confirmed = 'Allocated' AND (Rooms.Pool = 1 OR Private_Rooms.Dept_ID = '" + department + "')";
                            retRooms = SQLSelect.Select("Requests", "Request_Preferences.Room_ID", where, leftJoin); // select the room id of all rooms that have a booking at the same start time, are on during the start time selected or start before the selected period stops, match the current week and are either pool or private rooms
                            if (retRooms != "[]") // if something has been returned by the search
                            {
                                // this block removes uneeded symbols from the string returned by the select statement
                                retRooms = retRooms.Replace("{", "");
                                retRooms = retRooms.Replace("}", "");
                                retRooms = retRooms.Replace("\"Room_ID\":", "");
                                retRooms = retRooms.Replace("\"", "");
                                retRooms = retRooms.Replace("[", "");
                                retRooms = retRooms.Replace("]", "");

                                string[] fndRooms = retRooms.Split(','); // convert the remaining string into an array of strings

                                for (int n = 0; n < fndRooms.Length; n++) // for each string in the array above produce a room object from it and add to the list of booked rooms
                                {
                                    Rooms newBook = new Rooms(fndRooms[n], times[j - 1], i); // creates new object with the room code, booked time and week booked
                                    bookedRooms.Add(newBook);
                                }
                            }
                        }
                        else
                        {
                            // this block removes uneeded symbols from the string returned by the select statement for the default weeks
                            retRooms = retRooms.Replace("{", "");
                            retRooms = retRooms.Replace("}", "");
                            retRooms = retRooms.Replace("\"Room_ID\":", "");
                            retRooms = retRooms.Replace("\"", "");
                            retRooms = retRooms.Replace("[", "");
                            retRooms = retRooms.Replace("]", "");

                            string[] fndRooms = retRooms.Split(','); // convert the remaining string into an array of strings
                            for (int n = 0; n < fndRooms.Length; n++)  // for each string in the array above produce a room object from it and add to the list of booked rooms
                            {
                                Rooms newBook = new Rooms(fndRooms[n], times[j - 1], i);  // creates new object with the room code, booked time and week booked
                                bookedRooms.Add(newBook);
                            }
                        }
                    }
                }
            }
            return bookedRooms;
        }
        private static List<Rooms> SearchFacs(string facs, string department)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<int> reqFacs = json.Deserialize<List<int>>(facs); // convert the string of 0 and 1s representing facilities to a list of 0's and 1's
            List<Rooms> possRooms = new List<Rooms>();
            List<Rooms> rooms = new List<Rooms>();
            string retRooms;
            string where;
            string leftJoin;
            List<string> facilities = new List<string>(); 
            List<List<string>> facList = SQLSelect.SelectList("Facilities", "Facility_ID", "1=1", ""); // selects all the facility IDs from the DB 
            for(int i = 0; i < facList.Count; i++)
            {
                facilities.Add(facList[i][0]); // loops through the facs found earlier and adds the ID to the list of facilities for use later
            }
            int numRequests = 0; // set the int to store the number of facilities requested
            if (facs.Contains("1")) // if there is at least 1 facility requested
            {
                for (int i = 0; i < reqFacs.Count; i++) // loop for all 0s and 1 in request facs
                {
                    if (reqFacs[i] == 1) // if set to 1 the user has selected the facility
                    {
                        numRequests++; // increase the number of requests by 1
                        leftJoin = "LEFT JOIN Rooms ON Rooms.Room_ID = Room_Facilities.Room_ID LEFT JOIN Buildings ON Buildings.Building_ID = Rooms.Building_ID LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID";
                        where = "Room_Facilities.Facility_ID = '" + facilities[i] + "' AND (Rooms.Pool = 1 OR Private_Rooms.Dept_ID = '" + department + "')";
                        retRooms = SQLSelect.Select("Room_Facilities", "Room_Facilities.Room_ID, Buildings.Park_ID, Rooms.Room_Type", where, leftJoin); // select all the rooms where the facilities match those requested and are pool or the departments private rooms. Get the park and type too to make object
                        if (retRooms != "[]") // if result was non empty
                        {
                            // this block strips uneeded symbols from the string returned by the select statement
                            retRooms = retRooms.Replace("\"", "");
                            retRooms = retRooms.Replace("[", "");
                            retRooms = retRooms.Replace("]", "");

                            string[] fndRooms = retRooms.Split('{'); // splits the remaing string returned into an array as { symbolises the start of the inner array
                            for (int n = 0; n < fndRooms.Length; n++) // loops through the just created string array
                            {
                                if (fndRooms[n].Length > 0) // if the element is not nothing
                                {
                                    //this block removes the uneeded symbols from the current element
                                    fndRooms[n] = fndRooms[n].Substring(0, fndRooms[n].Length - 1);
                                    fndRooms[n] = fndRooms[n].Replace("}", "");
                                    fndRooms[n] = fndRooms[n].Replace("Room_ID:", "");
                                    fndRooms[n] = fndRooms[n].Replace("Park_ID:", "");
                                    fndRooms[n] = fndRooms[n].Replace("Room_Type:", "");

                                    string[] roomDet = fndRooms[n].Split(','); // splits he current element into a further array 
                                    Rooms newBook = new Rooms(roomDet[0], roomDet[1][0], roomDet[2][0]); // creates a new Rooms object [0] has the room code, [1] the park id and [2] the room type
                                    possRooms.Add(newBook); // push found room to the list of possible rooms
                                }
                            }
                        }
                    }
                }
                possRooms = possRooms.OrderBy(x => x.roomNum).ToList(); // order the rooms by room id
                int counter = 1; // set the counter to one for number of facilities
                for (int i = 0; i < possRooms.Count; i++)
                {
                    if (i != 0 && possRooms[i].getNum() == possRooms[i - 1].getNum()) // if the current element matches the previous one increase the counter
                    {
                        counter++; // increase counter as room appears more than once
                    }
                    else
                    {
                        if (i != 0 && counter == numRequests) // if counter is equal to the number of requests push the possible room to be a definite room in the rooms list as it has all the facilities
                        {
                            rooms.Add(possRooms[i - 1]);
                        }
                        else if (i == 0 && counter == numRequests && possRooms[i].getNum() != possRooms[i + 1].getNum()) // if counter is equal to the number of requests and teh next element is not the same push the possible room to be a definite room in the rooms list as it has all the facilities
                        {
                            rooms.Add(possRooms[i]);
                        }
                        counter = 1;
                    }
                }
            }
            else
            {
                leftJoin = "LEFT JOIN Buildings ON Buildings.Building_ID = Rooms.Building_ID LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID";
                where = "1=1";
                retRooms = SQLSelect.Select("Rooms", "Rooms.Room_ID, Buildings.Park_ID, Rooms.Room_Type", where, leftJoin); // select all rooms that are pool or the departments as no specific requirements
                if (retRooms != "[]") // if resulkt is non empty
                {
                    //this block strips uneeded symbols from the result
                    retRooms = retRooms.Replace("\"", "");
                    retRooms = retRooms.Replace("[", "");
                    retRooms = retRooms.Replace("]", "");

                    string[] fndRooms = retRooms.Split('{'); // turns remaining string to array
                    for (int n = 0; n < fndRooms.Length; n++)
                    {
                        if (fndRooms[n].Length > 0)
                        {
                            //strips uneeded elements from current element
                            fndRooms[n] = fndRooms[n].Substring(0, fndRooms[n].Length - 1);
                            fndRooms[n] = fndRooms[n].Replace("}", "");
                            fndRooms[n] = fndRooms[n].Replace("Room_ID:", "");
                            fndRooms[n] = fndRooms[n].Replace("Park_ID:", "");
                            fndRooms[n] = fndRooms[n].Replace("Room_Type:", "");

                            string[] roomDet = fndRooms[n].Split(','); // splits current element to array

                            Rooms newBook = new Rooms(roomDet[0], roomDet[1][0], roomDet[2][0]); // creates room object from array elements
                            rooms.Add(newBook); // adds room to list of definite rooms
                        }
                    }
                }
            }
            return rooms;
        }
    }
    public class Periods // period object to store all the data about a period
    {
        private int day;
        private int start;
        private int end;

        public Periods(int day, int start, int length)
        {
            this.day = day;
            this.start = start;
            this.end = start + length - 1; // calculates it length to end to make searching simpler as thats how it is stored in the DB
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

    public class FreeRoom // object to store data of rooms that are free
    {
        public string room;
        public int week;
        public int day;
        public int start;
        public int end;
        public char park;
        public char type;
        public bool all;

        public FreeRoom(string room, int week, int day, int start, int end, char park, char type, bool all)
        {
            this.room = room;
            this.week = week;
            this.day = day;
            this.start = start;
            this.end = end;
            this.park = park;
            this.type = type;
            this.all = all; // boolean value to store whether the room is availible at the time for all weeks user has selected
        }
    }
    
    public class Rooms
    {
        public string roomNum; //set to public for purposes of ordering above
        private Periods periodBooked;
        private int week;
        private char park;
        private char type;

        public Rooms(String roomNum, char park, char type) // constructor function for a room that is found by the searchPark or searchFacs functions
        {
            this.roomNum = roomNum;
            this.periodBooked = null;
            this.week = -1;
            this.park = park;
            this.type = type;
        }

        public Rooms(String roomNum, Periods periodBooked, int week) // constructor function for a room found by the searchPeriods function
        {
            this.roomNum = roomNum;
            this.periodBooked = periodBooked;
            this.week = week;
            this.park = 'N';
            this.type = 'N';
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
        public char getPark()
        {
            return park;
        }
        public char getType()
        {
            return type;
        }
    }
}