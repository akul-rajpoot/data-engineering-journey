from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def hello():
    print("Hello First Dag")

with DAG(
    dag_id="Hello World",
    start_date=datetime(2025,1,1),
    schedule="@daily",
    catchup=False
) as dag :

Task=PythonOperator(task_id='hello_task',python_callable=hello)
