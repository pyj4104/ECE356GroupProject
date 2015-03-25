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
        <title>Search for a Doctor:</title>
    </head>
    <body>
        <% 
            if (session.getAttribute("doctor").toString() != "false") {
                response.sendRedirect("./error/error404.jsp"); 
            }
        %>
        <h1>Doctors</h1>
        <ul>
            
        </ul>
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
            <h2>Doctor Search Data Form</h2>
            <table>
                <tr>
                    <td>First Name:</td>
                    <td><input type="text" name="docFirstName" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Last Name:</td>
                    <td><input type="text" name="docLastName" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Middle Initial:</td>
                    <td><input type="text" name="docMiddleInitial" size="12" autofocus></td>
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
                    <td><input type="text" name="docStreet" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Postal Code:</td>
                    <td><input type="text" name="docPostalCode" size="12" autofocus></td>
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
                    <td><input type="text" name="docReviewKeywords" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Reviewed by a Friend:</td>
                    <td><input type="checkbox" name="docReviewedByPatFriend" size="12" autofocus></td>
                </tr>
            </table>
            <h3><input type="submit" value="Search"></h3>
        </form>
                        
        <%
                if (doctorsList != null) {
                    if (!doctorsList.isEmpty()) { %>
                        <table>
                <%      for (Doctor d : doctorsList) {
                %>
                        <tr>
                            <h4><label>Name: <%= d.get_Name()%></label></h4>
                            <h4><label>Gender: <%= d.get_Gender() %></label></h4>
                            <h4><label>Avg. Rating <%= d.get_Avg_Rating() %></label></h4>
                            <h4><label>No. of reviews: <%= d.get_Num_Review() %></label></h4>
                            <a href="DoctorServlet?qnum=2&fromAlias=<%= d.get_Alias()%>">View Profile</a>
                        </tr>
                        <hr>
                <%
                        } %>
                        </table>
                <%  } else {
                %>
                    <li><h2>No doctors found.</h2></li>
                <%
                    }
                    
                }
            %>
    </body>
</html>
