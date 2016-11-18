<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UseCases.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header" style="margin-top: 0px; margin-bottom: 0px;">
        <div class="form-horizontal">

            <div class="form-group">
                <h3 class="">UseCases</h3>
            </div>


        </div>
    </div>

    <div class="page-body">
        <div class="form-group">
            <a id="linkAddUseCase" class="btn btn-success btn-sm details" runat="server" onclick="addUseCase()">
                <i class="fa fa-user-plus"></i>&nbsp;Add UseCase</a>
        </div>
        <div class="form-group" runat="server" id="divUseCases">
        </div>
    </div>


    <script>

        $(document).ready(function () {

            $("#myTable").DataTable({

                responsive: true,
                pageLength: 1
            });

            $("#btnEditUseCase").click(function () {
                var name = $("#txtUName").val();
                var description = $("#txtUDescription").val();
                var company = $("#txtUCompany").val();

                if ($("#txtUName").val().length != 0 && $("#txtUDescription").val().length != 0 && $("#txtUCompany").val().length != 0) {
                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "UseCases.aspx/EditUseCase?Name=" + name + "&desc=" + description + "&Company=" + company,
                        datatype: "json",
                        success: function (data) {
                            // showAlert(data.d);
                        },
                        error: function (result) {
                        }
                    });
                }
                else {
                    bootbox.alert("Fields are empty");
                }
            });

            $("#btnAddUseCase").click(function () {
                var name = $("#txtName").val();
                var description = $("#txtDescription").val();
                var company = $("#txtCompany").val();

                if ($("#txtName").val().length != 0 && $("#txtDescription").val().length != 0 && $("#txtCompany").val().length != 0) {

                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Users.aspx/AddUseCase?Name=" + name + "&desc=" + description + "&Company=" + company,
                        datatype: "json",
                        success: function (data) {
                            //  showAlert(data.d);
                        },
                        error: function (result) {
                        }
                    });

                }
                else {
                    bootbox.alert("Fields are empty");
                }
            });

            $('.closeModal').click(function () {
                $("#divAddUseCase").modal('hide');
                $("#divEditUseCase").modal('hide');
                $("#divUseCase").modal('hide');
            });

        })

        function editUseCase(id, Name, Description, Company) {

            $("#txtUName").val(Name);
            $("#txtUDescription").val(Description);
            $("#txtUCompany").val(Company);

            $("#divEditUseCase").modal('show');
            $("#divAddUseCase").modal('hide');

            $("#divUseCase").modal('show');

        }

        function deleteUseCase(id) {
            bootbox.confirm({
                message: "Are you sure you want to delete Company " + id + "?",
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
                            url: "UseCases.aspx/DeleteUseCase?id=" + id,
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

        function addUseCase() {

            $("#divAddUseCase").modal('show');
            $("#divEditUseCase").modal('hide');
            $("#divUseCase").modal('show');
        }

    </script>
    <div id="divUseCase" class="modal-open">

        <form id="UseCase" runat="server">

            <div id="divAddUseCase" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Add UseCase</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide1" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">Name</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Description</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Company</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnAddUseCase" title="Add UseCase">Add</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="divEditUseCase" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Edit UseCase</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide9" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">Name</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Description</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUDescription" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Company</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUCompany" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnEditUseCase" title="Edit UseCase">Update</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>
    </div>
</asp:Content>

