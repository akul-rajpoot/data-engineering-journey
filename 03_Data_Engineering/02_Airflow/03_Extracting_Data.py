from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime


def extracting_customer():
    print("Extracting customers data")
    return {"total_customers": 1000}


def extracting_product():
    print("Extracting product data")
    return {"total_products": 500}


def extracting_orders():
    print("Extracting orders data")
    return {"total_orders": 2500}


def generate_report(ti):
    cust_data = ti.xcom_pull(task_ids="extract_cus")
    prod_data = ti.xcom_pull(task_ids="extract_prd")
    order_data = ti.xcom_pull(task_ids="extract_ord")

    print("--- GENERATING FINAL REPORT ---")
    print(f"Customers: {cust_data['total_customers']}")
    print(f"Products: {prod_data['total_products']}")
    print(f"Orders: {order_data['total_orders']}")


with DAG(
    dag_id="ecom_data_extraction",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False
) as dag:

    extract_cus = PythonOperator(
        task_id="extract_cus",
        python_callable=extracting_customer
    )

    extract_prd = PythonOperator(
        task_id="extract_prd",
        python_callable=extracting_product
    )

    extract_ord = PythonOperator(
        task_id="extract_ord",
        python_callable=extracting_orders
    )

    gen_report = PythonOperator(
        task_id="gen_report",
        python_callable=generate_report
    )

    [extract_cus, extract_prd, extract_ord] >> gen_report