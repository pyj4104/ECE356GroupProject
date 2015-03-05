<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form method="post" action="LoginServlet">
            <h2>Welcome to Healthcare Provider Recommendation System!</h2>
            <h3>Sign In</h3>
            <table>
                <tr>
                    <td>Enter Alias:</td>
                    <td><input type="text" name="userInputAlias" size="12" autofocus></td>
                </tr>
                <tr>
                    <td>Enter Password:</td>
                    <td><input type="password" name="userInputPassword" size="12" autofocus></td>
                </tr>
            </table>
            <h3><input type="submit" value="Log In"></h3>
        </form>
    </body>
</html>
