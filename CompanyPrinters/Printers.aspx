<%@ Page Language="C#"
    MasterPageFile="~/MainDashboard.master"
    AutoEventWireup="true"
    CodeBehind="Printers.aspx.cs"
    Inherits="CompanyPrinters.Printers" %>

<%@ Register Assembly="Telerik.Web.UI"
    Namespace="Telerik.Web.UI"
    TagPrefix="telerik" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/Printers.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" />

    <div class="page-container">

        <!-- PAGE TITLE -->
        <div class="page-title">
    <h2>Printers Management</h2>
</div>


        <!-- FILTER PANEL -->
        <div class="filter-box">

            <!-- Printer Name -->
            <div class="filter-row">
                <label class="filter-label">Printer Make:</label>
                <telerik:RadComboBox ID="ddlPrinterMake" runat="server"
                    EmptyMessage="Select Printer Make" AllowCustomText="false" />
            </div>

            <!-- From Date -->
            <div class="filter-row">
                <label class="filter-label">From Date:</label>
                <telerik:RadDatePicker ID="dpFromDate" runat="server" Width="250px" />
            </div>

            <!-- To Date -->
            <div class="filter-row">
                <label class="filter-label">To Date:</label>
                <telerik:RadDatePicker ID="dpToDate" runat="server" Width="250px" />
            </div>

            <!-- Buttons -->
            <div class="filter-row justify-content-center">
     <telerik:RadButton 
    ID="btnDeleteSelected" 
    runat="server" 
    Text="Delete Selected" 
    CssClass="btn btn-danger-delete" 
    AutoPostBack="true" 
    OnClick="btnDeleteSelected_Click"
    OnClientClicking="confirmBulkDelete" />

            <asp:LinkButton ID="btnAddPrinter" 
                runat="server" 
                CssClass="btn-add-user" 
                OnClick="btnAddPrinter_Click" 
                CausesValidation="false" 
                ClientIDMode="Static">
                 Add New Printer
            </asp:LinkButton>

            <telerik:RadButton ID="btnSearch" runat="server" Text="Search"
                CssClass="btn btn-primary" OnClick="btnSearch_Click" />

            <telerik:RadButton ID="btnClear" runat="server" Text="Clear"
                CssClass="btn btn-secondary" OnClick="btnClear_Click" />


            </div>
        </div>


        <!-- RADGRID -->
    
     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel">
        <div class="grid-container">
     <div class="grid-wrapper">
     <telerik:RadGrid ID="rgPrinters" runat="server" OnClientLoad="OnClientLoad"
    Skin="WebBlue"
    AllowPaging="True"
    AllowSorting="True"
    PageSize="5"
    AutoGenerateColumns="False"   
    OnNeedDataSource="rgPrinters_NeedDataSource"
    OnInsertCommand="rgPrinters_InsertCommand"
    OnUpdateCommand="rgPrinters_UpdateCommand"
   OnDeleteCommand="rgPrinters_DeleteCommand"
    OnItemDataBound="rgPrinters_ItemDataBound"
    OnItemCommand="rgPrinters_ItemCommand"      
    AllowMultiRowSelection="True" AllowFilteringByColumn="True"  Width="100%"
    EnableViewState="True"
 >
  
<PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="True" HorizontalAlign="Right" />
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
<GroupingSettings CaseSensitive="false" />

          <ClientSettings>
        <Selecting AllowRowSelect="true" />
              <Scrolling AllowScroll="false" />
        <ClientEvents 
            OnRowSelected="handleRowSelection"
            OnRowDeselected="handleRowSelection"
            OnPopUpShowing="OnPopUpShowing" />
    </ClientSettings>

    <MasterTableView
        DataKeyNames="EngenPrintersID,PrinterMakeID" 
        EditMode="PopUp"
        InsertItemDisplay="Top"
        ShowAddNewRecordButton="false"
        CommandItemDisplay="None"  ColumnResizeMode="NextColumn"  >

        
        <EditFormSettings EditFormType="Template" CaptionFormatString="Add / Edit Printer">
    <PopUpSettings Modal="true" Width="700px" Height="500px" />

    <FormTemplate>
        <asp:Panel runat="server" CssClass="printer-popup-form">

            <table style="width:100%; border-spacing:15px;">
                <!-- ================= PRINTER MAKE ================= -->
                <tr>
                    <td class="label">Printer Make</td>
                    <td>
                        <telerik:RadComboBox
                            ID="ddlPrinterMake"
                            runat="server"
                            Width="100%"
                            DataTextField="PrinterMakeName"
                            DataValueField="PrinterMakeID"
                            EmptyMessage="-- Select Printer Make --" />

                        <asp:CustomValidator
                            ID="cvPrinterMake"
                            runat="server"
                            ControlToValidate="ddlPrinterMake"
                            ErrorMessage="Printer Make is required"
                            ForeColor="Red"
                            Display="Dynamic"
                            OnServerValidate="cvPrinterMake_ServerValidate" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Printer Name</td>
                    <td>
                        <asp:TextBox
                            ID="txtPrinterName"
                            runat="server"
                            Width="100%"
                            Text='<%# Bind("PrinterName") %>' />

                        <asp:RequiredFieldValidator
                            runat="server"
                            ControlToValidate="txtPrinterName"
                            ErrorMessage="Printer Name is required"
                            ForeColor="Red"
                            Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Folder To Monitor</td>
                    <td>
                        <asp:TextBox
                            ID="txtFolderToMonitor"
                            runat="server"
                            Width="100%"
                            Text='<%# Bind("FolderToMonitor") %>' />

                        <asp:RequiredFieldValidator
                            runat="server"
                            ControlToValidate="txtFolderToMonitor"
                            ErrorMessage="Folder path is required"
                            ForeColor="Red"
                            Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Output Type</td>
                    <td>
                        <asp:TextBox
                            ID="txtOutputType"
                            runat="server"
                            Width="100%"
                            Text='<%# Bind("OutputType") %>' />

                        <asp:RequiredFieldValidator
                            runat="server"
                            ControlToValidate="txtOutputType"
                            ErrorMessage="Output Type is required"
                            ForeColor="Red"
                            Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td class="label">File Output</td>
                    <td>
                        <asp:TextBox
                            ID="txtFileOutput"
                            runat="server"
                            Width="100%"
                            Text='<%# Bind("FileOutput") %>' />

                        <asp:RequiredFieldValidator
                            runat="server"
                            ControlToValidate="txtFileOutput"
                            ErrorMessage="File Output is required"
                            ForeColor="Red"
                            Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Active</td>
                    <td>
                        <asp:CheckBox
                            ID="chkActive"
                            runat="server"
                            Checked='<%# Bind("Active") %>' />
                    </td>
                </tr>
                <tr runat="server" visible='<%# !Container.OwnerTableView.IsItemInserted %>'>
                    <td class="label">Created</td>
                    <td>
                        <asp:Label
                            ID="lblCreated"
                            runat="server"
                            Text='<%# Eval("CreatedTimeStamp", "{0:MM/dd/yyyy HH:mm}") %>'
                            CssClass="muted-text" />
                    </td>
                </tr>
               <tr>
    <td colspan="2">
        <div class="form-buttons">
            <asp:Button
                ID="btnSave"
                runat="server"
                CssClass="btn-save"
                Text='<%# Container.OwnerTableView.IsItemInserted ? "Add Printer" : "Update Printer" %>'
                CommandName='<%# Container.OwnerTableView.IsItemInserted ? "PerformInsert" : "Update" %>' />

           
        </div>
            </div>
     
      
    </td>
</tr>

            </table>
        </asp:Panel>
    </FormTemplate>
</EditFormSettings>
      
  
       <Columns>
    <telerik:GridClientSelectColumn UniqueName="SelectColumn" HeaderStyle-Width="20px" />

    <telerik:GridBoundColumn HeaderText="Printer Make" DataField="PrinterMakeName" UniqueName="PrinterMakeName" HeaderStyle-Width="70px" FilterControlWidth="70px"  CurrentFilterFunction="Contains" />
    <telerik:GridBoundColumn HeaderText="Printer Name" DataField="PrinterName" UniqueName="PrinterName" HeaderStyle-Width="70px" FilterControlWidth="70px"/>
    <telerik:GridBoundColumn HeaderText="Folder To Monitor" DataField="FolderToMonitor" UniqueName="FolderToMonitor" HeaderStyle-Width="180px" FilterControlWidth="180px" />
    <telerik:GridBoundColumn HeaderText="Output Type" DataField="OutputType" UniqueName="OutputType" HeaderStyle-Width="100px"  AllowFiltering="true" FilterControlWidth="80px" />
    <telerik:GridBoundColumn HeaderText="File Output" DataField="FileOutput" UniqueName="FileOutput" HeaderStyle-Width="180px"  AllowFiltering="true"  FilterControlWidth="180px" />

    <telerik:GridTemplateColumn HeaderText="Active" HeaderStyle-Width="30px"  AllowFiltering="false" >
        <ItemTemplate>
            <asp:CheckBox runat="server" Checked='<%# Eval("Active") %>' Enabled="false" />
        </ItemTemplate>
    </telerik:GridTemplateColumn>

           <telerik:GridBoundColumn 
    HeaderText="Date Created" 
    DataField="CreatedTimeStamp" 
    UniqueName="CreatedTimeStamp" 
    HeaderStyle-Width="100px" 
    DataFormatString="{0:MM/dd/yyyy HH:mm}" 
    ReadOnly="true"  AllowFiltering="true" FilterControlWidth="100px" />

    <telerik:GridEditCommandColumn HeaderText="Edit" HeaderStyle-Width="30px" UniqueName="EditCommandColumn" />


   <telerik:GridTemplateColumn 
    HeaderText="Delete" 
    UniqueName="DeleteColumn"
    HeaderStyle-Width="40px" 
    AllowFiltering="false">

    <ItemTemplate>
        <asp:LinkButton ID="btnDeleteCustom"
            runat="server"
            CommandName="DeleteCustom"
            CommandArgument='<%# Eval("EngenPrintersID") %>'
            OnClientClick="return confirmDelete(this);"
          
            CssClass="delete-btn">

            <i class="bi bi-trash-fill"
               style="color:red; font-size:18px;"></i>

        </asp:LinkButton>
    </ItemTemplate>

</telerik:GridTemplateColumn>

</Columns>

    </MasterTableView>
</telerik:RadGrid>
            </div>
         <!-- SUCCESS NOTIFICATION -->
        <telerik:RadNotification ID="rnSuccess" runat="server"
    Position="TopRight"
    AutoCloseDelay="3000"
    Skin="Bootstrap"
    Title="Success" />

<telerik:RadNotification ID="rnError" runat="server"
    Position="TopRight"
    AutoCloseDelay="4000"
    Skin="Bootstrap"
    Title="Error" />    
   </telerik:RadAjaxPanel>
           

        <telerik:RadWindowManager ID="RadWindowManager2" runat="server">
</telerik:RadWindowManager>
       
    </div>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script type="text/javascript">

    function confirmBulkDelete(sender, args) {

        args.set_cancel(true);

        var grid = $find('<%= rgPrinters.ClientID %>');
       if (!grid) return;

       var selectedItems = grid.get_masterTableView().get_selectedItems();

       if (selectedItems.length === 0) {
           alert("Please select at least one printer.");
           return;
       }

       var printerNames = [];

       for (var i = 0; i < selectedItems.length; i++) {

           var cell = selectedItems[i].get_cell("PrinterName");
           if (cell) {
               // Add a bullet before each printer name
               printerNames.push("• " + cell.innerText.trim());
           }
       }

       var message = "Are you sure you want to delete these printers?\n\n";
       message += printerNames.join("\n");

       radconfirm(message, function (confirmed) {
           if (confirmed) {
               __doPostBack(sender.get_uniqueID(), "");
           }
       }, 450, 300, null, "Confirm Bulk Delete");
   }


    function handleRowSelection(sender, args) {
        // Get the grid by its static client ID
        var grid = $find('rgPrinters');
        if (!grid) return;

        var masterTable = grid.get_masterTableView();
        var selectedItems = masterTable.get_selectedItems();

        // Get the Delete button by its static client ID
        var btnDelete = $find('btnDeleteSelected');
        if (!btnDelete) return;

        // Enable the button if at least one item is selected
        btnDelete.set_enabled(selectedItems.length > 0);
    }

    function OnClientLoad(sender, args) { }

    function OnPopUpShowing(sender, args) {
        var popUp = args.get_popUp();
        // Delay centering slightly to ensure the window is fully rendered
        setTimeout(function () {
            popUp.center();
        }, 50);
    }

    function setDefaultPage(sender, args) {
        var grid = $find("rgPrinters");
        var masterTable = grid.get_masterTableView();

        masterTable.set_currentPageIndex(0);
        masterTable.dataBind();
    }

    function confirmDelete(button) {

        if (button.getAttribute("data-confirmed") === "true") {
            button.removeAttribute("data-confirmed");
            return true;
        }

        radconfirm("Are you sure you want to delete this printer?", function (arg) {
            if (arg) {
                button.setAttribute("data-confirmed", "true");
                button.click();
            }
        }, 330, 150, null, "Confirm Delete");

        return false;
    }

    function clearFiltersClient() {

        var fromDate = $find("<%= dpFromDate.ClientID %>");
        if (fromDate) fromDate.clear();

        var toDate = $find("<%= dpToDate.ClientID %>");
    if (toDate) toDate.clear();

        var ddl = $find("<%= ddlPrinterMake.ClientID %>");
        if (ddl) ddl.clearSelection();
    }

</script>
</telerik:RadCodeBlock>

</asp:Content>
