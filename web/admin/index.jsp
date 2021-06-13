<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">
        <%
            Usuario usuario = (Usuario) session.getAttribute("user");
            if (usuario == null) {
                response.sendRedirect(request.getContextPath() + "login.jsp");
                return;
            } else {
                if (usuario.rol.equals("USER")) {
                    response.sendRedirect(request.getContextPath());
                    return;
                }
            }
        %>
    </head>
    <body>
        <jsp:include page="../parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <h3 class="text-secondary mb-3 text-center">Panel de administración</h3>
                    <div class="row mt-5">
                        <div class="col-md-4 text-center">
                            <a class="text-secondary" href="usuarios.jsp">
                                <img src="<%=request.getContextPath()%>/assets/img/usuario.png" width="75px"/>
                                Usuarios
                            </a>
                        </div>
                        <div class="col-md-4 text-center">
                            <a class="text-secondary" href="catalogo">
                                <img src="<%=request.getContextPath()%>/assets/img/catalogo.png" width="75px"/>
                                Catalogos
                            </a>
                        </div>
                        <div class="col-md-4 text-center">
                            <a class="text-secondary" href="categoria.jsp">
                                <img src="<%=request.getContextPath()%>/assets/img/categoria.png" width="75px" />
                                Categorías
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
