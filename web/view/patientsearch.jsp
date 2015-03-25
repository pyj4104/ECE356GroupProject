<%-- 
    Document   : patientsearch
    Created on : Mar 22, 2015, 7:57:06 PM
    Author     : Nirmal
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="ece356.Patient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Search</title>
        <link rel="stylesheet" href="/ECE356GroupProject/css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <% 
            if (session.getAttribute("doctor").toString() != "false") {
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
            <div class="center-block">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Patient Search</h3>
                    </div>
                    <div class="panel-body">
                    <%
                            if (request.getAttribute("patientsList") != null) {
                    %>
                     <form method="post" action="PatientSearchServlet">
                    <%
                            } else {
                    %>
                     <form method="post" action="../PatientSearchServlet">
                    <% 
                           } 
                    %>
                    <table class="table">
                            <tr>
                                <td>Enter Alias:</td>
                                <td><input type="text" class="form-control" name="pAlias" size="25" maxlength="25" placeholder="Alias" autofocus</td>
                            </tr>
                            <tr>
                                <td>Select Province:</td>
                                <td>
                                    <select name="pProv">
                                        <option value="">Select Province</option>
                                        <option value="Ontario">Ontario</option>
                                        <option value="Quebec">Quebec</option>
                                        <option value="Nova Scotia">Nova Scotia</option>
                                        <option value="New Brunswick">New Brunswick</option>
                                        <option value="Manitoba">Manitoba</option>
                                        <option value="British Columbia">British Columbia</option>
                                        <option value="PEI">PEI</option>
                                        <option value="Saskatchewan">Saskatchewan</option>
                                        <option value="Alberta">Alberta</option>
                                        <option value="Newfoundland and Labrador">Newfoundland and Labrador</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Select City</td>
                                <td>
                                    <select name="pCity">
                                        <option value="">Select City</option>
                                        <%! ArrayList<String> cities;%>
                                        <%
                                            cities = (ArrayList<String>) session.getAttribute("cities");
                                            for (String c : cities) {
                                        %>
                                        <option value="<%= c%>"><%= c%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                        </table>    
                        <input class="btn btn-primary" type="submit" value="Search">
                    </form>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Result</h3>
                </div>
                <div class="panel-body">
                <%! ArrayList<Patient> patientList;%>
                <%
                    if (request.getAttribute("patientsList") != null) {
                        patientList = (ArrayList<Patient>) request.getAttribute("patientsList");
                        if (patientList.isEmpty()) {
                %>
                            <h4>No patients exist for the given search parameters</h4>
               <%
                        } else { 
                            String strUserAlias = session.getAttribute("alias").toString();
               %>
                            <table class="table">
                                <thead>
                                    <th>Name</th>
                                    <th>Alias</th>
                                    <th>Province</th>
                                    <th>City</th>
                                    <th>No. of reviews</th>
                                    <th>Latest Review Date</th>
                                    <th>Friendship Status</th>
                                </thead>
                <%          for (Patient p : patientList) {
                            if (!p.getAlias().contentEquals(strUserAlias)) {
                %>
                                <tr>
                                    <td><%= p.getFullName() %></td>
                                    <td><%= p.getAlias() %></td>
                                    <td><%= p.getProvince() %></td>
                                    <td><%= p.getCity() %></td>
                                    <td><%= p.getNumberOfReviews()%></td>
                                    <td><%= (!p.getLastReviewDate().isEmpty()) ? p.getLastReviewDate() : "N/A" %></td>
                                    <td>
                                    <%
                                        if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == -1) {
                                    %>
                                        <a class="btn btn-success" href="FriendRequestsServlet?toalias=<%= p.getAlias()%>">Add as Friend</a>
                                    <% } else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == 0) {
                                    %>
                                        <a class="btn btn-warning" href="FriendRequestsServlet?op=1">Confirm Pending Friend Request</a>
                                    <%
                                        } else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == 1) {
                                    %>
                                        <span class="btn btn-danger disabled">In Friends List</span>
                                    <% }  else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == -2) {
                                    %>
                                        <span class="btn btn-info disabled">Friend request sent</span>
                                    <% } %>
                                    </td>
                                </tr>
                                <% }
                            }   %>
                            </table>
                <%
                       }
                    }
                %>
                </div>
            </div>
            </div>
        </div>
    </body>
</html>
