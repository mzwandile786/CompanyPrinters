using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CompanyPrinters
{
    public partial class MainDashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security check
                if (Session["Role"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                string role = Session["Role"].ToString();

                // Hide everything first (safe default)
                menuUsers.Visible = false;
                menuDesignation.Visible = false;
                menuPrinters.Visible = false;

                // Role-based access
                int designationId = Convert.ToInt32(Session["DesignationID"]);
                if (designationId == 2) // Admin
                {
                    menuPrinters.Visible = true;
                    menuUsers.Visible = true;
                    menuDesignation.Visible = true;
                }
                else if (designationId == 1) // Manager
                {
                    menuPrinters.Visible = true;
                }
                else if (designationId == 3) // Employee
                {
                    menuPrinters.Visible = true;
                }

                // Set logged-in user info label
                if (Session["UserName"] != null)
                {
                    // 1. Get the values from Session safely
                    string userName = Session["UserName"].ToString();
                    string designationName = Session["DesignationName"] != null
                                             ? Session["DesignationName"].ToString()
                                             : "User";

                    // 2. Assign the text (Use the exact ID from your .aspx file)
                    // Note: If you want Bold names, use the line below
                    lblUserInfo.Text = "Welcome " + userName + ", you are login as " + designationName;
                }
            }

            /*// Highlight current page in the menu
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            foreach (RadMenuItem item in RadMenuMain.Items)
            {
                if (item.NavigateUrl != null &&
                    item.NavigateUrl.EndsWith(currentPage, StringComparison.OrdinalIgnoreCase))
                {
                    item.Selected = true;
                }
            }*/
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            foreach (RadMenuItem item in RadMenuMain.Items)
            {
                // Clear previous highlights
                item.CssClass = "";

                if (!string.IsNullOrEmpty(item.NavigateUrl) &&
                    item.NavigateUrl.EndsWith(currentPage, StringComparison.OrdinalIgnoreCase))
                {
                    item.Selected = true;
                    item.CssClass = "active-menu-item"; // Add this custom class
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
