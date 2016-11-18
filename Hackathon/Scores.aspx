<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Scores.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript">
      


    </script>

    <style>
        .chart {
            width: 100%;
            min-height: 450px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script>

        google.load("visualization", "1", {
            packages: ["corechart"]
        });
        google.setOnLoadCallback(drawchart);

        $(document).ready(function () {

            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Scores.aspx/getReports',
                data: '{}',
                success:
                function (response) {
                    drawchart(response.d);
                },
                error: function () {
                    alert("Error loading data!");
                }
            });
        });


        $(window).on("throttledresize", function (event) {

            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Scores.aspx/getReports',
                data: '{}',
                success:
                function (response) {
                    drawchart(response.d);
                },

                error: function () {
                    alert("Error loading data!");
                }
            });
        });



        function drawchart(dataValues) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Column Name');
            data.addColumn('number', 'Teams');
            for (var i = 0; i < dataValues.length; i++) {
                data.addRow([dataValues[i].TeamName, dataValues[i].Score]);
            }
            new google.visualization.ColumnChart(document.getElementById('myChartDiv')).
            draw(data, {
                title: "Hackathon Results",
                bar: { groupWidth: '15%' },
                "responsive": { "enabled": true }
            });
        }

    </script>

    <div id="myChartDiv" style="width: 700px; height: 450px;" class="chart ">
    </div>

</asp:Content>

