<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="Default" %>

<%@ Register Assembly="Telerik.Web.UI"
    Namespace="Telerik.Web.UI"
    TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>

    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>

<body>
<form id="form1" runat="server">

    <!-- REQUIRED FOR TELERIK -->
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" />

    <!-- ===== TOP MENU ===== -->
    <div style="margin:20px;">
        <telerik:RadMenu ID="RadMenu1" runat="server"
            Flow="Horizontal"
            Skin="Bootstrap"
            Width="100%">

            <Items>
                <telerik:RadMenuItem Text="Home" NavigateUrl="~/Default.aspx" />
                <telerik:RadMenuItem Text="Printers" NavigateUrl="~/Printers.aspx" />
                <telerik:RadMenuItem Text="Users" NavigateUrl="~/Users.aspx" />
                <telerik:RadMenuItem Text="Designation" NavigateUrl="~/Designation.aspx" />
                <telerik:RadMenuItem Text="Logout" NavigateUrl="~/Logout.aspx" />
            </Items>

        </telerik:RadMenu>
    </div>

    <!-- ===== PAGE CONTENT ===== -->
    <div style="margin:30px;">
        <h2>Welcome</h2>
        <p>Please select a menu option above.</p>
    </div>

</form>
</body>
</html>
