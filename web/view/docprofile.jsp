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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Doctor Profile</h1>
        <%! Doctor doctor;%>
        <%
            doctor = (Doctor) request.getAttribute("docProfile");
            session.setAttribute("docName", doctor.get_Name());
            if (doctor != null)
            {
        %>
        
            <table>
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
                        <ul>
                        <% 
                           HashMap hmReviews = doctor.get_Reviews_Hashmap();
                           
                           Iterator i = hmReviews.entrySet().iterator();
                           if (i.hasNext()) {
                            session.setAttribute("Reviews", hmReviews);
                            session.setAttribute("nReviews", hmReviews.size());
                            while (i.hasNext()) {
                                Map.Entry e = (Map.Entry) i.next();
                                %>
                                <li><a href="ViewReviewServlet?reviewid=<%= (e.getKey()).toString() %>"><%= ((Review)(e.getValue())).toString() %></a></li>
                                <%
                            }
                           } else {
                        %>
                        <li>No Reviews</li>
                        <% } %>
                        </ul>
                    </td>
                </tr>
            </table>
        <%
            }
        %>
        <h2><a href="view/doctorsearch.jsp"><< Go Back</a></h2>
    </body>
</html>
