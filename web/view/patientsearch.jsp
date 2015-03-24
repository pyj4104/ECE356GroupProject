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
    </head>
    <body>
        <h1>Patient Search</h1>
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
        <table>
                <tr>
                    <td>Enter Alias:</td>
                    <td><input type="text" name="pAlias" size="25" autofocus</td>
                </tr>
                <tr>
                    <td>Enter Province:</td>
                    <td>
                        <select name="pProv">
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
                    <td>Enter City</td>
                    <td><input type="text" name="pCity" size="25" autofocus=""></td>
                </tr>
            </table>    
            <input type="submit" value="Search">
        </form>
        <%! ArrayList<Patient> patientList;%>
        <%
            if (request.getAttribute("patientsList") != null) {
                patientList = (ArrayList<Patient>) request.getAttribute("patientsList");
                if (patientList.isEmpty()) {
        %>
       <h2>No patients exist for the given search parameters.</h2>
       <%
                } else { 
                    String strUserAlias = session.getAttribute("alias").toString();
       %>
                    <table>
        <%          for (Patient p : patientList) {
        %>
                        <tr>
                            <h4><label>Name: <%= p.getFullName() %></label></h4>
                            <h4><label>Alias: <%= p.getAlias() %></label></h4>
                            <h4><label>Province: <%= p.getProvince() %></label></h4>
                            <h4><label>City: <%= p.getCity() %></label></h4>
                            <h4><label>No. of reviews: <%= p.getNumberOfReviews()%></label></h4>
                            <h4><label>Latest Review Date: <%= (!p.getLastReviewDate().isEmpty()) ? p.getLastReviewDate() : "N/A" %></label></h4>
                            <%
                            if (!p.getAlias().contentEquals(strUserAlias)) {
                                if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == -1) {
                            %>
                                <a href="FriendRequestsServlet?toalias=<%= p.getAlias()%>">Add as Friend</a>
                            <% } else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == 0) {
                            %>
                                <a href="FriendRequestsServlet?op=1">Confirm Pending Friend Request</a>
                            <%
                                } else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == 1) {
                            %>
                                <h5>In Friends List</h5>
                            <% }  else if (Integer.parseInt(p.getFriends().get(strUserAlias).toString()) == -2) {
                            %>
                                <h5>Friend request sent.</h5>
                            <% } %>
                        </tr>
                        <% } %>
                        <hr>
                    </table>
        <%        }
               }
        %>
       <h2><a href="LoginServlet"><< Go Back</a></h2>
       <%
            } else {
        %>
        <h2><a href="../LoginServlet"><< Go Back</a></h2>
        <% 
            } 
        %>
    </body>
</html>
