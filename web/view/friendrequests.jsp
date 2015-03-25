<%@page import="ece356.Patient"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Friend Requests</title>
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
                    <!--<a type="button" class="btn btn-primary navbar-btn" href="LoginServlet">Go Back</a>-->
                    <a type="button" class="btn btn-primary navbar-btn" href="LogoutServlet">Sign out</a>
               </div>
            </div>
        </nav>
        <div class="container" style="padding-top: 85px">
            <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title">View Pending Friend Requests</h3>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <%! ArrayList<Patient> friendRequestsList;%>
                        <%
                            friendRequestsList = (ArrayList<Patient>) request.getAttribute("friendrequests");
                            if (friendRequestsList.isEmpty()) {
                        %>
                            <tr><td>No friend requests pending</td></tr>
                        <%
                            } else {
                                for (Patient p : friendRequestsList) {
                        %>
                            <tr>
                                <td><label value="<%= p.getAlias()%>"> <%= p.getFullName() %> </label></td>
                                <td><a class="btn btn-warning" href="FriendRequestsServlet?fromalias=<%= p.getAlias()%>">Confirm Friend Request</a></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
