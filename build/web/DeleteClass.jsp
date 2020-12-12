<%@page import="com.tecleon.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String sid = request.getParameter("idClase");


            Horario hr = HorarioDAO.getHorarioByIdClase(sid);
            
            int statushor = HorarioDAO.delete(hr.getIdHorario());
            int statuscl = ClaseDAO.delete(sid);
            
            out.println(statuscl);
            out.println(statushor);
            
            if (statushor > 0 && statuscl >0) {
                    out.println("<p>Record saved successfully! </p>");
                    out.print("<script>location.replace('classes.jsp');</script>");
                } else {
                    out.println("Sorry! unable to save record");
                }
            
        %>
        <h1>Deleting!</h1>
    </body>
</html>
