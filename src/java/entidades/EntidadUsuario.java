package entidades;

import java.sql.*;
import java.util.*;
import modelos.Usuario;

public class EntidadUsuario extends EntidadBase {

    private final String tabla = "usuario";

    public EntidadUsuario() {
        super();
    }

    public Usuario obtenerElemento(ResultSet resultSet) throws SQLException {
        try {
            Usuario usuario = new Usuario();
            usuario.cedula = resultSet.getString("cedula");
            usuario.nombre = resultSet.getString("nombre");
            usuario.sexo = resultSet.getString("sexo");
            usuario.fecha_nacimiento = resultSet.getString("fecha_nacimiento");
            usuario.fecha_creacion = resultSet.getString("fecha_creacion");
            usuario.clave = resultSet.getString("clave");
            usuario.rol = resultSet.getString("rol");
            return usuario;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public List<Usuario> obtenerUsuarios() throws Exception {
        String sql = String.format("SELECT * FROM %s ORDER BY fecha_creacion DESC;", this.tabla);
        try (ResultSet resultSet = super.ejecutarConsulta(sql)) {
            List<Usuario> usuarios = new ArrayList<>();
            while (resultSet.next()) {
                usuarios.add(this.obtenerElemento(resultSet));
            }
            return usuarios;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            super.closeConnection();
        }
    }

    public Usuario obtenerUsuario(String llave, String valor) throws Exception {
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

    public int guardarUsuario(Usuario usuario) throws Exception {
        try {
            String sql = String.format("INSERT INTO %s(cedula, nombre, sexo, fecha_nacimiento, clave, rol) "
                    + "VALUES ('%s', '%s', '%s', '%s', '%s', '%s')", this.tabla, usuario.cedula, usuario.nombre,
                    usuario.sexo, usuario.fecha_nacimiento, usuario.clave, usuario.rol);
            return super.ejecutarActualizacion(sql);
        } catch (Exception ex) {
            throw ex;
        }
    }

}
