package entidades;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelos.*;

public class EntidadCatalogoEnCarro extends EntidadBase {

    private final String tabla = "productos_en_carro";

    public EntidadCatalogoEnCarro() {
        super();
    }

    public ProductoEnCarro obtenerElemento(ResultSet resultSet) throws SQLException {
        try {
            ProductoEnCarro carro = new ProductoEnCarro();
            carro.id_producto_en_carro = resultSet.getInt("id_producto_en_carro");
            carro.carro = resultSet.getInt("carro");
            carro.catalogo = resultSet.getInt("catalogo");
            carro.cantidad = resultSet.getInt("cantidad");
            carro.precio = resultSet.getDouble("precio");
            carro.precio_unitario = resultSet.getDouble("precio_unitario");
            carro.nombre = resultSet.getString("nombre");
            carro.descripcion = resultSet.getString("descripcion");
            carro.imagen = resultSet.getString("imagen");

            return carro;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public List<ProductoEnCarro> obtenerProductosEnCarro(int carro) throws Exception {
        String sql = String.format("SELECT PEC.id_producto_en_carro, PEC.carro, PEC.catalogo, PEC.cantidad, PEC.precio, "
                + "CA.precio_unitario, CA.nombre, CA.descripcion, CA.imagen FROM %s PEC INNER JOIN catalogo CA "
                + "ON CA.id_catalogo = PEC.catalogo WHERE PEC.carro = %d ORDER BY id_producto_en_carro DESC;", this.tabla, carro);

        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<ProductoEnCarro> carros = new ArrayList<>();
            while (resultSet.next()) {
                carros.add(this.obtenerElemento(resultSet));
            }
            return carros;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public int crearProductoEnCarro(ProductoEnCarro carro) throws Exception {
        try {
            String sql = String.format("INSERT INTO %s(carro, catalogo, cantidad, precio) VALUES (%s, %s, %s, %s)", this.tabla, carro.carro, carro.catalogo, carro.cantidad, carro.precio);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }

}
