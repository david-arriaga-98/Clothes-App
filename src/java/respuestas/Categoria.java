package respuestas;

import entidades.EntidadCategoria;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Categoria", urlPatterns = {"/Categoria"})
public class Categoria extends HttpServlet {

    public void guardarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorMsg = "";
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");

            if (descripcion.equals("") || nombre.equals("")) {
                errorMsg = "Todos los campos son requeridos";
            } else {

                EntidadCategoria ec = new EntidadCategoria();
                modelos.Categoria categoria = new modelos.Categoria();
                categoria.nombre = nombre;
                categoria.descripcion = descripcion;
                int resultado = ec.guardarCategoria(categoria);
                if (resultado == 0) {
                    errorMsg = "La categoría no se guardó";
                }
            }
            session.setAttribute("errorMsg", errorMsg);
            response.sendRedirect(request.getContextPath() + "/admin/categoria.jsp");
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Ha ocurrido un error al ejecutar esta petición");
            response.sendRedirect(request.getContextPath() + "/admin/categoria.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String opcion = request.getParameter("opcion");
            switch (opcion) {
                case "guardar":
                    guardarCategoria(request, response);
                    break;
            }
        } catch (IOException | ServletException e) {
            throw e;
        }
    }

}
