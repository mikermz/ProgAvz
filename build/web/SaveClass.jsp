<%-- 
    Document   : SaveClass
    Created on : 11/12/2020, 06:47:08 PM
    Author     : jaime.infante
--%>
<%@page import="com.tecleon.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Saving!</h1>
        <%
            
            String idProf = request.getParameter("prof");
            String idMat = request.getParameter("mat");
            String grupo = request.getParameter("grupo");
            String idClase = request.getParameter("claveClase");
            Clase cl = new Clase();

            cl.setIdClase(idClase);
            cl.setIdProfe(Integer.parseInt(idProf));
            cl.setIdMateria(idMat);
            cl.setGrupo(grupo);
            cl.setNumAlumnos(0);

            int statusClase = ClaseDAO.saveClase(cl);

            String salon = request.getParameter("salon");
            String horario = request.getParameter("horario");
            String lunes = request.getParameter("lunes");
            String martes = request.getParameter("martes");
            String miercoles = request.getParameter("miercoles");
            String jueves = request.getParameter("jueves");
            String viernes = request.getParameter("viernes");

            Horario hor = new Horario();

            hor.setIdClase(idClase);
            if (lunes != null) {
                hor.setHorLunes(horario);
                hor.setSalLunes(salon);
            } else {
                hor.setHorLunes("");
                hor.setSalLunes("");
            }

            if (martes != null) {
                hor.setHorMartes(horario);
                hor.setSalMartes(salon);
            } else {
                hor.setHorMartes("");
                hor.setSalMartes("");
            }
            if (miercoles != null) {
                hor.setHorMiercoles(horario);
                hor.setSalMiercoles(salon);
            } else {
                hor.setHorMiercoles("");
                hor.setSalMiercoles("");
            }
            if (jueves != null) {
                hor.setHorJueves(horario);
                hor.setSalJueves(salon);
            } else {
                hor.setHorJueves("");
                hor.setSalJueves("");
            }
            if (viernes != null) {
                hor.setHorViernes(horario);
                hor.setSalViernes(salon);
            } else {
                hor.setHorViernes("");
                hor.setSalViernes("");
            }
            hor.setPeriodo("Agosto-Diciembre");

            boolean empalma = HorarioDAO.horarioEmpalma(cl.getIdProfe(), hor.getHorLunes(), hor.getHorMartes(),
                    hor.getHorMiercoles(), hor.getHorJueves(), hor.getHorViernes());

            int statusHor = 0;
            if (empalma == false) {
                statusHor = HorarioDAO.saveHorario(hor);
            } else {
                out.println("Sorry! Hay otra clase en ese horario");
                statusClase = ClaseDAO.delete(idClase);
            }

            if (statusHor > 0 && statusClase > 0) {
                out.println("<p>Record saved successfully! </p>");
                out.print("<script>location.replace('classes.jsp');</script>");
            } else {
                out.println("Sorry! unable to save record");
            }
             
        %>
    </body>
</html>
