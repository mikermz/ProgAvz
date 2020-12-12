<%@page import="java.util.*"%>
<%@page import="com.tecleon.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Class</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            String[] grupos = {"A", "B", "C", "D", "E", "F"};
            List<Prof> profes = ProfDAO.getAllProf();
            List<Materia> materias = MateriaDAO.getAllMaterias();
        %>
        <div class="menu">
            <hr>
            <h1>New Class</h1>
            <hr>
            <a href="login.jsp">Login</a> |   
            <a href="profile.jsp">Profile</a>|
            <a href="classes.jsp">Classes</a>
            <hr>
            <br>
        </div>
        <div class="container">

            <form method="post" action="SaveClass.jsp" class="form-horizontal">
                <div class="form-group">
                    <label for="claveClase">Clave Grupo:</label>
                    <input type="text" name="claveClase" id="claveClase" class="form-control" >
                </div>
                <div class="form-group">
                    <label for="prof">Professor:</label>
                    <select name="prof" id="prof" class="custom-select">
                        <%
                            for (Prof c : profes) {
                                out.println("<option value='" + c.getIdProf() + "'>" + c.getNombreProf() + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="prof">Materia:</label>
                    <select name="mat" id="mat" class="custom-select">
                        <%
                            for (Materia c : materias) {
                                out.println("<option value='" + c.getIdMateria() + "'>" + c.getNombreMateria() + "</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="grupo">Grupo:</label>
                    <select name="grupo" id="grupo"  class="custom-select">
                        <%
                            for (String c : grupos) {
                                out.println("<option value='" + c + "'>" + c + "</option>");
                            }
                        %>
                    </select>
                </div>


                <div class="form-group">
                    <label for="salon">Salon:</label>
                    <input type="text" name="salon" id="salon" class="form-control">
                </div>

                <div class="form-check">
                    <input type="checkbox" id="lunes" name="lunes" value="lunes" class="form-check-input">                
                    <label for="lunes" class="form-check-label"> Lunes</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" id="martes" name="martes" value="martes" class="form-check-input">
                    <label for="martes" class="form-check-label"> Martes</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" id="miercoles" name="miercoles" value="miercoles" class="form-check-input">
                    <label for="miercoles" class="form-check-label"> Miercoles</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" id="jueves" name="jueves" value="jueves" class="form-check-input">
                    <label for="jueves" class="form-check-label"> Jueves</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" id="viernes" name="viernes" value="viernes" class="form-check-input">
                    <label for="viernes" class="form-check-label"> Viernes</label>
                </div>


                <div class="form-group">
                    <label for="horario">Horario:</label>
                    <select name="horario" id="horario" class="custom-select">
                        <option value="7:00-8:40">7:00-8:40</option>
                        <option value="8:40-10:30">8:40-10:30</option>
                        <option value="10:30-12:10">10:30-12:10</option>
                        <option value="12:10-1:50">12:10-1:50</option>
                    </select>  
                </div>

                <input type="submit" class="btn btn-default" value="Guardar">
            </form>
        </div>
        


    </body>
</html>
