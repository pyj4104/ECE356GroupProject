<%-- 
    Document   : docprofile
    Created on : Mar 23, 2015, 1:20:36 AM
    Author     : suvignes
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ece356.Review" %>
<%@page import="ece356.Doctor" %>
<%@page import="ece356.WorkAddress" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctor Profile View</title>
        <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
               <div id="navbar" class="collapse navbar-collapse navbar-right">
                   <p class="navbar-header navbar-text navbar-left">Logged in as <%= session.getAttribute("alias") %></p>
                   <a type="button" class="btn btn-primary navbar-btn navbar-left" href="/ECE356GroupProject/LogoutServlet">Sign out</a>
               </div>
            </div>
        </nav>
        <div class="container" style="padding-top: 85px">
            <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title">Doctor Profile View</h3>
                </div>
                <div class="panel-body">
                    <%! Doctor doctor;%>
                    <%
                        doctor = (Doctor) request.getAttribute("docProfile");
                        if (!(Boolean)request.getSession().getAttribute("doctor")
                                || doctor.get_Alias().equals((String) request.getSession().getAttribute("alias")))
                        {
                            if (doctor != null)
                            {
                               session.setAttribute("docName", doctor.get_Name());
                               session.setAttribute("docAlias", doctor.get_Alias());
                    %>

                        <table class="table">
                            <tr>
                                <td>Name:</td>
                                <td><%= doctor.get_Name() %></td>
                            </tr>
                            <tr>
                                <td>Gender:</td>
                                <td><%= doctor.get_Gender() %></td>
                            </tr>
                            <tr>
                                <td>Work Address(es):</td>
                                <td><%= doctor.get_Addresses()%></td>
                            </tr>
                            <tr>
                                <td>Area(s) of Specialization:</td>
                                <td><%= doctor.get_Specializations()%></td>
                            </tr>
                            <tr>
                                <td>Number of Years Licensed:</td>
                                <td><%= doctor.get_Licensed_Since() %></td>
                            </tr>
                            <tr>
                                <td>Average Star Rating:</td>
                                <td><%= doctor.get_Avg_Rating() %></td>
                            </tr>
                            <tr>
                                <td>Number of Reviews:</td>
                                <td><%= doctor.get_Num_Review() %></td>
                            </tr>
                            <% if (session.getAttribute("doctor").toString() == "true") { %>
                            <tr>
                                <td>Email:</td>
                                <td><%= doctor.get_Email() %></td>
                            </tr>
                            <% } %>
                            <tr>
                                <td>List of Reviews:</td>
                                <td>
                                    <div class="btn-group-vertical" role="group">
                                    <% 
                                       HashMap hmReviews = doctor.get_Reviews_Hashmap();

                                       Iterator i = hmReviews.entrySet().iterator();
                                       if (i.hasNext()) {
                                        session.setAttribute("Reviews", hmReviews);
                                        session.setAttribute("nReviews", hmReviews.size());
                                        while (i.hasNext()) {
                                            Map.Entry e = (Map.Entry) i.next();
                                            %>
                                            <a type="button" class="btn btn-default" href="ViewReviewServlet?reviewid=<%= (e.getKey()).toString() %>"> <%= ((Review)(e.getValue())).toString() %> </a>
                                            <%
                                        }
                                       } else {
                                    %>
                                    <div class="alert alert-warning" role="alert">No Reviews!</div>
                                    <% } %>
                                </td>
                            </tr>
                        </table>
                    <%
                            }
                            if(!(Boolean)request.getSession().getAttribute("doctor"))
                            {
                    %>
                        <a type="button" class="btn btn-success" href="view/writereview.jsp">Write Doctor Review</a>
                    <%
                            }
                        }
                        else
                        {
                            request.getRequestDispatcher("/view/error/ForbiddenAccess.jsp").forward(request, response);
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
