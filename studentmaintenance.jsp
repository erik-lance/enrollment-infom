<!DOCTYPE html>
<!--
    Document:   studentmaintenance.jsp
    Author:     Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Student Maintenance JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <jsp:useBean id="studentBean" class="enrollment.students" scope="session"/>
        <% studentBean.viewRecord(); %>
        
        <% String studentid       = request.getParameter("studentid");    %>
        <% String completename  = request.getParameter("completename"); %>
        <% String degreeid      = request.getParameter("price");        %>
        <p><%=studentid%></p>

        <form name="studentID" action="studentmaintenance.jsp" method="POST">
            Enter student ID - <input type="text" name="ID" id="ID"><br>
            <input type="submit" value="Load Data" name="checkID" />
            <input type="submit" value="Add" name="addID" />
        </form>
        <form name="studentIDConfig" method="POST">
            
            <input type="submit" value="Modify" name="modifyID" />
            <input type="submit" value="Delete" name="deleteID" />
        </form>


        
        
        <!-- <form name="selectMaintenance" action="" -->
    </body>
</html>
