from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("DataFrameDemo") \
    .getOrCreate()

data = [
    (1, "Akul", 100000),
    (2, "Rahul", 80000),
    (3, "Amit", 120000)
]

columns = ["emp_id", "emp_name", "salary"]

df = spark.createDataFrame(data, columns)

df.show()

spark.stop()