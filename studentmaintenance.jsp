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
        
        
        <% 
            if (request.getParameter("stID") != null)
            studentBean.studentid = Integer.parseInt(request.getParameter("stID")); 
            studentBean.viewRecord();
        
        %>
        <% String studentid = (studentBean.studentid == 0) ? "" : 
        Long.toString(studentBean.studentid);   
        
        %>
        <% String completename  = studentBean.completename;         %>
        <% String degreeid      = studentBean.degreeid;             %>
        <p><%=studentid%></p>
        <p><%=completename%></p>
        <p><%=degreeid%></p>

        <form name="studentID" action="studentmaintenance.jsp" method="POST">
            Enter student ID - <input type="text" name="stID" id="stID"><br>
            <input type="submit" value="LoadData" name="checkID" />
            <input type="submit" value="Add" name="addID" />
        </form>
        <form name="studentIDConfig" method="POST">
            
            <input type="submit" value="Modify" name="modifyID" />
            <input type="submit" value="Delete" name="deleteID" />
        </form>


        
        
        <!-- <form name="selectMaintenance" action="" -->
    </body>
</html>
