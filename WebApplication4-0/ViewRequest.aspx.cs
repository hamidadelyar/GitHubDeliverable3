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


namespace WebApplication4_0
{
    public partial class ViewRequest : System.Web.UI.Page
    {
        //static SqlConnection conn;
        //DataTable dt = new DataTable();
        //public String data = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string[] cols = { "Request No.", "Module Code", "Day", "Start Time", "End Time", "Semester", "Year", "Round", "Priority", "No. of Rooms", "No. of Students" };
            DataTable dt = this.GetData("Request_ID, Module_Code, Day, Start_Time, End_Time, Semester, Year, Round, Priority, Number_Rooms, Number_Students", "Requests", "" );

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
                            default: mod = rows1[i]; break;

                        }
                    }

                }
                Rows rows2 = new Rows(req, mod, days, st, ed, sem, y, rnd, pr, rms, stu);
                rows.Add(rows2);
                rows1.Clear();
                //html.Append("</tr>");
            }

            html.Append("<tbody>");
            for(int i=0;i<rows.Count;i++)
            {
                html.Append("<tr>");
                for (int j = 0; j <= 10; j++)
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
                    }
                }
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

        private DataTable GetData(string select, string from, string where)
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
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

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

            public Rows (int request_no, string module, int day, int start, int end, bool semester, int year, int round, bool priority, int rooms_no, int students_no)
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
                if(start >= 9 && start <= 12)
                {
                    this.start = start + "am";
                }
                else
                {
                    this.start = start + "pm";
                }
                /*if(this.start < 12)
                {
                    string s = this.start.ToString();
                    //this.start = start.ToString();
                    s = s ="pm";
                }*/
                if (end >= 10 && end <= 12)
                {
                    this.end = end + "am";
                }
                else
                {
                    this.end = end + "pm";
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
        }


    }
}