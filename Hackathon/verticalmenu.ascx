<%@ Control Language="C#" AutoEventWireup="true" CodeFile="verticalmenu.ascx.cs" Inherits="verticalmenu" %>

<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="profile-element">
                    <a href="UseCases.aspx">
                     <strong class="font-bold" style="font-weight: 600; font-size: 12px;">Hackathon Evaluation</strong></a>
                </div>
                <div class="logo-element" style="height: 72px; display: none !important">
                    <a href="UseCases.aspx">
                        <img alt="logo" style="height: 28px; margin: -7px 10px -10px 0; border: 0; padding: 0; vertical-align: top;" src="<%=ResolveUrl("~/images/UMKC_1C_white.png")%>"></a>
                    <strong class="font-bold" style="font-weight: 600; font-size: 12px;">Hackathon Evaluation</strong>
                </div>
            </li>
            <li>
                <a href="UseCases.aspx" id="liUsecases" runat="server">
                    <i class="fa fa-book fa-lg" title="Manage User Agreements"></i><span class="nav-label">UseCases</span>
                </a>
            </li>
            <li>
                <a href="Teams.aspx" id="liTeams" runat="server">
                    <i class="fa fa-users fa-lg" title="Manage Users"></i><span class="nav-label">Teams</span>
                </a>
            </li>

            <li>
                <a href="Scores.aspx" id="A1" runat="server">
                    <i class="fa fa-users fa-lg" title="Scores"></i><span class="nav-label">Scores</span>
                </a>
            </li>
            <li>
                <a href="Companies.aspx" id="liCompanies" runat="server" visible="false">
                    <i class="fa fa-book fa-lg" title="User Agreements"></i><span class="nav-label">Companies</span>
                </a>
            </li>
            <li>
                <a href="Users.aspx" id="liUsers" runat="server" visible="false">
                    <i class="fa fa-book fa-lg" title="Users"></i><span class="nav-label">Users</span>
                </a>
            </li>
            <li class=" visible-xs hidden-sm hidden-md hidden-lg">
                <a href="~/Logout.aspx" runat="server" id="logout">
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                </a>
            </li>
        </ul>
    </div>
</nav>


