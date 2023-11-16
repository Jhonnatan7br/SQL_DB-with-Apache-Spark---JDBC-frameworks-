import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLDatabaseConnection {
    public static void main(String[] args) {
        // Replace the values below with your database credentials
        String url = "jdbc:sqlserver://yourserver.database.windows.net:1433;database=yourdatabase";
        String user = "yourusername";
        String password = "yourpassword";

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            System.out.println("Connected to SQL database successfully!");
        } catch (SQLException e) {
            System.out.println("Connection to SQL database failed!");
            e.printStackTrace();
        }
    }
}
