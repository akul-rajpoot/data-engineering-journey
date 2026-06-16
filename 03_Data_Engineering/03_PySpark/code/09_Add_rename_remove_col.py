from pyspark.sql import SparkSession
from pyspark.sql.functions import expr

spark=SparkSession.builder.appName("add_remove_rename").getOrCreate()

schema = "id int, name string, age short, salary int"

data_list = [(100, "Prashant", 45, 45000),
             (101, "Tarun", 36, 33000),
             (102, "David", 48, 28000)]

df = spark.createDataFrame(data=data_list, schema=schema)
df.show()
#increment: 10% of the salary up to 3000 maximum increment
#revised_salary: salary + increment
df.withColumns({"increment": expr("case when salary>35000 then 3500 else salary*10/100 end")
                ,"revised_salary":expr("salary+increment")}
                ).show()

#increment: 10% of the salary up to 3000 maximum increment
#salary: current salary + increment

df=df.withColumn("increment",expr("case when salary>35000 then 3500 else salary*10/100 end")).withColumn("salary",expr("salary+increment"))
df.show()

#rename 
#increment - annual_increment
#salary - incremented_salary

df=(
    df.withColumnsRenamed({
    "increment":"annual_increment",
    "salary":"incremented_salary"
})
)

df2=(df.drop("age"))
df2.show()