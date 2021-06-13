<%@page import="entidades.EntidadCategoria"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Categoria"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administracion de catálogo</title>
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
            List<Categoria> categorias = null;
            try {
                EntidadCategoria entidadCategoria = new EntidadCategoria();
                categorias = entidadCategoria.obtenerCategorias();
            } catch (Exception e) {
                errorMsg = "Ha ocurrido un error al obtener los elementos";
            }
        %>
    </head>
    <body>
        <jsp:include page="../../parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <h3 class="text-secondary mb-3 text-center">Gestión del catálogo</h3>

                    <div class="row justify-content-center mt-4">
                        <div class="col-md-6">
                            <form method="POST" action="<%=request.getContextPath()%>/Catalogo" enctype="multipart/form-data">

                                <div class="row justify-content-center">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="nombre">Nombre</label>
                                            <input type="text" required class="form-control" id="nombre" name="nombre">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="descripcion">Descripción</label>
                                            <input type="text" required class="form-control" id="descripcion" name="descripcion">
                                        </div>
                                    </div>
                                </div>

                                <div class="row justify-content-center">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="precio">Precio</label>
                                            <input type="number" required step="0.01" class="form-control" id="precio" name="precio">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="costo">Costo</label>
                                            <input type="number" required step="0.01" class="form-control" id="costo" name="costo">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="cantidad">Cantidad</label>
                                            <input type="number" required class="form-control" id="cantidad" name="cantidad">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="categoria">Categoría</label>
                                    <select id="categoria" class="form-control" name="categoria">
                                        <option value="-1" >--- Escoger ---</option>
                                        <% for (Categoria categoria : categorias) {%>
                                        <option value="<%=categoria.id_categoria%>"><%=categoria.nombre%></option>
                                        <% }%>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="imagen">Imagen</label>
                                    <input type="file" required class="form-control-file" id="imagen" name="imagen">
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary btn-block">Guardar Catálogo</button>
                                </div>
                        </div>
                    </div>
                    </form>

                    <%
                        String value = (String) session.getAttribute("catErrorMsg");
                        session.removeAttribute("catErrorMsg");
                    %>
                    <% if (value != null) {%>
                    <p class="text-center"><%=value%></p>
                    <% }%>

                </div>
            </div>


        </div>
    </div>
</div>

</body>
</html>
