from tqdm import tqdm
import logging
import psycopg2
import csv
import os
THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))
csvfile = os.path.join(THIS_FOLDER, 'drug.csv')

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

logging.debug('Start inserting data..')

sql = "INSERT INTO dim_drug(drug_id,drug_name,drug_category,drug_price_buy,drug_price_sell,drug_expired) VALUES (%s,%s,%s,%s,%s,%s)"
with open(csvfile) as csv_file:
    data = csv.reader(csv_file, delimiter=',')
    next(data)
    for i in tqdm(data):
        cur.execute(sql, i)
    conn.commit()

logging.debug('Finish!')
