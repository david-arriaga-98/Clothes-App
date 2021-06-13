package respuestas;

import entidades.EntidadUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import modelos.Usuario;

@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            String cedula = request.getParameter("cedula");
            String nombre = request.getParameter("nombre");
            String sexo = request.getParameter("sexo");
            String fechaNacimiento = request.getParameter("fecha_nacimiento");

            String contrasena = request.getParameter("contrasena");
            String confContrasena = request.getParameter("conf_contrasena");

            if (cedula.equals("") || nombre.equals("") || sexo.equals("") || fechaNacimiento.equals("") || contrasena.equals("") || confContrasena.equals("")) {
                session.setAttribute("errorMsg", "Faltan campos por enviar");
                response.sendRedirect("register.jsp");
            } else {
                EntidadUsuario eu = new EntidadUsuario();
                Usuario usuario = eu.obtenerUsuario("cedula", cedula);
                String errorMsg;
                if (usuario == null) {
                    if (contrasena.equals(confContrasena)) {

                        Usuario crearUsuario = new Usuario();
                        crearUsuario.cedula = cedula;
                        crearUsuario.nombre = nombre;
                        crearUsuario.clave = contrasena;
                        crearUsuario.sexo = sexo;
                        crearUsuario.rol = "USER";
                        crearUsuario.fecha_nacimiento = fechaNacimiento;

                        int resultado = eu.guardarUsuario(crearUsuario);
                        if (resultado == 1) {
                            session.setAttribute("errorMsg", "Usuario guardado correctamente");
                            response.sendRedirect("login.jsp");
                            return;
                        } else {
                            errorMsg = "El usuario no se guardó";

                        }
                    } else {
                        errorMsg = "Las contraseñas no coinciden";
                    }
                } else {
                    errorMsg = "El usuario ya existe";
                }
                session.setAttribute("errorMsg", errorMsg);
                response.sendRedirect("register.jsp");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Ha ocurrido un error en el sistema");
        }
    }

}
