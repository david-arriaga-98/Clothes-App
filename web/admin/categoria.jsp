<%@page import="entidades.EntidadCategoria"%>
<%@page import="modelos.Categoria"%>
<%@page import="java.util.List"%>
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
        <jsp:include page="../parciales/cabecera.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <h3 class="text-secondary mb-3 text-center">Gestión de categorías</h3>

                    <div class="row justify-content-center mt-4">

                        <div class="col-md-4">
                            <form method="POST" action="<%=request.getContextPath()%>/Categoria?opcion=guardar">
                                <div class="form-group">
                                    <label for="nombre" >Nombre</label>
                                    <input type="text" required class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre">
                                </div>
                                <div class="form-group">
                                    <label for="descripcion" >Descripción</label>
                                    <input type="text" required class="form-control" id="descripcion" name="descripcion" placeholder="Ingrese la descripcíón">
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary btn-block">Guardar Categoría</button>
                                </div>
                            </form>
                        </div>
                    </div>


                    <%
                        if (errorMsg.equals("")) {
                    %>

                    <%
                        if (categorias.size() == 0) {
                    %>
                    <p class="text-secondary text-center">No hay ninguna categoría ingresada</p>
                    <%
                    } else {
                    %>

                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Fecha de creación</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% for (Categoria categ : categorias) {%>
                            <tr>
                                <th scope="row"><%=categ.id_categoria%></th>
                                <td><%=categ.nombre%></td>
                                <td><%=categ.descripcion%></td>
                                <td><%=categ.fecha_creacion%></td>
                            </tr>
                            <% } %>

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
            </div>
    </body>
</html>
