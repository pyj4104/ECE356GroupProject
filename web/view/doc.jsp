<%-- 
    Document   : doc
    Created on : Mar 21, 2015, 8:02:44 PM
    Author     : yeounjunpark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Doctor to DocBook!</title>
    </head>
    <body>
        <h1>Hello Doc!</h1>
        <h2>Doctor Operation</h2>
        <h3><a href="DoctorServlet?qnum=2&fromAlias=<%=(String)request.getSession().getAttribute("alias").toString()%>">View Doctor Profile</a></h3>
        <a href="LogoutServlet">Log out</a>
    </body>
</html>
