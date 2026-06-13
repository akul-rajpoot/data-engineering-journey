from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number,col,lag

spark=SparkSession.builder.appName("window_function").getOrCreate()
data = [
    (1, "Akul", "IT", 100000),
    (2, "Rahul", "IT", 80000),
    (3, "Amit", "IT", 120000),
    (4, "Neha", "HR", 50000),
    (5, "Priya", "HR", 70000)
]
columns = ["emp_id", "emp_name", "dept", "salary"]
df=spark.createDataFrame(data,columns)
window_spec=Window.partitionBy("dept").orderBy(col("salary").desc())
df=df.withColumn("rn",row_number().over(window_spec))
window_spec2=Window.partitionBy('dept').orderBy(col("emp_id"))
df=df.withColumn("prev_sal",lag("salary",1).over(window_spec2))
df.show()
df.filter(col("rn")==1).select("emp_name", "dept", "salary").show()


spark.stop()