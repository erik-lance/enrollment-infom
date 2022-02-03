<!DOCTYPE html>
<!--
    Document:   submitdrop.jsp
    Author:     Clyla Rafanan, Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Submitting Drop Cart</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Courses were dropped successfully</h1>
        <jsp:useBean id="dropBean" class="enrollment.drop" scope="session" />
        <%
            // The top is removed because it was initialized before submitting.

            int index = dropBean.DropList.size()-1;
            dropBean.DropList.remove(index);
            long studentid = dropBean.Student.studentid;
            int term = dropBean.EnrollmentList.get(index-1).term;
            int year = dropBean.EnrollmentList.get(index-1).schoolyear;

             dropBean.confirmDrop();

        %>
        <p><%=studentid%> <%=dropBean.Student.completename%> <br></p>
        <p>Term <%=term%>, <%=year%><p> <br>
        <b>Courses added:</b>
        <%
            for (int i = 0; i < dropBean.DropList.size(); i++) {
                enrollment.enrollment E    = new enrollment.enrollment();
                E = dropBean.DropList.get(i);
        %>
                <br><%=(i+1)%> <%=E.courseid%>
          <%} dropBean.clearDrop();%>
        <br><br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
