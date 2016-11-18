<%@ Control Language="C#" AutoEventWireup="true" CodeFile="horizontalmenu.ascx.cs" Inherits="horizontalmenu" %>


<nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0; background-color: tomato !important; color: white;">

    <div class="navbar-header">
        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary visible-xs visible-sm hiddlen-md hiddlen-lg " href="#"><i class="fa fa-bars"></i></a>

    </div>


    <asp:Panel ID="loginPanel" runat="server">

        <div class="form-group">

            <div class="navbar-form-custom col-md-offset-1 col-md-4" style="width: 400px; padding-top: 5px;">
                <span class="clear"><span class="block m-t-xs" style="color: white;"><strong class="font-bold" style="font-weight: 500; font-size: x-large; word-wrap: normal;">Hackathon Evaluation</strong></span></span>
            </div>

            <div id="Log" runat="server" class="pull-right col-md-2">
                <a href="#" runat="server" id="divLog" class="margin btn btn-primary" onclick="userLogin()">Login here !</a>
                <a href="#" runat="server" id="linkLogout" class="margin btn btn-warning" visible="false">Logout</a>
            </div>




        </div>


    </asp:Panel>

    <div id="divLogin" class="modal fade">
        <%--<form id="login" runat="server">--%>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Login</h4>
                </div>

                <div class="modal-body">
                    <div id="slide1" class="slide form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-md-4">Username</label>
                            <div class="col-md-6">
                                <input type="text" name="txtUserName" id="txtUserName" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4">Password</label>
                            <div class="col-md-6">
                                <input type="password" name="txtPassword" id="txtPassword" required="required">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                    <button class="btn btn-success btn-sm" id="btnLogin" title="Add Review">Login</button>
                </div>
            </div>
        </div>
        <%--</form>  --%>
    </div>






</nav>
<style>
    .user {
        float: left;
        width: 32% !important;
        height: 32% !important;
        border-radius: 50% !important;
        background-position: center center !important;
        background-size: cover !important;
        margin-left: -27% !important;
        border: 18px solid;
        border-color: white;
    }

    .margin {
        /*margin-left: 14% !important;*/
    }

    @media only screen and (max-width: 768px) {
        /* For mobile phones: */
        .visibility {
            display: inline-block !important;
        }
    }
</style>
<%--<script src="<%=ResolveUrl("~/js/jquery-2.1.1.js")%>"></script>--%>

<script src="js/bootbox.min.js"></script>

<script>

    $(document).ready(function () {

        $('.closeModal').click(function () {
            $("#divLogin").modal('hide');
        });


        $("#btnLogin").click(function () {

            //var userName = $('input:textbox').val();
            //var password = $('input:password').val();
            //$('input:textbox').val()

            var userName = $("#txtUserName").val();
            var password = $("#txtPassword").val();
            $("#divLogin").modal('hide');
            if ($("#txtUserName").val().length != 0 && $("#txtPassword").val().length != 0) {
                $.ajax({
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Usecases.aspx/UserLogin?UN=" + userName + "&PW=" + password,
                    datatype: "json",
                    success: function (data) {
                        if (!data.d) {
                            bootbox.alert("InValid Credentials");
                        }
                        else {
                            location.reload();
                        }
                    },
                    error: function (result) {
                    }
                });
            }
            else {
                bootbox.alert("Fields should not be empty");
            }
        });


    });
    function userLogin() {
        //$("#divAddUser").modal('show');
        //$("#divEditUser").modal('hide');

        $("#divLogin").modal('show');
    }

</script>

