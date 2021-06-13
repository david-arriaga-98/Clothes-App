<%@page import="modelos.Catalogo"%>
<%@page import="entidades.EntidadCatalogo"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administracion de categorías</title>
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

            String idCatalogo = request.getParameter("id");
            EntidadCatalogo ec = new EntidadCatalogo();

            Catalogo cat = null;
            String errorMsg;

            try {
                if (idCatalogo != null) {
                    cat = ec.obtenerCatalogo("id_catalogo", idCatalogo);
                }
            } catch (Exception e) {
                errorMsg = "Ha ocurrido un error al obtener este registro";
            }

        %>
    </head>
    <body>
        <jsp:include page="../../parciales/cabecera.jsp"/>

        <div class="container">
            <div class="row justify-content-center mt-5">
                <div class="col-md-9">

                    <% if (idCatalogo == null) { %>
                    <p class="text-center text-secondary">Debes brindar un id</p>
                    <% } else {%>


                    <% if (cat == null) { %>
                    <p class="text-center text-secondary">Este artículo no existe</p>
                    <% } else {%>



                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <img src="<%=request.getContextPath() + "/assets/productos/" + cat.imagen%>" class="rounded" width="90%" height="80%" />
                        </div>
                        <div class="col-md-6">

                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="nombre">Nombre</label>
                                        <input type="text" value="<%=cat.nombre%>" class="form-control" id="nombre" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="descripcion">Descripción</label>
                                        <input type="text" value="<%=cat.descripcion%>" class="form-control" id="descripcion" readonly>
                                    </div>
                                </div>
                            </div>


                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="precio">Precio</label>
                                        <input type="number" value="<%=cat.precio_unitario%>" step="0.01" class="form-control" id="precio" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="costo">Costo</label>
                                        <input type="number" value="<%=cat.costo_unitario%>" step="0.01" class="form-control" id="costo" readonly>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <% } %>
                    <% }%>


                </div>
            </div>
        </div>

    </body>
</html>
