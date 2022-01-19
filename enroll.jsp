<!DOCTYPE html>
<!--
    Document:   enroll.jsp
    Author:     
-->
<html>
    <head>
        <title>Enroll JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Enrolling a Student into the Database</h1>
        <p> Load Student Data</p>
        <jsp:usebean id="enrollBean" class="enrollment.enroll" scope="session" />
    </body>
</html>
