using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4_0
{
    public partial class CurrencyConverter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Convert.ServerClick += this.Convert_ServerClick;

            if(this.IsPostBack == false) //if postback is false safe to initialise as this is the first time the page is being created.
            {
                Currency.Items.Add(new ListItem("Euros", "0.85"));
                Currency.Items.Add(new ListItem("Japanese Yen", "110.33"));
                Currency.Items.Add(new ListItem("Canadian Dollar", "1.2"));

        
            }
        }

        protected void Convert_ServerClick(object sender, EventArgs e)
        {
            decimal oldAmount;
            //Attempt the conversion
            bool success = Decimal.TryParse(US.Value, out oldAmount);
            
            //check if succeeded
            if(success)
            {
                //the conversion succeeded
                //retrieve the selected ListItem object by its index number.
                ListItem item = Currency.Items[Currency.SelectedIndex];

                decimal newAmount = oldAmount * Decimal.Parse(item.Value);
                Result.InnerText = oldAmount.ToString() + " U.S. dollars = ";
                Result.InnerText += newAmount.ToString() + " " + item.Text;

                Curren.InnerText = item.Text;
                Result.Style["color"] = "Red";
            }
            else
            {
                //the conversion failed
                Result.InnerText = "The number you typed was not in the " + "correct format. Use only numbers.";
              
            }
          
        }
    }
}