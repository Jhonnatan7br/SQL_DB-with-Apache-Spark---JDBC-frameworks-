package net.jgp.labs.spark.l150_udf.l100_x2_multiplier;

import static org.apache.spark.sql.functions.callUDF;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;

import net.jgp.labs.spark.x.udf.Multiplier2;

/**
 * Simple UDF call to multiply a column by two. The UDF itself is defined in
 * an external class in the
 * <code>net.jgp.labs.spark.x.udf.Multiplier2</code> package.
 * 
 * @author jgp
 *
 */
public class BasicExternalUdfFromTextFile {

  public static void main(String[] args) {
    System.out
        .println("Working directory = " + System.getProperty("user.dir"));
    BasicExternalUdfFromTextFile app = new BasicExternalUdfFromTextFile();
    app.start();
  }

  private void start() {
    SparkSession spark = SparkSession.builder().appName("CSV to Dataset")
        .master("local").getOrCreate();

    spark.udf().register("x2Multiplier", new Multiplier2(),
        DataTypes.IntegerType);

    String filename = "data/tuple-data-file.csv";
    Dataset<Row> df =
        spark.read().format("csv").option("inferSchema", "true")
            .option("header", "false").load(filename);
    df = df.withColumn("label", df.col("_c0")).drop("_c0");
    df = df.withColumn("value", df.col("_c1")).drop("_c1");
    df = df.withColumn("x2", callUDF("x2Multiplier", df.col("value").cast(
        DataTypes.IntegerType)));
    df.show();
  }
}
