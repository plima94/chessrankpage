
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author Rui Boticas
 * @version 1.0.2
 */
public class DBWorker {

    private final String servidor;
    private final String user;
    private final String password;
    private final String baseDados;
    private final String url;

    private final Connection conn;

    public DBWorker(String servidor, String user, String password, String baseDados) throws SQLException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        this.servidor = servidor;
        this.user = user;
        this.password = password;
        this.baseDados = baseDados;
        this.url = "jdbc:mysql://" + this.servidor + ":3306/" + this.baseDados + "?serverTimezone=UTC";
        conn = getConnection();
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        return DriverManager.getConnection(url, user, password);
    }

    public int executeUpdate(String sql) throws SQLException {
        final Statement st = conn.createStatement();
        int resultado = st.executeUpdate(sql);
        return resultado;
    }

    public ResultSet executeQuery(String sql) throws SQLException {
        final Statement st = conn.createStatement();
        return st.executeQuery(sql);
    }
    
    public void closeConnection() throws SQLException {

        if (conn != null) {
            conn.close();
        }
    }
}
