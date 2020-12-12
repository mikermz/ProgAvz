<%@page import="com.tecleon.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <script>
            function showDivCar() {
                document.getElementById('divCarrera').style.display = "block";
            }
            function showDivJefe() {
                document.getElementById('divJefe').style.display = "block";
            }
        </script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession();
            ProfDAO pr = new ProfDAO();
            List<Carrera> carreras = CarreraDAO.getAllCarrers();
            List<Prof> profes = ProfDAO.getAllProf();

            String user, type;

            if (ses.getAttribute("user") != null && ses.getAttribute("type") != null) {
                user = ses.getAttribute("user").toString();
                type = ses.getAttribute("type").toString();
                out.print("<a href='login.jsp?close='true'><h5>Logout  " + user + "</h5></a>");
            } else {
                out.print("<script>location.replace('login.jsp');</script>");
            }
        %>
        <hr>
        <h1>Admin Page</h1>
        <hr>
        <a href="login.jsp">Login</a> |   
        <a href="profile.jsp">Profile</a>|
        <a href="classes.jsp">Schedules</a>
        <%
                if(ses.getAttribute("type").toString().equals("admin"))
                    out.println("|<a href='indexAdmin.jsp'>Admin</a>");
            %>
        <hr> 
        <hr>

        <h3>Carreras</h3>
        <table class="table table-condensed">
            <thead >
                <tr >
                    <td >Clave Carrera</td><td>Nombre Carrera</td>
                </tr>
            </thead>
            <tbody>
                <%
                    ProfDAO p = new ProfDAO();
                    try {
                        Connection con = ProfDAO.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("Select * from carrera ;");
                        while (rs.next()) {
                %>
                <tr>

                    <td><%=rs.getString("idCarrera")%></td>
                    <td><%=rs.getString("nombreCarrera")%></td>
                </tr>
                <%}
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }%>
                <tr>
                    <td colspan="4"><button onclick="showDivCar()" class="btn btn-primary">Nueva carrera</button></td>
                </tr>
            </tbody>
            <tbody>
        </table>

        <div class="nuevaCarrera" id="divCarrera" style="display: none;">
            <form method="POST" action="indexAdmin.jsp">
                <h4>Agregar nueva carrera</h4>
                <div class="form-group">
                    <label for="idCarrera" class="form-label">Id Carrera:</label>
                    <input type="text" name="idCarrera" id="idCarrera" class="form-input">
                </div>
                <div class="form-group">
                    <label for="nombreCarrera" class="form-label"> Nombre Carrera:</label>
                    <input type="text" name="nombreCarrera" id="nombreCarrera" class="form-input">
                </div>


               
                
                <input type="submit" value="Guardar Carrera" class="btn btn-primary">
            </form>
        </div>
        <%
            String idCarrera = request.getParameter("idCarrera");
            String nombreCarrera = request.getParameter("nombreCarrera");

            Carrera cr = new Carrera();
            cr.setIdCarrera(idCarrera);
            cr.setNombreCarrera(nombreCarrera);
            int statusCarrera = CarreraDAO.saveCarrera(cr);

            if (statusCarrera > 0) {
                out.println("<p>Record saved successfully! </p>");
                out.print("<script>location.replace('indexAdmin.jsp');</script>");
            }
        %>

        <h3>Jefes de carrera</h3>
        <table class="table table-condensed">
            <thead >
                <tr >
                    <td >Clave Profesor</td><td>Nombre</td><td>Apellido</td><td>Email</td>  
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = ProfDAO.getConnection();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("Select * from profe where puesto ='jefe' ;");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getInt("idProf")%></td>
                    <td><%=rs.getString("nombreProf")%></td>
                    <td><%=rs.getString("apellidoProf")%></td>
                    <td><%=rs.getString("emailProf")%></td>
                </tr>
                <%}
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }%>
                <tr>
                    <td colspan="4"><button onclick="showDivJefe()" class="btn btn-primary">Nuevo jefe</button></td>
                </tr>
            </tbody>
            <tbody>
        </table>
        <div class="nuevoJefe" id="divJefe" style="display: none;">
            <form method="POST" action="indexAdmin.jsp">
                <h5 class="h4">Agregar nuevo jefe</h5>


                <div class="form-group">
                    <label for="prof" class="form-label">Profesor:</label>
                    <select name="prof" id="prof" class="form-select">
                        <%
                            for (Prof c : profes) {
                                out.println("<option value='" + c.getEmailProf() + "'>" + c.getNombreProf() + "</option>");
                            }
                        %>

                    </select>
                </div>
                <input type="submit" value="Guardar Jefe" class="btn btn-primary">
            </form>
        </div> 
        <%
            String prof = request.getParameter("prof");

            Prof pro = ProfDAO.getProfByEmail(prof);

            int statusJefe = ProfDAO.updatePuesto(pro);

            if (statusJefe > 0) {
                out.println("<p>Record updated successfully! </p>");
                out.print("<script>location.replace('indexAdmin.jsp');</script>");
            }
        %>
    </body>
</html>
