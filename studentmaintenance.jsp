<!DOCTYPE html>
<!--
    Document:   studentmaintenance.jsp
    Author:     Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.*" %>

<html>
    <head>
        <title>Student Maintenance JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <jsp:useBean id="studentBean" class="students" scope="session"/>
        
        <!-- This entire section is for printing and manipulating the data of student. -->
        <% 
            String status = "Choose a Maintenance Option";
            if (request.getParameter("stID") != null) {
                studentBean.studentid = Integer.parseInt(request.getParameter("stID")); 
                status = "Student Record";
            }
            studentBean.viewRecord();

            if (request.getParameter("deleteID") != null) {
                status = "Deleting Student";
                //studentBean.delRecord();
            }
            else if (request.getParameter("modifyID") != null) { status = "Modifying Student"; }
            else if (request.getParameter("addID") != null) { status = "Adding Student"; }
            else if (request.getParameter("saveMod") != null) 
            {   // This is to help save the modifications performed on a student ID.
                status = "Student modified successfully.";
                studentBean.viewRecord();
                studentBean.completename = request.getParameter("stFName") + " " + request.getParameter("stLName");
                studentBean.degreeid = request.getParameter("stDegree");
                //studentBean.modRecord();
                studentBean.viewRecord();
            }
            else if (request.getParameter("saveAdd") != null)
            {   // This section is to save the additions performed on a new student ID.
                status = "Student added successfully.";
                studentBean.completename = request.getParameter("stFName") + " " + request.getParameter("stLName");
                studentBean.degreeid = request.getParameter("stDegree");
                //studentBean.addRecord();
                studentBean.viewRecord();
            }

            // This is for printing out the data of selected student based on ID.
            // This ternary is to clean out student id as blank because its datatype is long.
            String studentid = (studentBean.studentid == 0) ? "" : 
            Long.toString(studentBean.studentid);   

            String completename  = studentBean.completename;
            String degreeid      = studentBean.degreeid;             
        %>
        <h1><%=status%></h1>
        <p><%=studentid%></p>
        <p><%=completename%></p>
        <p><%=degreeid%></p>

        <form name="studentID" action="studentmaintenance.jsp" method="POST">
            Enter student ID - <input type="text" name="stID" id="stID"><br>
            <input type="submit" value="Load Data" name="checkID" />
            <input type="submit" value="Add" name="addID" />
            <input type="submit" value="Modify" name="modifyID" />
            <input type="submit" value="Delete" name="deleteID" />
            <br>
        </form>
        <%
        if (status.equals("Modifying Student")) {
        %>
            <form name="studentIDConfig" action="studentmaintenance.jsp" method="POST">
                <br><br>Enter new<br>
                First Name: <input type="text"   name="stFName"   id="stFName" /><br>
                Last Name:  <input type="text"   name="stLName"   id="stLName" /><br>
                Degree ID:  <input type="text"   name="stDegree" id="stDegree" /><br>
                <input type="submit" name="saveMod"  value="Submit"/>
            </form>
        <%    
        }
        else if (status.equals("Adding Student")) {
        %>
            <form name="studentIDConfig" action="studentmaintenance.jsp" method="POST">
                <br><br><bold>Enter new</bold><br>
                First Name: <input type="text"   name="stFName"   id="stFName" /><br>
                Last Name:  <input type="text"   name="stLName"   id="stLName" /><br>
                Degree ID:  <input type="text"   name="stDegree" id="stDegree" /><br>
                <input type="submit" name="saveAdd"  value="Submit"/>
            </form>
        <%
        }
        %>
        <br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
