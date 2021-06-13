<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entidades.EntidadCatalogo"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Catalogo"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administración de catálogo</title>
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
            List<Catalogo> catalogos = null;
            try {
                EntidadCatalogo entidadCatalogo = new EntidadCatalogo();
                catalogos = entidadCatalogo.obtenerCatalogos();
            } catch (Exception e) {
                errorMsg = "Ha ocurrido un error al obtener los elementos";
            }
        %>

    </head>
    <body>
        <jsp:include page="../../parciales/cabecera.jsp"/>
        <div class="container">
            <h3 class="text-secondary mb-3 text-center">Gestión de catálogo</h3>

            <a class="btn btn-info mb-3" href="crear.jsp">Crear catálogo</a>
            <%
                if (errorMsg.equals("")) {
            %>

            <%
                if (catalogos.size() == 0) {
            %>
            <p class="text-secondary text-center">No hay ningun catálogo ingresado</p>
            <%
            } else {
            %>

            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Categoria</th>
                        <th scope="col">Precio</th>
                        <th scope="col">Costo</th>
                        <th scope="col">Descripcion</th>
                        <th scope="col">Fecha de Creación</th>
                        <th scope="col">Accion</th>
                    </tr>
                </thead>
                <tbody>

                    <% for (Catalogo c : catalogos) {%>
                    <tr>
                        <th scope="row"><%=c.id_catalogo%></th>
                        <td><%=c.nombre%></td>
                        <td><%=c.id_categoria%></td>
                        <td><%=c.precio_unitario%></td>
                        <td><%=c.costo_unitario%></td>
                        <td><%=c.descripcion%></td>
                        <td><%=c.fecha_creacion%></td>
                        <td>
                            <a class="btn btn-info btn-sm" href="ver.jsp?id=<%=c.id_catalogo%>">Ver</a>
                        </td>

                    </tr>
                    <% }%>

                </tbody>
            </table>

            <%}%>

            <%
            } else {
            %>

            <p class="text-center"><%=errorMsg%></p>

            <%
                }
            %>


        </div>




    </body>
</html>
