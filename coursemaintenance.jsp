<!DOCTYPE html>
<!--
    Document:   coursemaintenance.jsp
    Author:     Clyla Rafanan, Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Course Maintenance JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <jsp:useBean id="courseBean" class="enrollment.courses" scope="session"/>
        <!-- This entire section is for printing and manipulating the data of student. -->
        <%
            String status = "Choose a Maintenance Option";
            if (request.getParameter("crsID") != null) {
                courseBean.coursename = "";
                courseBean.department = "";
                courseBean.courseid = request.getParameter("crsID");
                status = "Course Record";
            }
            courseBean.viewRecord();

            if (request.getParameter("deleteID") != null) {
                status = "Deleting Course";
                courseBean.delRecord();
            }
            else if (request.getParameter("modifyID") != null) { status = "Modifying Course"; }
            else if (request.getParameter("addID") != null) { status = "Adding Course"; }
            else if (request.getParameter("saveMod") != null)
            {   // This is to help save the modifications performed on the course ID.
                status = "Course modified successfully.";
                courseBean.viewRecord();
                courseBean.coursename = request.getParameter("crsName");
                courseBean.department = request.getParameter("crsDept");
                courseBean.modRecord();
                courseBean.viewRecord();
            }
            else if (request.getParameter("saveAdd") != null)
            {   // This section is to save the additions performed on a new student ID.
                status = "Course added successfully.";
                courseBean.coursename = request.getParameter("crsName");
                courseBean.department = request.getParameter("crsDept");
                courseBean.addRecord();
                courseBean.viewRecord();
            }
            else if (request.getParameter("crsID") == null)
            {   // This clears all information when coming from a diff page
                courseBean.courseid = "";
                courseBean.coursename = "";
                courseBean.department = "";
            }

            // This is for printing out the data of selected course based on the courseID.

            String courseid = courseBean.courseid;
            String coursename  = courseBean.coursename;
            String department      = courseBean.department;
        %>
        <h1><%=status%></h1>
        <p><%=courseid%></p>
        <p><%=coursename%></p>
        <p><%=department%></p>

        <form name="courseID" action="coursemaintenance.jsp" method="POST">
            Enter course ID - <input type="text" name="crsID" id="crsID"><br>
            <input type="submit" value="Load Data" name="checkID" />
            <input type="submit" value="Add" name="addID" />
            <input type="submit" value="Modify" name="modifyID" />
            <input type="submit" value="Delete" name="deleteID" />
            <br>
        </form>
        <%
        if (status.equals("Modifying Course")) {
        %>
            <form name="courseIDConfig" action="coursemaintenance.jsp" method="POST">
                <br><br>Enter new<br>
                Course Name: <input type="text"   name="crsName"   id="crsName" /><br>
                Course Department:  <input type="text"   name="crsDept" id="crsDept" /><br>
                <input type="submit" name="saveMod"  value="Submit"/>
            </form>
        <%
        }
        else if (status.equals("Adding Course")) {
        %>
            <form name="courseIDConfig" action="coursemaintenance.jsp" method="POST">
                <br><br><bold>Enter new</bold><br>
                Course Name: <input type="text"   name="crsName"   id="crsName" /><br>
                Course Department:  <input type="text"   name="crsDept" id="crsDept" /><br>
                <input type="submit" name="saveAdd"  value="Submit"/>
            </form>
        <%
        }
        %>
        <br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
