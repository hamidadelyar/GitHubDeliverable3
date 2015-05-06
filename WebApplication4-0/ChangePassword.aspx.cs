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
    public partial class ChangePassword : System.Web.UI.Page
    {
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

            string checkpass = "Select Count(*) from [Users] WHERE Username='" + username + "' AND Password = '" + passwordEncr + "'";

            SqlCommand comm2 = new SqlCommand(checkpass, conn1);

            int count = Convert.ToInt32(comm2.ExecuteScalar());

            if (count != 1)
            {
                conn1.Close();
                return false;
            }

            conn1.Close();
            return true;

        }
        [System.Web.Services.WebMethod]
        public static bool UpdatePassword(string username, string password)
        {
            SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn1.Open();
            string checksalt = "Select Salt from [Users] where Username='" + username + "'";
            string checkfore = "Select Forename from [Users] where Username='" + username + "'";
            string checksur = "Select Surname from [Users] where Username='" + username + "'";
            string checkEmail = "Select Email from [Users] where Username='" + username + "'";

            SqlCommand comm = new SqlCommand(checksalt, conn1);
            SqlCommand comm2 = new SqlCommand(checkfore, conn1);
            SqlCommand comm3 = new SqlCommand(checksur, conn1);
            SqlCommand comm4 = new SqlCommand(checkEmail, conn1);

            string salt = comm.ExecuteScalar().ToString();
            string forename = comm2.ExecuteScalar().ToString();
            string surname = comm3.ExecuteScalar().ToString();
            string email = comm4.ExecuteScalar().ToString();

            byte[] data = System.Text.Encoding.ASCII.GetBytes(password + salt);
            data = new System.Security.Cryptography.SHA256Managed().ComputeHash(data);
            String passwordEncr = System.Text.Encoding.ASCII.GetString(data);

            conn1.Close();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "UPDATE Users SET Password = @pass WHERE Username = @user";
                    command.Parameters.Add("@user", SqlDbType.VarChar, 50).Value = username;
                    command.Parameters.Add("@pass", SqlDbType.VarChar, 255).Value = passwordEncr;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
            }

            MailMessage msg = new MailMessage();
            msg.Subject = "Your new password.";
            msg.From = new MailAddress("lboro.timetabling@gmail.com");
            msg.Body = "Hello " + forename + " " + surname + ", \n \n Your new password is: " + password + "\n \n Thank you";
            msg.To.Add(new MailAddress(email));
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