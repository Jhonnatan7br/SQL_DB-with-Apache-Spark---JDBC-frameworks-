# SQL_DB-with-Apache-Spark---JDBC-frameworks-

This project is a demonstration of how to use Apache Spark and JDBC frameworks to connect to a SQL database and perform various operations on it. The project shows how to:

Create a Spark session and configure it to use the JDBC driver for the database.
Read and write data from and to the database using Spark SQL and DataFrames.
Query and analyze data using Spark SQL and various built-in and user-defined functions.

# Steps to connect to a SQL database using JDBC:

Load the JDBC driver: First, you need to load the JDBC driver for the database you want to connect to. You can do this by calling the Class.forName() method and passing the name of the driver class as an argument.

Establish a connection: Once you have loaded the driver, you can establish a connection to the database using the DriverManager.getConnection() method. You need to pass the URL of the database, the username, and the password as arguments to this method.

Create a statement: After establishing a connection, you can create a Statement object using the Connection.createStatement() method. This object is used to execute SQL statements against the database.

Execute a query: You can execute a SQL query using the Statement.executeQuery() method. This method returns a ResultSet object that contains the results of the query.

Process the results: Finally, you can process the results of the query by iterating over the ResultSet object and extracting the data you need.

![image](https://github.com/Jhonnatan7br/SQL_DB-with-Apache-Spark---JDBC-frameworks-/assets/104907786/ae9274f7-e6c3-45a9-8e6d-b939a92d44a3)

# Steps to connect to a SQL database using Apache Spark Framework:

Identify the JDBC driver: First, you need to identify the JDBC driver for the database you want to connect to. You can usually find the driver on the database vendor’s website.

Add the driver to your project: Once you have identified the driver, you need to add it to your project’s classpath. You can do this by adding the driver JAR file to the lib directory of your Spark installation.

Create a SparkSession: After adding the driver to your project, you can create a SparkSession object using the SparkSession.builder() method. You need to set the JDBC URL of the database, the username, and the password as options to this method.

Read data from the database: Once you have created the SparkSession object, you can read data from the database using the DataFrameReader.jdbc() method. You need to pass the JDBC URL of the database, the table name, and the SparkSession object as arguments to this method.

Process the data: Finally, you can process the data by applying transformations and actions to the DataFrame object returned by the DataFrameReader.jdbc() method.

![image](https://github.com/Jhonnatan7br/SQL_DB-with-Apache-Spark---JDBC-frameworks-/assets/104907786/d9bfe365-bed9-4885-8eae-31d07182f9db)

# SQL Database structure (Can be seen from MySQL)

![image](https://github.com/Jhonnatan7br/SQL_DB-with-Apache-Spark---JDBC-frameworks-/assets/104907786/d541528b-11eb-4efe-b957-bb64662422dc)

The diagram of a database schema shows the relationship between different tables and fields in the database. The tables are represented as rectangles with rounded corners, while the fields are represented as rectangles with sharp corners. The tables are connected by lines, representing the relationship between them. The tables are labeled with their names, such as “employees”, “salaries”, and “departments”. The fields are labeled with their names, such as “emp_no”, “first_name”, and “last_name”
