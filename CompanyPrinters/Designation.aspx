<%@ Page Language="C#"
    MasterPageFile="~/MainDashboard.master"
    AutoEventWireup="true"
    CodeBehind="Designation.aspx.cs"
    Inherits="CompanyPrinters.Designation" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/Designation.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   
    <div class="page-title">Designation Management</div>
 
    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel">
    <div class="grid-wrapper">
        <div class="radgrid-container">
            <telerik:RadGrid ID="RadGridDesignation" runat="server"
    AutoGenerateColumns="False"
    AllowPaging="True"
    AllowSorting="True"
    Skin="WebBlue"
    AllowFilteringByColumn="True"
    PageSize="5"
   
    OnNeedDataSource="RadGridDesignation_NeedDataSource"
    OnInsertCommand="RadGridDesignation_InsertCommand"
    OnUpdateCommand="RadGridDesignation_UpdateCommand"
    OnDeleteCommand="RadGridDesignation_DeleteCommand"
    OnItemCommand="RadGridDesignation_ItemCommand"
    EnableViewState="True">

                <ClientSettings>
                    <ClientEvents OnPopUpShowing="OnPopUpShowing" />
                </ClientSettings>

                <MasterTableView DataKeyNames="DesignationID" CommandItemDisplay="Top" EditMode="PopUp">
                    
                    <CommandItemTemplate>
                        <div class="custom-command-bar">
                            <asp:LinkButton ID="InitInsertButton" runat="server" CommandName="InitInsert" CssClass="designation-add-btn">
                                Add New Designation
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>

                      <PagerStyle Mode="NextPrevAndNumeric"
                    Position="Bottom"
                    AlwaysVisible="True"
                    />

                    <%-- CORRECT PLACEMENT OF EDITFORMSETTINGS --%>
                    <EditFormSettings EditFormType="Template" CaptionFormatString="Add/Edit Designation">
                        <PopUpSettings Modal="true" Width="600px" /> 
                        <FormTemplate>
                            <div class="custom-edit-form">
                                <div class="form-row">
                                    <label>Designation Name:</label>
                                    <telerik:RadTextBox ID="txtDesignationName" runat="server" 
                                        Text='<%# Bind("DesignationName") %>' Width="100%" Skin="Bootstrap" 
                                        ValidationGroup="DesignationGroup" />
                                    
                                    <asp:RequiredFieldValidator ID="rfvDesignation" runat="server" 
                                        ControlToValidate="txtDesignationName" ErrorMessage="* Required"
                                        ForeColor="Red" Display="Dynamic" Font-Size="12px"
                                        ValidationGroup="DesignationGroup" />
                                </div>
                                <div class="custom-button-row">
                                    <asp:Button ID="btnUpdate" runat="server" 
                                        Text='<%# (Container is GridEditFormInsertItem) ? "Add Designation" : "Update" %>' 
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' 
                                        CssClass="popup-btn-save" ValidationGroup="DesignationGroup" />

                                   
                                </div>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>

                 <Columns>
    <telerik:GridBoundColumn DataField="DesignationID" HeaderText="ID" ReadOnly="True" Visible="False" />
    <telerik:GridBoundColumn DataField="DesignationName" HeaderText="Designation Name" UniqueName="DesignationName" CurrentFilterFunction="Contains" />

    <%-- 1. ADD THIS BACK FOR THE EDIT ICON --%>
    <telerik:GridEditCommandColumn HeaderText="Edit" HeaderStyle-Width="70px" ButtonType="FontIconButton" />

    <%-- 2. YOUR DELETE COLUMN --%>
    <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="70px" AllowFiltering="false">
        <ItemTemplate>
            <asp:LinkButton ID="btnDeleteCustom" runat="server" 
                CommandName="DeleteCustom" 
                CommandArgument='<%# Eval("DesignationID") %>'
                OnClientClick="return confirmDelete(this);"
                UseSubmitBehavior="false"
                CssClass="delete-btn">
                <i class="bi bi-trash-fill" style="color:red; font-size:18px;"></i>
            </asp:LinkButton>
        </ItemTemplate>
    </telerik:GridTemplateColumn>


</Columns>

                </MasterTableView>

            </telerik:RadGrid>
           
        </div>
    </div>
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
    
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Bootstrap" />

    <script>


        function OnClientLoad(sender, args) { }

        function OnPopUpShowing(sender, args) {
            var popUp = args.get_popUp();
            // Delay centering slightly to ensure the window is fully rendered
            setTimeout(function () {
                popUp.center();
            }, 50);
        }

      
            function clearDesignationForm(btn) {
        var form = btn.closest(".rgEditForm");
            if (!form) return false;

            /* Clear normal inputs */
            form.querySelectorAll("input[type='text']").forEach(function (i) {
                i.value = "";
        });

            /* Clear Telerik RadTextBox */
            if (window.$telerik) {
                $telerik.findControls(form).forEach(function (c) {
                    if (c.set_value) {
                        c.set_value("");
                    }
                });
        }

            /* Clear validation messages */
            if (typeof (Page_Validators) !== "undefined") {
                Page_Validators.forEach(function (v) {
                    v.isvalid = true;
                    if (v.style) v.style.display = "none";
                });
        }

            return false; // ✅ keep popup open
    }

            Sys.Application.add_load(function () {
                document.querySelectorAll(".rgEditForm .popup-btn-cancel").forEach(function (btn) {
                    btn.onclick = function () {
                        return clearDesignationForm(this);
                    };
                });
            });

        function setDefaultPage(sender, args) {
            var grid = $find("RadGridDesignation");
            var masterTable = grid.get_masterTableView();

            masterTable.set_currentPageIndex(0);
            masterTable.dataBind();
        }

        function confirmDelete(button) {
            // If the hidden flag is set, let the postback happen
            if (button.getAttribute("data-confirmed") === "true") {
                button.setAttribute("data-confirmed", "false");
                return true;
            }

            // Use radconfirm (ensure RadWindowManager is on the page)
            radconfirm("Are you sure you want to delete this record?", function (arg) {
                if (arg) {
                    button.setAttribute("data-confirmed", "true");
                    // This triggers the button click again, but this time data-confirmed is true
                    button.click();
                }
            }, 330, 150, null, "Confirm Delete");

            return false; // Stop the first click
        } 
        
    </script>
</asp:Content>