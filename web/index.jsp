<%@page import="java.util.List"%>
<%@page import="modelos.CatalogoConCategoria"%>
<%@page import="entidades.EntidadCatalogo"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ropa Gallardo | Principal</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">
        <%
            EntidadCatalogo ec = new EntidadCatalogo();
            List<CatalogoConCategoria> ct = null;

            String errorMsg = "";
            try {
                ct = ec.obtenerCatalogoConCategoria(-1);
            } catch (Exception e) {
                errorMsg = "Ha ocurrido un error al obtener los datos";
            }

        %>
    </head>
    <body>
        <jsp:include page="parciales/cabecera.jsp"/>

        <!--Listamos las categorias con sus productos-->

        <div class="container">
            <div class="row justify-content-center">
                <h3 class="text-secondary mb-3 text-center">Catálogo disponible</h3>

            </div>
            <div class="row justify-content-center">

                <% if (errorMsg.equals("")) { %>


                <% if (ct.size() == 0) {%>

                <p class="text-secondary text-center">No hay ningun artículo ingresado</p>

                <% } else { %>

                <% for (CatalogoConCategoria c : ct) {%>

                <div class="col-md-3 mt-3">
                    <div class="card">
                        <img height="250px" width="75%" src="<%=request.getContextPath() + "/assets/productos/" + c.imagen%>" class="card-img-top" alt="<%=c.nombre_catalogo%>">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <p class="card-title text-center"><%=c.nombre_catalogo%></p>
                            <p class="text-center text-secondary">$ <%=c.precio_unitario%></p>
                            <a class="btn btn-secondary btn-sm text-center" href="catalogo.jsp?id=<%=c.id_catalogo%>">ver</a>
                        </div>
                    </div>
                </div>

                <% } %>



                <% } %>



                <% } else {%>

                <p class="text-center"><%=errorMsg%></p>

                <% }%>

            </div>

        </div>
    </body>
</html>
