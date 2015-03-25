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
        <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <% 
            if (session.getAttribute("doctor").toString() != "true") {
                response.sendRedirect("./error/error404.jsp"); 
            }
        %>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
               <div id="navbar" class="collapse navbar-collapse navbar-right">
                   <p class="navbar-header navbar-text navbar-left">Logged in as <%= session.getAttribute("alias") %></p>
                   <a type="button" class="btn btn-primary navbar-btn navbar-left" href="/ECE356GroupProject/LogoutServlet">Sign out</a>
               </div>
            </div>
        </nav>
        <div class="container" style="padding-top: 85px">
            <div class="jumbotron">
                <div class="page-header text-center">
                    <h1>
                        <div class="glyphicon glyphicon-user"></div>
                        <span>Hello <%= session.getAttribute("alias") %>!</span>
                    </h1>
                    <br>
                    <blockquote>
                        <p>But the real secret to lifelong good health is actually the opposite: Let your body take care of you.</p>
                        <footer>Deepak Chopra</footer>
                    </blockquote>
                </div>
            </div>
            <div class="col-lg-4 col-lg-offset-5">
                <div class="btn-group-lg btn-group-vertical" role="group">
                    <a class="btn btn-default" href="DoctorServlet?qnum=2&fromAlias=<%=(String)request.getSession().getAttribute("alias").toString()%>">View Profile</a>
                </div>
            </div>
        </div>
    </body>
</html>
