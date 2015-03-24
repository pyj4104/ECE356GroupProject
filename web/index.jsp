<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
    </head>
    <body>
        <div class="container">
            <div class="input-group col-lg-4 col-lg-offset-4">
                <form method="post" action="LoginServlet">
                            <div class="page-header text-center">
                                <h1>
                                    <div class="glyphicon glyphicon-plus"></div>
                                    <span>DNS Healthcare</span>
                                </h1>
                            </div>
                            <h3>Sign In</h3>
                            <p class="text-center">
                                <input type="text" class="form-control" placeholder="Alias" aria-describedby="basic-addon1" name="userInputAlias" size="12" autofocus>
                            </p><br><br>
                            <p class="text-center">
                                <input type="password" class="form-control" placeholder="Password" aria-describedby="basic-addon1" name="userInputPassword" size="12" autofocus>
                            </p><br><br>
                            <p class="text-center">
                                <input type="submit" class="btn btn-primary" value="Log In">
                            </p>
                </form>
            </div>
            <span class="text-center text-danger"><h4><% if(request.getAttribute("Error") != null) {out.println(request.getAttribute("Error"));} %></h4></span>
        </div>
    </body>
</html>
