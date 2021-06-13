<%-- 
    Document   : ordenes-de-compra
    Created on : 08/03/2021, 22:08:20
    Author     : braya
--%>

<%@page import="modelos.OrdenDeCompra"%>
<%@page import="java.util.List"%>
<%@page import="entidades.EntidadCarro"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ropa Gallardo | Ordenes</title>
        <link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.css" />
        <link rel="stylesheet" href="styles.css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;700&display=swap" rel="stylesheet">
        <%
            Usuario usuario = (Usuario) session.getAttribute("user");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            EntidadCarro ec = new EntidadCarro();
            List<OrdenDeCompra> ordenes = null;
            String error = "";
            try {
                ordenes = ec.obtenerOrdenes(usuario.cedula);
            } catch (Exception e) {
                error = "Ha ocurrido un error";
            }

        %>
    </head>
    <body>
        <jsp:include page="parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <h3 class="text-secondary mb-3 text-center">Ordenes de compra</h3>
            </div>
            <div class="row justify-content-center">


                <% if (error.equals("")) { %>


                <% for (OrdenDeCompra oc : ordenes) {%>

                <div class="col-md-3 mt-3">
                    <div class="card">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <p class="card-title text-center">Orden número: <span class="text-secondary"><%=oc.carro%></span></p>
                            <p class="card-title text-center">Total en compras: <span class="text-secondary">$ <%=oc.precio%></span></p>
                            <p class="card-title text-center">Cantidad: <span class="text-secondary"><%=oc.cantidad%></span></p>
                        </div>
                    </div>
                </div>


                <% } %>


                <% } else {%>

                <p class="text-center text-secondary"><%=error%></p>

                <% }%>

            </div>
        </div>
    </body>
</html>
