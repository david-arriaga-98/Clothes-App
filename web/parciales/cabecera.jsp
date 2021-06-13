<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    boolean estaConSession = false;
    String rol = "";
    Usuario usuario = (Usuario) session.getAttribute("user");
    if (usuario != null) {
        estaConSession = true;
        rol = usuario.rol;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark">
    
    
    <%  if(estaConSession) { %>
    
    <a class="navbar-brand text-secondary" href="<%=request.getContextPath()%><%=rol.equals("USER") ? "/index.jsp" : "/admin"%>" >
        <img src="<%=request.getContextPath()%>/assets/img/Logo.png" width="80px"  />
        Ropa Gallardo
    </a>
    
    <%  }  else {  %>
    
    <a class="navbar-brand text-secondary" href="<%=request.getContextPath()%>" >
        <img src="<%=request.getContextPath()%>/assets/img/Logo.png" width="80px"  />
        Ropa Gallardo
    </a>
    
    <%  }  %>
    
    <ul class="navbar-nav ml-auto">

        <%
            if (estaConSession) {
        %>

        <%
            if (rol.equals("USER")) {
        %>
        <li class="nav-item">
            <a class="nav-link text-secondary mr-3" href="<%=request.getContextPath()%>/ordenes-de-compra.jsp">Ordenes de compra</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-secondary mr-3" href="<%=request.getContextPath()%>/carrito-de-compras.jsp">Carrito de compras</a>
        </li>
        <% }%>


        <li class="nav-item">
            <a class="nav-link text-secondary" href="<%=request.getContextPath()%>/CerrarSesion">Cerrar Sesión</a>
        </li>
        <% } else {%>
        <li class="nav-item">
            <a class="nav-link text-secondary" href="<%=request.getContextPath()%>/login.jsp">Iniciar Sesión</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-secondary" href="<%=request.getContextPath()%>/register.jsp">Registrarse</a>
        </li>
        <% }%>

    </ul>
</nav>