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

namespace WebApplication4_0
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /* If logged in i.e. Session["LoggedIn"]==true, then automatically navigates to home.aspx (not written yet), instead of asking
             you to login again*/
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            //where "myConnectionString" is the connection string in the web.config file
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open(); //opening connection with the DB
            //prepare query
            //checks to see if user exists in db
            string checkuser = "Select count(*) FROM [Users] WHERE Username = '" + TextboxUsername.Text + "'";  //i.e. cord
            SqlCommand comm = new SqlCommand(checkuser, conn);  //1st argument is query, 2nd argument is connection with DB
            int temp = Convert.ToInt32(comm.ExecuteScalar().ToString());    //returns 1 if found
            // string result = comm.ExecuteScalar().ToString();
            conn.Close();

            if (temp == 1) //this means that the user entered exists in the database
            {

                LoginErrorMessage.InnerHtml = ""; //no error message with successful username


                //check if password matches the username provided
                conn.Open();
                string checkpassword = "Select Password from [Users] where Username='" + TextboxUsername.Text + "'";
                string checksalt = "Select Salt from [Users] where Username='" + TextboxUsername.Text + "'";
                SqlCommand comm2 = new SqlCommand(checkpassword, conn);
                SqlCommand comm3 = new SqlCommand(checksalt, conn);
                    //1st argument is query, 2nd argument is connection with DB
                string password = comm2.ExecuteScalar().ToString();
                string salt = comm3.ExecuteScalar().ToString();
                conn.Close();
                //gets rid of empty space, i.e. "admin ", now equals "admin"
                string username = TextboxUsername.Text.Replace(" ", "");
                    //removes any spaces a user may accidently put after username
                username = username.ToLower();

                byte[] userData = System.Text.Encoding.ASCII.GetBytes(TextboxPassword.Text + salt);
                userData = new System.Security.Cryptography.SHA256Managed().ComputeHash(userData);
                String userEncr = System.Text.Encoding.ASCII.GetString(userData);
                if (userEncr == password)
                {
                    Redirect(username);
                }
                else //if password DOES NOT match the username
                {
                    //#LoginErrorMessage is a <p> tag within the form
                    LoginErrorMessage.InnerHtml = "Username or password is incorrect"; //password incorrect
                }
            }
            else //user does not exist
            {
                //LoginErrorMessage is a <p> tag within the form
                LoginErrorMessage.InnerHtml = "Username or password is incorrect"; //username incorrect
            }


        }

        private void Redirect(string username)
        {
            if (username != "admin") //timetabler view shown
            {
                Session["Username"] = username;
                Session["LoggedIn"] = true;
                if (Request.QueryString["prevPage"] != null)
                // if prev page is set we dont want to go to timetable we want to go to where the user was
                {
                    string url = Request.QueryString["prevPage"]; //gets the prevPage
                    if (FileExists(url))
                    // checks the file exists on the server before attempting to access it
                    {
                        Response.Redirect(url); // redirects to the prevPage the user was on
                    }
                    else
                    {
                        Response.Redirect("Home.aspx");
                        // redirects to timetable if the page wasn't existant
                    }
                }
                else
                {
                    Response.Redirect("Home.aspx");
                    // redirects to timetable if the user didnt come from a previous page
                }
                LoginErrorMessage.InnerHtml = ""; //no error message with successful password
            }
            else //if admin logs in, then they are redirected to a different view of the website
            {
                Session["Username"] = username;
                Session["LoggedIn"] = true;
                if (Request.QueryString["prevPage"] != null)
                // if prev page is set we dont want to go to timetable we want to go to where the user was
                {
                    string url = Request.QueryString["prevPage"]; //gets the prevPage
                    if (FileExists(url))
                    // checks the file exists on the server before attempting to access it
                    {
                        Response.Redirect(url); // redirects to the prevPage the user was on
                    }
                    else
                    {
                        Response.Redirect("Home.aspx");
                        // redirects to admin home if the page wasn't existant
                    }
                }
                else
                {
                    Response.Redirect("AdminFolder/Admin.aspx");
                    // redirects to admin home if the user didnt come from a previous page
                }
                LoginErrorMessage.InnerHtml = ""; //no error message with successful password
            }
        }
        private bool FileExists(string url)
        {
            try
            {
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest; //Creating the HttpWebRequest
                request.Method = "HEAD"; //sets the request method to just get the head
                HttpWebResponse response = request.GetResponse() as HttpWebResponse; // gets the response of the page
                return (response.StatusCode == HttpStatusCode.OK); //Returns TRUE if it loads
            }
            catch
            {
                //Any exception will returns false.
                return false;
            }
        }
    }
}