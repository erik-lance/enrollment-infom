<!DOCTYPE html>
<!--
    Document:   report.jsp
    Author:     
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.*" %>

<html>
    <head>
        <title>Added to Cart</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Added course to cart!</h1>
        <jsp:useBean id="enrollBean" class="enroll" scope="session" />
        <%
            enrollment E = enrollBean.EnrollmentList.get(enrollBean.EnrollmentList.size()-1);
            E.courseid = request.getParameter("selectCourse");
            String studentid = E.studentid;
            String courseid  = E.courseid;
            String term      = E.term;
            String year      = E.schoolyear;

            // Note this isn't added as a record in enrollment immediately as it is just in the cart.
            // This will be handled in submitenroll.jsp
        %>
        <%=studentid%><br>
        You are enrolling in: <%=courseid%> <br>
        <%=term%> of <%=year%> <br><br>

        <!-- TODO: Add a list of currently enrolled courses for viewing -->
        <a href="enroll.jsp">Return to enroll</a>
    </body>
</html>
