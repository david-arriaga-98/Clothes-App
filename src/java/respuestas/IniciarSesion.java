package respuestas;

import entidades.EntidadUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.*;

@WebServlet(name = "IniciarSesion", urlPatterns = {"/IniciarSesion"})
public class IniciarSesion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            String cedula = request.getParameter("cedula");
            String contrasena = request.getParameter("contrasena");
            if (cedula.equals("") || contrasena.equals("")) {
                session.setAttribute("errorMsg", "Faltan campos por enviar");
                response.sendRedirect("login.jsp");
            } else {
                EntidadUsuario eu = new EntidadUsuario();
                Usuario usuario = eu.obtenerUsuario("cedula", cedula);

                if (usuario != null) {
                    if (contrasena.equals(usuario.clave)) {
                        session.setAttribute("user", usuario);

                        if (usuario.rol.equals("USER")) {
                            response.sendRedirect(request.getContextPath());
                            return;
                        } else if (usuario.rol.equals("ADMIN")) {
                            response.sendRedirect(request.getContextPath() + "/admin");
                            return;
                        }
                        session.setAttribute("errorMsg", "Rol desconocido");
                        response.sendRedirect("login.jsp");
                    }
                }
                session.setAttribute("errorMsg", "Usuario y/o Contraseña incorrectos");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Ha ocurrido un error en el sistema");
            response.sendRedirect("login.jsp");
        }
    }

}
