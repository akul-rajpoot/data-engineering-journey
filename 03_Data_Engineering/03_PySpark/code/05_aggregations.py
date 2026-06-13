from pyspark.sql import SparkSession
from pyspark.sql.functions import sum,avg,max

spark=SparkSession.builder.appName('Aggregation').getOrCreate()
data = [
    ("IT", 100000),
    ("IT", 80000),
    ("HR", 50000),
    ("HR", 60000)
]

columns = ["department", "salary"]
df=spark.createDataFrame(data,columns)

df.groupby("department").agg(sum("salary").alias("total_salary"),
                             avg("salary").alias("average_salary"),
                             max("salary").alias("max_dep_sal")).show()
spark.stop()
