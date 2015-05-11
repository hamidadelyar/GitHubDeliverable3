using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace WebApplication4_0
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static void SendEmail(string title, string text)
        {

            string request = SQLSelect.Select("Users", "*", "1=1", "");
            JavaScriptSerializer jss = new JavaScriptSerializer();
            List<Users> users = jss.Deserialize<List<Users>>(request);

            MailMessage msg = new MailMessage();
            msg.Subject = "New Announcement - " + title;
            msg.From = new MailAddress("lboro.timetabling@gmail.com");
            msg.Body = "Admin has made a new announcement. \n \n Title: " + title + "\n \n Message: " + text;

            for (var i = 0; i < users.Count; i++)
            {
                msg.To.Add(new MailAddress(users[i].Email));
            }
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials = false;
            NetworkCredential nc = new NetworkCredential("lboro.timetabling@gmail.com", "lboroTeam02");
            smtp.Credentials = nc;
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(msg);
        }

        private class Users
        {
            public int User_ID { get; set; }
            public string Username { get; set; }
            public string Password { get; set; }
            public string Forename { get; set; }
            public string Surname { get; set; }
            public string Dept_ID { get; set; }
            public string Email { get; set; }
            public string Salt { get; set; }
    }
    }
}