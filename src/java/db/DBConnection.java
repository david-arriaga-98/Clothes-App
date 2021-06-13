package db;

import java.sql.*;

public class DBConnection {

    public final String urlConnection;

    public DBConnection() {
        this.urlConnection = "jdbc:sqlserver://david-server.com:1433;databaseName=ropa_gallardo;user=SA;password=David9812";
    }

    protected Connection getConnection() throws Exception {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(this.urlConnection);
        } catch (ClassNotFoundException | SQLException e) {
            throw e;
        }
    }

}
