using System;
using System.Data;
using System.Web.UI.WebControls;
using CompanyPrinters.BLL;

namespace CompanyPrinters
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                //  Call BUSINESS LOGIC
                BusinessLogicLayers loginBLL = new BusinessLogicLayers(); // BLL4110
                DataTable dt = loginBLL.Login(
                    txtUsername.Text.Trim(),
                    txtPassword.Text.Trim()
                );

                if (dt != null && dt.Rows.Count > 0)
                {
                    int designationId = Convert.ToInt32(dt.Rows[0]["DesignationID"]);

                  

                    Session["UserID"] = dt.Rows[0]["UserID"];
                    Session["UserName"] = dt.Rows[0]["UserName"];
                    Session["DesignationID"] = designationId;
                    Session["DesignationName"] = dt.Rows[0]["DesignationName"].ToString();


                    // Redirect based on role
                    switch (designationId)
                    {
                        case 1: // Manager
                            Session["Role"] = "Manager";
                            Response.Redirect("Printers.aspx");
                            break;

                        case 2: // Admin
                            Session["Role"] = "System Administrator";
                            Response.Redirect("Printers.aspx");
                            break;

                        case 3: // Level 1 Employee
                            Session["Role"] = "Level 1 Employee";
                            Response.Redirect("Printers.aspx");
                            break;

                        default:
                            lblMessage.Text = "User role not recognised.";
                            break;
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                }
            }
            catch (Exception)
            {
                lblMessage.Text = "An error occurred. Please try again later.";
            }
        }
    }
}








