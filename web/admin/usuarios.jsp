<%@page import="java.util.List"%>
<%@page import="entidades.EntidadUsuario"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administracion de usuarios</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">
        <%
            Usuario usuario = (Usuario) session.getAttribute("user");
            if (usuario == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            } else {
                if (usuario.rol.equals("USER")) {
                    response.sendRedirect(request.getContextPath());
                    return;
                }
            }
            String errorMsg = "";
            List<Usuario> usuarios = null;
            try {
                EntidadUsuario entidadUsuario = new EntidadUsuario();
                usuarios = entidadUsuario.obtenerUsuarios();
            } catch (Exception e) {
                errorMsg = "Ha ocurrido un error al obtener los elementos";
            }
        %>
    </head>
    <body>
        <jsp:include page="../parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col">
                    <h3 class="text-secondary mb-3 text-center">Usuarios registrados en el sistema</h3>
                    <%
                        if (errorMsg.equals("")) {
                    %>

                    <table class="table mt-5">
                        <thead>
                            <tr>
                                <th scope="col">Cédula</th>
                                <th scope="col">Nombres</th>
                                <th scope="col">Género</th>
                                <th scope="col">Fecha de nacimiento</th>
                                <th scope="col">Rol</th>
                                <th scope="col">Fecha de creación</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% for (Usuario usua : usuarios) {%>
                            <tr>
                                <th scope="row"><%=usua.cedula%></th>
                                <td><%=usua.nombre%></td>
                                <td><%=usua.sexo.equals("M") ? "Masculino" : "Femenino"%></td>
                                <td><%=usua.fecha_nacimiento%></td>
                                <td><%=usua.rol.equals("ADMIN") ? "Administrador" : "Usuario"%></td>
                                <td><%=usua.fecha_creacion%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>

                    <%
                    } else {
                    %>

                    <p class="text-center"><%=errorMsg%></p>

                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
