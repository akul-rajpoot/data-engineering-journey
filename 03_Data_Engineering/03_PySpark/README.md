

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