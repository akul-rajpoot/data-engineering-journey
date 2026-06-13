from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark=SparkSession.builder.appName('Transformation').getOrCreate()
data = [
    (1, "Akul", 100000),
    (2, "Rahul", 80000),
    (3, "Amit", 120000)
]

columns = ["emp_id", "emp_name", "salary"]

df=spark.createDataFrame(data,columns)
print("select")
df.select("emp_name").show()

print('Filter')
df.filter(col('salary')>90000).select("emp_name","salary").show()

print("With columns")
df=df.withColumn('bonus',col('salary')*0.10)
df.show()
spark.stop()