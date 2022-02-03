<!DOCTYPE html>
<!--
    Document:   addtodrop.jsp
    Author:     Clyla Rafanan, Erik Lance Tiongquico
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, enrollment.enrollment.*" %>
<html>
    <head>
        <title>Added to Drop Cart</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Added course to drop cart!</h1>
        <jsp:useBean id="dropBean" class="enrollment.drop" scope="session" />
        <%
            enrollment.enrollment E = dropBean.DropList.get(dropBean.DropList.size()-1);
            E.courseid = request.getParameter("selectCourse");
            String studentid = Long.toString(E.studentid);
            String courseid  = E.courseid;
            String term      = Integer.toString(E.term);
            String year      = Integer.toString(E.schoolyear);

            // Note this isn't added as a record in drop list immediately as it is just in the cart.
            // This will be handled in submitdrop.jsp
        %>
        <p><%=studentid%> <%=dropBean.Student.completename%></p>
        You are dropping: <%=courseid%> <br>
        Term <%=term%> of <%=year%> <br><br><br>

        <b>Courses in Drop Cart:</b>
        <%
            for (int i = 0; i < dropBean.DropList.size(); i++) {
                E    = new enrollment.enrollment();
                E = dropBean.DropList.get(i);
        %>
                <br><%=(i+1)%> <%=E.courseid%>
          <%}%>
        <br><br><br>
        <a href="drop.jsp">Return to dropping</a>
    </body>
</html>
