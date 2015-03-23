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
                    <td>Postal Code:</td>
                    <td><input type="text" name="docPostalCode" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Duration of Medical License:</td>
                    <td><input type="text" name="docLicenseDuration" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Average Star Rating:</td>
                    <td><input type="text" name="docAvgRating" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Gender:</td>
                    <td><input type="text" name="docGender" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Profession:</td>
                    <td><input type="text" name="docSpec" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Street:</td>
                    <td><input type="text" name="docStreet" size="12" autofocus></td>
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
                    if (!doctorsList.isEmpty()) {
                        for (Doctor d : doctorsList) {
                %>
                            <li>
                                <h2><label value="<%= d.get_Name()%>"><%= d.get_Gender() %> <%= d.get_Avg_Rating() %> <%= d.get_Num_Review() %></label></h2>
                            </li>
                <%
                        }
                    } else {
                %>
                    <li><h2>No doctors found.</h2></li>
                <%
                    }
                    
                } else {
                    
                }
            %>
        <h2><a href="LoginServlet"><< Go Back</a></h2>
    </body>
</html>
