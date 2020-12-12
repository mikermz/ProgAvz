<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <hr>
        <h1>Formulario de acceso</h1>
        <hr>
        <form action="login.jsp" method="post">
            <div class="input-group">
                <label>Username:</label>
                <input type="email" name="userName" id="userName">
            </div>
            <div class="input-group">
                <label>Password:</label>
                <input type="password" name="userPass" id="userPass">
            </div>
            <div class="input-group">
                <button type="submit" class="btn" name="loginBtn">Login</button>
            </div>
        </form>
    </body>
</html>
