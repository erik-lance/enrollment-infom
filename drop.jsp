<!DOCTYPE html>
<!--
    Document:   drop.jsp
    Author:     Clyla Rafanan, Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>

<html>
    <head>
        <title>Drop JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Dropping a Course</h1>
        <jsp:useBean id="dropBean" class="enrollment.drop" scope="session"/>
        <jsp:useBean id="enrollBean" class="enrollment.enroll" scope="session"/>

        <!-- This entire section is for printing the data of student. -->
        <%
            String status = "Drop";
            int term = 0;
            int year = 0;
            if (request.getParameter("stID") != null) {
                // This makes sure cart is empty should a new user want to use the cart.
                dropBean.clearDrop();
                dropBean.Student.studentid = Integer.parseInt(request.getParameter("stID"));
                status = "Student Record";

                // This is to prepare student for enrollment by creating a record for the list.
                // The courseID is to be provided in addtoenroll.jsp after submitting.
                enrollment.enrollment E = new enrollment.enrollment();
                E.studentid  = dropBean.Student.studentid;
                E.term       = Integer.parseInt(request.getParameter("curTerm"));
                E.schoolyear = Integer.parseInt(request.getParameter("curYear"));
                term = Integer.parseInt(request.getParameter("curTerm"));
                year = Integer.parseInt(request.getParameter("curYear"));
                dropBean.DropList.add(E);

                // Note: As you can see, a new Enrollment object was added to the list already.
                // This object has the details for ID, term, year, but not the course. This is properly
                // filled after adding a course to cart.
            }
            else if (dropBean.DropList.size() > 0 && dropBean.Student.studentid != 0) {
                // This can only be called from addtoenroll.jsp to replace the form.
                // This will help take over in the form's request to get a parameter
                // Instead of checking a form request, it will check the most recent cart addition.
                int index = dropBean.DropList.size()-1;
                term = dropBean.DropList.get(index).term;
                year = dropBean.DropList.get(index).schoolyear;
                status = "Choosing Courses to Drop";

                enrollment.enrollment E = new enrollment.enrollment();
                E.studentid = dropBean.Student.studentid;
                E.term = term;
                E.schoolyear = year;
                dropBean.DropList.add(E);
            }
            else {
                // Clears student
                dropBean.Student.studentid = 0;
                dropBean.Student.completename = "";
                dropBean.Student.degreeid = "";
                dropBean.clearDrop();
            }
            dropBean.Student.viewRecord();

            // This is for printing purposes since it will print 0 instead of empty.
            // By default this is empty and only prints details once a student is selected.
            String studentid = (dropBean.Student.studentid == 0) ? "" :
            Long.toString(dropBean.Student.studentid);

            String completename  = dropBean.Student.completename;
            String degreeid      = dropBean.Student.degreeid;
        %>
        <!-- This loads the student data -->
        <h2><%=status%></h2>
        <p><%=studentid%></p>
        <p><%=completename%></p>
        <p><%=degreeid%></p>

        <!-- Student must input their ID num. and their current term and year -->
        <form name="studentID" action="drop.jsp" method="POST">
            Enter student ID: <input type="text" name="stID" id="stID"><br>
            Current Term: <input type="text" name="curTerm"><br>
            School Year: <input type="text" name="curYear"><br>
            <input type="submit" value="Enter" name="checkID" />
            <br>
        </form>

        <%
            // This makes sure that the form for courses will appear only after
            // a student ID has been loaded.
            if (request.getParameter("checkID") != null || dropBean.DropList.size() > 0) {
                dropBean.loadEnrollment(term, year);
        %>
        <form name="studentDrop" action="addtodrop.jsp" method="POST">
            <h2>Select a course to drop</h2>
            <p>You are dropping courses for Term <%=term%>, <%=year%></p>
            <select name="selectCourse" id="selectCourse">
                <%  for (int i = 0; i < dropBean.EnrollmentList.size(); i++) {
                        String crsID = "";
                        crsID = dropBean.EnrollmentList.get(i).courseid;
                        boolean valid = true;
                        for (int j = 0; j < dropBean.DropList.size(); j++) {
                            if (dropBean.DropList.get(j).courseid.equals(crsID)){
                                valid = false; break;
                            }
                        }
                        if (valid) {
                %>
                            <option value="<%=crsID%>"><%=crsID%></option>
                <%      }
                    }   %>
            </select>
            <input type="submit" value="Add to drop cart" name="addCart" />
        </form>
        <% } %>

        <!-- To avoid submitting with nothing in cart. -->
        <% if(dropBean.DropList.size()> 1) {%>
        <form name="dropSave" action="submitdrop.jsp" method="POST">
            <br><input type="submit" value="Submit Course Drop" name="submitCart" />
        </form>
        <%}%>

        <br><br>
        <a href="index.html">Return to main menu</a>

        <div></div>
    </body>
</html>
