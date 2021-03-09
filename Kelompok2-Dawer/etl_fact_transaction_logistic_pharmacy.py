from tqdm import tqdm
import logging
import psycopg2
import csv
import os
THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))
csvfile = os.path.join(
    THIS_FOLDER, 'recap_logistic.csv')

# config
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(process)d - %(name)s - %(levelname)s - %(message)s'
)

host = 'localhost'
database = 'dw'
user = 'postgres'
password = '787898'

# connection
conn = psycopg2.connect(host=host, database=database,
                        user=user, password=password)
cur = conn.cursor()

logging.debug('Start Read Data')

logistic = []
with open(csvfile, mode='r') as csv_file:
    data = csv.reader(csv_file, delimiter=',')
    next(data)
    for i in tqdm(data):
        logistic.append(i)
logging.debug('Done Read Data')
logging.debug('Start Insert Data')

for row in tqdm(logistic):
    t_id = row[0]
    date = row[1]
    drug_supp = row[2]
    drug_id = row[3]
    drug_qty = row[4]

    # revenue
    cur_revenue = conn.cursor()
    cur_revenue.execute(
        "SELECT %s*drug_price_sell FROM dim_drug WHERE drug_id = %s", [drug_qty, drug_id])
    revenue = float(cur_revenue.fetchone()[0])

    # expense
    cur_expense = conn.cursor()
    cur_expense.execute(
        "SELECT %s*drug_price_buy FROM dim_drug WHERE drug_id = %s", [drug_qty, drug_id])
    expense = float(cur_expense.fetchone()[0])

    # income
    income = revenue - expense
    sql = "INSERT INTO fact_transaction_logistic_pharmacy(transaction_logistic_pharmacy_id,date,drug_supplier_id,drug_id,drug_qty,revenue,expense,income) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
    value = (t_id, date, drug_supp, drug_id,
             drug_qty, revenue, expense, income)
    cur.execute(sql, value)
    conn.commit()
logging.debug('Finish!')
