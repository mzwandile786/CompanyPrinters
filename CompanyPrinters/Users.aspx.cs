using System;
using System.Data;
using Telerik.Web.UI;
using CompanyPrinters.BLL;
using System.Web.UI.WebControls;
using System.Web.UI;


namespace CompanyPrinters
{
    public partial class Users : System.Web.UI.Page
    {
        UserBLL userBLL = new UserBLL();
        DesignationBLL designationBLL = new DesignationBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // LoadSearchDesignations();   // Load the filter dropdown
                //  rgUsers.Rebind();           // Load users into the grid
                LoadSearchDesignations();   // Load the filter dropdown

                // Make sure the grid has a DataSource
                rgUsers.DataSource = userBLL.GetUsers();
                rgUsers.DataBind();
            }
        }



        protected void rgUsers_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            int? designationId = null;
            int parsedId;

            if (int.TryParse(ddlSearchDesignation.SelectedValue, out parsedId) && parsedId > 0)
            {
                designationId = parsedId;
            }

            // Always return the full DataTable if designationId is null
            rgUsers.DataSource = designationId.HasValue
                ? userBLL.GetUsersByDesignation(designationId)
                : userBLL.GetUsers(); // make sure this DataTable includes UserID
        }

        protected void rgUsers_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditFormItem item = e.Item as GridEditFormItem;
            if (item == null)
            {
                e.Canceled = true;
                return;
            }

            // Find controls by ID (matching single FormTemplate)
            TextBox txtFirstName = item.FindControl("txtFirstName") as TextBox;
            TextBox txtLastName = item.FindControl("txtLastName") as TextBox;
            TextBox txtEmail = item.FindControl("txtEmail") as TextBox;
            TextBox txtUserName = item.FindControl("txtUserName") as TextBox;
            TextBox txtPassword = item.FindControl("txtPassword") as TextBox;
            DropDownList ddlDesignation = item.FindControl("ddlDesignation") as DropDownList;

            // Safety check
            if (txtFirstName == null || txtLastName == null || txtEmail == null ||
                txtUserName == null || txtPassword == null || ddlDesignation == null)
            {
                rnError.Text = "Form controls not found.";
                rnError.Show();
                e.Canceled = true;
                return;
            }

            // Check designation
            if (string.IsNullOrWhiteSpace(ddlDesignation.SelectedValue))
            {
                rnError.Text = "Please select a designation.";
                rnError.Show();
                e.Canceled = true;
                return;
            }

            try
            {
                int designationId = int.Parse(ddlDesignation.SelectedValue);

                // Call BLL to insert
                userBLL.InsertUser(
                    txtFirstName.Text.Trim(),
                    txtLastName.Text.Trim(),
                    txtEmail.Text.Trim(),
                    txtUserName.Text.Trim(),
                    txtPassword.Text.Trim(),
                    designationId
                );

                e.Canceled = true; // stop default insert
                rnSuccess.Text = "User added successfully!";
                rnSuccess.Show();

                rgUsers.Rebind(); // refresh grid
            }
            catch (Exception ex)
            {
                rnError.Text = "Failed to add user: " + ex.Message;
                rnError.Show();
                e.Canceled = true;
            }
        }

        protected void rgUsers_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditFormItem item = e.Item as GridEditFormItem;
            if (item == null)
            {
                e.Canceled = true;
                return;
            }

            // Find controls by ID (single FormTemplate)
            TextBox txtFirstName = item.FindControl("txtFirstName") as TextBox;
            TextBox txtLastName = item.FindControl("txtLastName") as TextBox;
            TextBox txtEmail = item.FindControl("txtEmail") as TextBox;
            TextBox txtUserName = item.FindControl("txtUserName") as TextBox;
            TextBox txtPassword = item.FindControl("txtPassword") as TextBox;
            DropDownList ddlDesignation = item.FindControl("ddlDesignation") as DropDownList;

            // Safety check
            if (txtFirstName == null || txtLastName == null || txtEmail == null ||
                txtUserName == null || txtPassword == null || ddlDesignation == null)
            {
                rnError.Text = "Form controls not found.";
                rnError.Show();
                e.Canceled = true;
                return;
            }

            // Check designation
            if (string.IsNullOrWhiteSpace(ddlDesignation.SelectedValue))
            {
                rnError.Text = "Please select a designation.";
                rnError.Show();
                e.Canceled = true;
                return;
            }

            try
            {
                int designationId = int.Parse(ddlDesignation.SelectedValue);

                // Get UserID from DataKey
                int userId = Convert.ToInt32(item.GetDataKeyValue("UserID"));

                // Call BLL to update
                userBLL.EditUser(
                    userId,
                    txtFirstName.Text.Trim(),
                    txtLastName.Text.Trim(),
                    txtEmail.Text.Trim(),
                    txtUserName.Text.Trim(),
                    txtPassword.Text.Trim(),
                    designationId
                );

                e.Canceled = true; // stop default update
                rnSuccess.Text = "User updated successfully!";
                rnSuccess.Show();

                rgUsers.Rebind(); // refresh grid
            }
            catch (Exception ex)
            {
                rnError.Text = "Failed to update user: " + ex.Message;
                rnError.Show();
                e.Canceled = true;
            }
        }

        protected void rgUsers_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                int userId =
                    Convert.ToInt32((e.Item as GridDataItem).GetDataKeyValue("UserID"));

                userBLL.DeleteUser(userId);

                ShowSuccess("User deleted successfully!");
            }
            catch (Exception)
            {
                ShowError("Failed to delete user.");
            }
        }

        protected void rgUsers_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCustom")
            {
                try
                {
                    int userId = Convert.ToInt32(e.CommandArgument);

                    // ✅ Use SAME BLL as DeleteCommand
                    userBLL.DeleteUser(userId);

                    ShowSuccess("User deleted successfully!");

                    rgUsers.Rebind();
                }
                catch (Exception)
                {
                    ShowError("Failed to delete user.");
                }
            }
        }


        protected void rgUsers_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem editItem && editItem.IsInEditMode)
            {
                // Update button text
                Button btnUpdate = editItem.FindControl("btnSave") as Button;
                if (btnUpdate != null)
                {
                    btnUpdate.Text = editItem.OwnerTableView.IsItemInserted ? "Add User" : "Update User";
                }

                // Bind controls
                TextBox txtFirstName = editItem.FindControl("txtFirstName") as TextBox;
                TextBox txtLastName = editItem.FindControl("txtLastName") as TextBox;
                TextBox txtEmail = editItem.FindControl("txtEmail") as TextBox;
                TextBox txtUserName = editItem.FindControl("txtUserName") as TextBox;
                TextBox txtPassword = editItem.FindControl("txtPassword") as TextBox;
                TextBox txtConfirmPassword = editItem.FindControl("txtConfirmPassword") as TextBox;
                DropDownList ddlDesignation = editItem.FindControl("ddlDesignation") as DropDownList;

                // Bind Designation dropdown safely
                if (ddlDesignation != null)
                {
                    ddlDesignation.DataSource = designationBLL.GetDesignations();
                    ddlDesignation.DataTextField = "DesignationName";
                    ddlDesignation.DataValueField = "DesignationID";
                    ddlDesignation.DataBind();
                    ddlDesignation.Items.Insert(0, new ListItem("-- Select Designation --", ""));
                }

                // Bind TextBoxes only if editing (UPDATE)
                if (!editItem.OwnerTableView.IsItemInserted)
                {
                    DataRowView data = editItem.DataItem as DataRowView;
                    if (data != null)
                    {
                        if (txtFirstName != null) txtFirstName.Text = data["FirstName"]?.ToString() ?? "";
                        if (txtLastName != null) txtLastName.Text = data["LastName"]?.ToString() ?? "";
                        if (txtEmail != null) txtEmail.Text = data["Email"]?.ToString() ?? "";
                        if (txtUserName != null) txtUserName.Text = data["UserName"]?.ToString() ?? "";

                        // IMPORTANT: Password fields must use Attributes["value"]
                        if (txtPassword != null)
                            txtPassword.Attributes["value"] = data["Password"]?.ToString() ?? "";

                        if (txtConfirmPassword != null)
                            txtConfirmPassword.Attributes["value"] = data["Password"]?.ToString() ?? "";

                        // Select the user's designation
                        if (ddlDesignation != null && data.Row.Table.Columns.Contains("DesignationID"))
                            ddlDesignation.SelectedValue = data["DesignationID"].ToString();
                    }
                }
            }
        }

        private void ShowSuccess(string message)
        {
            rnSuccess.Text = message;
            rnSuccess.Show();
        }

        private void ShowError(string message)
        {
            rnError.Text = message;
            rnError.Show();
        }
        private void LoadSearchDesignations()
        {
            ddlSearchDesignation.DataSource = designationBLL.GetDesignations();
            ddlSearchDesignation.DataTextField = "DesignationName";
            ddlSearchDesignation.DataValueField = "DesignationID";
            ddlSearchDesignation.DataBind();

            ddlSearchDesignation.Items.Insert(0,
                new ListItem("-- Select Designation --", "0"));
        }

        protected void ddlSearchDesignation_SelectedIndexChanged(object sender, EventArgs e)
        {
            int parsedId;
            int? designationId = null;

            if (int.TryParse(ddlSearchDesignation.SelectedValue, out parsedId) && parsedId > 0)
                designationId = parsedId;

            rgUsers.DataSource = userBLL.GetUsersByDesignation(designationId);
            rgUsers.Rebind();
        }



        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            // 1. Reset the dropdown to the first item ("-- All --")
            if (ddlSearchDesignation.Items.Count > 0)
            {
                ddlSearchDesignation.SelectedIndex = 0;
            }

            // 2. Rebind the grid to show all users (no filter)
            rgUsers.Rebind();
        }

        protected void cvUsername_ServerValidate(object source, ServerValidateEventArgs args)
        {
            CustomValidator validator = (CustomValidator)source;
            GridEditableItem item = (GridEditableItem)validator.NamingContainer;

            int? userId = null;

            // Edit mode → allow same username for same user
            if (!item.OwnerTableView.IsItemInserted)
            {
                userId = Convert.ToInt32(item.GetDataKeyValue("UserID"));
            }

            args.IsValid = !userBLL.UsernameExists(args.Value.Trim(), userId);
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            rgUsers.MasterTableView.IsItemInserted = true;
            rgUsers.Rebind();
        } 
    }

 }



   