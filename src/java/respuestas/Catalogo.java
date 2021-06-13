package respuestas;

import entidades.EntidadCatalogo;
import entidades.EntidadCategoria;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "Catalogo", urlPatterns = {"/Catalogo"})
public class Catalogo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        String errorMsg = "Hay elementos inválidos";
        try {
            FileItemFactory file = new DiskFileItemFactory();
            ServletFileUpload fileUpload = new ServletFileUpload(file);
            List items = fileUpload.parseRequest(request);
            
            modelos.Catalogo catalogo = new modelos.Catalogo();

            String nombre = "";
            String descripcion = "";
            String precio = "";
            String costo = "";
            String categoria = "";

            for (int i = 0; i < items.size(); i++) {
                FileItem fileItem = (FileItem) items.get(i);
                if (!fileItem.isFormField()) {

                    String imageName = fileItem.getName();
                    String[] element = imageName.split("\\.");
                    String uuid = UUID.randomUUID().toString();
                    File files = new File(getServletContext().getRealPath("/") + "assets\\productos\\" + uuid + "." + element[1]);
                    fileItem.write(files);
                    catalogo.imagen = uuid + "." + element[1];
                    
                } else {
                    switch (fileItem.getFieldName()) {
                        case "nombre":
                            nombre = fileItem.getString();
                            break;
                        case "descripcion":
                            descripcion = fileItem.getString();
                            break;
                        case "precio":
                            precio = fileItem.getString();
                            break;
                        case "costo":
                            costo = fileItem.getString();
                            break;
                        case "categoria":
                            categoria = fileItem.getString();
                            break;
                    }
                }
            }

            if (nombre.equals("") || descripcion.equals("") || precio.equals("") || costo.equals("")  || categoria.equals("")) {
                errorMsg = "Todos los campos son requeridos";
            } else {
                double precioo = Double.parseDouble(precio);
                double costoo = Double.parseDouble(costo);
                int categoriaa = Integer.parseInt(categoria);

                if (categoriaa == -1) {
                    errorMsg = "Debes escoger una categoría";
                } else {
                    EntidadCategoria ec = new EntidadCategoria();
                    modelos.Categoria categ = ec.obtenerCategoria("id_categoria", Integer.toString(categoriaa));
                    if (categ == null) {
                        errorMsg = "La categoría no existe";
                    } else {
                        catalogo.precio_unitario = precioo;
                        catalogo.costo_unitario = costoo;
                        catalogo.nombre = nombre;
                        catalogo.descripcion = descripcion;
                        catalogo.id_categoria = categoriaa;

                        EntidadCatalogo eco = new EntidadCatalogo();
                        int resultado = eco.guardarCatalogo(catalogo);

                        if (resultado == 1) {
                             response.sendRedirect(request.getContextPath() + "/admin/catalogo/");
                            return;
                        } else {
                            errorMsg = "El catálogo no se guardó";
                        }
                    }
                }
            }
            session.setAttribute("catErrorMsg", errorMsg);
            response.sendRedirect(request.getContextPath() + "/admin/catalogo/crear.jsp");
        } catch (Exception e) {
            session.setAttribute("catErrorMsg", errorMsg);
            response.sendRedirect(request.getContextPath() + "/admin/catalogo/crear.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
