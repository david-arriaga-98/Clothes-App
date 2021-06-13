package entidades;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelos.Carro;
import modelos.OrdenDeCompra;

public class EntidadCarro extends EntidadBase {

    private final String tabla = "carro";

    public EntidadCarro() {
        super();
    }

    public Carro obtenerElemento(ResultSet resultSet) throws SQLException {
        try {
            Carro carro = new Carro();
            carro.id_carro = resultSet.getInt("id_carro");
            carro.usuario = resultSet.getString("usuario");
            carro.estado = resultSet.getBoolean("estado");
            carro.fecha_creacion = resultSet.getString("fecha_creacion");
            return carro;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public List<OrdenDeCompra> obtenerOrdenes(String usuario) throws Exception {

        String sql = String.format("SELECT SUM(precio) as precio, carro, SUM(cantidad) as cantidad, "
                + "C.usuario FROM productos_en_carro PC INNER JOIN carro C ON PC.carro = C.id_carro "
                + "WHERE C.usuario='%s'  GROUP BY carro, C.usuario;", usuario);
        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<OrdenDeCompra> ordenes = new ArrayList<>();
            while (resultSet.next()) {
                OrdenDeCompra oc = new OrdenDeCompra();
                oc.cantidad = resultSet.getInt("cantidad");
                oc.carro = resultSet.getInt("carro");
                oc.precio = resultSet.getDouble("precio");
                oc.usuario = resultSet.getString("usuario");
                ordenes.add(oc);
            }
            return ordenes;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public int cerrarCarrito() throws Exception {
        try {
            String sql = String.format("UPDATE %s SET estado=1 WHERE estado=0", this.tabla);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }

    public List<Carro> obtenerCarros(String cedula, boolean soloActivos) throws Exception {
        String sql = String.format("SELECT * FROM %s WHERE usuario='%s' ", this.tabla, cedula);
        if (soloActivos) {
            sql += "AND estado=0 ";
        }
        sql += "ORDER BY id_carro DESC;";

        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<Carro> carros = new ArrayList<>();
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

    public int crearCarro(Carro carro) throws Exception {
        try {
            String sql = String.format("INSERT INTO %s(usuario) VALUES ('%s')", this.tabla, carro.usuario);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }

}
