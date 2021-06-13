package entidades;

import java.sql.*;
import modelos.Categoria;
import java.util.*;

public class EntidadCategoria extends EntidadBase {

    private final String tabla = "categoria";

    public EntidadCategoria() {
        super();
    }

        
    public Categoria obtenerElemento(ResultSet resultSet) throws SQLException {
        try {
            Categoria categoria = new Categoria();
            categoria.id_categoria = resultSet.getInt("id_categoria");
            categoria.nombre = resultSet.getString("nombre");
            categoria.descripcion = resultSet.getString("descripcion");
            categoria.fecha_creacion = resultSet.getString("fecha_creacion");
            return categoria;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public List<Categoria> obtenerCategorias() throws Exception {
        String sql = String.format("SELECT * FROM %s ORDER BY id_categoria DESC;", this.tabla);
        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<Categoria> categorias = new ArrayList<>();
            while (resultSet.next()) {
                categorias.add(this.obtenerElemento(resultSet));
            }
            return categorias;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public Categoria obtenerCategoria(String llave, String valor) throws Exception {
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

    public int guardarCategoria(Categoria categoria) throws Exception {
        try {
            String sql = String.format("INSERT INTO %s(nombre, descripcion) "
                    + "VALUES ('%s', '%s')", this.tabla, categoria.nombre, categoria.descripcion);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }
}
