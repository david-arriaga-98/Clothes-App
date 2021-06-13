<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">

        <%

            Usuario usuario = (Usuario) session.getAttribute("user");
            if (usuario != null) {
                response.sendRedirect("index.jsp");
                return;
            }

        %>

    </head>
    <body>
        <jsp:include page="parciales/cabecera.jsp"/>

        <div class="container">

            <div class="row justify-content-center">
                <div class="col-md-4">
                    <h3 class="text-secondary mb-3 text-center">Ingrese a su cuenta</h3>
                    <form method="POST" action="IniciarSesion">
                        <div class="form-group">
                            <label for="cedula" >Cédula</label>
                            <input type="text" required class="form-control" id="cedula" name="cedula" placeholder="Ingrese su cédula">
                        </div>
                        <div class="form-group">
                            <label for="contrasena" >Contraseña</label>
                            <input type="password" required class="form-control" id="contrasena" name="contrasena" placeholder="Ingrese su contraseña">
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-secondary btn-block">Iniciar Sesión</button>
                        </div>
                    </form>

                    <%                
                        String value = (String) session.getAttribute("errorMsg");
                        session.removeAttribute("errorMsg");
                    %>
                    <% if (value != null) {%>
                    <p class="text-center"><%=value%></p>
                    <% }%>
                </div>
            </div>
        </div>
    </body>
</html>


