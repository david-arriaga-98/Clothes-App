package entidades;

import db.DBConnection;
import java.sql.*;

public class EntidadBase extends DBConnection {

    public Connection cnn;
    public PreparedStatement preparedStatement;

    public EntidadBase() {
        super();
    }

    protected void closeConnection() {
        try {
            this.cnn.close();
            this.preparedStatement.close();
        } catch (SQLException ex) {
        }
    }

    protected int ejecutarActualizacion(String sql) throws Exception {
        try {
            this.cnn = super.getConnection();
            this.preparedStatement = this.cnn.prepareStatement(sql);
            return this.preparedStatement.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        }
    }

    protected ResultSet ejecutarConsulta(String sql) throws Exception {
        try {
            this.cnn = super.getConnection();
            this.preparedStatement = this.cnn.prepareStatement(sql);
            return this.preparedStatement.executeQuery();
        } catch (Exception ex) {
            throw ex;
        }
    }

}
