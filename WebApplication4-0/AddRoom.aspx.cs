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
    public partial class AddRoom : System.Web.UI.Page
    {
        public string buildings = "";
        public string facs = "";
        public string rooms = "";
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
            buildings = SQLSelect.Select("Buildings", "Building_Name, Building_ID", "1=1", "");
            facs = SQLSelect.Select("Facilities", "Facility_Name, Facility_ID", "1=1", "");
            rooms = SQLSelect.Select("Rooms", "Rooms.Room_ID, Capacity, Room_Type, Building_ID, Dept_ID, Pool", "1=1", "LEFT JOIN Private_Rooms ON Private_Rooms.Room_ID = Rooms.Room_ID");
            if(Session["LoggedIn"] != null)
            {
                department = SQLSelect.Select("Users", "Dept_ID", "Username = '" + Session["Username"] + "'", "");
            }
        }

        [System.Web.Services.WebMethod]
        public static bool AddBuilding(string buildCode, string buildName, string park)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "INSERT INTO Buildings (Building_ID, Building_Name, Park_ID) VALUES (@buildCode, @buildName, @park)";
                    command.Parameters.Add("@buildCode", SqlDbType.VarChar, 5).Value = buildCode;
                    command.Parameters.Add("@buildName", SqlDbType.VarChar, 255).Value = buildName;
                    command.Parameters.Add("@park", SqlDbType.Char, 1).Value = park;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                    return true;
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static string GetFacs(string roomCode)
        {
            return SQLSelect.Select("Room_Facilities", "Facility_ID", "Room_ID = '" + roomCode + "'", "");
        }
        [System.Web.Services.WebMethod]
        public static bool DeleteRoom (string roomCode)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "DELETE FROM Rooms WHERE Room_ID = @roomCode;";
                    command.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                    return true;
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static bool InsertRoom(string roomCode, string buildCode, string roomType, string capacity, string facs, string dept)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    int pool = 0;
                    if (dept == "AD")
                    {
                        pool = 1;
                    }
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "INSERT INTO Rooms VALUES (@roomCode, @capacity,  @roomType, @buildCode, "+pool+")";
                    command.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                    command.Parameters.Add("@roomType", SqlDbType.Char, 1).Value = roomType;
                    command.Parameters.Add("@capacity", SqlDbType.Int).Value = capacity;
                    command.Parameters.Add("@buildCode", SqlDbType.VarChar, 5).Value = buildCode;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
                if (dept != "AD")
                {
                    using (SqlCommand command2 = new SqlCommand())
                    {
                        command2.Connection = conn;
                        command2.CommandType = CommandType.Text;
                        command2.CommandText = "INSERT INTO Private_Rooms VALUES (@roomCode, @dept)";
                        command2.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                        command2.Parameters.Add("@dept", SqlDbType.Char, 2).Value = dept;
                        conn.Open();
                        int recordsAffected = command2.ExecuteNonQuery();
                        conn.Close();
                    }
                }
            }
            insertFacs(roomCode, facs);
            return true;
        }
        [System.Web.Services.WebMethod]
        public static bool UpdateRoom(string roomCode, string roomType, string capacity, string facs)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "UPDATE Rooms SET Room_Type = @roomType, Capacity = @capacity WHERE Room_ID = @roomCode";
                    command.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                    command.Parameters.Add("@roomType", SqlDbType.Char, 1).Value = roomType;
                    command.Parameters.Add("@capacity", SqlDbType.Int).Value = capacity;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
                using (SqlCommand command2 = new SqlCommand())
                {
                    command2.Connection = conn;
                    command2.CommandType = CommandType.Text;
                    command2.CommandText = "DELETE FROM Room_Facilities WHERE Room_ID = @roomCode";
                    command2.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                    conn.Open();
                    int recordsAffected = command2.ExecuteNonQuery();
                    conn.Close();
                }
                insertFacs(roomCode, facs);
            }
            return true;
        }
        private static bool insertFacs(string roomCode, string facs)
        {
            List<string> facList = new JavaScriptSerializer().Deserialize<List<string>>(facs);
            string facVals = "";
            for(int i = 0; i < facList.Count; i++)
            {
                facVals += "('"+roomCode+"','"+facList[i]+"'),";
            }
            if(facVals != "")
            {
                facVals = facVals.Substring(0, facVals.Length - 1);
            }
            if(facVals != "")
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
                {
                    using (SqlCommand command3 = new SqlCommand())
                    {
                        command3.Connection = conn;
                        command3.CommandType = CommandType.Text;
                        command3.CommandText = "INSERT INTO Room_Facilities VALUES " + facVals;
                        command3.Parameters.Add("@roomCode", SqlDbType.VarChar, 13).Value = roomCode;
                        conn.Open();
                        int recordsAffected = command3.ExecuteNonQuery();
                        conn.Close();
                    }
                }
            }
            return true;
        }
    }
}