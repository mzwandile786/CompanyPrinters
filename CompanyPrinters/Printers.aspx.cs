using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Web.UI;
using System.Web.UI.WebControls;
using CompanyPrinters.DAL;
using CompanyPrinters.BLL;
using static CompanyPrinters.BLL.BusinessLogicLayers;

namespace CompanyPrinters
{
    public partial class Printers : System.Web.UI.Page
    {
        BusinessLogicLayers bll = new BusinessLogicLayers();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPrinterMake();

                // ONLY handle Session check/Redirect here. 
                // DO NOT use rgPrinters.MasterTableView.GetColumn here.
                if (Session["DesignationID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }


        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Session["DesignationID"] != null &&
                Convert.ToInt32(Session["DesignationID"]) == 3)
            {
                // 1️⃣ Hide bulk delete button
                if (btnDeleteSelected != null)
                    btnDeleteSelected.Visible = false;

                // 2️⃣ Hide DELETE column
                GridColumn deleteCol =
                    rgPrinters.MasterTableView.GetColumnSafe("DeleteColumn");
                if (deleteCol != null)
                    deleteCol.Visible = false;

                // 3️⃣ Hide CHECKBOX (Select) column
                GridColumn selectCol =
                    rgPrinters.MasterTableView.GetColumnSafe("SelectColumn");
                if (selectCol != null)
                    selectCol.Visible = false;

                // ❗ DO NOT hide EditCommandColumn
                // Add + Edit stay visible ✔
            }
        }

        private void LoadPrinterMake()
        {
            try
            {
                // 1. Instantiate the BLL
                PrinterBLL bll = new PrinterBLL();

                // 2. Call the BLL method to get the data
                DataTable dt = bll.GetPrinterMakes();

                // 3. Bind the data to the dropdown
                ddlPrinterMake.DataSource = dt;
                ddlPrinterMake.DataTextField = "PrinterMakeName";
                ddlPrinterMake.DataValueField = "PrinterMakeID";
                ddlPrinterMake.DataBind();

                // 4. Insert the default "All Printers" option
                ddlPrinterMake.Items.Insert(0, new RadComboBoxItem("-- All Printers --", ""));
            }
            catch (Exception ex)
            {
                // Log error and notify user (e.g., using a label or alert)

            }
        }


        protected void rgPrinters_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            PrinterBLL bll = new PrinterBLL();

            // Check if filters are empty
            bool isFilterEmpty = string.IsNullOrEmpty(ddlPrinterMake.SelectedValue)
                                 && !dpFromDate.SelectedDate.HasValue
                                 && !dpToDate.SelectedDate.HasValue;

            if (isFilterEmpty)
            {
                // No filters? Get everything
                rgPrinters.DataSource = bll.GetPrinters();
            }
            else
            {
                // Filters exist? Get filtered data
                int? makeId = !string.IsNullOrEmpty(ddlPrinterMake.SelectedValue)
                              ? (int?)int.Parse(ddlPrinterMake.SelectedValue) : null;

                rgPrinters.DataSource = bll.SearchPrinters(makeId, dpFromDate.SelectedDate, dpToDate.SelectedDate);
            }
        }
       


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Gather inputs from UI controls
                int? printerMakeId = !string.IsNullOrEmpty(ddlPrinterMake.SelectedValue)
                                     ? (int?)int.Parse(ddlPrinterMake.SelectedValue)
                                     : null;

                DateTime? fromDate = dpFromDate.SelectedDate;
                DateTime? toDate = dpToDate.SelectedDate;

                // 2. Call the BLL (Logic and Date handling happen inside the BLL)
                PrinterBLL bll = new PrinterBLL();
                DataTable dt = bll.SearchPrinters(printerMakeId, fromDate, toDate);

                // 3. Bind to Grid
                rgPrinters.DataSource = dt;
                rgPrinters.Rebind();
            }
            catch (Exception ex)
            {
                // Handle error (e.g., show a message to the user)

            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            // 1. Reset UI Controls
            ddlPrinterMake.ClearSelection();
            // Ensure the "All Printers" item is selected again if needed
            if (ddlPrinterMake.Items.Count > 0) ddlPrinterMake.SelectedIndex = 0;

            dpFromDate.Clear();
            dpToDate.Clear();

            // 2. Clear your local variable if you are using one
            //  printersData = null;

            // 3. Rebind the grid. This triggers rgPrinters_NeedDataSource
            rgPrinters.Rebind();
        }

        protected void rgPrinters_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditFormItem item = e.Item as GridEditFormItem;
            if (item == null) { e.Canceled = true; return; }

            TextBox txtPrinterName = item.FindControl("txtPrinterName") as TextBox;
            TextBox txtFolder = item.FindControl("txtFolderToMonitor") as TextBox;
            TextBox txtOutputType = item.FindControl("txtOutputType") as TextBox;
            TextBox txtFileOutput = item.FindControl("txtFileOutput") as TextBox;
            CheckBox chkActive = item.FindControl("chkActive") as CheckBox;
            RadComboBox ddlMake = item.FindControl("ddlPrinterMake") as RadComboBox;

            if (ddlMake == null || string.IsNullOrEmpty(ddlMake.SelectedValue))
            {
                rnError.Text = "Please select Printer Make.";
                rnError.Show();
                e.Canceled = true;
                return;
            }

            try
            {
                int makeId = int.Parse(ddlMake.SelectedValue);

                bll.InsertPrinterBusiness(
                    txtPrinterName.Text.Trim(),
                    txtFolder.Text.Trim(),
                    txtOutputType.Text.Trim(),
                    txtFileOutput.Text.Trim(),
                    chkActive.Checked,
                    makeId
                );

                e.Canceled = true;

                rnSuccess.Text = "Printer added successfully!";
                rnSuccess.Show();

                // 🔥 CLEAR CLIENT FILTERS (IMPORTANT FOR RAD AJAX)
                ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "clearFilters",
                    @"
            function clearFiltersClient() {

                var fromDate = $find('" + dpFromDate.ClientID + @"');
                if (fromDate) fromDate.clear();

                var toDate = $find('" + dpToDate.ClientID + @"');
                if (toDate) toDate.clear();

                var ddl = $find('" + ddlPrinterMake.ClientID + @"');
                if (ddl) ddl.clearSelection();

                var grid = $find('" + rgPrinters.ClientID + @"');
                if (grid) {
                    grid.get_masterTableView().clearFilter();
                }
            }
            clearFiltersClient();
            ",
                    true
                );

                rgPrinters.Rebind();
            }
            catch (Exception ex)
            {
                rnError.Text = ex.Message;
                rnError.Show();
                e.Canceled = true;
            }
        }

        protected void rgPrinters_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem editItem && editItem.IsInEditMode)
            {
                RadComboBox ddlMake = editItem.FindControl("ddlPrinterMake") as RadComboBox;
                DropDownList ddlOutputType = editItem.FindControl("ddlOutputType") as DropDownList;

                if (ddlMake != null && ddlMake.Items.Count == 0)
                {
                    DALclass dal = new DALclass();

                    ddlMake.DataSource = dal.GetPrinterMakes();
                    ddlMake.DataBind();
                    ddlMake.Items.Insert(0, new RadComboBoxItem("-- Select Printer Make --", ""));

                    if (!editItem.OwnerTableView.IsItemInserted)
                    {
                        var drv = editItem.DataItem as DataRowView;
                        if (drv != null)
                            ddlMake.SelectedValue = drv["PrinterMakeID"].ToString();
                    }
                }


            }

        }


        protected void cvPrinterMake_ServerValidate(object source, ServerValidateEventArgs args)
        {
            GridEditFormItem item = (source as CustomValidator)?.NamingContainer as GridEditFormItem;
            RadComboBox ddl = item?.FindControl("ddlPrinterMake") as RadComboBox;

            args.IsValid = ddl != null && !string.IsNullOrWhiteSpace(ddl.SelectedValue);
        }

        protected void rgPrinters_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditFormItem item = e.Item as GridEditFormItem;

            TextBox txtName = item.FindControl("txtPrinterName") as TextBox;
            TextBox txtFolder = item.FindControl("txtFolderToMonitor") as TextBox;
            TextBox txtOutput = item.FindControl("txtOutputType") as TextBox;
            TextBox txtFile = item.FindControl("txtFileOutput") as TextBox;
            CheckBox chkActive = item.FindControl("chkActive") as CheckBox;
            RadComboBox ddlMake = item.FindControl("ddlPrinterMake") as RadComboBox;

            if (string.IsNullOrWhiteSpace(ddlMake.SelectedValue))
                throw new ApplicationException("Printer Make is required.");

            int printerId = Convert.ToInt32(item.GetDataKeyValue("EngenPrintersID"));

            bll.UpdatePrinterBusiness(
                printerId,
                txtName.Text,
                txtFolder.Text,
                txtOutput.Text,
                txtFile.Text,
                chkActive.Checked,
                int.Parse(ddlMake.SelectedValue)
            );

            rgPrinters.EditIndexes.Clear();
            rgPrinters.Rebind();

            rnSuccess.Text = "Printer updated successfully!";
            rnSuccess.Show();
        }


        protected void rgPrinters_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            // This method handles the default Grid delete event (if triggered)
            try
            {
                GridEditableItem item = e.Item as GridEditableItem;
                if (item != null)
                {
                    int printerId = Convert.ToInt32(item.GetDataKeyValue("EngenPrintersID"));

                    DALclass dal = new DALclass();
                    dal.DeletePrinter(printerId);

                    rnSuccess.Text = "Printer deleted successfully!";
                    rnSuccess.Show();
                }
            }
            catch (Exception ex)
            {
                rnError.Text = "Error: " + ex.Message;
                rnError.Show();
            }
            finally
            {
                // ALWAYS cancel and rebind to stop the loading hang
                e.Canceled = true;
                rgPrinters.Rebind();
            }
        }



        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            DALclass dal = new DALclass();
            bool anySelected = false;

            foreach (GridDataItem item in rgPrinters.SelectedItems)
            {
                int printerId = (int)item.GetDataKeyValue("EngenPrintersID");
                dal.DeletePrinter(printerId);
                anySelected = true;
            }

            if (!anySelected)
            {
                rnError.Text = "Please select at least one printer to delete.";
                rnError.Show();
                return;
            }

            rnSuccess.Text = "Selected printers deleted successfully.";
            rnSuccess.Show();

            rgPrinters.Rebind();
        }


        protected void rgPrinters_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                GridEditFormItem editForm = (GridEditFormItem)e.Item;

                // Find the Update/Insert button
                Button btnSave = editForm.FindControl("UpdateButton") as Button;
                if (btnSave == null) btnSave = editForm.FindControl("PerformInsertButton") as Button;

                // Find the Cancel button
                Button btnCancel = editForm.FindControl("CancelButton") as Button;

                // Directly injecting the class and a style attribute to force the change
                if (btnSave != null)
                {
                    btnSave.CssClass = "btn btn-success printer-btn-custom";
                    btnSave.Attributes.Add("style", "background-color: #28a745 !important; color: white !important;");
                }

                if (btnCancel != null)
                {
                    btnCancel.CssClass = "btn btn-danger printer-btn-custom";
                    btnCancel.Attributes.Add("style", "background-color: #dc3545 !important; color: white !important;");
                }
            }
        }

        protected void btnAddPrinter_Click(object sender, EventArgs e)
        {
            // This tells the RadGrid to ignore the data rows and open the Template defined in EditFormSettings
            rgPrinters.MasterTableView.IsItemInserted = true;

            // This re-renders the grid so the PopUp actually appears on the screen
            rgPrinters.Rebind();
        }
        protected void rgPrinters_ItemCommand(object sender, GridCommandEventArgs e)
        {
            // ============================================================
            // 1. CUSTOM DELETE (Triggered by LinkButton CommandName="DeleteCustom")
            // ============================================================
            if (e.CommandName == "DeleteCustom")
            {
                try
                {
                    // Get ID directly from CommandArgument
                    int printerId = Convert.ToInt32(e.CommandArgument);

                    DALclass dal = new DALclass();
                    dal.DeletePrinter(printerId);

                    rnSuccess.Text = "Printer deleted successfully!";
                    rnSuccess.Show();

                    // Refresh the grid and stop any loading state
                    rgPrinters.Rebind();
                }
                catch (Exception ex)
                {
                    rnError.Text = "Error deleting printer: " + ex.Message;
                    rnError.Show();
                }
            }

            // ============================================================
            // 2. CLEAR FORM logic
            // ============================================================
            if (e.CommandName == "ClearForm")
            {
                GridEditFormItem item = e.Item as GridEditFormItem;
                if (item != null)
                {
                    TextBox txtPrinterName = item.FindControl("txtPrinterName") as TextBox;
                    TextBox txtFolder = item.FindControl("txtFolderToMonitor") as TextBox;
                    TextBox txtOutputType = item.FindControl("txtOutputType") as TextBox;
                    TextBox txtFileOutput = item.FindControl("txtFileOutput") as TextBox;
                    CheckBox chkActive = item.FindControl("chkActive") as CheckBox;
                    RadComboBox ddlMake = item.FindControl("ddlPrinterMake") as RadComboBox;

                    if (txtPrinterName != null) txtPrinterName.Text = string.Empty;
                    if (txtFolder != null) txtFolder.Text = string.Empty;
                    if (txtOutputType != null) txtOutputType.Text = string.Empty;
                    if (txtFileOutput != null) txtFileOutput.Text = string.Empty;
                    if (chkActive != null) chkActive.Checked = false;

                    if (ddlMake != null)
                    {
                        ddlMake.ClearSelection();
                        if (ddlMake.Items.Count > 0) ddlMake.SelectedIndex = 0;
                    }

                    e.Canceled = true;
                }
            }
        }
    }
}