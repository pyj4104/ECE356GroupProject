<%@page import="ece356.Review"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Review</title>
    </head>
    <body>
        <h1>Review - </h1>
    <table>
        <% 
            int nReviews = Integer.parseInt(session.getAttribute("nReviews").toString());
            int reviewID = Integer.parseInt(request.getAttribute("reviewid").toString());
            Review review = ((Review)(request.getAttribute("review")));
            String strDoctorAlias = review.get_DoctorAlias();
            int next = (reviewID - 1);
            int prev = (reviewID == nReviews) ? 0 : (reviewID + 1);
        %>
        <tr>
            <td>Doctor Name: </td>
            <td><%= session.getAttribute("docName") %></td>
        </tr>
        <tr>
            <td>Date: </td>
            <td><%= review.get_Review_Date() %></td>
        </tr>
        <tr>
            <td>Rating : </td>
            <td><%= review.get_Rating() %></td>
        </tr>
        <tr>
            <td>Comments </td>
            <td><%= review.get_Comments() %></td>
        </tr>
        <tr>
            <% 
                if (prev != 0) {
            %>
            <td><a href="ViewReviewServlet?reviewid=<%= prev %>"> << Previous</a></td>
            <% } 
                if (next != 0) {
            %>
            <td><a href="ViewReviewServlet?reviewid=<%= next %>"> Next >></a></td>
            <%
                }
            %>
        </tr>
    </table>
        <h2><a href="DoctorServlet?qnum=2&fromAlias=<%= strDoctorAlias%>"><< Go Back</a></h2>
    </body>
</html>
