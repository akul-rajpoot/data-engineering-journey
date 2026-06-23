# PySpark

## Section 1 - Big Data Fundamentals

### Evolution of Data Processing

#### COBOL Era
- Early business applications were built using COBOL.
- Limited scalability and analytics capabilities.

#### RDBMS Era
Data started being stored in relational databases.

Examples:
- Oracle
- MySQL
- SQL Server
- PostgreSQL

Components:

##### SQL
- Used for querying and managing data.

Example:
```sql
SELECT * FROM Employees;
```

##### Procedural Languages
Examples:
- PL/SQL
- T-SQL

Used for implementing business logic inside databases.

##### Connectivity Interfaces
Examples:
- JDBC
- ODBC

Used by applications to connect with databases.

---

### Data Categories

#### Structured Data
Data stored in rows and columns.

Examples:
- Employee Table
- Customer Table
- Sales Table

#### Semi-Structured Data
Data with flexible structure.

Examples:
- JSON
- XML

#### Unstructured Data
Data without a predefined structure.

Examples:
- Images
- Videos
- Audio Files
- PDFs
- Documents

---

### Big Data Challenges (3 Vs)

#### Volume
Large amount of data.

Examples:
- TBs
- PBs

#### Velocity
Speed at which data is generated.

Examples:
- Stock Market Data
- IoT Sensor Data
- Streaming Data

#### Variety
Different formats of data.

Examples:
- Tables
- JSON
- Images
- Videos
- Logs

---

### Processing Approaches

#### Monolithic Processing
Single machine handles:
- Storage
- Processing
- Computation

Limitation:
- Difficult to scale.

#### Distributed Processing
Multiple machines work together.

Advantages:
- Scalability
- Fault Tolerance
- Better Performance

---

## Hadoop Ecosystem

Main Components:
- YARN
- HDFS
- MapReduce

---

### HDFS (Hadoop Distributed File System)

Distributed storage layer of Hadoop.

Purpose:
- Store data across multiple machines.

#### NameNode
Master component.

Responsibilities:
- Stores metadata.
- Maintains file names.
- Maintains block locations.
- Maintains file permissions.

Note:
- NameNode does NOT store actual data.

#### DataNode
Worker component.

Responsibilities:
- Stores actual data blocks.
- Handles read/write requests.

---

### YARN (Yet Another Resource Negotiator)

Resource management layer of Hadoop.

Responsibilities:
- Resource allocation.
- Job scheduling.
- Cluster management.

Components:

#### Resource Manager (RM)
Master component.

Responsibilities:
- Allocates resources.
- Schedules jobs across the cluster.

#### Node Manager (NM)
Runs on worker nodes.

Responsibilities:
- Monitors resources.
- Executes tasks.

#### Application Master (AM)
Responsible for managing a specific application/job.

---

### MapReduce

Distributed processing framework.

#### Map Phase
- Reads data blocks.
- Applies logic at block level.
- Produces intermediate output.

#### Reduce Phase
- Consolidates outputs from mappers.
- Produces final result.

---

## Spark vs Hadoop MapReduce

### Advantages of Apache Spark

#### 1. Performance
- In-memory processing.
- Faster than MapReduce.

#### 2. Ease of Development
Supports:
- Python
- Java
- Scala
- R
- SQL

#### 3. Better APIs
Provides:
- DataFrame API
- Spark SQL
- Machine Learning Libraries
- Streaming Support

#### 4. Flexible Storage
Supports:
- HDFS
- S3
- Azure Data Lake
- Databases
- Cloud Storage

#### 5. Flexible Resource Managers
Can run on:
- YARN
- Kubernetes
- Mesos
- Standalone Cluster

---

## Modern Data Architectures

### Data Warehouse

```text
Source Systems
      ↓
ETL
      ↓
Data Warehouse
      ↓
BI / Reporting
```

Characteristics:
- Data transformed before loading.
- Stores curated and processed data.

---

### Data Lake

```text
Source Systems
      ↓
Raw Data
      ↓
Data Lake (HDFS / S3)
      ↓
ETL
      ↓
Data Warehouse / RDBMS
      ↓
BI / Reporting
```

Characteristics:
- Stores raw data first.
- Supports structured, semi-structured, and unstructured data.

---

### Data Lakehouse

```text
Source Systems
      ↓
Data Lake
      ↓
PySpark / Spark SQL
      ↓
Analytics / BI / ML
```

Characteristics:
- Processing happens directly on the Data Lake.
- Supports BI, Analytics, Data Science, and Machine Learning.
- Combines benefits of Data Warehouse and Data Lake.

---

## Key Interview Questions

1. Difference between NameNode and DataNode?
2. Difference between HDFS and YARN?
3. What are the 3 Vs of Big Data?
4. Why is Spark faster than MapReduce?
5. Difference between Data Warehouse and Data Lake?
6. What is the role of Resource Manager in YARN?
7. What is Distributed Processing?
8. What are Structured, Semi-Structured, and Unstructured Data?

---

## Quick Revision

```text
HDFS = Storage Layer
YARN = Resource Management Layer

NameNode = Metadata
DataNode = Actual Data Blocks

Map = Process Data
Reduce = Consolidate Results

3 Vs = Volume, Velocity, Variety

Spark > MapReduce
Reason: In-Memory Processing

Data Warehouse = Processed Data
Data Lake = Raw + Processed Data
Data Lakehouse = Processing Directly on Data Lake
```


## Section 2 - Spark Fundamentals

### What is Apache Spark?

Apache Spark is a distributed data processing framework used for processing large datasets across multiple machines.

### What is PySpark?

PySpark is the Python API for Apache Spark that allows large-scale data processing using Python.

### Why PySpark Instead of Pandas?

#### Pandas
- Runs on a single machine.
- Data is processed in local memory.
- Suitable for small and medium datasets.

#### PySpark
- Supports distributed processing.
- Can process very large datasets.
- Suitable for big data workloads.

---

### SparkSession

SparkSession is the entry point to PySpark.

Uses:
- Create DataFrames.
- Read data from files.
- Execute Spark SQL.
- Interact with Spark cluster.

Example:

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("MyApp") \
    .getOrCreate()
```

---

### DataFrame

A DataFrame is a distributed collection of data organized into rows and columns.

It is similar to a table in a relational database.

Example:

```python
data = [
    (1, "Akul", 100000),
    (2, "Rahul", 80000)
]

columns = ["emp_id", "emp_name", "salary"]

df = spark.createDataFrame(data, columns)
```

---

### Common DataFrame Actions

#### show()
Displays DataFrame records.

```python
df.show()
```

#### printSchema()
Displays column names and data types.

```python
df.printSchema()
```

#### count()
Returns the total number of rows.

```python
df.count()
```

---

## Section 3 - Transformations and Actions

### Transformations

Transformations create a new DataFrame.

Examples:

```python
df.select()
df.filter()
df.withColumn()
df.drop()
df.distinct()
df.orderBy()
```

Important:

- Transformations are lazy.
- They do not execute immediately.
- Spark creates an execution plan.

---

### Actions

Actions trigger execution.

Examples:

```python
df.show()
df.count()
df.collect()
df.first()
```

---

### Lazy Evaluation

Spark executes transformations only when an action is called.

Example:

```python
df.filter(col("salary") > 90000)
```

No execution happens until:

```python
df.show()
```

---

### select()

Select specific columns.

```python
df.select("emp_name")
```

---

### filter()

Filter rows based on a condition.

```python
df.filter(col("salary") > 90000)
```

---

### withColumn()

Add or modify a column.

```python
df.withColumn("bonus", col("salary") * 0.10)
```

---

### drop()

Remove one or more columns.

```python
df.drop("salary")
```

---

### distinct()

Remove duplicate rows.

```python
df.distinct()
```

---

### orderBy()

Sort data.

```python
df.orderBy("salary")
```

Descending:

```python
df.orderBy(col("salary").desc())
```

---

## Section 4 - Aggregations

### groupBy()

Groups records for aggregation.

```python
df.groupBy("department")
```

---

### Aggregate Functions

```python
sum()
avg()
max()
count()
```

Example:

```python
df.groupBy("department") \
  .agg(
      sum("salary").alias("total_salary"),
      avg("salary").alias("avg_salary"),
      max("salary").alias("max_salary")
  )
```

---

### count(*) vs count(column)

#### count(*)
Counts all rows including rows containing NULL values.

#### count(column)
Counts only non-null values.

Example:

```text
100000
NULL
80000
```

```text
count(*) = 3
count(salary) = 2
```

---

## Section 5 - Joins

### Inner Join

Returns only matching records.

```python
df1.join(df2, "dept_id", "inner")
```

---

### Left Join

Returns all records from the left DataFrame and matching records from the right DataFrame.

```python
df1.join(df2, "dept_id", "left")
```

---

### SQL vs PySpark

SQL:

```sql
SELECT *
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id;
```

PySpark:

```python
emp_df.join(dept_df, "dept_id", "inner")
```

---

## Section 6 - Window Functions

### Window Specification

```python
from pyspark.sql.window import Window

window_spec = Window.partitionBy("dept") \
                    .orderBy(col("salary").desc())
```

---

### row_number()

Assigns unique sequential numbers.

Example:

```text
1
2
3
4
```

---

### rank()

Assigns same rank for ties and skips ranks.

Example:

```text
1
2
2
4
```

---

### dense_rank()

Assigns same rank for ties without gaps.

Example:

```text
1
2
2
3
```

---

### lag()

Returns value from previous row.

```python
lag("sales", 1)
```

Meaning:

```text
Look 1 row backward.
```

---

### lead()

Returns value from next row.

```python
lead("sales", 1)
```

Meaning:

```text
Look 1 row forward.
```

---

## Quick Revision - Section 2 to 6

```text
SparkSession = Entry Point

DataFrame = Table in PySpark

show(), count() = Actions

select(), filter(), withColumn(), drop(), distinct(), orderBy() = Transformations

Transformations = Lazy
Actions = Execute

count(*) = All Rows
count(column) = Non-Null Values

Inner Join = Matching Records
Left Join = All Left Records

row_number = 1 2 3 4
rank = 1 2 2 4
dense_rank = 1 2 2 3


lag = Previous Row
lead = Next Row
```

---

## Section 7 - Practical Window Function Scenarios

### Finding Top Employee Per Department

Business Requirement:
- Find the highest-paid employee in each department.

```python
window_spec = Window.partitionBy("Dept") \
                    .orderBy(col("Salary").desc())
```

```python
df = df.withColumn(
    "rn",
    row_number().over(window_spec)
)

result = df.filter(col("rn") == 1)
```

Key Learning:
- Use `partitionBy()` whenever ranking must restart for each group.
- Examples: Department, Customer, Product, Region.

---

### lag(column, n)

Returns value from `n` rows before the current row.

```python
lag("Sale", 1)
```

Meaning:

```text
Look 1 row backward.
```

Example:

```text
Month  Sale  Prev_Sale
Jan    100   NULL
Feb    120   100
Mar    150   120
Apr    130   150
May    170   130
```

---

### lead(column, n)

Returns value from `n` rows after the current row.

```python
lead("Sale", 1)
```

Meaning:

```text
Look 1 row forward.
```

Example:

```text
Month  Sale  Next_Sale
Jan    100   120
Feb    120   150
Mar    150   130
Apr    130   170
May    170   NULL
```

---

### lag(column, 2)

```text
Month  Sale  Lag_2
Jan    100   NULL
Feb    120   NULL
Mar    150   100
Apr    130   120
May    170   150
```

---

### lead(column, 2)

```text
Month  Sale  Lead_2
Jan    100   150
Feb    120   130
Mar    150   170
Apr    130   NULL
May    170   NULL
```

---

### Month-over-Month Difference

Business Requirement:
- Calculate difference from previous month's sales.

```python
df = df.withColumn(
    "diff",
    col("Sale") - col("prev_val")
)
```

Example:

```text
Month  Sale  Prev_Sale  Diff
Jan    100   NULL       NULL
Feb    120   100        20
Mar    150   120        30
Apr    130   150       -20
May    170   130        40
```

---

### Month-over-Month Growth Percentage

Formula:

```text
((Current Sale - Previous Sale) / Previous Sale) * 100
```

PySpark:

```python
df = df.withColumn(
    "Growth_Percentage",
    ((col("Sale") - col("prev_val")) / col("prev_val")) * 100
)
```

Example:

```text
Feb -> 20.00%
Mar -> 25.00%
Apr -> -13.33%
May -> 30.77%
```

---

## Interview Tips

```text
When you hear:
- Per Customer
- Per Department
- Per Product
- Per Region

Think:
Window.partitionBy(...)
```

```text
row_number() -> Unique ranking
rank() -> Same rank with gaps
dense_rank() -> Same rank without gaps
```

```text
lag() -> Look backward
lead() -> Look forward
```

## Section 8 - DataFrame Immutability & Interview Notes

### DataFrame Immutability

A DataFrame is immutable.

Meaning:
- Existing DataFrame cannot be modified.
- Every transformation creates a new DataFrame.

Example:

df2 = df1.filter(col("salary") > 100000)

Result:
df1 -> Original DataFrame
df2 -> New Filtered DataFrame

---

### Reassigning a DataFrame

df1 = df1.filter(col("salary") > 100000)

Explanation:
- Spark creates a new DataFrame.
- The variable df1 now points to the new DataFrame.
- The original DataFrame is not modified.

---

### Why Spark Uses Immutable DataFrames

- Fault Tolerance
- Parallel Processing
- Lazy Evaluation
- Catalyst Optimization
- Safe Distributed Execution

---

### Transformation Execution Flow

Incorrect:

df.select("department") \
  .filter(col("salary") > 50000)

Reason:
salary no longer exists after select().

Correct:

df.filter(col("salary") > 50000) \
  .groupBy("department") \
  .count() \
  .orderBy(col("count").desc())

---

### Interview Notes

header=True
- Uses first row as column names.

inferSchema=True
- Automatically detects column data types.

Without inferSchema:
- All columns become StringType.

Example:

100
20
3

Sorted as strings:

100
20
3

Not:

3
20
100

---

### Quick Revision

DataFrames are Immutable

Transformations create new DataFrames

Variables are reassigned, objects are not modified

header=True -> First row is header

inferSchema=True -> Detect data types

Without inferSchema -> StringType for all columns

Use explicit schema in production

## Section 9 - Data Types, Null Handling & File Operations

### Common Spark Data Types

#### Numeric Types

```python
IntegerType()
LongType()
FloatType()
DoubleType()
DecimalType()
```

#### String Type

```python
StringType()
```

#### Date & Time Types

```python
DateType()
TimestampType()
```

#### Boolean Type

```python
BooleanType()
```

---

### Schema Inference

#### header=True

```text
Uses the first row of the file as column names.
```

Example:

```text
emp_id,emp_name,salary
1,Akul,100000
```

---

#### inferSchema=True

```text
Automatically detects column data types.
```

Without inferSchema:

```text
All columns become StringType.
```

Example:

```text
emp_id -> string
salary -> string
```

---

### Explicit Schema Definition

```python
from pyspark.sql.types import *

schema = StructType([
    StructField("emp_id", IntegerType(), True),
    StructField("salary", DoubleType(), True)
])
```

Advantages:

```text
Faster than inferSchema
Predictable
Production Friendly
Avoids Schema Inference Scan
```

---

### Null Handling

#### fillna()

```python
df.fillna(0)
```

Replaces NULL values.

---

#### coalesce()

```python
coalesce(col("salary"), lit(0))
```

Returns the first non-null value.

---

### CAST vs TRY_CAST

#### CAST

```sql
CAST('ABC' AS INT)
```

Result:

```text
Error
```

---

#### TRY_CAST

```sql
TRY_CAST('ABC' AS INT)
```

Result:

```text
NULL
```

Interview Point:

```text
TRY_CAST prevents ETL failures caused by bad data.
```

---

## Read Operations

### Read CSV

```python
df = spark.read.csv(
    "employees.csv",
    header=True,
    inferSchema=True
)
```

### Read JSON

```python
df = spark.read.json("employees.json")
```

### Read Parquet

```python
df = spark.read.parquet("employees.parquet")
```

### Read Table

```python
df = spark.read.table("employee")
```

Used for Hive Metastore, Unity Catalog, and Spark Catalog tables.

---

## Write Operations

### Write CSV

```python
df.write.csv("output/")
```

### Write JSON

```python
df.write.json("output/")
```

### Write Parquet

```python
df.write.parquet("output/")
```

### Save as Table

```python
df.write.saveAsTable("employee")
```

---

## CSV vs Parquet

### CSV

```text
Row Based Storage
Human Readable
Larger File Size
Slower Queries
```

### Parquet

```text
Columnar Storage
Compressed
Smaller File Size
Faster Queries
Schema Support
```

Interview Point:

```text
Parquet is preferred because Spark can read only required columns instead of scanning the entire dataset.
```

---


## Quick Revision - Section 9

```text
IntegerType
LongType
FloatType
DoubleType
StringType
DateType
TimestampType

header=True -> First row is column names
inferSchema=True -> Detect data types automatically

StructType + StructField -> Explicit Schema

fillna() -> Replace NULL values
coalesce() -> First non-null value

CAST -> Error on invalid conversion
TRY_CAST -> NULL on invalid conversion

read.csv()
read.json()
read.parquet()
read.table()

write.csv()
write.json()
write.parquet()
saveAsTable()

CSV -> Row Based
Parquet -> Columnar Storage
```


## Section 10 - Spark Architecture

### Why Spark Architecture?

Understanding Spark Architecture helps explain what happens internally when actions such as:

```python
df.show()
df.count()
```

Key Components:

```text
Driver
Executor
Cluster Manager
Job
Stage
Task
```

---

### Driver

The Driver is the brain of a Spark application.

Responsibilities:

```text
Creates SparkSession
Builds Execution Plan
Creates Jobs
Creates Stages
Creates Tasks
Coordinates Executors
Returns Results
```

Example:

```python
spark = SparkSession.builder \
    .appName("Employee") \
    .getOrCreate()
```

Think:

```text
Driver = Project Manager
```

---

### Executor

Executors perform the actual work.

Responsibilities:

```text
Execute Tasks
Process Data
Store Cached Data
Return Results
```

Example:

```text
Driver
  |
  |-- Executor 1
  |-- Executor 2
  |-- Executor 3
```

Think:

```text
Executors = Workers
```

---

### Cluster Manager

Responsible for resource allocation.

Examples:

```text
YARN
Kubernetes
Mesos
Standalone Cluster
```

Responsibilities:

```text
Allocate CPU
Allocate Memory
Start Executors
Manage Cluster Resources
```

Think:

```text
Cluster Manager = HR Department
```

---

### Job

A Job is created whenever an Action is executed.

Examples:

```python
df.show()
df.count()
df.collect()
df.first()
```

Rule:

```text
1 Action = 1 Job
```

Transformations alone do not create jobs.

Example:

```python
df.filter(col("salary") > 50000)
```

Result:

```text
No Job Created
```

---

### Stage

A Job is divided into one or more Stages.

Wide transformations create new stages because they require a shuffle.

Example:

```python
df.filter(col("salary") > 50000) \
  .groupBy("department") \
  .count() \
  .show()
```

Execution:

```text
Stage 1 -> filter()
Shuffle
Stage 2 -> groupBy() + count()
```

---

### Task

A Stage is divided into Tasks.

Rule:

```text
1 Partition = 1 Task
```

Example:

```text
8 Partitions = 8 Tasks
```

---

### Narrow Transformations

Definition:

```text
Child partition depends on only one parent partition.
No data movement.
No shuffle.
```

Examples:

```python
select()
filter()
withColumn()
drop()
```

---

### Wide Transformations

Definition:

```text
Child partition depends on multiple parent partitions.
Data movement occurs.
Shuffle occurs.
```

Examples:

```python
groupBy()
join()
distinct()
repartition()
orderBy()
```

---

### Shuffle

Definition:

```text
Movement of data across partitions/executors.
```

Common Operations Causing Shuffle:

```text
groupBy()
join()
distinct()
repartition()
orderBy()
```

Why Expensive?

```text
Network Transfer
Disk I/O
Sorting
Data Redistribution
```

---

### Important Relationships

```text
Action
  ↓
Job
  ↓
Stage
  ↓
Task
```

```text
Wide Transformation
       ↓
    Shuffle
       ↓
   New Stage
```

---

## Section 11 - Spark Performance Optimization

### Why Performance Optimization?

On small datasets Spark performs well automatically.

On large datasets:

```text
Bad Partitioning
Too Many Shuffles
Poor Join Strategy
```

can make jobs run for hours.

---

### repartition()

Used to:

```text
Increase Partitions
Decrease Partitions
Redistribute Data Evenly
```

Example:

```python
df.repartition(10)
```

Important:

```text
Causes Shuffle
Expensive Operation
```

Use when:

```text
Data is Skewed
Need More Parallelism
Need Balanced Partitions
```

---

### coalesce()

Usually used to reduce partitions.

Example:

```python
df.coalesce(2)
```

Advantages:

```text
More Efficient Than repartition()
Usually Avoids Full Shuffle
```

Interview Question:

Current:

```text
100 Partitions
```

Need:

```text
5 Partitions
```

Preferred:

```python
df.coalesce(5)
```

Reason:

```text
Less Expensive
Usually Avoids Shuffle
```

---

### cache()

Stores DataFrame in memory.

Example:

```python
df.cache()
```

Use when:

```text
Same DataFrame Used Multiple Times
```

Important:

```text
cache() is Lazy
Nothing Is Cached Immediately
```

Example:

```python
df.cache()
df.count()
```

Execution:

```text
df.cache()  -> Marks For Caching
count()     -> Computes And Stores In Cache
```

---

### persist()

More flexible than cache().

Example:

```python
from pyspark import StorageLevel

df.persist(StorageLevel.MEMORY_AND_DISK)
```

Common Options:

```text
MEMORY_ONLY
MEMORY_AND_DISK
DISK_ONLY
```

Interview Point:

```text
cache() = MEMORY_ONLY Shortcut
persist() = More Control
```

---

### Broadcast Join

One of the most important PySpark interview topics.

Problem:

```text
Large Table + Small Lookup Table
```

Example:

```text
Sales Table      = 1 Billion Rows
Product Table    = 500 Rows
```

Solution:

```python
from pyspark.sql.functions import broadcast

sales_df.join(
    broadcast(product_df),
    "product_id"
)
```

What Happens?

```text
Small Table Copied To Every Executor
Join Happens Locally
Large Shuffle Avoided
```

Benefits:

```text
Faster Joins
Less Network Traffic
Better Performance
```

Common Examples:

```text
Employee + Department
Sales + Product Master
Transactions + Country Lookup
```

---

### Common Shuffle Operations

Always remember these:

```text
groupBy()
join()
distinct()
repartition()
orderBy()
```

Reason:

```text
Cause Data Movement Across Partitions
```

---

### Important Interview Questions

#### Difference Between repartition() and coalesce()

```text
repartition()
- Increase Or Decrease Partitions
- Causes Shuffle

coalesce()
- Usually Reduce Partitions
- More Efficient
- Usually Avoids Full Shuffle
```

---

#### Difference Between cache() and persist()

```text
cache()
- MEMORY_ONLY
- Simpler

persist()
- Multiple Storage Options
- More Flexible
```

---

#### What Loads Data Into Cache?

Code:

```python
df.cache()
df.show()
df.count()
```

Answer:

```text
First Action Triggers Computation
And Populates Cache
```

---

## Quick Revision - Section 11

```text
repartition()
- Increase Or Decrease Partitions
- Causes Shuffle

coalesce()
- Usually Reduce Partitions
- More Efficient Than repartition()

cache()
- Stores DataFrame In Memory
- Lazy Evaluation

persist()
- More Control Than cache()
- MEMORY_ONLY
- MEMORY_AND_DISK
- DISK_ONLY

Broadcast Join
- Small Table + Large Table
- Avoids Shuffle
- Faster Join

Common Shuffle Operations
- groupBy()
- join()
- distinct()
- repartition()
- orderBy()

1 Partition = 1 Task

cache() Is Lazy
First Action Populates Cache
```

---

## Quick Revision - Section 10

```text
Driver = Brain of Spark Application

Executor = Executes Tasks

Cluster Manager = Allocates Resources

Action -> Creates Job

1 Action = 1 Job

Job -> Divided into Stages

Stage -> Divided into Tasks

1 Partition = 1 Task

Narrow Transformations:
select()
filter()
withColumn()
drop()

Wide Transformations:
groupBy()
join()
distinct()
repartition()
orderBy()

Wide Transformation
       ↓
    Shuffle
       ↓
   New Stage
```
