<%@ Page Language="C#"
    MasterPageFile="~/MainDashboard.master"
    AutoEventWireup="true"
    CodeBehind="Users.aspx.cs"
    Inherits="CompanyPrinters.Users" %>

<%@ Register Assembly="Telerik.Web.UI"
    Namespace="Telerik.Web.UI"
    TagPrefix="telerik" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/Users.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">
    <div class="page-header">
    <h2 class="Tittle">Users Management</h2>
</div>
<div class="search-section">
    <div class="filter-wrapper">
        <div class="filter-container">
            <!-- Row for Label + Dropdown -->
            <div class="filter-row">
                <asp:Label ID="lblSearchDesignation"
                    runat="server"
                    Text="Filter by Designation"
                    CssClass="filter-label" />

                <asp:DropDownList ID="ddlSearchDesignation"
                    runat="server"
                    AutoPostBack="true"
                    CssClass="dropdown-search"
                    OnSelectedIndexChanged="ddlSearchDesignation_SelectedIndexChanged" />
            </div>

            <!-- Row for Buttons -->
            <div class="button-row">
                <asp:LinkButton ID="btnAddUser"
                    runat="server"
                    CssClass="btn-add-user"
                    OnClick="btnAddUser_Click">
                     Add New User
                </asp:LinkButton>

                <asp:Button ID="btnClearFilter"
                    runat="server"
                    Text="Clear"
                    CssClass="btn-clear"
                    OnClick="btnClearFilter_Click" />
            </div>
        </div>
    </div>
</div>

     <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel">
    <div class="grid-container">
        <div class="radgrid-wrapper">
            <telerik:RadGrid ID="rgUsers" runat="server" OnClientLoad="OnClientLoad"
    AutoGenerateColumns="False"
    AllowSorting="True"
    AllowPaging="True"
    PageSize="5"
    width="100%"
    DataKeyNames="UserID,DesignationID"
    AllowFilteringByColumn="True"
    CssClass="centered-grid"
    OnNeedDataSource="rgUsers_NeedDataSource"
    OnInsertCommand="rgUsers_InsertCommand"
    OnUpdateCommand="rgUsers_UpdateCommand"
    OnDeleteCommand="rgUsers_DeleteCommand"
    OnItemDataBound="rgUsers_ItemDataBound"
    OnItemCommand="rgUsers_ItemCommand"
    Skin="WebBlue"
    EnableViewState="True">

    <ClientSettings>
        <ClientEvents OnPopUpShowing="OnPopUpShowing" />
    </ClientSettings>

    <MasterTableView DataKeyNames="UserID,DesignationID"
                     EditMode="PopUp"
                     InsertItemDisplay="Top"
                     ShowAddNewRecordButton="false"
                     ShowRefreshButton="false"
                     CommandItemDisplay="None"
                     AllowPaging="True"
                     PageSize="10"
         TableLayout="Fixed"
        
                     AllowSorting="True">

        <PagerStyle Mode="NextPrevAndNumeric"
                    Position="Bottom"
                    AlwaysVisible="True"
                    />
        
        <EditFormSettings EditFormType="Template" CaptionFormatString="Add / Edit User">
            <PopUpSettings Modal="true" Width="700px" KeepInScreenBounds="true" ZIndex="9999"/>
            <FormTemplate>
                <asp:Panel runat="server" CssClass="popup-form">
                    <asp:ValidationSummary ID="vsUser" runat="server" ForeColor="Red" 
                        HeaderText="Please fix the following errors:" ShowSummary="true" />

                    <table style="width:100%; border-spacing:15px;">
                        <!-- First Name -->
                        <tr>
                            <td>First Name</td>
                            <td>
                                <asp:TextBox ID="txtFirstName" runat="server" Width="100%" Placeholder="Enter first name" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Last Name -->
                        <tr>
                            <td>Last Name</td>
                            <td>
                                <asp:TextBox ID="txtLastName" runat="server" Placeholder="Enter last name" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Email -->
                        <tr>
                            <td>Email</td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server"  Placeholder="e.g. user@example.com" HeaderStyle-Width="100px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid email format" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Username -->
                        <tr>
                            <td>Username</td>
                            <td>
                                <asp:TextBox ID="txtUserName" runat="server" Placeholder="Choose a unique username" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName" ErrorMessage="Username is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                                <asp:CustomValidator runat="server" ID="cvUsername" ControlToValidate="txtUserName" OnServerValidate="cvUsername_ServerValidate" ErrorMessage="Username already exists" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Password -->
                        <tr>
                            <td>Password</td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"  Placeholder="Enter a secure password"   />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=<>?]).{5,}$" ErrorMessage="Password must be at least 5 characters and include uppercase, lowercase, number, and special character." ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Confirm Password -->
                        <tr>
                            <td>Confirm Password</td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"  Placeholder="Re-enter password"   /> 
                                <asp:RequiredFieldValidator ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="Confirm Password is required" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                                <asp:CompareValidator ControlToValidate="txtConfirmPassword" runat="server" ControlToCompare="txtPassword" Operator="Equal" Type="String" ErrorMessage="Passwords do not match" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Designation -->
                        <tr>
                            <td>Designation</td>
                            <td>
                                <asp:DropDownList ID="ddlDesignation" runat="server" HeaderStyle-Width="100px" />
                                <asp:RequiredFieldValidator ControlToValidate="ddlDesignation" runat="server" InitialValue="" ErrorMessage="Please select a designation" ForeColor="Red" Display="Dynamic" ValidationGroup="UserFormVG" />
                            </td>
                        </tr>
                        <!-- Buttons -->
                        <tr>
                            <td colspan="2" style="text-align:right; padding-top:20px;">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn-save" Text='<%# Container.OwnerTableView.IsItemInserted ? "Add User" : "Update User" %>' CommandName='<%# Container.OwnerTableView.IsItemInserted ? "PerformInsert" : "Update" %>' ValidationGroup="UserFormVG" CausesValidation="true" />
                               
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </FormTemplate>
        </EditFormSettings>

        <Columns>
            <telerik:GridBoundColumn HeaderText="First Name" DataField="FirstName" UniqueName="FirstName" HeaderStyle-Width="60px" FilterControlWidth="120px" />
            <telerik:GridBoundColumn HeaderText="Last Name" DataField="LastName" UniqueName="LastName" HeaderStyle-Width="60px" FilterControlWidth="120px"/>
            <telerik:GridBoundColumn HeaderText="Email" DataField="Email" UniqueName="Email" HeaderStyle-Width="80px" FilterControlWidth="175px"/>
            <telerik:GridBoundColumn HeaderText="Username" DataField="UserName" UniqueName="UserName" HeaderStyle-Width="70px"  FilterControlWidth="140px"/>
            <telerik:GridBoundColumn HeaderText="Password" DataField="Password" UniqueName="Password" HeaderStyle-Width="70px"  FilterControlWidth="140px"/>
          
            <telerik:GridBoundColumn HeaderText="Designation" DataField="DesignationName" UniqueName="DesignationName" HeaderStyle-Width="70px"  FilterControlWidth="140px"/>
            <telerik:GridEditCommandColumn HeaderText="Edit" UniqueName="EditColumn" HeaderStyle-Width="20px" />
           
          <telerik:GridTemplateColumn HeaderText="Delete"
    HeaderStyle-Width="30px"
    AllowFiltering="false">

    <ItemTemplate>
        <asp:LinkButton ID="btnDeleteCustom"
            runat="server"
            CommandName="DeleteCustom"
            CommandArgument='<%# Eval("UserID") %>'
            OnClientClick="return confirmDelete(this);"
            UseSubmitBehavior="false"
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
        </div> 

         <telerik:RadNotification ID="rnSuccess"
    runat="server"
    Position="TopCenter"
    AutoCloseDelay="3000"
    Title="Success"
    Skin="Bootstrap"
    VisibleOnPageLoad="false" />


<telerik:RadNotification ID="rnError"
    runat="server"
    Position="TopCenter"
    AutoCloseDelay="5000"
    Title="Error"
    Skin="Bootstrap"
    VisibleOnPageLoad="false" />

          </telerik:RadAjaxPanel>
   

  
<telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    <Windows>
        <telerik:RadWindow ID="UserPopup" runat="server" Width="500px" Height="550px" Modal="true" CenterIfModal="true" />
    </Windows>
</telerik:RadWindowManager>

    <telerik:RadWindowManager ID="RadWindowManager2"
    runat="server"
    Skin="Bootstrap" />


<script>
    function clearEditForm(btn) {
        var form = btn.closest(".rgEditForm");
        if (!form) return false;

        // Clear textboxes
        form.querySelectorAll("input[type='text'], input[type='password']").forEach(i => i.value = "");

        // Clear dropdowns
        form.querySelectorAll("select").forEach(s => s.selectedIndex = 0);

        // Clear RadComboBox
        if (window.$telerik) {
            $telerik.findControls(form).forEach(c => {
                if (c.clearSelection) c.clearSelection();
            });
        }

        return false; // stop Telerik cancel (do NOT close popup)
    }
    Sys.Application.add_load(function () {
        document.querySelectorAll(".rgEditForm .rgCancel").forEach(btn => {
            btn.onclick = function () {
                return clearEditForm(this);
            };
        });
    });

   
        function OnClientLoad(sender, args) { }

        function OnPopUpShowing(sender, args) {
        var popUp = args.get_popUp();
        // Delay centering slightly to ensure the window is fully rendered
        setTimeout(function () {
            popUp.center();
        }, 50);
    }

    function setDefaultPage(sender, args) {
        var grid = $find("RrgUsers");
        var masterTable = grid.get_masterTableView();

        masterTable.set_currentPageIndex(0);
        masterTable.dataBind();
    }

    function confirmDelete(button) {

        if (button.getAttribute("data-confirmed") === "true") {
            button.setAttribute("data-confirmed", "false");
            return true;
        }

        radconfirm("Are you sure you want to delete this User?", function (arg) {
            if (arg) {
                button.setAttribute("data-confirmed", "true");
                button.click();
            }
        }, 330, 200, null, "Confirm Delete");

        return false;
    }
 
</script>
</asp:Content>


