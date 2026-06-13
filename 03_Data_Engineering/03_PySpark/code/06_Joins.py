from pyspark.sql import SparkSession

spark=SparkSession.builder.appName("Joins").getOrCreate()

Employee_Data= [
    (1,"Akul", 10),
    (2,"Rahul", 20),
    (3,"Amit", 40)
]
col=['emp_id','emp_name','dept_id']
df1=spark.createDataFrame(Employee_Data,col)

Department_Data=[(10,"IT"),
    (20,"HR"),
    (50,"Finance")]
col2=['dept_id','dept_name']
df2=spark.createDataFrame(Department_Data,col2)

df1.join(df2,"dept_id","inner").show()
df1.join(df2,"dept_id","left").show()

spark.stop()

