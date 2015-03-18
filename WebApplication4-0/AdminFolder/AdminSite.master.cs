using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4_0
{
    public partial class AdminSite : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //no need to write this on every page as it is on master page
            //checks to see if the user has logged in
            //if not logged in, then redirect to login page
            if ((Session["LoggedIn"]) == null || (bool)(Session["LoggedIn"]) == false)  //checks to see if it has been set or not or if it is false
            {   //if not Logged in
                Response.Redirect("~/Default.aspx");
            }

            string username = (string)(Session["username"]);

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
            conn.Open();
            string getForename = "Select Forename from [Users] where Username='" + username + "'";
            SqlCommand comm2 = new SqlCommand(getForename, conn);  //1st argument is query, 2nd argument is connection with DB
            string forename = comm2.ExecuteScalar().ToString();
            string getSurname = "Select Surname from [Users] where Username='" + username + "'";
            SqlCommand comm3 = new SqlCommand(getSurname, conn);  //1st argument is query, 2nd argument is connection with DB
            string surname = comm3.ExecuteScalar().ToString();
            conn.Close();
            LoginDetails.InnerHtml = "Logged in as: " + forename + " " + surname + " (" + username + ")";

        }


        protected void logoutButton_Click(object sender, EventArgs e)
        {
            Session["LoggedIn"] = false;
            Response.Redirect("~/Default.aspx");
        }
    }
}