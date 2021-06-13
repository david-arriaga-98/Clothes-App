<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de usuario</title>
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
        <div class="row justify-content-center">
            <div class="col-md-4">
                <h3 class="text-secondary mb-3 text-center">Ingrese sus datos</h3>
                <form method="POST" action="Registro">
                    <div class="form-group">
                        <label for="cedula" >Cédula</label>
                        <input type="text" required class="form-control" id="cedula" name="cedula" placeholder="Ingrese su cédula">
                    </div>

                    <div class="form-group">
                        <label for="nombre" >Nombres</label>
                        <input type="text" required class="form-control" id="nombre" name="nombre" placeholder="Ingrese sus nombres">
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="sexo">Género:</label>
                                <select id="sexo" class="form-control" name="sexo">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fecha_nacimiento">Fecha de nacimiento:</label>
                                <input type="date" class="form-control" required id="fecha_nacimiento" name="fecha_nacimiento" />
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="contrasena" >Contraseña</label>
                                <input type="password" required class="form-control" id="contrasena" name="contrasena" placeholder="Ingrese su contraseña">
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="conf_contrasena">Confirmar contraseña</label>
                                <input type="password" required class="form-control" id="conf_contrasena" name="conf_contrasena" placeholder="Confirme su contraseña">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-secondary btn-block">Registrarme</button>
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

    </body>
</html>
