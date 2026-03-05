<%@ Master Language="C#" AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs"
    Inherits="CompanyPrinters.AdminDashboard" %>

<%@ Register Assembly="Telerik.Web.UI"
    Namespace="Telerik.Web.UI"
    TagPrefix="telerik" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Telerik -->
    <telerik:RadStyleSheetManager runat="server" ID="RadStyleSheetManager1" />
</head>

<body>
<form runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminHome.aspx">Admin Panel</a>

            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="adminNavbar">

                <!-- ADMIN MENU -->
                <telerik:RadMenu ID="RadMenuAdmin" runat="server"
                    Skin="Bootstrap"
                    EnableEmbeddedSkins="false"
                    CssClass="navbar-nav me-auto">

                    <Items>
                        <telerik:RadMenuItem Text="Dashboard" NavigateUrl="~/AdminHome.aspx" />

                        <telerik:RadMenuItem Text="Printers"
                            NavigateUrl="~/Printers.aspx" />

                        <telerik:RadMenuItem Text="Users"
                            NavigateUrl="~/Users.aspx" />

                        <telerik:RadMenuItem Text="Designation"
                            NavigateUrl="~/Designation.aspx" />
                    </Items>
                </telerik:RadMenu>

                <!-- LOGOUT -->
                <asp:Button ID="btnLogout" runat="server"
                    Text="Logout"
                    CssClass="btn btn-danger"
                    OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="container mt-4">
        <asp:ContentPlaceHolder ID="MainContent" runat="server" />
    </div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
