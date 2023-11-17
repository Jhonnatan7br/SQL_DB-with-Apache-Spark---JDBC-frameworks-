package net.jgp.labs.spark.l250_map.l020_dataset_book;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import org.apache.spark.api.java.function.MapFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Encoders;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import net.jgp.labs.spark.l250_map.l020_dataset_book.CsvToDatasetBookApp.BookMapper;
import net.jgp.labs.spark.x.model.Book;

public class CsvToDatasetBookToDataframeApp implements Serializable {
  private static final long serialVersionUID = 4262746489728980066L;

  class BookMapper implements MapFunction<Row, Book> {
    private static final long serialVersionUID = -8940709795225426457L;

    @Override
    public Book call(Row value) throws Exception {
      Book b = new Book();
      b.setId(value.getAs("id"));
      b.setAuthorId(value.getAs("authorId"));
      b.setLink(value.getAs("link"));
      SimpleDateFormat parser = new SimpleDateFormat("M/d/yy");
      String stringAsDate = value.getAs("releaseDate");
      if (stringAsDate == null) {
        b.setReleaseDate(null);
      } else {
        b.setReleaseDate(parser.parse(stringAsDate));
      }
      b.setTitle(value.getAs("title"));
      return b;
    }
  }

  public static void main(String[] args) {
    CsvToDatasetBookToDataframeApp app = new CsvToDatasetBookToDataframeApp();
    app.start();
  }

  private void start() {
    SparkSession spark = SparkSession.builder().appName("CSV to Dataset<Book>")
        .master("local").getOrCreate();

    String filename = "data/books.csv";
    Dataset<Row> df = spark.read().format("csv")
        .option("inferSchema", true)
        .option("header", true)
        .load(filename);
    df.show();

    Dataset<Book> bookDs = df.map(new BookMapper(), Encoders.bean(Book.class));
    bookDs.show();
    bookDs.printSchema();

    Dataset<Row> df2 = bookDs.toDF();
    df2.show();
    df2.printSchema();
  }
}
