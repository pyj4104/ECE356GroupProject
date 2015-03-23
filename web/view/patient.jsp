<%-- 
    Document   : patient
    Created on : Mar 21, 2015, 8:03:13 PM
    Author     : yeounjunpark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to PatBook!</title>
    </head>
    <body>
        <h1>Hello Patient!</h1>
        <h2>Patient Operation</h2>
        <ul>
            <li><a href="./view/patientsearch.jsp">Search Patient</a></li>
            <li><a href="FriendRequestsServlet?op=1">View Friend Request</a></li>
            <li><a href="view/doctorsearch.jsp">Search Doctor</a></li>
        </ul>
        <a href="LogoutServlet">Log out</a>
    </body>
</html>
