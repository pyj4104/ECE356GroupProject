<%@page import="ece356.Review"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Review</title>
        <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <% 
            int nReviews = Integer.parseInt(session.getAttribute("nReviews").toString());
            int reviewID = Integer.parseInt(request.getAttribute("reviewid").toString());
            Review review = ((Review)(request.getAttribute("review")));
            String strDoctorAlias = review.get_DoctorAlias();
            int next = (reviewID - 1);
            int prev = (reviewID == nReviews) ? 0 : (reviewID + 1);
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
            <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title">Review</h3>
                </div>
                <div class="panel-body">
                    <table class="table">
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
                    </table>
                </div>
            </div>
            <nav>
                <ul class="pagination">
                    <% if (prev != 0) { %>
                    <li>
                      <a href="ViewReviewServlet?reviewid=<%= prev %>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                      </a>
                    </li>
                    <% } if (next != 0) { %>
                    <li>
                      <a href="ViewReviewServlet?reviewid=<%= next %>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                      </a>
                    </li>
                    <% } %>
                </ul>
            </nav>
        </div>
    </body>
</html>
