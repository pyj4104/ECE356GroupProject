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
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="../WriteReviewServlet?doc_alias=&pat_alias=">  
            <h2>Write a Review</h2>
            <table>
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
                    <td><input type="text" name="docComments" size="12" autofocus></td>
                </tr>
            </table>
            <h3><input type="submit" value="Search"></h3>
        </form>
    </body>
</html>
