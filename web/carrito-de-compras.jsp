<%@page import="modelos.ProductoEnCarro"%>
<%@page import="entidades.EntidadCatalogoEnCarro"%>
<%@page import="modelos.Carro"%>
<%@page import="java.util.List"%>
<%@page import="entidades.EntidadCarro"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ropa Gallardo | Carrito</title>
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
            EntidadCatalogoEnCarro ecc = new EntidadCatalogoEnCarro();
            List<Carro> carros = null;
            List<ProductoEnCarro> pc = null;
            String errorMsg = "";
            int productos = 0;
            double totalAPagar = 0;
            try {
                carros = ec.obtenerCarros(usuario.cedula, true);
                if (!carros.isEmpty()) {
                    Carro ca = carros.get(0);
                    pc = ecc.obtenerProductosEnCarro(ca.id_carro);
                } else {
                    errorMsg = "No hay productos en el carrito";
                }
            } catch (Exception e) {
                errorMsg = e.getMessage();
            }
        %>
    </head>
    <body>
        <jsp:include page="parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <h3 class="text-secondary mb-3 text-center">Carrito de compra</h3>
            </div>
            <div class="row justify-content-center">

                <% if (!errorMsg.equals("")) {%>

                <p class="text-secondary text-center"><%=errorMsg%></p>

                <% } else { %>


                <% if (carros == null) { %>

                <p class="text-secondary text-center">No hay elementos en el carrito de compra</p>

                <% } else { %>



                <% for (ProductoEnCarro pec : pc) {

                        productos += pec.cantidad;
                        totalAPagar += pec.precio;

                %>

                <div class="col-md-3 mt-3">
                    <div class="card">
                        <img height="250px" width="75%" src="<%=request.getContextPath() + "/assets/productos/" + pec.imagen%>" class="card-img-top" alt="<%=pec.nombre%>">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <p class="card-title text-center"><%=pec.nombre%></p>
                            <p class="text-center text-secondary">$ <%=pec.precio_unitario%></p>
                            <p class="card-title text-center">Cantidad: <span class="text-secondary"><%=pec.cantidad%></span></p>
                            <p class="card-title text-center">Total a pagar: <span class="text-secondary">$<%=pec.precio%></span></p>
                        </div>
                    </div>
                </div>

                <% }%>



                <% }%>


                <% }%>


            </div>

            <div class="row justify-content-center">
                <div class="col-md-3 mt-3">
                    <div class="card">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <p>Total a pagar:</p>
                            <p class="text-center text-secondary">$ <%=totalAPagar%></p>
                            <p>Cantidades compradas:</p>
                            <p class="text-center text-secondary"><%=productos%></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center mt-3 mb-3">
                <a class="btn btn-secondary" href="<%=request.getContextPath() + "/Carrito?opcion=cerrar"%>">Pagar carrito</a>
            </div>

        </div>

    </body>
</html>
