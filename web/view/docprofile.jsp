<%-- 
    Document   : docprofile
    Created on : Mar 23, 2015, 1:20:36 AM
    Author     : suvignes
--%>
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
                <tr>
                    <td>List of Reviews:</td>
                    <td><%= doctor.get_Reviews() %></td>
                </tr>
            </table>
        <%
            }
        %>
        <%
            if(!(Boolean)request.getSession().getAttribute("doctor"))
            {
        %>
                <a href="WriteReviewServlet?docAlias=<%= doctor.get_Alias() %>&patAlias=<%=session.getAttribute("Alias")%>">Write Doctor Review</a>
        <%
            }
        %>
            
    </body>
</html>
