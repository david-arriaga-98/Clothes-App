<%@page import="java.sql.SQLException"%>
<%@page import="modelos.CatalogoConCategoria"%>
<%@page import="java.util.List"%>
<%@page import="entidades.EntidadCatalogo"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <title>Catálogo</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">

        <%

            boolean estaConSession = false;

            Usuario usuario = (Usuario) session.getAttribute("user");
            if (usuario != null) {
                estaConSession = true;
            }

            EntidadCatalogo ec = new EntidadCatalogo();
            List<CatalogoConCategoria> ct = null;

            String errorMsg = "";
            String id = "";
            try {
                id = (String) request.getParameter("id");
                int idc = Integer.parseInt(id);
                ct = ec.obtenerCatalogoConCategoria(idc);
            } catch (SQLException e) {
                errorMsg = "Ha ocurrido un error al obtener los datos";
            } catch (NumberFormatException e) {
                errorMsg = "El id no es válido";
            }

        %>


    </head>
    <body>
        <jsp:include page="parciales/cabecera.jsp"/>

        <div class="container">
            <div class="row justify-content-center">

                <% if (errorMsg.equals("")) { %>


                <% if (ct.size() == 0) {%>

                <p class="text-secondary text-center">No hay ningun artículo ingresado</p>

                <% } else { %>

                <% for (CatalogoConCategoria c : ct) {%>

                <div class="col-md-4 mt-3">
                    <div class="card">
                        <img height="250px" width="75%" src="<%=request.getContextPath() + "/assets/productos/" + c.imagen%>" class="card-img-top" alt="<%=c.nombre_catalogo%>">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <p class="card-title text-center"><%=c.nombre_catalogo%></p>
                            <p class="text-center text-secondary">$ <%=c.precio_unitario%></p>
                            <p class="card-title text-center">Categoría</p>
                            <p class="text-secondary text-center"><%=c.nombre_categoria%></p>

                            <% if (estaConSession) {%>

                            <p class="card-title text-center">Cantidad a comprar</p>

                            <form class="form" method="POST" action="<%=request.getContextPath()%>/Carrito?opcion=guardar" >
                                <input required type="number" class="form-control" name="cantidad"/>
                                <input type="hidden" name="id" value="<%=id%>" />
                                <input type="hidden" name="cedula" value="<%=usuario.cedula%>" />
                                <input type="hidden" name="preciou" value="<%=c.precio_unitario%>" />
                                <button type="submit" class="btn btn-secondary btn-block text-center mt-3">Escoger</button>
                            </form>

                            <%  }  %>

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
