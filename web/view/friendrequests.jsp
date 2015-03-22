<%@page import="ece356.Patient"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Friend Requests</title>
    </head>
    <body>
        <h1>View Pending Friend Requests</h1>
        <ul>
            <%! ArrayList<Patient> friendRequestsList;%>
            <%
                friendRequestsList = (ArrayList<Patient>) request.getAttribute("friendrequests");
                if (friendRequestsList.isEmpty()) {
            %>
            <li><h2>No friend requests pending</h2></li>
            <%
                } else {
                    for (Patient p : friendRequestsList) {
            %>
                        <li>
                            <h2><label value="<%= p.getAlias()%>"> <%= p.getFullName() %> </label></h2>
                            <a href="FriendRequestsServlet?fromalias=<%= p.getAlias()%>">Confirm Friend Request</a>
                        </li>
            <%
                    }
                }
            %>
        </ul>
        <h2><a href="LoginServlet"><< Go Back</a></h2>
    </body>
</html>
