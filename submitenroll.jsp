<!DOCTYPE html>
<!--
    Document:   submitenroll.jsp
    Author:     
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Submitting Cart</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Courses were added successfully</h1>
        <jsp:useBean id="enrollBean" class="enrollment.enroll" scope="session" />
        <%
            // The top is removed because it was initialized before submitting.
            
            int index = enrollBean.EnrollmentList.size()-1; 
            enrollBean.EnrollmentList.remove(index);    
            long studentid = enrollBean.Student.studentid;
            int term = enrollBean.EnrollmentList.get(index-1).term;
            int year = enrollBean.EnrollmentList.get(index-1).schoolyear;
            
            // enrollBean.confirmEnrollment();
            
        %>
        <p><%=studentid%> <%=enrollBean.Student.completename%> <br></p>
        <p>Term <%=term%>, <%=year%><p> <br>
        <b>Courses added:</b>
        <%
            for (int i = 0; i < enrollBean.EnrollmentList.size(); i++) {
                enrollment.enrollment E    = new enrollment.enrollment();
                E = enrollBean.EnrollmentList.get(i);
        %>
                <br><%=(i+1)%> <%=E.courseid%>
          <%} enrollBean.clearEnrollment();%>
        <br><br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
