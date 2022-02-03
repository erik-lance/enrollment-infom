<!DOCTYPE html>
<!--
    Document:   enroll.jsp
    Author:    Erik Lance Tiongquico
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
        <h1>Enrolling to a Course</h1>
        <jsp:useBean id="enrollBean" class="enrollment.enroll" scope="session"/>

        <!-- This entire section is for printing the data of student. -->
        <%
            String status = "Enroll";
            int term = 0;
            int year = 0;
            if (request.getParameter("stID") != null) {
                // This makes sure cart is empty should a new user want to use the cart.
                enrollBean.clearEnrollment();
                enrollBean.Student.studentid = Integer.parseInt(request.getParameter("stID"));
                status = "Student Record";

                // This is to prepare student for enrollment by creating a record for the list.
                // The courseID is to be provided in addtoenroll.jsp after submitting.
                enrollment.enrollment E = new enrollment.enrollment();
                E.studentid  = enrollBean.Student.studentid;
                E.term       = Integer.parseInt(request.getParameter("curTerm"));
                E.schoolyear = Integer.parseInt(request.getParameter("curYear"));
                term = Integer.parseInt(request.getParameter("curTerm"));
                year = Integer.parseInt(request.getParameter("curYear"));
                enrollBean.EnrollmentList.add(E);
            }
            else if (enrollBean.EnrollmentList.size() > 0 && enrollBean.Student.studentid != 0) {
                // This will only be called from addtoenroll.jsp to replace the form.
                // This will help take over in the form's request to get a parameter
                // Instead of checking a form request, it will check the most recent cart addition.
                int index = enrollBean.EnrollmentList.size()-1;
                term = enrollBean.EnrollmentList.get(index).term;
                year = enrollBean.EnrollmentList.get(index).schoolyear;
                status = "Shopping for Courses";

                enrollment.enrollment E = new enrollment.enrollment();
                E.studentid = enrollBean.Student.studentid;
                E.term = term;
                E.schoolyear = year;
                enrollBean.EnrollmentList.add(E);
            }
            else {
                // Clears student
                enrollBean.Student.studentid = 0;
                enrollBean.Student.completename = "";
                enrollBean.Student.degreeid = "";
                enrollBean.clearEnrollment();
            }
            enrollBean.Student.viewRecord();

            // This is for printing purposes since it will print 0 instead of empty.
            String studentid = (enrollBean.Student.studentid == 0) ? "" :
            Long.toString(enrollBean.Student.studentid);

            String completename  = enrollBean.Student.completename;
            String degreeid      = enrollBean.Student.degreeid;
        %>
        <!-- This loads the student data -->
        <h2><%=status%></h2>
        <p><%=studentid%></p>
        <p><%=completename%></p>
        <p><%=degreeid%></p>

        <!-- Student must input their ID num. and their current term and year -->
        <form name="studentID" action="enroll.jsp" method="POST">
            Enter student ID: <input type="text" name="stID" id="stID"><br>
            Current Term: <input type="text" name="curTerm"><br>
            School Year: <input type="text" name="curYear"><br>
            <input type="submit" value="Enter" name="checkID" />
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
            <p>You are enrolling for Term <%=term%>, <%=year%></p>
            <select name="selectCourse" id="selectCourse">
                <%  for (int i = 0; i < enrollBean.CourseList.size(); i++) {
                        enrollment.coursedegree CD = new enrollment.coursedegree();
                        CD = enrollBean.CourseList.get(i);
                        boolean valid = true;
                        // This makes sure the course doesn't show up again.
                        for (int j = 0; j < enrollBean.EnrollmentList.size(); j++) {
                            if (enrollBean.EnrollmentList.get(j).courseid.equals(CD.courseid)) {
                                valid = false; break;
                            }
                        }
                        if (valid) {
                %>
                            <option value="<%=CD.courseid%>"><%=CD.courseid%></option>
                <%      }
                    }   %>
            </select>
            <input type="submit" value="Add to cart" name="addCart" />
        </form>
        <% } %>

        <!-- To avoid submitting with nothing in cart. -->
        <% if(enrollBean.EnrollmentList.size()> 1) {%>
        <form name="enrollSave" action="submitenroll.jsp" method="POST">
            <br><input type="submit" value="Submit Enrollment" name="submitCart" />
        </form>
        <%}%>

        <br><br>
        <a href="index.html">Return to main menu</a>
    </body>
</html>
