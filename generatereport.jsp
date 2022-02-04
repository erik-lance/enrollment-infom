<!DOCTYPE html>
<!--
    A report showing the number of students that enrolled in every
    course for the term and school year will be displayed.

    Document:   generatereport.jsp
    Author:     Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Report Generation</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <jsp:useBean id="reportBean" class="enrollment.report" scope="session"/>
        <%
            int term = Integer.parseInt(request.getParameter("term"));
            int year = Integer.parseInt(request.getParameter("year"));
            reportBean.term       = term;
            reportBean.schoolyear = year;
            reportBean.generatereport();
        %>
        <h1>Report for Term <%=term%>, <%=year%></h1>
        <p> Course ID | Count</p>
        <%  // This for loop helps load each course name with its respective number.
            for (int i = 0; i < reportBean.CourseReportList.size(); i++) {
                enrollment.courses C = new enrollment.courses();
                int CT = 0;
                C  = reportBean.CourseReportList.get(i);
                CT = reportBean.CountReportList.get(i); %>

                <%=C.courseid%> &nbsp;<%=CT%><br>
        <%  } reportBean.resetreport();
        %>
        <br><br><a href="index.html">Return to main menu</a>
    </body>
</html>
