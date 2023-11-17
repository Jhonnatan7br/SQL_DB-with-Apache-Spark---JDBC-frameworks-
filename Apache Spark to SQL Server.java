import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
// After imports
public class SparkSqlExample {
    public static void main(String[] args) {
        // Create a SparkSession
        SparkSession spark = SparkSession.builder()
            .appName("Spark SQL Example")
            .config("spark.master", "local")
            .config("spark.sql.warehouse.dir", "/user/hive/warehouse")
            .getOrCreate();

        // Read data from the database
        Dataset<Row> df = spark.read()
            .format("jdbc")
            .option("url", "jdbc:mysql://localhost:3306/mydatabase")
            .option("dbtable", "mytable")
            .option("user", "username")
            .option("password", "password")
            .load();

        // Process the data
        df.show();

        // Stop the SparkSession
        spark.stop();
    }
}