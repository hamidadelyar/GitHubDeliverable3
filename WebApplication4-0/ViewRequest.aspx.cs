using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.Providers.Entities;
using System.Web.Script.Serialization;


namespace WebApplication4_0
{
    public partial class ViewRequest : System.Web.UI.Page
    {
        //static SqlConnection conn;
        //DataTable dt;
        //public String data = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = GetData("Request_ID, Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students", "Requests", "");
            if ((Session["LoggedIn"]) != null)
            {
                dt = GetData("Requests.Request_ID, Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students, Confirmed", "Requests, Bookings", "WHERE LEFT(Module_Code,2) = '" + Session["Username"].ToString().Substring(0, 2) + "' AND Requests.Request_ID = Bookings.Request_ID");
            }

            
            /*
            foreach(DataRow row1 in user.Rows)
            {
                foreach(DataColumn col1 in user.Columns)
                {
                    string deptid = row1[col1.ColumnName].ToString();
                }
            }*/

            string[] cols = { "Request No.", "Module Code", "Day", "Start Time", "End Time", "Semester", "Year", "Round", "Priority", "No. of Rooms", "No. of Students", "Status", "Delete Row" };
            //DataTable dt = GetData("Request_ID, Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students", "Requests", "" );

            StringBuilder html = new StringBuilder();

            List<Rows> rows = new List<Rows>();

            List<string> rows1 = new List<string>();

            html.Append("<table border = 2 id='requestTable' class='tablesorter'>");
            html.Append("<thead>");

            html.Append("<tr>");
            for(int i=0;i<cols.Length;i++)
            {
                html.Append("<th>");
                html.Append(cols[i]);
                html.Append("</th>");
            }
            html.Append("</tr>");
            html.Append("</thead>");

            int req = 0;
            string mod = "";
            int days = 0;
            int st = 0;
            int ed = 0;
            bool sem = true;
            int y = 0;
            int rnd = 0;
            bool pr = true;
            int rms = 0;
            int stu = 0;
            string stat = "";

            foreach (DataRow row in dt.Rows)
            {
                //html.Append("<tr>");
                foreach (DataColumn column in dt.Columns)
                {
                    
                    
                    //Rows newRow = new Rows(row["Request_ID"], row["Module_Code"], row["Day"], row["Start_Time"], row["End_Time"], row["Semester"], row["Year"], row["Round"], row["Priority"], row["Number_Rooms"], row["Number_Students"]); 
                    string s = row[column.ColumnName].ToString();
                    rows1.Add(s);

                    for (int i = 0; i < rows1.Count; i++)
                    {
                            switch (i)
                            {
                                case 0: req = Convert.ToInt32(rows1[i]); break;
                                case 1: mod = rows1[i]; break;
                                case 2: days = Convert.ToInt32(rows1[i]); break;
                                case 3: st = Convert.ToInt32(rows1[i]); break;
                                case 4: ed = Convert.ToInt32(rows1[i]); break;
                                case 5: sem = Convert.ToBoolean(rows1[i]); break;
                                case 6: y = Convert.ToInt32(rows1[i]); break;
                                case 7: rnd = Convert.ToInt32(rows1[i]); break;
                                case 8: pr = Convert.ToBoolean(rows1[i]); break;
                                case 9: rms = Convert.ToInt32(rows1[i]); break;
                                case 10: stu = Convert.ToInt32(rows1[i]); break;
                                case 11: stat = rows1[i]; break;
                                default: mod = rows1[i]; break;

                            }
                    }
                  

                }
                if (rows1.Count() != 0)
                {
                    Rows rows2 = new Rows(req, mod, days, st, ed, sem, y, rnd, pr, rms, stu, stat);
                    rows.Add(rows2);
                    rows1.Clear();
                    //html.Append("</tr>");
                }
            }

            html.Append("<tbody>");
            for(int i=0;i<rows.Count;i++)
            {
                html.Append("<tr id='" + i + "' class='header'>");
                for (int j = 0; j <= 11; j++)
                {
                    switch(j)
                    {
                            case 0: html.Append("<td>");
                                    html.Append(rows[i].getReq());
                                    html.Append("</td>");
                                    break;
                            case 1: html.Append("<td>");
                                    html.Append(rows[i].getMod());
                                    html.Append("</td>");
                                    break;
                            case 2: html.Append("<td>");
                                    html.Append(rows[i].getDay());
                                    html.Append("</td>");
                                    break;
                            case 3: html.Append("<td>");
                                    html.Append(rows[i].getStart());
                                    html.Append("</td>");
                                    break;
                            case 4: html.Append("<td>");
                                    html.Append(rows[i].getEnd());
                                    html.Append("</td>");
                                    break;
                            case 5: html.Append("<td>");
                                    html.Append(rows[i].getSem());
                                    html.Append("</td>");
                                    break;
                            case 6: html.Append("<td>");
                                    html.Append(rows[i].getYear());
                                    html.Append("</td>");
                                    break;
                            case 7: html.Append("<td>");
                                    html.Append(rows[i].getRound());
                                    html.Append("</td>");
                                    break;
                            case 8: html.Append("<td>");
                                    html.Append(rows[i].getPriority());
                                    html.Append("</td>");
                                    break;
                            case 9: html.Append("<td>");
                                    html.Append(rows[i].getRooms());
                                    html.Append("</td>");
                                    break;
                            case 10:html.Append("<td>");
                                    html.Append(rows[i].getStudents());
                                    html.Append("</td>");
                                    break;
                            case 11: if (rows[i].getStatus() == "Allocated")
                                    {
                                        html.Append("<td style='color:#00FF00'>");
                                        html.Append(rows[i].getStatus());
                                        html.Append("</td>");
                                        break;
                                    }
                                    else if (rows[i].getStatus() == "Pending")
                                    {
                                        html.Append("<td style='color:#FFFF00'>");
                                        html.Append(rows[i].getStatus());
                                        html.Append("</td>");
                                        break;
                                    }
                                    else
                                    {
                                        html.Append("<td style='color:#FF0000'>");
                                        html.Append(rows[i].getStatus());
                                        html.Append("</td>");
                                        break;
                                    }
                    }

                }
                DataTable pref = GetData("Pref_ID", "Request_Preferences", "WHERE Request_ID = " + rows[i].getReq());
                int p = 0;

                foreach (DataRow rowp in pref.Rows)
                {
                    //html.Append("<tr>");
                    foreach (DataColumn columnp in pref.Columns)
                    {
                        p = Convert.ToInt32(rowp[columnp.ColumnName]);
                        //rowps.Add(p);
                    }
                }

                html.Append("<td>");
                html.Append("<input type='button' id='button" + i + "' value='Delete' onclick=\"deleteRow(" + rows[i].getReq() + "," + p + ")\"/>");
                //html.Append("<asp:button runat='server' id='button" + i + "' Text='Delete' OnClick='deleteRow_Click' />");
                html.Append("</td>");
                html.Append("</tr>");
                html.Append("<tr>");
                html.Append("<td>");
                html.Append("data");
                html.Append("</td>");
                html.Append("</tr>");
            }
            html.Append("</tbody>");
          


            html.Append("</table>");

            PlaceHolder1.Controls.Add(new Literal { Text = html.ToString() });

            /*conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open();

            string vreqQuery = "SELECT Request_ID, Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students FROM Requests";
            SqlCommand comm = new SqlCommand(vreqQuery, conn);

            SqlDataAdapter da = new SqlDataAdapter(comm);
            da.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
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
            data = serializer.Serialize(rows);
        */
        }

        
        /*public string GetUsername()
        {
            string username = "";
            if (HttpContext.Current.Session == null)
            {
                Redirect("Default.aspx");
            }
            else
            {
                username = HttpContext.Current.Session["Username"].ToString();
            }
            return username;
        }
        
        private static void Redirect(string p)
        {
            throw new NotImplementedException();
        }
        */

        [System.Web.Services.WebMethod]
        public static string Delete(int id, int pref_id)
        {
            string msg = string.Empty;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            using (conn)
            {
                string sql = "DELETE FROM Bookings WHERE Request_ID = @Request_ID";
                string sql1 = "DELETE FROM Requests WHERE Request_ID = @Request_ID ";
                string sql2 = "DELETE FROM Request_Preferences WHERE Request_ID = @Request_ID";
                string sql3 = "DELETE FROM Request_Facilities WHERE Pref_ID = @Pref_ID";
                string sql4 = "DELETE FROM Request_Weeks WHERE Pref_ID = @Pref_ID";
                string sql5 = "DELETE FROM Request_Lecturers WHERE Request_ID = @Request_ID";

                //conn.Open();
                SqlCommand cmd = new SqlCommand(sql);
                cmd.CommandType = CommandType.Text;

                //conn.Open();
                cmd.Parameters.AddWithValue("@Request_ID", id);
                cmd.Connection = conn;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                SqlCommand cmd1 = new SqlCommand(sql1);
                cmd1.CommandType = CommandType.Text;

                
                cmd1.Parameters.AddWithValue("@Request_ID", id);
                cmd1.Connection = conn;
                conn.Open();
                cmd1.ExecuteNonQuery();
                conn.Close();

                SqlCommand cmd2 = new SqlCommand(sql2);
                cmd2.CommandType = CommandType.Text;


                cmd2.Parameters.AddWithValue("@Request_ID", id);
                cmd2.Connection = conn;
                conn.Open();
                cmd2.ExecuteNonQuery();
                conn.Close();

                SqlCommand cmd3 = new SqlCommand(sql3);
                cmd3.CommandType = CommandType.Text;


                cmd3.Parameters.AddWithValue("@Pref_ID", pref_id);
                cmd3.Connection = conn;
                conn.Open();
                cmd3.ExecuteNonQuery();
                conn.Close();

                SqlCommand cmd4 = new SqlCommand(sql4);
                cmd4.CommandType = CommandType.Text;


                cmd4.Parameters.AddWithValue("@Pref_ID", pref_id);
                cmd4.Connection = conn;
                conn.Open();
                cmd4.ExecuteNonQuery();
                conn.Close();

                SqlCommand cmd5 = new SqlCommand(sql5);
                cmd5.CommandType = CommandType.Text;


                cmd5.Parameters.AddWithValue("@Request_ID", id);
                cmd5.Connection = conn;
                conn.Open();
                cmd5.ExecuteNonQuery();
                conn.Close();
                /*if (y == 1)
                {
                    msg = "true";
                }
                else
                {
                    msg = "false";
                }
                */
            }
            msg = "true";
            return msg;
                    //conn.Dispose();
        }

        /*[System.Web.Services.WebMethod]
        protected void deleteRow_Click(object sender, EventArgs e)
        {
            Button button = sender as Button;
            string buttonID = button.ID;

            Delete(buttonID);
        }
        */
        public DataTable GetData(string select, string from, string where)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            string vreqQuery = "SELECT " + select + " FROM " + from + " " + where;
            SqlCommand comm = new SqlCommand(vreqQuery, conn);
            SqlDataAdapter da = new SqlDataAdapter(comm);
            //conn.Open();

            using (conn)
            {
                using (comm)
                {
                    using (da)
                    {
                        comm.Connection = conn;
                        da.SelectCommand = comm;
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }
        
        /*
        public class SQLSelect
        {
            public SQLSelect()
            {

            }
            
            public static DataTable GetData(string select, string from, string where)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
                string vreqQuery = "SELECT " + select + " FROM " + from + where;
                SqlCommand comm = new SqlCommand(vreqQuery, conn);
                SqlDataAdapter da = new SqlDataAdapter(comm);
                //conn.Open();

                using (conn)
                {
                    using (comm)
                    {
                        using (da)
                        {
                            comm.Connection = conn;
                            da.SelectCommand = comm;
                            using (DataTable dts = new DataTable())
                            {
                            da.Fill(dts);
                            return dts;
                            }
                        }
                    }
                }
            }
        }
        */
        public class Rows
        {
            private int request_no;
            private string module;
            private string day;
            private string start;
            private string end;
            private int semester;
            private int year;
            private int round;
            private string priority;
            private int rooms_no;
            private int students_no;
            private string status;

            public Rows (int request_no, string module, int day, int start, int end, bool semester, int year, int round, bool priority, int rooms_no, int students_no, string status)
            {
                this.request_no = request_no;
                this.module = module;
                switch(day)
                {
                    case 1: this.day = "Monday"; break;
                    case 2: this.day = "Tuesday"; break;
                    case 3: this.day = "Wednesday"; break;
                    case 4: this.day = "Thursday"; break;
                    case 5: this.day = "Friday"; break;
                }
                switch(start)
                {
                    case 1: this.start = "9am"; break;
                    case 2: this.start = "10am"; break;
                    case 3: this.start = "11am"; break;
                    case 4: this.start = "12am"; break;
                    case 5: this.start = "1pm"; break;
                    case 6: this.start = "2pm"; break;
                    case 7: this.start = "3pm"; break;
                    case 8: this.start = "4pm"; break;
                    case 9: this.start = "5pm"; break;
                }
                /*if(this.start < 12)
                {
                    string s = this.start.ToString();
                    //this.start = start.ToString();
                    s = s ="pm";
                }*/
                switch (end)
                {
                    case 1: this.end = "9am"; break;
                    case 2: this.end = "10am"; break;
                    case 3: this.end = "11am"; break;
                    case 4: this.end = "12am"; break;
                    case 5: this.end = "1pm"; break;
                    case 6: this.end = "2pm"; break;
                    case 7: this.end = "3pm"; break;
                    case 8: this.end = "4pm"; break;
                    case 9: this.end = "5pm"; break;
                    case 10: this.end = "6pm"; break;
                }
                if(semester == true)
                {
                    this.semester = 1;
                }
                else
                {
                    this.semester = 2;
                }
                
                //this.semester = semester;
                this.year = year;
                this.round = round;
                if(priority == true)
                {
                    this.priority = "Yes";
                }
                else
                {
                    this.priority = "No";
                }
                this.rooms_no = rooms_no;
                this.students_no = students_no;
                this.status = status;

            }

            public int getReq()
            {
                return request_no;
            }

            public string getMod()
            {
                return module;
            }

            public string getDay()
            {
                return day;
            }

            public string getStart()
            {
                return start;
            }

            public string getEnd()
            {
                return end;
            }

            public int getSem()
            {
                return semester;
            }

            public int getYear()
            {
                return year;
            }

            public int getRound()
            {
                return round;
            }

            public string getPriority()
            {
                return priority;
            }

            public int getRooms()
            {
                return rooms_no;
            }
            
            public int getStudents()
            {
                return students_no;
            }

            public string getStatus()
            {
                return status;
            }
        }


    }
}