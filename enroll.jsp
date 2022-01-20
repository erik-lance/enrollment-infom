<!DOCTYPE html>
<!--
    Document:   enroll.jsp
    Author:     
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Enroll JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Enrolling a Student into the Database</h1>
        
        <p> Load Student Data</p>
        <jsp:useBean id="enrollBean" class="enrollment.enroll" scope="session"/>
        
        <!-- This entire section is for printing the data of student. -->
        <% 
            String status = "Enroll";
            if (request.getParameter("stID") != null) {
                enrollBean.Student.studentid = Integer.parseInt(request.getParameter("stID")); 
                status = "Student Record";

                // This is to prepare student for enrollment by creating a record for the list.
                // The courseID is to be provided in addtoenroll.jsp after submitting.
                enrollment.enrollment E = new enrollment.enrollment();
                E.studentid  = enrollBean.Student.studentid;
                E.term       = Integer.parseInt(request.getParameter("curTerm"));
                E.schoolyear = Integer.parseInt(request.getParameter("curYear"));
                enrollBean.EnrollmentList.add(E);
            }
            enrollBean.Student.viewRecord();
        
            // This is for printing purposes since it will print 0 instead of empty.
            String studentid = (enrollBean.Student.studentid == 0) ? "" : 
            Long.toString(enrollBean.Student.studentid);   

            String completename  = enrollBean.Student.completename;
            String degreeid      = enrollBean.Student.degreeid;             
        %>
        <!-- This loads the student data -->
        <h1><%=status%></h1>
        <p><%=studentid%></p>
        <p><%=completename%></p>
        <p><%=degreeid%></p>

        <!-- Student must input their ID num. and their current term and year -->
        <form name="studentID" action="enroll.jsp" method="POST">
            Enter student ID - <input type="text" name="stID" id="stID"><br>
            Current Term - <input type="text" name="curTerm"><br>
            School Year - <input type="text" name="curYear"><br>
            <input type="submit" value="Load Data" name="checkID" />
            <br>
        </form>

        <%
            // TODO add checker if came from addtoenroll.jsp solved with size check
            // This makes sure that the form for courses will appear only after
            // a student ID has been loaded.
            if (request.getParameter("checkID") != null || enrollBean.EnrollmentList.size() > 0) {
                enrollBean.loadCourses();
        %>
        <form name="studentEnroll" action="addtoenroll.jsp" method="POST">
            <h2>Select a course to enroll</h2>
            <select name="selectCourse" id="selectCourse">
                <%  for (int i = 0; i < enrollBean.CourseList.size(); i++) {
                        enrollment.coursedegree CD = new enrollment.coursedegree();
                        CD = enrollBean.CourseList.get(i);                      %>
                    <option value="<%=CD.courseid%>"><%=CD.courseid%></option>
                <%  }%>
            </select><br>
            <input type="submit" value="Add to cart" name="addCart" />
        </form>
        
        <% } %>

        <br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
