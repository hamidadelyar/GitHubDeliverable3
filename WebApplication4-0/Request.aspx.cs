using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
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
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm.ExecuteScalar().ToString();
                // string result = comm.ExecuteScalar().ToString();
                modname = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0, 2))   //if request is for module from another department
                {
                    modname = "Sorry, you do not have access to this module";
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
                string username = HttpContext.Current.Session["Username"].ToString();
                string result = comm2.ExecuteScalar().ToString();
           
                modcode = result;
                if (modcode.ToLower().Substring(0, 2) != username.ToLower().Substring(0,2))   //if request is for module from another department
                {
                    modcode = "Sorry, you do not have access to this module";
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





    }

   
  
}