<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /*ul.ui-autocomplete {
            width: 30px;
            background-color: white;
            max-height: 300px;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 500 !important;
            position: relative;
        }*/


        .modal-content {
            top: 150px;
            z-index: 3;
        }

        body.modal-open div.modal-backdrop {
            z-index: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header" style="margin-top: 0px; margin-bottom: 0px;">
        <h3 class="">Users</h3>
    </div>

    <div class="page-body">

        <div class="form-group">
            <a id="linkAddUser" class="btn btn-success btn-sm details" runat="server" onclick="AddUser()">
                <i class="fa fa-user-plus"></i>&nbsp;Add User
            </a>
        </div>
        <div runat="server" id="divUsers">
        </div>
    </div>




    <script>
        $(document).ready(function () {
            $("#myTable").DataTable({

                responsive: true,
            });

            $('.closeModal').click(function () {
                $("#divAddUser").modal('hide');
                $("#divEditUser").modal('hide');
                $("#divUser").modal('hide');
            });


            $("#btnEditUser").click(function () {
                var UFirstName = $("#txtUFirstName").val();
                var ULastName = $("#txtULastName").val();
                var UUserName = $("#txtUUserName").val();
                var UUserRole = $("#txtUUserRole").val();
                var UEmail = $("#txtEmail").val();

                $.ajax({
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "users.aspx/EditUser?FN=" + UFirstName + "&LN=" + ULastName + "&EM=" + UEmail + "&UN=" + UUserName + "&UR=" + UUserRole,
                    datatype: "json",
                    success: function (data) {
                        showAlert(data.d);
                    },
                    error: function (result) {
                    }
                });
            });

            $("#btnAddUser").click(function () {
                var FirstName = $("#txtFirstName").val();
                var LastName = $("#txtLastName").val();
                var UserName = $("#txtUserName").val();
                var email = $("#txtEmail").val();
                var UserRole = $('#txtUserRole').val();

                //var ddlRoles = $("[id*=ddlUserRole]");
                //var UserRole = ddlRoles.find("option:selected").Text();


                var email = $("#txtEmail").val();
                //if ($("#txtFirstName").val().length != 0 && $("#txtLastName").val().length != 0 && $("#txtUserName").val().length != 0) {
                  //  if (!isUNAvailable(UserName)) {
                        $.ajax({
                            method: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Users.aspx/AddUser?FN=" + FirstName + "&LN=" + LastName + "&EM=" + email + "&UN=" + UserName + "&UR=" + UserRole,
                            datatype: "json",
                            success: function (data) {
                                showAlert(data.d);
                            },
                            error: function (result) {
                            }
                        });
                //    }
                //    else {
                //        bootbox.alert("UserName already exists");
                //    }
                //}
                //else {
                //    bootbox.alert("Fields are empty")
                //}
            });
        })

        function isUNAvailable(userName) {
            $.ajax({
                method: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Users.aspx/isUNAvailable?UN=" + userName,
                datatype: "json",
                success: function (data) {
                    return data;
                },
                error: function (result) {
                }
            });
        }

        function EditUser(id, firstName, lastName, userName, email, userRole) {

            $("#divAddUser").modal('hide');
            $("#divEditUser").modal('show');

            $("#txtUFirstName").val(firstName);
            $("#txtULastName").val(lastName);
            $("#txtUUserName").val(userName);
            $("#txtUEmail").val(email);
            $("#txtUUserRole").val(userRole);

            $("#divUser").modal('show');

        }

        function DeleteUser(id,name) {

            bootbox.confirm({
                message: "Are you sure you want to delete User : " + name + "?",
                animate: true,
                buttons: {
                    cancel: {
                        label: "Cancel",
                        className: "btn-primary btn-xs",
                    },
                    confirm: {
                        label: "Delete",
                        className: "btn-warning btn-xs",
                    }
                },
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: "POST",
                            url: "User.aspx/DeleteUser?id=" + id,
                            contentType: "application/json; charset=utf-8",
                            success: function (response) {
                                location.reload(true);
                            },
                            failure: function (response) {

                            }
                        });
                    }
                }
            });
        }

        function AddUser() {

            $("#divAddUser").modal('show');
            $("#divEditUser").modal('hide');

            $("#divUser").modal('show');
        }






    </script>
    <div id="divUser" class="modal-open">

        <form id="User" runat="server">

            <div id="divAddUser" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Add User</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide1" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">FirstName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">LastName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UserName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Email</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UserRole</label>
                                    <div class="col-md-6">
                                       <asp:TextBox ID="txtUserRole" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnAddUser" title="Add User">Add User</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="divEditUser" class="modal fade">

                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Edit User</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide2" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">FirstName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUFirstName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">LastName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtULastName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UserName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUUserName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Email</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUEmail" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UserRole</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUUserRole" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnEditUser" title="Add User">Update</button>
                        </div>
                    </div>
                </div>

            </div>

        </form>
    </div>

</asp:Content>

