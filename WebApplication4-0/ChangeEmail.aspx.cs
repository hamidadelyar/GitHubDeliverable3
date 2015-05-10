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

namespace WebApplication4_0
{
    public partial class ChangeEmail : System.Web.UI.Page
    {
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
        }

        [System.Web.Services.WebMethod]
        public static bool CheckPassword(string password, string username)
        {
            SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn1.Open();
            string checksalt = "Select Salt from [Users] WHERE Username='" + username + "'";

            SqlCommand comm = new SqlCommand(checksalt, conn1);

            string salt = comm.ExecuteScalar().ToString();

            byte[] data = System.Text.Encoding.ASCII.GetBytes(password + salt);
            data = new System.Security.Cryptography.SHA256Managed().ComputeHash(data);
            String passwordEncr = System.Text.Encoding.ASCII.GetString(data);

            string checkpass = "Select Count(*) from [Users] WHERE Username='" + username + "' AND Password = '" + passwordEncr +"'";

            SqlCommand comm2 = new SqlCommand(checkpass, conn1);

            int count = Convert.ToInt32(comm2.ExecuteScalar());

            if(count != 1)
            {
                conn1.Close();
                return false;
            }

            conn1.Close();
            return true;

        }
        [System.Web.Services.WebMethod]
        public static bool ChangeEmails(string username, string email)
        {
            SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn1.Open();
            string checkfore = "Select Forename from [Users] where Username='" + username + "'";
            string checksur = "Select Surname from [Users] where Username='" + username + "'";
            string checkemail = "Select Email from [Users] where Username='" + username + "'";

            SqlCommand comm2 = new SqlCommand(checkfore, conn1);
            SqlCommand comm3 = new SqlCommand(checksur, conn1);
            SqlCommand comm4 = new SqlCommand(checkemail, conn1);

            string forename = comm2.ExecuteScalar().ToString();
            string surname = comm3.ExecuteScalar().ToString();
            string oldEmail = comm4.ExecuteScalar().ToString();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "UPDATE Users SET Email = @email WHERE Username = @user";
                    command.Parameters.Add("@user", SqlDbType.VarChar, 50).Value = username;
                    command.Parameters.Add("@email", SqlDbType.VarChar, 255).Value = email;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
            }

            MailMessage msg = new MailMessage();
            msg.Subject = "Changed Email.";
            msg.From = new MailAddress("lboro.timetabling@gmail.com");
            msg.Body = "Hello " + forename + " " + surname + ", \n \n Your email preferences have been changed \n \n Thank you";
            msg.To.Add(new MailAddress(email));
            msg.To.Add(new MailAddress(oldEmail));
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials = false;
            NetworkCredential nc = new NetworkCredential("lboro.timetabling@gmail.com", "lboroTeam02");
            smtp.Credentials = nc;
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(msg);

            return true;
        }
    }
}