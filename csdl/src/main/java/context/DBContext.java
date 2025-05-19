package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Lớp DBContext để quản lý kết nối với MySQL
 */
public class DBContext {
    // Thông tin kết nối cơ sở dữ liệu
    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/hotel";
    private static final String USER = "root";
    private static final String PASS = "123456";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    private Connection connection;
    
    /**
     * Constructor - Tạo một instance của DBContext
     */
    public DBContext() {
        try {
            // Đăng ký MySQL Driver
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.out.println("Không thể tìm thấy MySQL Driver: " + e.getMessage());
        }
    }
    
    /**
     * Tạo kết nối đến cơ sở dữ liệu MySQL
     * 
     * @return Connection - kết nối đến database
     * @throws SQLException nếu không thể kết nối
     */
    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = DriverManager.getConnection(DB_URL, USER, PASS);
            } catch (SQLException e) {
                System.out.println("Lỗi kết nối đến cơ sở dữ liệu: " + e.getMessage());
                throw e;
            }
        }
        return connection;
    }
    
    /**
     * Đóng các tài nguyên của database
     * 
     * @param connection Kết nối cần đóng
     * @param ps PreparedStatement cần đóng
     * @param rs ResultSet cần đóng
     */
    public void closeResources(Connection connection, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
            
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi đóng tài nguyên database: " + e.getMessage());
        }
    }
    
    /**
     * Đóng PreparedStatement và ResultSet
     * 
     * @param ps PreparedStatement cần đóng
     * @param rs ResultSet cần đóng
     */
    public void closeResources(PreparedStatement ps, ResultSet rs) {
        closeResources(null, ps, rs);
    }
}
