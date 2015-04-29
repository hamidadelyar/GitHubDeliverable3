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
                                            string roomType3, int defaultWeeks)
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
             /*
              * Checks to see if this request already exists in the db. If it does, then the user is notified.

              */

            //gets Request_Id of the submitted request.
            //if request is not exactly the same, then is allowed?
            string query = "select Request_ID from [Requests] where Module_Code = '" + modcode + "' and Day = " + day;
            query += " and Start_Time = " + startTime + " and End_Time = " + endTime + " and Semester = " + 1 + " and Year = " + DateTime.Now.Year;
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
                    cmd.Parameters.AddWithValue("@Semester", 1);    //need to write function to work this out
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
                    if (numRooms > 1)
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

                    //if 3 rooms selected
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
                            cmd7.Parameters.AddWithValue("@Weeks", defaultWeeks); //if default weeks, then 1, otherwise 0
                            cmd7.Connection = connection;
                            connection.Open(); //opening connection with the DB
                            cmd7.ExecuteNonQuery();
                            connection.Close();

                        }
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