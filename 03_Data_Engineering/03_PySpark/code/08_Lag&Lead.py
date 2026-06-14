from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import lag , col ,lead
spark=SparkSession.builder.appName("LAG").getOrCreate()
data = [
    (1,"Jan",100),
    (2,"Feb", 120),
    (3,"Mar", 150),
    (4,"Apr", 130),
    (5,"May", 170)
]
column=['Id','Month','Sale']
df=spark.createDataFrame(data,column)
Windowspec=Window.orderBy('Id')
df=df.withColumn("prev_val",lag('Sale',1).over(Windowspec))
df.show()
df=df.withColumn("next_val",lead('Sale',2).over(Windowspec))
df.show()
df=df.withColumn("diff",col('Sale')-col('prev_val')) #for calculation difference
df=df.withColumn("Growth_percentage",((col("Sale")-col("prev_val"))/col("prev_val"))*100) #for calculating growth
df.show()
spark.stop()
