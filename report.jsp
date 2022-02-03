<!DOCTYPE html>
<!--
    Document:   report.jsp
    Author:     Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>Report JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Enrollment Report</h1>
        <form name="reportGen" action="generatereport.jsp" method="POST">
            <!-- Should I turn this into a select? -->
            Term: <input type="text" name="term" id="term" /> <br>
            Year: <input type="text" name="year" id="year" /> <br>
            <input type="submit" name="reportSub" />
        </form>
        <br><br><a href="index.html">Return to main menu</a>
        <div></div>
    </body>
</html>
