using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Providers.Entities;



namespace WebApplication4_0
{
    public partial class Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //automatically fills the modnameInput
        protected void modcodeInput_TextChanged(object sender, EventArgs e)
        {
            
        }

        [System.Web.Services.WebMethod]
        public static string ModcodeToModname(string modcode)
        {
            var modname = "";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "Select Module_Title from [Modules] WHERE Module_Code = '" + modcode + "'";
            SqlCommand comm = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
            if (comm.ExecuteScalar() != null)   //if it does return something
            {
                if (HttpContext.Current.Session == null)
                {
                    //Redirect("Default.aspx");
                    HttpContext.Current.Response.Redirect("Default.aspx");     
                }
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm.ExecuteScalar().ToString();
                // string result = comm.ExecuteScalar().ToString();
                modname = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0, 2))   //if request is for module from another department
                {
                    //modname = "Sorry, you do not have access to this module";
                    modname = "";
                }
            }
            else //if it doesnt return anything, it means that there is no such module code, hence no such module name
            {
                modname = "";
            }

            conn.Close();
            

            return modname;
        }

      
        [System.Web.Services.WebMethod]
        public static string ModnameToModcode(string modname) 
        {
            var modcode = "";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "Select Module_Code from [Modules] WHERE Module_Title = '" + modname + "'";
            SqlCommand comm2 = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
            if (comm2.ExecuteScalar() != null)   //if it does return something
            {
                if (HttpContext.Current.Session == null)
                {
                    //Redirect("Default.aspx");
                    HttpContext.Current.Response.Redirect("Default.aspx");     
                }
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm2.ExecuteScalar().ToString();
           
                modcode = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0,2))   //if request is for module from another department
                {
                    //modcode = "Sorry, you do not have access to this module";
                    modcode = "";
                }

            }
            else //if it doesnt return anything, it means that there is no such module code, hence no such module name
            {
                modcode = "";
            }

            conn.Close();


            return modcode;
        }


        /* This method takes in the value of the input ('term' parameter) that user enters in modInput, i.e. 'Server Side' and finds matching module names
         * on the database, if found returns as an autocomplete option for the user to be able to select, in this example, would return
         'Server Side Programming.
         * Minimum characters that have to be entered before search is carried out is 3. This is set in the javascript section on Request.aspx'*/
        [System.Web.Services.WebMethod]
        public static string[] GetModnames(string term)
        {
            List<string> retCategory = new List<string>();
           
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            {
                if (HttpContext.Current.Session == null)
                {
                    //Redirect("Default.aspx");
                    HttpContext.Current.Response.Redirect("Default.aspx");     
                }
                string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
                string dep = username.ToLower().Substring(0, 2); //this makes sure only module names from the logged in department come up as autocomplete options
                string query = string.Format("select Module_Title from [Modules] where Module_Code like '" + dep + "%' AND Module_Title Like '%{0}%'", term);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        retCategory.Add(reader.GetString(0));
                    }
                }
                con.Close();
            }
            return retCategory.ToArray();
        }

        /* Does the same as method above, but for modcodeInput. The minimum number of characters that have to be entered to execute this is 2*/
        [System.Web.Services.WebMethod]
        public static string[] GetModcodes(string term)
        {
            List<string> retCategory = new List<string>();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            {
                if (HttpContext.Current.Session == null)
                {
                    //Redirect("Default.aspx");
                    HttpContext.Current.Response.Redirect("Default.aspx");     
                }

                string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
                string dep = username.ToLower().Substring(0, 2); //this makes sure only module names from the logged in department come up as autocomplete options
                string query = string.Format("select Module_Code from [Modules] where Module_Code like '" + dep + "%' AND Module_Code Like '%{0}%'", term);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        retCategory.Add(reader.GetString(0));
                    }
                }
                con.Close();
            }
            return retCategory.ToArray();
        }

        /*
         on input in the lecturerInput text box, this method will provide suggestions for autocompletion.
         */
        [System.Web.Services.WebMethod]
        public static string[] GetLecturers(string term)
        {
            List<string> retCategory = new List<string>();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            {
                if (HttpContext.Current.Session == null)
                {
                    //Redirect("Default.aspx");
                    HttpContext.Current.Response.Redirect("Default.aspx");     
                }
                string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
                string dep = username.ToLower().Substring(0, 2); //this makes sure only module names from the logged in department come up as autocomplete options
                string query = string.Format("select Lecturer_Name from [Lecturers] where Lecturer_ID like '" + dep + "%' AND Lecturer_Name Like '%{0}%'", term);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        //retCategory.Add(reader.GetString(0) + " (" + reader.GetString(1) + ")");
                        retCategory.Add(reader.GetString(0));
                    }
                }
                con.Close();
            }
            return retCategory.ToArray();
        }

        private static void Redirect(string p)
        {
            throw new NotImplementedException();
        }
        [System.Web.Services.WebMethod]
        public static string ShowBuildingSelect(bool central, bool east, bool west)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            string query = "";
            //different possibilities of queries based on checkboxes checked by user. If user checks central, then central buildings shown.
            if (central == true && east == false && west == false)
            {
                query = "select * from [Buildings] where Park_ID = 'C'";
            }
            if (central == false && east == true && west == false)
            {
                query = "select * from [Buildings] where Park_ID = 'E'";
            }
            if (central == false && east == false && west == true)
            {
                query = "select * from [Buildings] where Park_ID = 'W'";
            }
            //query if multiple checkbox selected
            if (central == true && east == true && west == false)
            {
                query = "select * from [Buildings] where Park_ID != 'W'";
            }
            if (central == true && east == false && west == true)
            {
                query = "select * from [Buildings] where Park_ID != 'E'";
            }
            if (central == false && east == true && west == true)
            {
                query = "select * from [Buildings] where Park_ID != 'C'";
            }
            //query if all checkboxes selected
            if (central == true && east == true && west == true)
            {
                query = "select * from [Buildings]";
            }

            string result = "<option value='0'> - NO BUILDING PREFERENCE - </option>"; 

            if (query != "")
            {
                SqlCommand comm = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    result += "<option value ='" + reader.GetString(0) + "'>" + reader.GetString(1) + " (" + reader.GetString(0) + ")</option>";
                }
            }
           // string result = comm.ExecuteScalar().ToString();
            conn.Close();
            return result;
        }

        /*
         *Will narrow down rooms shown dependent on the building selected, capacity and room type.
         *to include: Dependant on Room facilities selected.
         */
        [System.Web.Services.WebMethod]
        public static string ShowRooms(string building, bool lecture, bool seminar, bool lab, string capacity, bool comp, bool ddp,
                                        bool dp, bool il, bool mp, bool pa, bool plasma, bool rev, bool mic, bool vis, bool wc, bool wb)
        {
            /*
             select distinct Room_Facilities.Room_ID from [Room_Facilities] 
             inner join [Rooms] on Room_Facilities.Room_ID = Rooms.Room_ID
             where Building_ID = 'A' and Room_Type = 'T' and Room_Facilities.Facility_ID= 'w' 
             */
            //if capacity input is empty, then set automatically to 0
            if (capacity == "")
            {
                capacity = "0";
            }
            string query = "";
            
            if (lecture == true && seminar == false && lab == false) //Tiered - T
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type = 'T' and Capacity >=" + capacity;
                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true) 
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID"; 
                if (ddp == true) 
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true) 
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true) 
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true) 
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true) 
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true) 
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true) 
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true) 
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true) 
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true) 
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true) 
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";
                    
                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type = 'T'";
                query += " and Capacity >=" + capacity;
                if(comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if(ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if(dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if(il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if(mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if(pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if(plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if(rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if(mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if(vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if(wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if(wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                

                //bool comp, bool ddp, bool dp, bool il, bool mp, bool pa, bool plasma, bool rev, bool mic, bool vis, bool wc, bool wb
                /*
                 * SQL query to carry out with multiple 'ands' on same column. This method renames the rooms table to room.
                 select distinct 
                    room.Room_ID 
                from 
                    [Rooms] room
                    join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID
                    join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID
                where 
                    room.Building_ID = 'LDS' 
                    and room.Room_Type = 's'
                    and facility1.Facility_ID = 'C' 
                    and facility2.Facility_ID = 'V'
                 */
            }
            if (lecture == false && seminar == true && lab == false) //Seminar - S
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type = 'S' and Capacity >=" + capacity;
                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type = 'S'";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            if (lecture == false && seminar == false && lab == true) //Lab - L
            {
               // query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type = 'L' and Capacity >=" + capacity;
                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type = 'L'";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            if (lecture == true && seminar == true && lab == false) 
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type != 'L' and Capacity >=" + capacity;

                
                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type != 'L'";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            if (lecture == true && seminar == false && lab == true)
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type != 'S' and Capacity >=" + capacity;

                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type != 'S'";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            if (lecture == false && seminar == true && lab == true)
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type != 'T' and Capacity >=" + capacity;

                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and room.Room_Type != 'T'";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            if (lecture == true && seminar == true && lab == true) //query when all checkboxes are selected
            {
                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Capacity >=" + capacity;

                //query = "select Room_ID from [Rooms] where Building_ID = '" + building + "' and Room_Type = 'T' and Capacity >=" + capacity;
                query = "select distinct room.Room_ID";
                query += " from [Rooms] room";
                if (comp == true)
                    query += " join [Room_Facilities] facility1 ON room.Room_ID = facility1.Room_ID";
                if (ddp == true)
                    query += " join [Room_Facilities] facility2 ON room.Room_ID = facility2.Room_ID";
                if (dp == true)
                    query += " join [Room_Facilities] facility3 ON room.Room_ID = facility3.Room_ID";
                if (il == true)
                    query += " join [Room_Facilities] facility4 ON room.Room_ID = facility4.Room_ID";
                if (mp == true)
                    query += " join [Room_Facilities] facility5 ON room.Room_ID = facility5.Room_ID";
                if (pa == true)
                    query += " join [Room_Facilities] facility6 ON room.Room_ID = facility6.Room_ID";
                if (plasma == true)
                    query += " join [Room_Facilities] facility7 ON room.Room_ID = facility7.Room_ID";
                if (rev == true)
                    query += " join [Room_Facilities] facility8 ON room.Room_ID = facility8.Room_ID";
                if (mic == true)
                    query += " join [Room_Facilities] facility9 ON room.Room_ID = facility9.Room_ID";
                if (vis == true)
                    query += " join [Room_Facilities] facility10 ON room.Room_ID = facility10.Room_ID";
                if (wc == true)
                    query += " join [Room_Facilities] facility11 ON room.Room_ID = facility11.Room_ID";
                if (wb == true)
                    query += " join [Room_Facilities] facility12 ON room.Room_ID = facility12.Room_ID";

                query += " where";
                query += " room.Building_ID = '" + building + "' ";
                query += " and Capacity >=" + capacity;
                if (comp == true)
                    query += " and facility1.Facility_ID = 'C'";
                if (ddp == true)
                    query += " and facility2.Facility_ID = 'DDP'";
                if (dp == true)
                    query += " and facility3.Facility_ID = 'DP'";
                if (il == true)
                    query += " and facility4.Facility_ID = 'I'";
                if (mp == true)
                    query += " and facility5.Facility_ID = 'MP'";
                if (pa == true)
                    query += " and facility6.Facility_ID = 'PA'";
                if (plasma == true)
                    query += " and facility7.Facility_ID = 'PS'";
                if (rev == true)
                    query += " and facility8.Facility_ID = 'RLC'";
                if (mic == true)
                    query += " and facility9.Facility_ID = 'RM'";
                if (vis == true)
                    query += " and facility10.Facility_ID = 'V'";
                if (wc == true)
                    query += " and facility11.Facility_ID = 'W'";
                if (wb == true)
                    query += " and facility12.Facility_ID = 'WB'";
                
            }
            string result = "<option value='0'> - NO ROOM PREFERENCE - </option>";
            //only carries out query if query exists
            if (query != "")
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
                conn.Open(); //opening connection with the DB
                SqlCommand comm = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    result += "<option value ='" + reader.GetString(0) + "'>" + reader.GetString(0) + "</option>";
                }
                conn.Close();
            }
          
            return result;
        }

         [System.Web.Services.WebMethod]
        public static string SubmitRequest(string modname, string modcode, int day, int startTime, int endTime, int numRooms, int roomCap1,
                                            int roomCap2, int roomCap3, int capacity, string lecturerName1, string lecturerName2, string lecturerName3,
                                            string specialR, int priority, string parkID1, string parkID2, string parkID3, string room1, string room2,
                                            string room3, string buildingID1, string buildingID2, string buildingID3, string roomType1, string roomType2, 
                                            string roomType3, int defaultWeeks, int[] weeks, bool comp, bool comp2, bool comp3, bool ddp, bool ddp2, bool ddp3,
                                            bool dp, bool dp2, bool dp3, bool il, bool il2, bool il3, bool mp, bool mp2, bool mp3, bool pa, bool pa2, bool pa3,
                                            bool plasma, bool plasma2, bool plasma3, bool rev, bool rev2, bool rev3, bool mic, bool mic2, bool mic3,
                                            bool vis, bool vis2, bool vis3, bool wc, bool wc2, bool wc3, bool wb, bool wb2, bool wb3)
        {
   
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            if (HttpContext.Current.Session == null)
            {
                //Redirect("Default.aspx");
                HttpContext.Current.Response.Redirect("Default.aspx");     
            }
            string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
            string dep = username.ToUpper().Substring(0, 2);

            string lecturerID = "";
            string lecturer2ID = "";
            string lecturer3ID = "";
            int requestID = -1;
            bool newRequest = false;
             int semester = 0;

            //30 September 2013 - 31 January 2014
            //3 February 2014 - 18 June 2014
             //can send request for  semester1 - after 18 june  - before 30 september
             //can send request for semester 2 - after 30 september - before 31 june
            DateTime semester1Start = new DateTime(DateTime.Now.Year, 6, 18);
            DateTime semester2Start = new DateTime(DateTime.Now.Year, 9, 30);
            DateTime currentDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
             //if between June 18 and September 30
            if(DateTime.Compare(currentDate, semester1Start) > 1 && DateTime.Compare(currentDate, semester2Start) < 0 ){
                semester = 0;
            }
            else
            {
                semester = 1;
            }

             /*
              * Checks to see if this request already exists in the db. If it does, then the user is notified.

              */


            //gets Request_Id of the submitted request.
            //if request is not exactly the same, then is allowed?
            string query = "select Request_ID from [Requests] where Module_Code = '" + modcode + "' and Day = " + day;
            query += " and Start_Time = " + startTime + " and End_Time = " + endTime + " and Semester = " + semester + " and Year = " + DateTime.Now.Year;
            query += " and Round = " + 1 + " and Priority = " + priority + " and Number_Rooms = " + numRooms + " and Number_Students = " + capacity;

            connection.Open(); //opening connection with the DB
            SqlCommand comm = new SqlCommand(query, connection);  //1st argument is query, 2nd argument is connection with DB
            SqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                requestID = reader.GetInt32(0);
            }
            connection.Close();
            /*
             gets Lecturer_ID since we have Lecturer_Name1
                 SqlCommand comm2 = new SqlCommand(query, conn);  //1st argument is query, 2nd argument is connection with DB
                 if (comm2.ExecuteScalar() != null)   //if it does return something
           {
             */

            string query3 = "select Lecturer_ID from [Lecturers] where Lecturer_Name = '" + lecturerName1 + "'";
            connection.Open();
            SqlCommand comm3 = new SqlCommand(query3, connection);  //1st argument is query, 2nd argument is connection with DB

            if (comm3.ExecuteScalar() != null)  //if it does return something
            {   
                lecturerID = comm3.ExecuteScalar().ToString();
            }
            connection.Close();

             /* gets Lecturer_ID for the 2nd lecturer (only if it has been assigned) */
            if (lecturerName2 != "")
            {
                string query5 = "select Lecturer_ID from [Lecturers] where Lecturer_Name = '" + lecturerName2 + "'";
                connection.Open();
                SqlCommand comm5 = new SqlCommand(query5, connection);  //1st argument is query, 2nd argument is connection with DB

                if (comm5.ExecuteScalar() != null)  //if it does return something
                {
                    lecturer2ID = comm5.ExecuteScalar().ToString();
                }
                connection.Close();
            }

            /* gets Lecturer_ID for the 3rd lecturer (only if it has been assigned) */
            if (lecturerName3 != "")
            {
                string query6 = "select Lecturer_ID from [Lecturers] where Lecturer_Name = '" + lecturerName3 + "'";
                connection.Open();
                SqlCommand comm6 = new SqlCommand(query6, connection);  //1st argument is query, 2nd argument is connection with DB

                if (comm6.ExecuteScalar() != null)  //if it does return something
                {
                    lecturer3ID = comm6.ExecuteScalar().ToString();
                }
                connection.Close();
            }

             /*
              * if the request ID does not already exist then we will now write all info into db.
              * Will write to [Requests] table
              *             [Request_Lecturers] table
              */
      
            if (requestID == -1)    //if the requestID does not already exist, then can write to the db
            {
                newRequest = true;  //it is a new request
               
                using (connection)
                {
                    /* Writes to the [Requests] table*/
                    string command = "Insert into [Requests]  (Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students, Dept_ID)";
                    command += " VALUES (@Module_Code, @Day, @Start_Time, @End_Time, @Semester, @Year, @Round, @Priority, @Number_Rooms, @Number_Students, @Dept_ID)";

                    SqlCommand cmd = new SqlCommand(command);
                    cmd.CommandType = CommandType.Text;

                    cmd.Parameters.AddWithValue("@Module_Code", modcode);
                    cmd.Parameters.AddWithValue("@Day", day);
                    cmd.Parameters.AddWithValue("@Start_Time", startTime);
                    cmd.Parameters.AddWithValue("@End_Time", endTime);
                    cmd.Parameters.AddWithValue("@Semester", semester);    //need to write function to work this out
                    cmd.Parameters.AddWithValue("@Year", DateTime.Now.Year);     //year
                    cmd.Parameters.AddWithValue("@Round", 1);       //need to check db to see what round it is
                    cmd.Parameters.AddWithValue("@Priority", priority);    //
                    cmd.Parameters.AddWithValue("@Number_Rooms", numRooms);
                    cmd.Parameters.AddWithValue("@Number_Students", capacity);
                    cmd.Parameters.AddWithValue("@Dept_ID", dep);
                    cmd.Connection = connection;
                    connection.Open(); //opening connection with the DB
                    cmd.ExecuteNonQuery();

                  
                    SqlCommand comm2 = new SqlCommand(query, connection);  //1st argument is query, 2nd argument is connection with DB
                    SqlDataReader reader2 = comm.ExecuteReader();
                    while (reader2.Read())
                    {
                        requestID = reader2.GetInt32(0); //this generates the new request id for the request that is being submitted
                    }
                    connection.Close();
                    /* writes to the [Request_Lecturers] if the Lecturer_ID has been obtained */
                    if (lecturerID != "")
                    {
                        string command2 = "insert into [Request_Lecturers] (Request_ID, Lecturer_ID) Values (@Request_ID, @Lecturer_ID)";
                        SqlCommand cmd2 = new SqlCommand(command2);
                        cmd2.CommandType = CommandType.Text;
                        cmd2.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd2.Parameters.AddWithValue("@Lecturer_ID", lecturerID);
                        cmd2.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd2.ExecuteNonQuery();
                        connection.Close();
                    }
                    /* writes to the [Request_Lecturers] if the Lecturer_ID for 2nd lecturer has been obtained */
                    if (lecturer2ID != "")
                    {
                        string command3 = "insert into [Request_Lecturers] (Request_ID, Lecturer_ID) Values (@Request_ID, @Lecturer_ID)";
                        SqlCommand cmd3 = new SqlCommand(command3);
                        cmd3.CommandType = CommandType.Text;
                        cmd3.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd3.Parameters.AddWithValue("@Lecturer_ID", lecturer2ID);
                        cmd3.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd3.ExecuteNonQuery();
                        connection.Close();
                    }
                    if (lecturer3ID != "")
                    {
                        string command4 = "insert into [Request_Lecturers] (Request_ID, Lecturer_ID) Values (@Request_ID, @Lecturer_ID)";
                        SqlCommand cmd4 = new SqlCommand(command4);
                        cmd4.CommandType = CommandType.Text;
                        cmd4.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd4.Parameters.AddWithValue("@Lecturer_ID", lecturer3ID);
                        cmd4.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd4.ExecuteNonQuery();
                        connection.Close();
                    }

                    if (room1 == "" || room1 == "0")
                    {
                        room1 = "";
                    }
                    if (buildingID1 == "")
                    {
                        buildingID1 = "";
                    }
                    /* writes to the [Request_Preferences] Table */
                    //if room and building specified


                    if (room1 != "" && room1 != "0" && buildingID1 != "0")
                    {
                        string command5 = "insert into [Request_Preferences] (Request_ID, Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                        SqlCommand cmd5 = new SqlCommand(command5);
                        cmd5.CommandType = CommandType.Text;
                        cmd5.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd5.Parameters.AddWithValue("@Room_ID", room1);
                        cmd5.Parameters.AddWithValue("@Building_ID", buildingID1);
                        cmd5.Parameters.AddWithValue("@Room_Type", roomType1);
                        cmd5.Parameters.AddWithValue("@Park_ID", parkID1);
                        cmd5.Parameters.AddWithValue("@Number_Students", roomCap1);
                        cmd5.Parameters.AddWithValue("@Special_Requirements", specialR);
                        cmd5.Parameters.AddWithValue("@Weeks", defaultWeeks);
                        cmd5.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd5.ExecuteNonQuery();
                        connection.Close();
                    }
                    //if room not specified, but building is
                    if ((room1 == "" && room1 == "0") && buildingID1 != "0")
                    {
                        string command5 = "insert into [Request_Preferences] (Request_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                        SqlCommand cmd5 = new SqlCommand(command5);
                        cmd5.CommandType = CommandType.Text;
                        cmd5.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd5.Parameters.AddWithValue("@Building_ID", buildingID1);
                        cmd5.Parameters.AddWithValue("@Room_Type", roomType1);
                        cmd5.Parameters.AddWithValue("@Park_ID", parkID1);
                        cmd5.Parameters.AddWithValue("@Number_Students", roomCap1);
                        cmd5.Parameters.AddWithValue("@Special_Requirements", specialR);
                        cmd5.Parameters.AddWithValue("@Weeks", defaultWeeks);
                        cmd5.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd5.ExecuteNonQuery();
                        connection.Close();
                    }
                    //if neither room or building is specified
                    if ((room1 == "" || room1 == "0") && buildingID1 == "0")
                    {
                        string command5 = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                        SqlCommand cmd5 = new SqlCommand(command5);
                        cmd5.CommandType = CommandType.Text;
                        cmd5.Parameters.AddWithValue("@Request_ID", requestID);
                        cmd5.Parameters.AddWithValue("@Room_Type", roomType1);
                        cmd5.Parameters.AddWithValue("@Park_ID", parkID1);
                        cmd5.Parameters.AddWithValue("@Number_Students", roomCap1);
                        cmd5.Parameters.AddWithValue("@Special_Requirements", specialR);
                        cmd5.Parameters.AddWithValue("@Weeks", defaultWeeks);
                        cmd5.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmd5.ExecuteNonQuery();
                        connection.Close();
                    
                    }
                    if (numRooms > 1) //if at least 2 rooms selected, this inserts the 2nd room to the table
                    {
                        //if room and building specified
                        if (room2 != "" && room2 != "0" && buildingID2 != "0")
                        {
                            string command6 = "insert into [Request_Preferences] (Request_ID, Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd6 = new SqlCommand(command6);
                            cmd6.CommandType = CommandType.Text;
                            cmd6.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd6.Parameters.AddWithValue("@Room_ID", room2);
                            cmd6.Parameters.AddWithValue("@Building_ID", buildingID2);
                            cmd6.Parameters.AddWithValue("@Room_Type", roomType2);
                            cmd6.Parameters.AddWithValue("@Park_ID", parkID2);
                            cmd6.Parameters.AddWithValue("@Number_Students", roomCap2);
                            cmd6.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd6.Parameters.AddWithValue("@Weeks", defaultWeeks);
                            cmd6.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd6.ExecuteNonQuery();
                            connection.Close();
                        }
                        //if room not specified, but building is
                        if ((room2 == "" && room2 == "0") && buildingID2 != "0")
                        {
                            string command6 = "insert into [Request_Preferences] (Request_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd6 = new SqlCommand(command6);
                            cmd6.CommandType = CommandType.Text;
                            cmd6.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd6.Parameters.AddWithValue("@Building_ID", buildingID2);
                            cmd6.Parameters.AddWithValue("@Room_Type", roomType2);
                            cmd6.Parameters.AddWithValue("@Park_ID", parkID2);
                            cmd6.Parameters.AddWithValue("@Number_Students", roomCap2);
                            cmd6.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd6.Parameters.AddWithValue("@Weeks", defaultWeeks);
                            cmd6.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd6.ExecuteNonQuery();
                            connection.Close();
                        }
                        //if neither room or building is specified
                        if ((room2 == "" || room2 == "0") && buildingID2 == "0")
                        {
                            string command6 = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd6 = new SqlCommand(command6);
                            cmd6.CommandType = CommandType.Text;
                            cmd6.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd6.Parameters.AddWithValue("@Room_Type", roomType2);
                            cmd6.Parameters.AddWithValue("@Park_ID", parkID2);
                            cmd6.Parameters.AddWithValue("@Number_Students", roomCap2);
                            cmd6.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd6.Parameters.AddWithValue("@Weeks", defaultWeeks);
                            cmd6.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd6.ExecuteNonQuery();
                            connection.Close();

                        }
                    }

                    //if 3 rooms selected - this inserts 3rd row 
                    if (numRooms > 2)
                    {
                        //if room and building specified
                        if (room3 != "" && room3 != "0" && buildingID3 != "0")
                        {
                            string command7 = "insert into [Request_Preferences] (Request_ID, Room_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd7 = new SqlCommand(command7);
                            cmd7.CommandType = CommandType.Text;
                            cmd7.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd7.Parameters.AddWithValue("@Room_ID", room3);
                            cmd7.Parameters.AddWithValue("@Building_ID", buildingID3);
                            cmd7.Parameters.AddWithValue("@Room_Type", roomType3);
                            cmd7.Parameters.AddWithValue("@Park_ID", parkID3);
                            cmd7.Parameters.AddWithValue("@Number_Students", roomCap3);
                            cmd7.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd7.Parameters.AddWithValue("@Weeks", defaultWeeks);
                            cmd7.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd7.ExecuteNonQuery();
                            connection.Close();
                        }
                        //if room not specified, but building is
                        if ((room3 == "" && room3 == "0") && buildingID3 != "0")
                        {
                            string command7 = "insert into [Request_Preferences] (Request_ID, Building_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Building_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd7 = new SqlCommand(command7);
                            cmd7.CommandType = CommandType.Text;
                            cmd7.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd7.Parameters.AddWithValue("@Building_ID", buildingID3);
                            cmd7.Parameters.AddWithValue("@Room_Type", roomType3);
                            cmd7.Parameters.AddWithValue("@Park_ID", parkID3);
                            cmd7.Parameters.AddWithValue("@Number_Students", roomCap3);
                            cmd7.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd7.Parameters.AddWithValue("@Weeks", defaultWeeks);
                            cmd7.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd7.ExecuteNonQuery();
                            connection.Close();
                        }
                        //if neither room or building is specified
                        if ((room3 == "" || room3 == "0") && buildingID3 == "0")
                        {
                            string command7 = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            SqlCommand cmd7 = new SqlCommand(command7);
                            cmd7.CommandType = CommandType.Text;
                            cmd7.Parameters.AddWithValue("@Request_ID", requestID);
                            cmd7.Parameters.AddWithValue("@Room_Type", roomType3);
                            cmd7.Parameters.AddWithValue("@Park_ID", parkID3);
                            cmd7.Parameters.AddWithValue("@Number_Students", roomCap3);
                            cmd7.Parameters.AddWithValue("@Special_Requirements", specialR);
                            cmd7.Parameters.AddWithValue("@Weeks", defaultWeeks); //if default weeks then 1, otherwise 0
                            cmd7.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd7.ExecuteNonQuery();
                            connection.Close();
                        }

                    }


                    /* 
                      gets the preference id for the first room with the request_id equal to submitted request id. 
                     */

                    string queryPrefID = "select Pref_ID from [Request_Preferences] where Request_ID = " + requestID;
                    connection.Open(); //opening connection with the DB
                    SqlCommand getPrefID = new SqlCommand(queryPrefID, connection);  //1st argument is query, 2nd argument is connection with DB
                    int prefID1 = Convert.ToInt32(getPrefID.ExecuteScalar().ToString());
                    int prefID2 = prefID1 + 1;
                    int prefID3 = prefID2 + 1;
                    connection.Close();
         

                    /*
                     * -- Writes to the weeks table --
                     */

                    //always bigger than 0.
                    if (numRooms>0) //then there is only 1 preference ID, so only inserts weeks for room1.
                    {
                        if(defaultWeeks != 1){ //only if user has chosen custom weeks
                        //string weeksQuery = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                        string weeksQuery = "";
                        
                        for (int i = 0; i < weeks.Length; i++)
                        {
                            weeksQuery += "insert into [Request_Weeks] (Pref_ID, Week_ID) Values (" + prefID1 + ", " + weeks[i].ToString() + ") ";
                        }
                        SqlCommand cmdWeeks = new SqlCommand(weeksQuery);
                        cmdWeeks.CommandType = CommandType.Text;
                        cmdWeeks.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmdWeeks.ExecuteNonQuery();
                        connection.Close();
                        }
                   
                    }

                    //if 2nd room exists
                    if (numRooms > 1) //then there is 2 preference IDs, so the first one has already been inserted above, this inserts weeks for 2nd room
                    {
                        if (defaultWeeks != 1)
                        { //only if user has chosen custom weeks
                            //string weeksQuery = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            string weeksQuery = "";

                            for (int i = 0; i < weeks.Length; i++)
                            {
                                weeksQuery += "insert into [Request_Weeks] (Pref_ID, Week_ID) Values (" + prefID2 + ", " + weeks[i].ToString() + ") ";
                            }
                            SqlCommand cmdWeeks = new SqlCommand(weeksQuery);
                            cmdWeeks.CommandType = CommandType.Text;
                            cmdWeeks.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmdWeeks.ExecuteNonQuery();
                            connection.Close();
                        }
                    }

                    //if 3rd room exists
                    if (numRooms > 2) //then there is 3 preference IDs, so the 1st and 2nd ones have already been inserted above, this inserts weeks for 3rd room
                    {
                        if (defaultWeeks != 1)
                        { //only if user has chosen custom weeks
                            //string weeksQuery = "insert into [Request_Preferences] (Request_ID, Room_Type, Park_ID, Number_Students, Special_Requirements, Weeks) Values (@Request_ID, @Room_Type, @Park_ID, @Number_Students, @Special_Requirements, @Weeks)";
                            string weeksQuery = "";

                            for (int i = 0; i < weeks.Length; i++)
                            {
                                weeksQuery += "insert into [Request_Weeks] (Pref_ID, Week_ID) Values (" + prefID3 + ", " + weeks[i].ToString() + ") ";
                            }
                            SqlCommand cmdWeeks = new SqlCommand(weeksQuery);
                            cmdWeeks.CommandType = CommandType.Text;
                            cmdWeeks.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmdWeeks.ExecuteNonQuery();
                            connection.Close();
                        }

                    }

                    /*
    comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic, vis: vis, wc: wc, wb: wb,
    */
                    /*
                     * 
                      <-- WRITES TO THE [REQUEST_FACILITIES] TABLE --> 
                     * 
                     */
                    string roomFacilityQuery1 = "";
                    if(comp == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'C') ";
                    if (ddp == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'DDP') ";
                    if (dp == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'DP') ";
                    if (il == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'I') ";
                    if (mp == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'MP') ";
                    if (pa == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'PA') ";
                    if (plasma == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'PS') ";
                    if (rev == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'RLC') ";
                    if (mic == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'RM') ";
                    if (vis == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'V') ";
                    if (wc == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'W') ";
                    if (wb == true)
                        roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID1 + ", 'WB') ";

                    if (numRooms > 1)
                    {
                        if (comp2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'C') ";
                        if (ddp2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'DDP') ";
                        if (dp2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'DP') ";
                        if (il2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'I') ";
                        if (mp2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'MP') ";
                        if (pa2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'PA') ";
                        if (plasma2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'PS') ";
                        if (rev2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'RLC') ";
                        if (mic2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'RM') ";
                        if (vis2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'V') ";
                        if (wc2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'W') ";
                        if (wb2 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID2 + ", 'WB') ";
                    }
                    if (numRooms > 2)
                    {
                        if (comp3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'C') ";
                        if (ddp3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'DDP') ";
                        if (dp3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'DP') ";
                        if (il3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'I') ";
                        if (mp3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'MP') ";
                        if (pa3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'PA') ";
                        if (plasma3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'PS') ";
                        if (rev3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'RLC') ";
                        if (mic3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'RM') ";
                        if (vis3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'V') ";
                        if (wc3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'W') ";
                        if (wb3 == true)
                            roomFacilityQuery1 += "insert into [Request_Facilities] (Pref_ID, Facility_ID) Values (" + prefID3 + ", 'WB') ";
                    }

                    //if query is not empty then carry it out
                    if (roomFacilityQuery1 != "")
                    {
                            SqlCommand cmdF = new SqlCommand(roomFacilityQuery1);
                            cmdF.CommandType = CommandType.Text;
                            cmdF.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmdF.ExecuteNonQuery();
                            connection.Close();
                    }


               
                    /* 
                     * -- FINALLY, WRITES TO BOOKING TABLE -- 
                     *  If the request, requests a departmental room, then booking is allocated straight away
                     *  otherwise, set to pending.
                     *  only set to allocated if all rooms requested are private rooms.
                     */
                    bool pool = true; //set to false by default, it is not a pool room, changed if not
                    
                   
                    //only carried out if room1 has been specified
                    if (room1 != "")
                    {
                        bool result1 = true;
                        //finds whether the room requested is a pool room or not, if not pool room, then it is a private room, for a specific department
                        string poolQuery1 = "select Pool from [Rooms] where Room_ID = '" + room1 + "'";
                        connection.Open();
                        SqlCommand getPool1 = new SqlCommand(poolQuery1, connection);  //gets Pool - false if private room, true if is a pool room
                        //getPool1.ExecuteScalar();
                        result1 = Convert.ToBoolean(getPool1.ExecuteScalar());
                        
                        connection.Close();
                        if (result1 == false)
                        {
                            pool = false;
                        }

                        string roomDep1 = "";   //contains department of the room i.e. CO
                        //finds out if the room belongs to the department making the request
                        if (pool == false)
                        {
                            string roomDepQuery1 = "select Dept_ID from [Private_Rooms] where Room_ID = '" + room1 + "'";
                            connection.Open();
                            SqlCommand getDep1 = new SqlCommand(roomDepQuery1, connection);  //gets Pool - 0 if private room, 1 if is a pool room
                            roomDep1 = getDep1.ExecuteScalar().ToString();
                            connection.Close();
                        }

                        //if room department different to that of the department making the request, pool set to true
                        if (roomDep1 != dep)
                        {
                            pool = true;
                        }
                      
                    }

                 
                    if (numRooms > 1)
                    {
                        if (pool == false)  //only carried out if 1st room is private
                        {
                            //only carried out if room2 has been specified
                            bool result2 = true;
                            if (room2 != "")
                            {
                                string poolQuery2 = "select Pool from [Rooms] where Room_ID = '" + room2 + "'";
                                connection.Open();
                                SqlCommand getPool2 = new SqlCommand(poolQuery2, connection);  //gets Pool - 0 (false) if private room, 1 (true) if is a pool room
                                result2 = Convert.ToBoolean(getPool2.ExecuteScalar().ToString());
                                connection.Close();
                            }
                      

                            if (result2 == false)
                            {
                                pool = false;
                            }
                            else
                            {
                                pool = true;    //sets pool back to true if 1st room is private room, but if 2nd room is pool
                            }

                            string roomDep2 = "";   //contains department of the room i.e. CO
                            //finds out if the room belongs to the department making the request
                            if (pool == false)
                            {
                                string roomDepQuery2 = "select Dept_ID from [Private_Rooms] where Room_ID = '" + room2 + "'";
                                connection.Open();
                                SqlCommand getDep2 = new SqlCommand(roomDepQuery2, connection);  //gets Pool - 0 if private room, 1 if is a pool room
                                roomDep2 = getDep2.ExecuteScalar().ToString();
                                connection.Close();
                            }

                            //if room department different to that of the department making the request, pool set to true
                            if (roomDep2 != dep)
                            {
                                pool = true;
                            }
                          
                        }            
                    }

                    if (numRooms > 2)
                    {
                        if (pool == false)  //only carried out if 1st and 2nd room are private rooms
                        {
                            bool result3 = true;
                            //only carried out if room3 is specified
                            if (room3 != "")
                            {
                                string poolQuery3 = "select Pool from [Rooms] where Room_ID = '" + room3 + "'";
                                connection.Open();
                                SqlCommand getPool3 = new SqlCommand(poolQuery3, connection);  //gets Pool - 0 (false) if private room, 1 (true) if is a pool room
                                result3 = Convert.ToBoolean(getPool3.ExecuteScalar().ToString());
                                connection.Close();
                            }
                   

                            if (result3 == false)
                            {
                                pool = false;
                            }
                            else
                            {
                                pool = true;    //sets pool back to true if 1st room is private room, but if 2nd room is pool
                            }

                            string roomDep3 = "";   //contains department of the room i.e. CO
                            //finds out if the room belongs to the department making the request
                            if (pool == false)
                            {
                                string roomDepQuery3 = "select Dept_ID from [Private_Rooms] where Room_ID = '" + room3 + "'";
                                connection.Open();
                                SqlCommand getDep3 = new SqlCommand(roomDepQuery3, connection);  //gets Pool - 0 if private room, 1 if is a pool room
                                roomDep3 = getDep3.ExecuteScalar().ToString();
                                connection.Close();
                            }

                            //if room department different to that of the department making the request, pool set to true
                            if (roomDep3 != dep)
                            {
                                pool = true;
                            }
                            
                        }
                    }

                    //if it is a pool room, writes the request to [Bookings] as 'pending'
                    
                    if (pool == true)
                    {
                        string writeBooking = "insert into [Bookings] (Request_ID, Confirmed) Values (@Request_ID, @Confirmed) ";
                        SqlCommand cmdWB = new SqlCommand(writeBooking);
                        cmdWB.Parameters.AddWithValue("@Request_ID", requestID);
                        cmdWB.Parameters.AddWithValue("@Confirmed", "Pending");
                        cmdWB.CommandType = CommandType.Text;
                        cmdWB.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmdWB.ExecuteNonQuery();
                        connection.Close();
                    }else{
                        string writeBooking = "insert into [Bookings] (Request_ID, Confirmed) Values (@Request_ID, @Confirmed) ";
                        SqlCommand cmdWB = new SqlCommand(writeBooking);
                        cmdWB.Parameters.AddWithValue("@Request_ID", requestID);
                        cmdWB.Parameters.AddWithValue("@Confirmed", "Allocated");
                        cmdWB.CommandType = CommandType.Text;
                        cmdWB.Connection = connection;
                        connection.Open(); //opening connection with the DB
                        cmdWB.ExecuteNonQuery();
                        connection.Close();
                    }
                    
        
                }

            }
           

            
            connection.Close();
           // return requestID;
            string result = "Sorry, this request has already been submitted, with Request ID: " + requestID + ".";
            result += "<br /> Please try again.";
            if (newRequest == true)
            {

                result = "<strong><h2 style='margin:0'>Success</h2></strong>";
                result += "<br />Your request has been submitted, thank you! Your Request ID is: " + requestID;
                result += "<br />Please make a note of your Request ID, so that you can track its progress.";
            }
          
            return result;
        }

          [System.Web.Services.WebMethod]
         public static string ValidateLecturer(string lecturerName)
         {
             string result = "";
             string query = "";
             if (HttpContext.Current.Session == null)
             {
                 //Redirect("Default.aspx");
                 HttpContext.Current.Response.Redirect("Default.aspx");                    
             }
             string username = HttpContext.Current.Session["Username"].ToString();   //retrieves the username from the logged in session, i.e. cord
             string dep = username.ToUpper().Substring(0, 2);
             query += "select Lecturer_Name from [Lecturers] where Lecturer_Name = '" + lecturerName + "' and Lecturer_ID like '" + dep + "%'" ;
             SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
             connection.Open(); //opening connection with the DB
             SqlCommand comm = new SqlCommand(query, connection);  //1st argument is query, 2nd argument is connection with DB
             SqlDataReader reader = comm.ExecuteReader();
             while (reader.Read())
             {
                 result = reader.GetString(0);
             }

             connection.Close();
             return result;
         }




    }

   
  
}