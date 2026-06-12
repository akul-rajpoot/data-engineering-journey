from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def Extract():
    print("Extracting Data")

def Transform():
    print("Transforming Data")

def Load():
    print("Loading data to DW")

with DAG (
    dag_id='etl_pipeline',
    start_date=datetime('2026-1-1'),
    schedule='@daily',  
    catchup=False
) as dag:

extract_task=PythonOperator(task_id='extract_task',python_callable=Extract)
transform_task=PythonOperator(task_id='transform_task',python_callable=Transform)
load_task=PythonOperator(task_id='load_task',python_callable=Load)

extract_task >> transform_task >> load_task