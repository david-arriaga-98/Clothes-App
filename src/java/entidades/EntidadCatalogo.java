package entidades;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelos.Catalogo;
import modelos.CatalogoConCategoria;

public class EntidadCatalogo extends EntidadBase {

    private final String tabla = "catalogo";

    public EntidadCatalogo() {
        super();
    }

    public Catalogo obtenerElemento(ResultSet resultSet) throws SQLException {
        try {
            Catalogo catalogo = new Catalogo();
            catalogo.id_catalogo = resultSet.getInt("id_catalogo");
            catalogo.id_categoria = resultSet.getInt("id_categoria");
            catalogo.precio_unitario = resultSet.getDouble("precio_unitario");
            catalogo.costo_unitario = resultSet.getDouble("costo_unitario");
            catalogo.nombre = resultSet.getString("nombre");
            catalogo.descripcion = resultSet.getString("descripcion");
            catalogo.imagen = resultSet.getString("imagen");
            catalogo.fecha_creacion = resultSet.getString("fecha_creacion");
            return catalogo;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    
    public List<CatalogoConCategoria> obtenerCatalogoConCategoria(int id) throws Exception {
        try {
            String sql = "SELECT CA.id_catalogo, CA.precio_unitario, CA.nombre as nombre_catalogo, "
                    + "CA.imagen, CT.nombre as nombre_categoria FROM catalogo CA INNER JOIN categoria CT ON CA.id_categoria = CT.id_categoria ";

            if (id == -1) {
                sql = sql + "ORDER BY CT.id_categoria DESC";
            } else {
                sql += "WHERE id_catalogo = " + id + " ORDER BY CT.id_categoria DESC";
            }

            try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
                List<CatalogoConCategoria> lista = new ArrayList<>();

                while (resultSet.next()) {

                    CatalogoConCategoria ct = new CatalogoConCategoria();
                    ct.id_catalogo = resultSet.getInt("id_catalogo");
                    ct.nombre_catalogo = resultSet.getString("nombre_catalogo");
                    ct.nombre_categoria = resultSet.getString("nombre_categoria");
                    ct.imagen = resultSet.getString("imagen");
                    ct.precio_unitario = resultSet.getDouble("precio_unitario");
                    lista.add(ct);
                }
                return lista;
            } catch (Exception ex) {
                throw ex;
            } finally {
                super.closeConnection();
            }

        } catch (Exception e) {
            throw e;
        }

    }

    public List<Catalogo> obtenerCatalogos() throws Exception {
        String sql = String.format("SELECT * FROM %s ORDER BY id_catalogo DESC;", this.tabla);
        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<Catalogo> catalogos = new ArrayList<>();
            while (resultSet.next()) {
                catalogos.add(this.obtenerElemento(resultSet));
            }
            return catalogos;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public Catalogo obtenerCatalogo(String llave, String valor) throws Exception {
        String sql = String.format("SELECT * FROM %s WHERE %s='%s';", this.tabla, llave, valor);
        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            if (resultSet.next()) {
                return this.obtenerElemento(resultSet);
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public int guardarCatalogo(Catalogo cat) throws Exception {
        try {
            String sql = String.format("INSERT INTO %s(id_categoria, precio_unitario, costo_unitario, nombre, descripcion, imagen) "
                    + "VALUES (%d, %s, %s, '%s', '%s', '%s')", this.tabla, cat.id_categoria, cat.precio_unitario, cat.costo_unitario, cat.nombre, cat.descripcion, cat.imagen);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }
}
