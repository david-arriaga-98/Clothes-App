package respuestas;

import entidades.EntidadCarro;
import entidades.EntidadCatalogoEnCarro;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Carro;
import modelos.ProductoEnCarro;

@WebServlet(name = "Carrito", urlPatterns = {"/Carrito"})
public class Carrito extends HttpServlet {

    public void guardarCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorMsg;
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            String cantidad = request.getParameter("cantidad");
            String id = request.getParameter("id");
            String cedula = request.getParameter("cedula");
            String preciou = request.getParameter("preciou");

            if (cantidad.equals("") || id.equals("") || cedula.equals("")) {
                errorMsg = "Todos los campos son requeridos";
            } else {
                EntidadCarro ec = new EntidadCarro();
                Carro carro = new Carro();
                // Buscamos el carro abierto
                List<Carro> carros = ec.obtenerCarros(cedula, true);
                if (carros.isEmpty()) {
                    carro.usuario = cedula;
                    ec.crearCarro(carro);
                    carros = ec.obtenerCarros(cedula, true);
                }
                Carro ca = carros.get(0);

                ProductoEnCarro pec = new ProductoEnCarro();
                pec.cantidad = Integer.parseInt(cantidad);
                pec.carro = ca.id_carro;
                pec.catalogo = Integer.parseInt(id);
                pec.precio = pec.cantidad * Double.parseDouble(preciou);

                EntidadCatalogoEnCarro ecc = new EntidadCatalogoEnCarro();
                int estado = ecc.crearProductoEnCarro(pec);
                if (estado == 1) {
                    errorMsg = "Guardado correctamente";
                } else {
                    errorMsg = "No se guardó";
                }
            }
            session.setAttribute("errorMsg", errorMsg);
            response.sendRedirect(request.getContextPath() + "/carrito-de-compras.jsp");
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Ha ocurrido un error al ejecutar esta petición");
            response.sendRedirect(request.getContextPath() + "/carrito-de-compras.jsp");
        }
    }

    public void cerrarCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            EntidadCarro ec = new EntidadCarro();
            ec.cerrarCarrito();
            session.setAttribute("mensaje", "Carrito guardado correctamente");
            response.sendRedirect(request.getContextPath() + "/carrito-de-compras.jsp");
        } catch (Exception e) {
            session.setAttribute("mensaje", "Ha ocurrido un error al ejecutar esta petición");
            response.sendRedirect(request.getContextPath() + "/carrito-de-compras.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        switch (opcion) {
            case "cerrar":
                cerrarCarrito(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String opcion = request.getParameter("opcion");
        switch (opcion) {
            case "guardar":
                guardarCarrito(request, response);
                break;
        }
    }

}
