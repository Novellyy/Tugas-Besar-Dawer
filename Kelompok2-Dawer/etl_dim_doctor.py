from tqdm import tqdm
import logging
import psycopg2
import csv
import os
THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))
csvfile = os.path.join(THIS_FOLDER, 'doctor.csv')

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

logging.debug('Start read csv data..')

doctor = []
with open(csvfile, mode='r') as csv_file:
    data = csv.reader(csv_file, delimiter=';')
    next(data)
    for i in tqdm(data):
        doctor.append(i)

logging.debug('Finih read csv data')

logging.debug('Start inserting data')

for row in tqdm(doctor):
    doctor_id = row[0]
    doctor_name = row[1]
    doctor_specialist = row[2]
    doctor_dob = row[3]
    doctor_phone = row[4]
    doctor_rate = row[5]

    sql = "INSERT INTO dim_doctor(doctor_id,doctor_name,doctor_specialist,doctor_dob,doctor_phone,doctor_rate) VALUES (%s,%s,%s,%s,%s,%s)"
    value = (doctor_id, doctor_name, doctor_specialist,
             doctor_dob, doctor_phone, doctor_rate)
    cur.execute(sql, value)
    conn.commit()

logging.debug('Finish!')
