<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Companies.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

    <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet" />--%>

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

    <div class="form-horzontal">

        <div class="page-header" style="margin-top: 0px; margin-bottom: 0px;">
            <h3 class="">Companies</h3>
        </div>

        <div class="page-body">

            <div class="form-group">
                <a id="linkAddCompany" class="btn btn-success btn-sm details" runat="server" onclick="AddCompany()">
                    <i class="fa fa-user-plus"></i>&nbsp;Add Company
                </a>
            </div>

            <div class="form-group panel-body" id="divCompanies" runat="server">
            </div>

        </div>

    </div>

    <script>

        $(document).ready(function () {

            $("#myTable").DataTable({
                responsive: true,

            });

            $('.closeModal').click(function () {
                $("#divAddCompany").modal('hide');
                $("#divEditCompany").modal('hide');
                $("#divCompany").modal('hide');
            });

            $("#txtRepresentative").autocomplete({
                minlength: 2,
                position: {
                    my: "right top",
                    at: "right bottom",
                    collision: "none"
                },
                autofocus: true,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Companies.aspx/GetCompaniesList",
                        data: "{'name':'" + $("#txtRepresentative").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            //alert("hi");
                            response(data.d);
                        },
                        error: function (result) {
                        }
                    });
                    $('.ui-helper-hidden-accessible').remove();
                }
            });


         <%--   $('#Company').validate({
                ignore: ":hidden",
                rules: {
                    '<%=txtCompanyName.UniqueID %>': {
                        required: true,
                        minlength:2,
                        maxlength: 20
                    },

                    '<%=txtRepresentative.UniqueID %>': {
                        required: true,
                        minlength: 2,
                        maxlength: 20
                    },

                },

                messages: {
                    '<%=txtCompanyName.UniqueID %>': { required: "Please enter Company Name" },
                    '<%=txtRepresentative.UniqueID %>': { required: "Please enter Representer Name" }
                },

                errorPlacement: function (error, element) {
                    if (element.parent('.input-group').length) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });--%>


            $("#btnAddCompany").click(function () {

                $("#divCompany").modal('hide');

                var CompanyName = $("#txtCompanyName").val();
                var representative = $("#txtRepresentative").val();

                if ($("#txtCompanyName").val().length != 0 && $("#txtRepresentative").val().length != 0) {
                    //if (isValidLastName(representative)==true) {
                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Companies.aspx/AddCompany?CompanyName=" + CompanyName + "&rep=" + representative,
                        datatype: "json",
                        success: function (data) {
                            location.reload();
                        },
                        error: function (result) {
                        }
                    });
                }
                    //else {
                    //    bootbox.alert("Please check the lastName")
                    //}
                    //}
                else {
                    bootbox.alert("Fields are empty");
                }
            });

            $("#btnEditCompany").click(function () {

                $("#divCompany").modal('hide');

                var CompanyName = $("#txtUCompanyName").val();
                var representative = $("#txtURepresentative").val();
                var companyId = $("#companyId").val();

                if ($("#txtUCompanyName").val().length != 0 && $("#txtURepresentative").val().length != 0) {

                    //if (isValidLastName(representative)) {
                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Companies.aspx/EditCompany?companyId=18" + "&CompanyName=" + CompanyName + "&rep=" + representative,
                        datatype: "json",
                        success: function (data) {
                            location.reload();
                        },
                        error: function (result) {
                        }
                    });
                    //}
                    //else {
                    //    bootbox.alert("Please check the lastName")
                    //}
                }
                else {
                    bootbox.alert("Fields are empty");
                }
            });

        });

        function isValidLastName(lastName) {
            $.ajax({
                method: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Companies.aspx/isValidLastName?lastName=" + lastName,
                datatype: "json",
                success: function (data) {
                    return data.d;
                },
                error: function (result) {
                }
            });
        }

        function AddCompany() {

            $("#divEditCompany").modal('hide');
            $("#divAddCompany").modal('show');
            $("#divCompany").modal('show');

        }

        function EditCompany(companyId, companyName, lastName) {

            $("#divAddCompany").modal('hide');
            $("#divEditCompany").modal('show');

            $("#txtUCompanyName").val(companyName);
            $("#txtURepresentative").val(lastName);
            $("#companyId").val(companyId);

            $("#divCompany").modal('show');
        }

        function DeleteCompany(id) {
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
                            url: "Companies.aspx/DeleteCompany?id=" + id,
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

    </script>

    <div id="divCompany" class="modal-open">

        <form id="Company" runat="server">

            <div id="divAddCompany" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Company</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide1" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">Company Name</label>
                                    <div class="col-md-6">
                                        <asp:Label ID="companyId" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>
                                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Representative</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtRepresentative" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm closeModal" id="btnAddCompany" title="Add Company">Add</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="divEditCompany" class="modal fade" role="dialog" tabindex="-1" role="dialog">

                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                            <h4 class="modal-title">Edit Company</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide3" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">Company Name</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUCompanyName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Representative</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtURepresentative" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnEditCompany" title="Edit Company" data-dismiss="modal">Update</button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>


</asp:Content>

