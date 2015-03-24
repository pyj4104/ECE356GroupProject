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
        <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <% 
            if (session.getAttribute("doctor").toString() != "false") {
                response.sendRedirect("./error/error404.jsp"); 
            }
        %>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
               <div id="navbar" class="collapse navbar-collapse navbar-left">
                   <a type="button" class="btn btn-primary navbar-btn" href="LogoutServlet">Sign out</a>
               </div>
            </div>
        </nav>
        <div class="container" style="padding-top: 85px">
            <div class="col-lg-4 col-lg-offset-5">
                <div class="btn-group-vertical" role="group">
                    <a class="btn btn-default" href="./view/patientsearch.jsp">Search Patient</a>
                    <a class="btn btn-default" href="FriendRequestsServlet?op=1">View Friend Requests</a>
                    <a class="btn btn-default" href="view/doctorsearch.jsp">Search Doctor</a>
                </div>
            </div>
        </div>
    </body>
</html>
