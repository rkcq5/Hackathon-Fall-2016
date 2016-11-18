<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Teams.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header" style="margin-top: 0px; margin-bottom: 0px;">
        <h3 class="">Teams</h3>
    </div>

    <div class="page-body">

        <div class="form-group">
            <a id="linkAddUser" class="btn btn-success btn-sm details" runat="server" onclick="addTeam()">
                <i class="fa fa-user-plus"></i>&nbsp;Add Team
            </a>
        </div>
        <div runat="server" id="divTeams">
        </div>
    </div>



    <script>
        $(document).ready(function () {
            $("#myTable").DataTable({
                responsive: true,
            });

            $("#btnAddReview").click(function () {

                $("#divTeam").modal('hide');

                var teamId = $("#lblReviewNo").val();
                var score = $("#txtScore").val();
                var comments = $("#txtComments").val();
                $.ajax({
                    method: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Teams.aspx/AddReview?score=" + score + "&comments=" + comments + "&teamId=" + teamId,
                    datatype: "json",
                    success: function (data) {
                        showAlert(data.d);
                    },
                    error: function (result) {
                    }
                });
            });


            $("#btnAddTeam").click(function () {

                var teamName = $("#txtUTeamName").val();
                var teamCount = $("#txtUTeamCount").val();
                var technology = $("#txtUTechnology").val();
                var useCaseName = $("#ddlUUsecase").val();
                if ($("#txtUTeamName").val().length != 0 && $("#txtUTeamCount").val().length != 0 && $("#txtUTechnology").val().length != 0) {

                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Teams.aspx/AddTeam?TN=" + teamName + "&TC=" + teamCount + "&tech=" + technology + "&UN=" + useCaseName,
                        datatype: "json",
                        success: function (data) {
                            showAlert(data.d);
                        },
                        error: function (result) {
                        }
                    });
                }
                else {
                    bootbox.alert("Fields are Empty");
                }

            });


            $("#btnEditTeam").click(function () {
                var teamName = $("#txtUTeamName").val();
                var teamCount = $("#txtUTeamCount").val();
                var technology = $("#txtUTechnology").val();
                var useCaseName = $("#ddlUUsecase").val();
                if ($("#txtUTeamName").val().length != 0 && $("#txtUTeamCount").val().length != 0 && $("#txtUTechnology").val().length != 0) {

                    $.ajax({
                        method: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Teams.aspx/EditTeam?TN=" + teamName + "&TC=" + teamCount + "&tech=" + technology + "&UN=" + useCaseName,
                        datatype: "json",
                        success: function (data) {
                            showAlert(data.d);
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
                $("#divAddTeam").modal('hide');
                $("#divEditTeam").modal('hide');
                $("#divAddReview").modal('hide');
                $("#divTeam").modal('hide');
            });

        })

        function AddReview(id) {
            //lblReview
            //$(".modal-header #lblReview").text(name);
            $(".modal-header #lblReviewNo").text(id);

            $("#divAddReview").modal('show');

            $("#divAddTeam").modal('hide');
            $("#divEditTeam").modal('hide');

            $("#divTeam").modal('show');
        }

        function ViewReviews(id,name) {
            $.ajax({
                type: "POST",
                url: "Teams.aspx/getReviews?id=" + id,
                contentType: "application/json; charset=utf-8",
                success: function (r) {
                    viewDescription(r, name)
                },
                failure: function (response) {
                },
            });
        }

        function viewDescription(description, name) {

            $("#myModal").modal('show');
            $(".modal-body #bookId").html(description.d);
            $(".modal-body #bookId").css("width", "auto");
            $(".modal-body #bookId").css("word-wrap", "break-word");
            $(".modal-header #reqno").text(name);
        }

        function addTeam() {
            $("#divAddReview").modal('hide');

            $("#divAddTeam").modal('show');
            $("#divEditTeam").modal('hide');

            $("#divTeam").modal('show');
        }

        function editTeam(id, teamName, teamCount, technology, useCaseName) {

            $("#divAddReview").modal('hide');
            $("#divAddTeam").modal('hide');
            $("#divEditTeam").modal('show');


            $("#txtUTeamName").val(teamName);
            $("#txtUTeamCount").val(teamCount);
            $("#txtUTechnology").val(technology);
            $("#ddlUUsecase").val(useCaseName);

            $("#divTeam").modal('show');

        }

        function deleteTeam(id) {
            bootbox.confirm({
                message: "Are you sure you want to delete team " + id + "?",
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
                            url: "Teams.aspx/DeleteTeam?id=" + id,
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

    <div id="divTeam" class="modal-open">

        <form id="Team" runat="server">

            <div id="divAddReview" class="modal fade">

                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Reviews</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide1" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">Score</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtScore" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Comments</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnAddReview" title="Add Review" data-dismiss="modal">Add Review</button>
                        </div>
                    </div>
                </div>

            </div>

            <div id="divAddTeam" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Add Team</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide10" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">TeamName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtTeamName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">TeamCount</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtTeamCount" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Technology</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtTechnology" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UseCase</label>
                                    <div class="col-md-6">
                                        <asp:DropDownList ID="ddlUseCase" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnAddTeam" title="Add User">Add Team</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="divEditTeam" class="modal fade">

                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close closeModal" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Edit Team</h4>
                        </div>

                        <div class="modal-body">
                            <div id="slide7" class="slide form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-md-4">TeamName</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUTeamName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">TeamCount</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUTeamCount" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Technology</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="txtUTechnology" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">UseCase</label>
                                    <div class="col-md-6">
                                        <asp:DropDownList ID="ddlUUseCase" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default btn-sm closeModal" data-dismiss="modal">Close</button>
                            <button class="btn btn-success btn-sm" id="btnEditUser" title="Edit Team">Update</button>
                        </div>
                    </div>
                </div>

            </div>

        </form>
    </div>

    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" style="background-color: #1c84c6">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" style="color: white" title="sdkjx">Reviews for: 
                        <asp:Label ID="reqno" runat="server" ClientIDMode="Static"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p id="bookId"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>





</asp:Content>

