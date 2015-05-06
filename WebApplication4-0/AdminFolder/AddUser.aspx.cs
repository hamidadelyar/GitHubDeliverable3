using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Web.Script.Serialization;

namespace WebApplication4_0.AdminFolder
{
    public partial class AddUser : System.Web.UI.Page
    {
        public string departments = "";
        public string users = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["LoggedIn"] != null)
            {
                if(((string) Session["username"]) != "admin")
                {
                    System.Diagnostics.Debug.WriteLine(Session["username"]);
                    Response.Write("<script>alert('You do not have permission to view this page.');</script>");
                    Response.Redirect("../Timetable.aspx");
                }
                departments = SQLSelect.Select("Departments", "Dept_ID + ' - ' + Dept_Name AS Dept_ID", "1=1", "");
                users = SQLSelect.Select("Users", "Username", "1=1", "");
            }
        }
        [System.Web.Services.WebMethod]
        public static bool InsertUser(string username, string password, string forename, string surname, string email, string dept)
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopwxyz";
            var random = new Random();
            var salt = new string(
                     Enumerable.Repeat(chars, 8)
                        .Select(s => s[random.Next(s.Length)])
                        .ToArray());
            byte[] data = System.Text.Encoding.ASCII.GetBytes(password+salt);
            data = new System.Security.Cryptography.SHA256Managed().ComputeHash(data);
            String passwordEncr = System.Text.Encoding.ASCII.GetString(data);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = conn;
                    command.CommandType = CommandType.Text;
                    command.CommandText = "INSERT INTO Users (Username, Password, Forename, Surname, Dept_ID, Email, Salt) VALUES (@user, @pass, @fore, @sur, @dept, @email, @salt)";
                    command.Parameters.Add("@user", SqlDbType.VarChar, 50).Value = username;
                    command.Parameters.Add("@pass", SqlDbType.VarChar, 255).Value = passwordEncr;
                    command.Parameters.Add("@fore", SqlDbType.VarChar, 50).Value = forename;
                    command.Parameters.Add("@sur", SqlDbType.VarChar, 50).Value = surname;
                    command.Parameters.Add("@dept", SqlDbType.Char, 2).Value = dept;
                    command.Parameters.Add("@email", SqlDbType.VarChar, 255).Value = email;
                    command.Parameters.Add("@salt", SqlDbType.VarChar, 255).Value = salt;
                    conn.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    conn.Close();
                }
            }
            MailMessage msg = new MailMessage();
            msg.Subject = "Your new account.";
            msg.From = new MailAddress("lboro.timetabling@gmail.com");
            msg.Body = "Welcome " + forename + " " + surname + ", \n Your new account is ready. \n \n Username: " + username + "\n Password: " + password + "\n \n Thank you";
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