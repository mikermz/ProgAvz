<%@page import="com.tecleon.ProfDAO"%>
<%@page import="com.tecleon.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>login</title>
    </head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <body>
        <hr>
        <h1>Formulario de acceso</h1>
        <hr>
        <form action="login.jsp" method="post" class="form-horizontal">
            <div class="form-group col-xs-2">
                <label for="userName">Username:</label>
                <input type="email" name="userName" id="userName" class="form-control">
            </div>
            <div class="form-group col-xs-2">
                <label for="userPass">Password:</label>
                <input type="password" name="userPass" id="userPass" class="form-control">
            </div>
            <div class="form-group input-group col-xs-2">
                <button type="submit" class="btn btn-primary" name="loginBtn">Login</button>
            </div>
        </form>
        <%
            ProfDAO us = new ProfDAO();

            if (request.getParameter("loginBtn") != null) {
                String name = request.getParameter("userName");
                String pass = request.getParameter("userPass");
                HttpSession ses = request.getSession();

                out.print(us.login(name, pass));
                switch (us.login(name, pass)) {
                    case "jefe":
                        ses.setAttribute("user", name);
                        ses.setAttribute("type", "jefe");
                        response.sendRedirect("profile.jsp");
                        break;
                    case "docente":
                        ses.setAttribute("user", name);
                        ses.setAttribute("type", "profesor");
                        response.sendRedirect("profile.jsp");
                        break;
                    case "admin":
                        ses.setAttribute("user", name);
                        ses.setAttribute("type", "admin");
                        response.sendRedirect("indexAdmin.jsp");
                        break;
                    default:
                        out.write("Invalid user or password");
                        break;
                }
            }
            if (request.getParameter("close") != null) {
                session.invalidate();
            }
        %>
    </body>
</html>
