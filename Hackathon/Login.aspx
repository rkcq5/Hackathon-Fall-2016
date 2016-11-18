<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Login</title>
    <link href="<%=ResolveUrl("~/css/bootstrap.min.css")%>" rel="stylesheet" />

    <link href="<%=ResolveUrl("~/font-awesome/css/font-awesome.css")%>" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.datatables.net/plug-ins/f2c75b7247b/integration/bootstrap/3/dataTables.bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.4/css/dataTables.responsive.css" type="text/css" />

    <link href="<%=ResolveUrl("~/css/animate.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/css/style.css")%>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/bootstrap.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/plugins/metisMenu/jquery.metisMenu.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/plugins/slimscroll/jquery.slimscroll.min.js")%>"></script>
    <script src="<%=ResolveUrl("js/plugins/datapicker/bootstrap-datepicker.js")%>"></script>

    <script src="common/jquery-validation/jquery.validate.min.js"></script>
    <!-- Custom and plugin javascript -->
    <script src="<%=ResolveUrl("~/js/inspinia.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/plugins/pace/pace.min.js")%>"></script>


    <script src="<%=ResolveUrl("~/common/FancyBox/source/jquery.fancybox.js")%>"></script>
    <link href="<%=ResolveUrl("~/common/FancyBox/source/jquery.fancybox.css")%>" rel="stylesheet" media="screen" />
    <style>
        html, body, .container-table {
            height: 100%;
        }

        .container-table {
            display: table;
        }

        .vertical-center-row {
            display: table-cell;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="col-md-6 " style="background-color: white;">
            <div class="form-horizontal">
                <div class="page-header" style="margin-top: 0px; margin-bottom: 10px;">
                    <h3 class="">Login</h3>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblFirstName" runat="server" CssClass="control-label col-md-2" AssociatedControlID="txtFirstName">First Name <em style="color:maroon">*</em></asp:Label>

                    <div class="col-md-4">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblPassword" runat="server" CssClass="control-label col-md-2" AssociatedControlID="txtPassword">Password<em style="color:maroon">*</em>

                    </asp:Label>
                    <div class="col-md-4">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="Password"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-offset-5 col-md-7">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="col-md-3 btn btn-primary" OnClick="btnLogin_Click" />
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
