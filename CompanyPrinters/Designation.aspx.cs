using System;
using System.Web.UI;
using Telerik.Web.UI;
using CompanyPrinters.BLL;

namespace CompanyPrinters
{
    public partial class Designation : System.Web.UI.Page
    {
        DesignationBLL bll = new DesignationBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
        }


        /* =========================================================
           SAFE NOTIFICATION HELPERS (WORKS INSIDE ANY CONTAINER)
        ========================================================= */

        private RadNotification GetNotification(string id)
        {
            return FindControlRecursive(this, id) as RadNotification;
        }

        private Control FindControlRecursive(Control parent, string id)
        {
            if (parent == null) return null;

            if (parent.ID == id)
                return parent;

            foreach (Control child in parent.Controls)
            {
                var found = FindControlRecursive(child, id);
                if (found != null)
                    return found;
            }

            return null;
        }

        private void ShowSuccess(string message)
        {
            var rn = GetNotification("rnSuccess");
            if (rn != null)
            {
                rn.Text = message;
                rn.Show();
            }
        }

        private void ShowError(string message)
        {
            var rn = GetNotification("rnError");
            if (rn != null)
            {
                rn.Text = message;
                rn.Show();
            }
        }

        /* =========================================================
           LOAD DATA
        ========================================================= */

        protected void RadGridDesignation_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGridDesignation.DataSource = bll.GetDesignations();
        }

        /* =========================================================
           INSERT
        ========================================================= */

        protected void RadGridDesignation_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                RadTextBox txtName = (RadTextBox)item.FindControl("txtDesignationName");

                string designationName = txtName?.Text.Trim();

                if (string.IsNullOrEmpty(designationName))
                {
                    ShowError("Designation name is required.");
                    e.Canceled = true;
                    return;
                }

                bll.AddDesignation(designationName);

                ShowSuccess("Designation added successfully.");

                e.Canceled = true;
                RadGridDesignation.Rebind();
            }
            catch
            {
                ShowError("Failed to add designation. Please try again.");
                e.Canceled = true;
            }
        }

        /* =========================================================
           UPDATE
        ========================================================= */

        protected void RadGridDesignation_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem item = (GridEditableItem)e.Item;

                int id = Convert.ToInt32(item.GetDataKeyValue("DesignationID"));

                RadTextBox txtName = (RadTextBox)item.FindControl("txtDesignationName");
                string designationName = txtName?.Text.Trim();

                if (string.IsNullOrEmpty(designationName))
                {
                    ShowError("Designation name is required.");
                    e.Canceled = true;
                    return;
                }

                bll.UpdateDesignation(id, designationName);

                ShowSuccess("Designation updated successfully.");

                e.Canceled = true;
                RadGridDesignation.Rebind();
            }
            catch
            {
                ShowError("Failed to update designation. Please try again.");
                e.Canceled = true;
                RadGridDesignation.MasterTableView.ClearEditItems(); // closes the popup
            }
        }

        /* =========================================================
           DELETE (DEFAULT)
        ========================================================= */

        protected void RadGridDesignation_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            e.Canceled = true;

            try
            {
                GridDataItem item = e.Item as GridDataItem;
                if (item == null)
                    throw new ApplicationException("Invalid row selected.");

                int id = Convert.ToInt32(item.GetDataKeyValue("DesignationID"));

                bll.RemoveDesignation(id);

                ShowSuccess("Designation deleted successfully.");
                RadGridDesignation.Rebind();
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        /* =========================================================
           CUSTOM DELETE BUTTON
        ========================================================= */

        protected void RadGridDesignation_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCustom")
            {
                try
                {
                    int id = Convert.ToInt32(e.CommandArgument);

                    bll.RemoveDesignation(id);

                    ShowSuccess("Deleted successfully!");
                    RadGridDesignation.Rebind();
                }
                catch (Exception ex)
                {
                    ShowError("Error: " + ex.Message);
                }
            }
        }
    }
}