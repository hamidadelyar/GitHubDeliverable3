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
    public partial class EditRequest : System.Web.UI.Page
    {
        public string modData = "";
        public string lectData = "";
        public string id = "";
        public string request = "";
        public string selLects = "";
        public string weekData = "";
        public string facs = "";
        public string buildings = "";
        public string rooms = "";
        public string preferences = "";
        public string facData = "";
        public string user = "";

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
            if(Session["LoggedIn"] != null)
            {
                user = "'"+Session["Username"].ToString()+"'";
                if (Request.QueryString["ID"] != null)
                {
                    id = Request.QueryString["ID"];
                }
                else
                {
                    Response.Redirect("ViewRequest.aspx");
                }
                if(user == "'admin'")
                {
                    modData = SQLSelect.Select("Modules", "Module_Code, Module_Title", "1=1",""); // runs a select to get all the module codes that are from the user's department
                    lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' - ' + Lecturer_Name AS Lecturer_ID", "1=1", ""); // runs a select to get all the lecturers from the user's department
                }
                else
                {
                    modData = SQLSelect.Select("Modules", "Module_Code, Module_Title", "LEFT(Module_Code, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the module codes that are from the user's department
                    lectData = SQLSelect.Select("Lecturers", "Lecturer_ID + ' - ' + Lecturer_Name AS Lecturer_ID", "LEFT(Lecturer_ID, 2) = '" + Session["Username"].ToString().Substring(0, 2) + "'", ""); // runs a select to get all the lecturers from the user's department
                }
                request = SQLSelect.Select("Requests", "*", "Request_ID = '" + id + "'", "");
                JavaScriptSerializer jss = new JavaScriptSerializer();
                List<RequestStuff> reqStuff = jss.Deserialize<List<RequestStuff>>(request);
                selLects = SQLSelect.Select("Request_Lecturers", "Lecturers.Lecturer_ID, Lecturers.Lecturer_Name", "Request_ID = '" + id + "'", "LEFT JOIN Lecturers ON Lecturers.Lecturer_ID = Request_Lecturers.Lecturer_ID");
                facs = SQLSelect.Select("Facilities", "Facility_Name, Facility_ID", "1=1", "");
                buildings = SQLSelect.Select("Buildings", "Building_Name, Building_ID, Park_ID", "1=1", "");
                rooms = SQLSelect.Select("Rooms", "Rooms.Room_ID, Building_ID, Room_Type, Capacity", " (Rooms.Pool = 1 OR Private_Rooms.Dept_ID = '" + reqStuff[0].Module_Code.Substring(0,2) + "')", "LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID");
                preferences = SQLSelect.Select("Request_Preferences", "Pref_ID, Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks", "Request_ID = '" + id + "'", "");
                weekData = SQLSelect.Select("Request_Weeks", "Request_Weeks.Pref_ID, Week_ID", "Request_ID = '" + id + "'", "LEFT JOIN Request_Preferences ON Request_Preferences.Pref_ID = Request_Weeks.Pref_ID");
                facData = SQLSelect.Select("Request_Facilities", "Request_Facilities.Pref_ID, Facility_ID", "Request_ID = '" + id + "'", "LEFT JOIN Request_Preferences ON Request_Preferences.Pref_ID = Request_Facilities.Pref_ID");
            }
        }
        [System.Web.Services.WebMethod]
        public static bool UpdateRequest(string requestDets, string reqLects, string prefData, string weekData, string facData, string username, string status)
        {
            JavaScriptSerializer jss = new JavaScriptSerializer();
            RequestData user = jss.Deserialize<RequestData>(requestDets);
            List<Lecturers> lects = jss.Deserialize<List<Lecturers>>(reqLects);
            System.Diagnostics.Debug.WriteLine(prefData);
            List<Preferences> prefs = jss.Deserialize<List<Preferences>>(prefData);
            List<Weeks> weeks = jss.Deserialize<List<Weeks>>(weekData);
            List<Facilities> facs = jss.Deserialize<List<Facilities>>(facData);

            int number_studs = 0;

            for(int i = 0; i < prefs.Count; i++)
            {
                number_studs += prefs[i].Number_Students;
            }

            int round = 0;

             /*
              Gets the round that is currently open i.e. 1
              */

             string queryRound = "select Round_Name from [Rounds] where Status = 'open'";
             SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
             connection.Open();
             SqlCommand commRound = new SqlCommand(queryRound, connection);  //1st argument is query, 2nd argument is connection with DB

             if (commRound.ExecuteScalar() != null)  //if it does return something
             {
                 round =  Convert.ToInt32(commRound.ExecuteScalar());
             }
             connection.Close();

            if (round < 1)
            {
                return false;
            }

            DateTime semester1Start = new DateTime(DateTime.Now.Year, 6, 18);
            DateTime semester2Start = new DateTime(DateTime.Now.Year, 9, 30);
            DateTime currentDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            int semester;
             //if between June 18 and September 30
            if(DateTime.Compare(currentDate, semester1Start) > 1 && DateTime.Compare(currentDate, semester2Start) < 0 ){
                semester = 0;
            }
            else
            {
                semester = 1;
            }

            SubmitEdit("UPDATE Requests SET Module_Code = '"+user.Module_Code+"', Day = '"+user.Day+"', Start_Time = '"+user.Start_Time+"', End_Time = '"+user.End_Time+"', Semester = '"+semester+"', Year = '"+ DateTime.Now.Year + "', Round = '" + round + "', Priority = '" + user.Priority + "', Number_Rooms = '"+user.Number_Rooms+"', Number_Students = '"+number_studs+"' WHERE Request_ID = '"+user.Request_ID+"'");
            SubmitEdit("DELETE FROM Request_Lecturers WHERE Request_ID = '" + user.Request_ID + "'");
            for (int i = 0; i < lects.Count; i++)
            {
                SubmitEdit("INSERT INTO Request_Lecturers VALUES('" + user.Request_ID + "','"+lects[i].Lecturer_ID+"')");
            }
            SubmitEdit("DELETE FROM Request_Preferences WHERE Request_ID = '" + user.Request_ID + "'");
            string privates = SQLSelect.Select("Private_Rooms", "Room_ID", "Private_Rooms.Dept_ID = '" + user.Module_Code.Substring(0, 2) + "'", "");
            List<PrivateRooms> privList = jss.Deserialize<List<PrivateRooms>>(privates);
            var privCounter = 0;
            for(int i = 0; i < prefs.Count; i++)
            {
                var newID = SubmitPref("INSERT INTO Request_Preferences(Request_ID, Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Output Inserted.Pref_ID VALUES('" + user.Request_ID + "','" + prefs[i].Room_ID + "','" + prefs[i].Building_ID + "','" + prefs[i].Room_Type + "','" + prefs[i].Park_ID + "','" + prefs[i].Number_Students + "','" + prefs[i].Special_Requirements + "','" + prefs[i].Weeks + "')");
                for (int j = 0; j < weeks.Count; j++)
                {
                    if (weeks[j].Pref_ID == prefs[i].Pref_ID)
                    {
                        SubmitEdit("INSERT INTO Request_Weeks VALUES('" + newID + "','" + weeks[j].Week_ID + "')");
                    }
                }
                for (int j = 0; j < facs.Count; j++)
                {
                    if (facs[j].Pref_ID == prefs[i].Pref_ID)
                    {
                        SubmitEdit("INSERT INTO Request_Facilities VALUES('" + newID + "','" + facs[j].Facility_ID + "')");
                    }
                }
                for (int j = 0; j < privList.Count; j++)
                {
                    if (privList[j].Room_ID == prefs[i].Room_ID)
                    {
                        privCounter++;
                    }
                }
            }
            if (privCounter == prefs.Count)
            {
                status = "Allocated";
            }
            SubmitEdit("UPDATE Bookings SET Confirmed = '"+status+"' WHERE Request_ID = '" + user.Request_ID + "'");
            return true;
        }

        private static void SubmitEdit(string cmdTxt)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = cmdTxt;
                    System.Diagnostics.Debug.WriteLine(cmdTxt);
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }

        private static int SubmitPref(string cmdTxt)
        {
            int recordsAffected = -1;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = cmdTxt;
                    System.Diagnostics.Debug.WriteLine(cmdTxt);
                    conn.Open();
                    recordsAffected = (int)command.ExecuteScalar();
                    conn.Close();
                }
            }
            return recordsAffected;
        }

        private class RequestData
        {
            public int Request_ID { get; set; }
            public string Module_Code { get; set; }
            public string Day { get; set; }
            public string Start_Time { get; set; }
            public string End_Time { get; set; }
            public int Priority { get; set; }
            public string Number_Rooms { get; set; }
        }

        private class RequestStuff
        {
            public int Request_ID { get; set; }
            public string Module_Code { get; set; }
            public int Day { get; set; }
            public int Start_Time { get; set; }
            public int End_Time { get; set; }
            public bool Semester { get; set; }
            public int Year { get; set; }
            public int Round { get; set; }
            public bool Priority { get; set; }
            public int Number_Rooms { get; set; }
            public int Number_Students { get; set; }
            public string Dept_ID { get; set; }
        }


        private class PrivateRooms
        {
            public string Room_ID { get; set; }
        }

        public class Lecturers
        {
            public int Request_ID { get; set; }
            public string Lecturer_ID { get; set; }
        }

        public class Preferences
        {
            public int Pref_ID { get; set; }
            public string Room_ID { get; set; }
            public string Building_ID { get; set; }
            public string Room_Type { get; set; }
            public string Park_ID { get; set; }
            public int Number_Students { get; set; }
            public string Special_Requirements { get; set; }
            public int Weeks { get; set; }
        }

        public class Weeks
        {
            public int Pref_ID { get; set; }
            public int Week_ID { get; set; }
        }

        public class Facilities
        {
            public int Pref_ID { get; set; }
            public string Facility_ID { get; set; }
        }
    }
}