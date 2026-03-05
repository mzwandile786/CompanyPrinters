<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="CompanyPrinters.Login" %>

<%@ Register Assembly="Telerik.Web.UI"
    Namespace="Telerik.Web.UI"
    TagPrefix="telerik" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Telerik Theme -->
    <link href="https://kendo.cdn.telerik.com/2026.1.119/styles/kendo.bootstrap-v4.min.css" rel="stylesheet" />
    <link href="~/Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>

<body>


<form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />

    <div class="login-container">
        <div class="text-center mb-4">
       
            <h4 class="portal-title">Company Printers</h4>
        </div>

        <h2 class="login-header">Log In</h2>

        <div class="mb-3">
            <label class="form-label">Username</label>
            <telerik:RadTextBox ID="txtUsername" runat="server" Width="100%" 
                CssClass="custom-input" RenderMode="Lightweight" 
                EmptyMessage="Enter your username" />
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                ControlToValidate="txtUsername" ErrorMessage="Username is required" 
                ForeColor="Red" Display="Dynamic" Font-Size="Small" />
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <telerik:RadTextBox ID="txtPassword" runat="server" TextMode="Password" 
                Width="100%" CssClass="custom-input" RenderMode="Lightweight" 
                EmptyMessage="Enter your password" placeholder="Enter your password" />
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                ForeColor="Red" Display="Dynamic" Font-Size="Small" />
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="chkRemember">
                <label class="form-check-label" for="chkRemember">Remember me</label>
            </div>
          <!--  <a href="#" class="forgot-link">Forgot password?</a> -->
        </div>

    <telerik:RadButton ID="btnLogin" runat="server" Text="Log In"
    OnClick="btnLogin_Click" 
    RenderMode="Lightweight" 
    Skin="" 
    Width="100%" 
    Style="background-color: #28a745; background-image: none; border: none; color: white; height: 45px; font-weight: bold; font-size: 16px; border-radius: 4px; cursor: pointer;" />
            
        <div class="text-center mt-3">
            <telerik:RadLabel ID="lblMessage" runat="server" CssClass="text-danger" />
        </div>
    </div>

   <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnLogin">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnLogin" LoadingPanelID="RadAjaxLoadingPanel1" />
                <telerik:AjaxUpdatedControl ControlID="lblMessage" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" 
    runat="server" 
    Skin="Bootstrap"
    Transparency="30" />
</form>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    

</body>
</html>
