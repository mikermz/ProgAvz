<%-- 
    Document   : classes
    Created on : 12/10/2020, 02:18:18 PM
    Author     : Miguel Ivan
--%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.tecleon.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css" media="screen">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Classes</title>
        <script src="js/jquery.js"></script>
        <script>
            function jsfunction() {
                location.replace('classes.jsp');
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
            String user;
            user = ses.getAttribute("user").toString();

            Prof pro = ProfDAO.getProfByEmail(user);
            List<Carrera> carreras = CarreraDAO.getAllCarrers();

        %>
        <div class="container">
            <hr>
            <h1>Classes  of <% out.println(pro.getNombreProf());%></h1>
            <hr>
            <a href="login.jsp">Login</a> |   
            <a href="profile.jsp">Profile</a>|
            <a href="classes.jsp">Classes</a>
            <hr>
            <a href="newClass.jsp">New Class</a>
            <hr>
            <br>
            <form  method="post" action="classes.jsp">
                Carrera:
                <select name="carrera" id="carrera">
                    <%
                        for (Carrera cr : carreras) {
                            out.println("<option value='" + cr.getIdCarrera() + "'>" + cr.getNombreCarrera() + "</option>");
                        }
                    %>
                </select>
                <input type="submit" id="actualizar" name="actualizar" value="Actualizar"><br>
            </form>
            <form method="post" action="DeleteClass.jsp">
                <table class="table table-condensed">
                    <thead >
                        <tr>
                            <td></td><td >ClaveHorario</td><td>ClaveMateria</td><td>claveCarrera</td><td>Materia</td><td>Carrera</td><td>Maestro</td><td>Periodo</td><td>Grupo</td><td>NoAlumnos</td><td>Semestre</td><td>Creditos</td><td>Lunes</td><td>Salon</td><td>Martes	</td><td>Salon	</td><td>Miercoles</td><td>Salon</td><td>Jueves	</td><td>Salon</td><td>Viernes<td>Salon</td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ProfDAO p = new ProfDAO();
                            String actualCar = request.getParameter("carrera");
                            //Carrera carrera = CarreraDAO.getCarrerbyId(); 
                            try {
                                FileWriter csvWriter = new FileWriter("new.csv");
                                csvWriter.append("ClaveHorario");
                                csvWriter.append(",");
                                csvWriter.append("ClaveMateria");
                                csvWriter.append(",");
                                csvWriter.append("ClaveCarrera");
                                csvWriter.append(",");
                                csvWriter.append("Materia");
                                csvWriter.append(",");
                                csvWriter.append("Carrera");
                                csvWriter.append(",");
                                csvWriter.append("Maestro");
                                csvWriter.append(",");
                                csvWriter.append("Periodo");
                                csvWriter.append(",");
                                csvWriter.append("Grupo");
                                csvWriter.append(",");
                                csvWriter.append("NoAlumnos");
                                csvWriter.append(",");
                                csvWriter.append("Semestre");
                                csvWriter.append(",");
                                csvWriter.append("Creditos");
                                csvWriter.append(",");
                                csvWriter.append("Lunes");
                                csvWriter.append(",");
                                csvWriter.append("Salon");
                                csvWriter.append(",");
                                csvWriter.append("Martes");
                                csvWriter.append(",");
                                csvWriter.append("Salon");
                                csvWriter.append(",");
                                csvWriter.append("Miercoles");
                                csvWriter.append(",");
                                csvWriter.append("Salon");
                                csvWriter.append(",");
                                csvWriter.append("Jueves");
                                csvWriter.append(",");
                                csvWriter.append("Salon");
                                csvWriter.append(",");
                                csvWriter.append("Viernes");
                                csvWriter.append("\n");
                                csvWriter.flush();
                                csvWriter.close();
                                Connection con = ProfDAO.getConnection();
                                PreparedStatement stmt = con.prepareStatement("Select  c.idClase, idHorario,c.idMateria,m.idCarrera,nombreMateria,nombreCarrera,nombreProf,periodo, grupo, numAlumnos , semestre,creditos, horLunes,salLunes,horMartes,salMartes,horMiercoles,salMiercoles,horJueves,salJueves,horViernes ,salViernes from clase c join materia m on  m.idMateria = c.idMateria join horario h on c.idClase = h.idClase join profe p on c.idProf=p.idProf join carrera s on s.idCarrera = m.idCarrera where m.idCarrera=?;");
                                stmt.setString(1, actualCar);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    csvWriter = new FileWriter("new.csv");
                                    csvWriter.append(rs.getString("idHorario"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("c.idMateria"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("m.idCarrera"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("nombreMateria"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("nombreCarrera"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("nombreProf"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("periodo"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("grupo"));
                                    csvWriter.append(",");
                                    csvWriter.append(""+rs.getInt("numAlumnos"));
                                    csvWriter.append(",");
                                    csvWriter.append(""+rs.getInt("semestre"));
                                    csvWriter.append(",");
                                    csvWriter.append(""+rs.getInt("creditos"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("horLunes"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("salLunes"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("horMartes"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("salMartes"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("horMiercoles"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("salMiercoles"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("horJueves"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("salJueves"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("horViernes"));
                                    csvWriter.append(",");
                                    csvWriter.append(rs.getString("salViernes"));
                                    csvWriter.append("\n");
                                    
                                    csvWriter.flush();
                                    csvWriter.close();
                        %>
                        <tr>

                            <td><a href="DeleteClass.jsp?idClase=<%=rs.getString("c.idClase")%>">Borrar</a></td>
                            <td><%=rs.getString("idHorario")%></td>
                            <td><%=rs.getString("c.idMateria")%></td>
                            <td><%=rs.getString("m.idCarrera")%></td>
                            <td><%=rs.getString("nombreMateria")%></td>
                            <td><%=rs.getString("nombreCarrera")%></td>
                            <td><%=rs.getString("nombreProf")%></td>
                            <td><%=rs.getString("periodo")%></td>
                            <td><%=rs.getString("grupo")%></td>
                            <td><%=rs.getInt("numAlumnos")%></td>
                            <td><%=rs.getInt("semestre")%></td>
                            <td><%=rs.getInt("creditos")%></td>
                            <td><%=rs.getString("horLunes")%></td>
                            <td><%=rs.getString("salLunes")%></td>
                            <td><%=rs.getString("horMartes")%></td>
                            <td><%=rs.getString("salMartes")%></td>      
                            <td><%=rs.getString("horMiercoles")%></td>
                            <td><%=rs.getString("salMiercoles")%></td>
                            <td><%=rs.getString("horJueves")%></td>
                            <td><%=rs.getString("salJueves")%></td>
                            <td><%=rs.getString("horViernes")%></td>
                            <td><%=rs.getString("salViernes")%></td>
                        </tr>
                        <%}
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }catch(IOException io){
                                io.printStackTrace();
                            }
                        %>
                    </tbody>
                    <tbody>
                </table>
            </form>
        </div>    
    </body>
</html>
