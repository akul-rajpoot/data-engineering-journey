

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