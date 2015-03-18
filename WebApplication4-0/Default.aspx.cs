using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

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

                LoginErrorMessage.InnerHtml = "";   //no error message with successful username

          
                //check if password matches the username provided
                conn.Open();
                string checkpassword = "Select Password from [Users] where Username='" + TextboxUsername.Text + "'";
                SqlCommand comm2 = new SqlCommand(checkpassword, conn);  //1st argument is query, 2nd argument is connection with DB
                string password = comm2.ExecuteScalar().ToString();
                conn.Close();
                //gets rid of empty space, i.e. "admin ", now equals "admin"
                string username = TextboxUsername.Text.Replace(" ", ""); //removes any spaces a user may accidently put after username
                
                if (password == TextboxPassword.Text)   //if password DOES match the username entered
                {
                    
                    if (username != "admin")    //timetabler view shown
                    {
                        Session["Username"] = username;
                        Session["LoggedIn"] = true;
                        Response.Redirect("Timetable.aspx");
                        LoginErrorMessage.InnerHtml = "";   //no error message with successful password
                    }
                    else //if admin logs in, then they are redirected to a different view of the website
                    {
                        Session["Username"] = username;
                        Session["LoggedIn"] = true;
                        Response.Redirect("AdminFolder/Admin.aspx");
                        LoginErrorMessage.InnerHtml = "";   //no error message with successful password
                    }
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
                LoginErrorMessage.InnerHtml = "Username or password is incorrect";  //username incorrect
            }


        }


    }
}