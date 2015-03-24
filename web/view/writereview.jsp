<%-- 
    Document   : writereview
    Created on : Mar 23, 2015, 3:22:40 PM
    Author     : suvignes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Write Review</title>
        <link rel="stylesheet" href="/ECE356GroupProject/css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <% 
            if (session.getAttribute("doctor").toString() != "false") {
                response.sendRedirect("./error/error404.jsp"); 
            }
        %>
        <div class="container" style="padding-top: 85px">
            <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title">Write Review</h3>
                </div>
                <div class="panel-body">
                    <form method="post" action="../WriteReviewServlet?doc_alias=<%= request.getSession().getAttribute("docAlias") %>&pat_alias=<%=request.getSession().getAttribute("alias")%>">  
                        <table class="table">
                            <tr>
                                <td>Rating:</td>
                                <td>
                                    <select name="docRating">
                                        <option value="0">0</option>
                                        <option value="0.5">0.5</option>
                                        <option value="1">1</option>
                                        <option value="1.5">1.5</option>
                                        <option value="2">2</option>
                                        <option value="2.5">2.5</option>
                                        <option value="3">3</option>
                                        <option value="3.5">3.5</option>
                                        <option value="4">4</option>
                                        <option value="4.5">4.5</option>
                                        <option value="5">5</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Comments:</td>
                                <td><input type="text" name="docComments" size="25" maxlength="1000" autofocus required></td>
                            </tr>
                        </table>
                        <input class="btn btn-primary" type="submit" value="Submit">
                    </form>
                    
                </div>
            </div>
        </div>
    </body>
</html>
