from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("FirstSparkApp") \
    .getOrCreate()

print("Spark Session Created Successfully")

spark.stop()