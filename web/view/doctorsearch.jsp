<%-- 
    Document   : doctorsearch
    Created on : Mar 21, 2015, 7:28:47 PM
    Author     : suvignes
--%>
<%@page import="ece356.Doctor"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctor Search</title>
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
                        <h3 class="panel-title">Doctors</h3>
                    </div>
                    <div class="panel-body">
                        <%! ArrayList<Doctor> doctorsList;%>
                        <%
                            doctorsList = (ArrayList<Doctor>) request.getAttribute("doctorSearchResults");
                            if (doctorsList != null)
                            {
                        %>
                        <form method="post" action="DoctorServlet?qnum=1">
                        <%

                            }
                            else
                            {
                        %>  
                        <form method="post" action="../DoctorServlet?qnum=1">  
                        <%
                            }
                        %> 
            <!--            <h2>Doctor Search Data Form</h2>-->
                        <table class = "table">
                            <tr>
                                <td>First Name:</td>
                                <td><input type="text" class="form-control" name="docFirstName" placeholder="First Name" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Last Name:</td>
                                <td><input type="text" class="form-control" name="docLastName" placeholder="Last Name" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Middle Initial:</td>
                                <td><input type="text" class="form-control" name="docMiddleInitial" placeholder="Middle Initial" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Duration of Medical License:</td>
                                <td><input type="number" name="docLicenseDuration" size="12" min ="0" max="150" step="1" pattern="[0-9]*" autofocus></td>
                            </tr>
                            <tr>
                                <td>Average Star Rating:</td>
                                <td>
                                    <select name="docAvgRating">
                                        <option value="">Select Average Rating</option>
                                        <%! double i;%>
                                        <%
                                            for(i=1;i<=5;i+=0.5) {
                                        %>
                                        <option value="<%= i%>"><%= i%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Gender:</td>
                                <td>
                                    <select name="docGender">
                                        <option value="" />
                                        <option value="Male">Male</option>
                                        <option value="Female" />Female</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Specialization: </td>
                                <td>
                                    <select name="docSpec">
                                        <option value="">Select Specialization</option>
                                        <%! ArrayList<String> specs;%>
                                        <%
                                            specs = (ArrayList<String>) session.getAttribute("specs");
                                            for (String s : specs) {
                                        %>
                                        <option value="<%= s%>"><%= s%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Street:</td>
                                <td><input type="text" class="form-control" name="docStreet" placeholder="Street" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Postal Code:</td>
                                <td><input type="text" class="form-control" name="docPostalCode" placeholder="Postal Code" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Select Province:</td>
                                <td>
                                    <select name="docProvince">
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
                                    <select name="docCity">
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
                            <tr>
                                <td>Keywords in Review:</td>
                                <td><input type="text" class="form-control" name="docReviewKeywords" placeholder="Review Keyword" size="12" autofocus></td>
                            </tr>
                            <tr>
                                <td>Reviewed by a Friend:</td>
                                <td><input class="checkbox" type="checkbox" name="docReviewedByPatFriend" size="12" value="True" autofocus></td>
                            </tr>
                        </table>
                                    <input type="submit" value="Search" class="btn btn-primary">
                        </form>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Result</h3>
                    </div>
                    <div class="panel-body">
                        <%
                        if (doctorsList != null) {
                            if (!doctorsList.isEmpty()) { %>
                                <table class="table">
                                    <thead>
                                        <th>Name</th>
                                        <th>Gender</th>
                                        <th>Avg. Rating</th>
                                        <th>No. of reviews</th>
                                        <th>Action</th>
                                    </thead>
                        <%      for (Doctor d : doctorsList) {
                        %>
                                <tr>
                                    <td><%= d.get_Name()%></td>
                                    <td><%= d.get_Gender() %></td>
                                    <td><%= d.get_Avg_Rating() %></td>
                                    <td><%= d.get_Num_Review() %></td>
                                    <td><a href="DoctorServlet?qnum=2&fromAlias=<%= d.get_Alias()%>">View Profile</a></td>
                                </tr>
                        <%
                                } %>
                                </table>
                        <%  } else {
                        %>
                            <h4>No doctors found</h4>
                        <%
                            }

                        }%>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
