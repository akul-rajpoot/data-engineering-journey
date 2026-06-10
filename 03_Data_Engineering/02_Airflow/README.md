

# Apache Airflow

## What is Airflow?

Apache Airflow is an open-source workflow orchestration platform used to schedule, monitor, and manage data pipelines.

It allows workflows to be defined as DAGs (Directed Acyclic Graphs).

---

# Airflow Architecture

## Metadata Database

Stores Airflow metadata such as:

- DAG Runs
- Task Status
- Scheduling Information
- Connections
- Variables
- User Information

---

## Scheduler

The Scheduler continuously checks DAGs and determines which tasks are ready to run based on schedules and dependencies.

### Responsibilities

- Reads DAG schedules
- Creates DAG runs
- Determines runnable tasks
- Respects dependencies and trigger rules

---

## Executor

The Executor determines how and where tasks should run.

Examples:

- Sequential Executor
- Local Executor
- Celery Executor
- Kubernetes Executor

---

## Worker

Workers execute tasks assigned by the Executor.

Examples:

- Run Python Code
- Run SQL Queries
- Execute Spark Jobs
- Call APIs

---

## Queue

Stores tasks waiting to be executed by workers.

Commonly used with Celery Executor.

---

## DAG File Processor

Parses DAG Python files and extracts workflow definitions.

---

## Web Server

Provides the Airflow UI for monitoring DAGs and tasks.

---

## Triggerer

Handles deferred and asynchronous tasks efficiently without blocking workers.

---

# DAG (Directed Acyclic Graph)

## Definition

A DAG is the core building block of Airflow.

It represents a workflow as a collection of tasks and dependencies.

A DAG defines:

- What tasks should run
- In what order they should run
- When they should run

---

## Directed

```text
Task A → Task B → Task C
```

Execution order is defined.

---

## Acyclic

Loops are not allowed.

Valid:

```text
A → B → C
```

Invalid:

```text
A → B → C → A
```

---

## Graph

Collection of connected tasks.

Example:

```text
Extract → Transform → Load
```

---

# Task

## Definition

A Task is a single unit of work within a DAG.

A Task is an instance of an Operator.

Example:

```text
DAG = ETL Pipeline

Tasks:
- Extract Data
- Transform Data
- Load Data
```

---

# Operator

## Definition

An Operator defines what work needs to be performed.

Operators act as templates for tasks.

### Memory Trick

```text
Operator = Class
Task = Object
```

---

## Common Operators

### PythonOperator

Executes Python functions.

### BashOperator

Executes shell commands.

### SQL Operators

Examples:

- PostgresOperator
- MySqlOperator
- SnowflakeOperator

---

# Task Dependencies

Dependencies define execution order.

Example:

```python
extract_task >> transform_task >> load_task
```

Meaning:

```text
Extract
   ↓
Transform
   ↓
Load
```

### Important

Tasks without dependencies can run in parallel.

---

# XCom (Cross Communication)

## Definition

XCom allows tasks within a DAG to exchange small pieces of data.

### Example

```text
Task A
   ↓
 XCom
   ↓
Task B
```

---

## Good Use Cases

- File Names
- Counts
- Status Flags
- IDs
- Dates

---

## Bad Use Cases

- Large DataFrames
- Millions of Records
- Large Files

XCom should only be used for small messages.

---

# Retries

## Definition

Retries define how many times Airflow should automatically rerun a failed task.

Example:

```python
retries=3
```

Means:

```text
1 Initial Attempt
+ 3 Retries
= 4 Total Attempts
```

---

## Retry Delay

Example:

```python
retry_delay=timedelta(minutes=5)
```

Waits 5 minutes before retrying.

---

# Scheduling

Scheduling determines when a DAG should run.

Examples:

```python
schedule='@daily'
schedule='@hourly'
```

---

## Cron Format

```text
* * * * *
│ │ │ │ │
│ │ │ │ └── Day Of Week
│ │ │ └──── Month
│ │ └────── Day Of Month
│ └──────── Hour
└────────── Minute
```

Examples:

```text
0 0 * * *     -> Daily Midnight
0 * * * *     -> Every Hour
0 9 * * 1     -> Every Monday 9 AM
30 18 * * 5   -> Every Friday 6:30 PM
```

---

# Trigger Rules

Trigger Rules define when a task should run based on upstream task status.

## all_success (Default)

Run only if all upstream tasks succeed.

---

## one_success

Run if at least one upstream task succeeds.

---

## all_failed

Run only if all upstream tasks fail.

---

## one_failed

Run if at least one upstream task fails.

---

# Executors

## Sequential Executor

- One task at a time
- No parallelism
- Best for learning

---

## Local Executor

- Multiple tasks in parallel
- Single machine

---

## Celery Executor

- Distributed execution
- Multiple workers
- Uses a queue

---

## Kubernetes Executor

- One Kubernetes Pod per task
- Highly scalable
- Cloud Native

---

# Executor Comparison

| Executor | Parallel | Multiple Machines |
|-----------|----------|-------------------|
| Sequential | No | No |
| Local | Yes | No |
| Celery | Yes | Yes |
| Kubernetes | Yes | Yes |

---

# DAG Example

```python
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime


def hello_world():
    print('Hello World')


with DAG(
    dag_id='hello_world_dag',
    start_date=datetime(2025,1,1),
    schedule='@daily',
    catchup=False
) as dag:

    hello_task = PythonOperator(
        task_id='hello_task',
        python_callable=hello_world
    )
```

---

# Common Interview Questions

1. What is Airflow?
2. What is a DAG?
3. Difference between Task and Operator?
4. What is XCom?
5. Why not use Cron Jobs?
6. What happens when a task fails?
7. What is the default Trigger Rule?
8. Difference between Scheduler, Executor and Worker?
9. Which Executor would you use in production?
10. Can tasks run in parallel?

---

# Quick Revision

```text
DAG = Workflow
Task = Unit Of Work
Operator = Blueprint For Task
XCom = Task Communication
Scheduler = Decides When To Run
Executor = Decides How To Run
Worker = Executes Tasks

all_success = Default Trigger Rule

Sequential = One Task
Local = Parallel On One Machine
Celery = Multiple Workers
Kubernetes = One Pod Per Task
```