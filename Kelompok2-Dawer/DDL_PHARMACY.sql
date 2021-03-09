-- tabel dimensi customer
CREATE TABLE IF NOT EXISTS dim_customer (
  customer_id VARCHAR(20) NOT NULL,
  customer_name VARCHAR(60) NULL,
  customer_dob DATE NULL,
  customer_phone VARCHAR(30) NULL,
  customer_address TEXT NULL,
  PRIMARY KEY (customer_id)
);
-- tabel dimensi pharmacist
CREATE TABLE IF NOT EXISTS dim_pharmacist (
  pharmacist_id VARCHAR(15) NOT NULL,
  pharmacist_name VARCHAR(80) NULL,
  pharmacist_address TEXT NULL,
  pharmacist_dob DATE NULL,
  pharmacist_phone VARCHAR(30) NULL,
  pharmacist_rate INT NULL,
  PRIMARY KEY (pharmacist_id)
);
-- tabel dimensi doctor
CREATE TABLE IF NOT EXISTS dim_doctor (
  doctor_id VARCHAR(10) NOT NULL,
  doctor_name VARCHAR(60) NULL,
  doctor_specialist VARCHAR(45) NULL,
  doctor_dob DATE NULL,
  doctor_phone VARCHAR(15) NULL,
  doctor_rate INT NULL,
  PRIMARY KEY (doctor_id)
);
-- TABEL drug_store
CREATE TABLE IF NOT EXISTS dim_drug_store (
  drug_store_id VARCHAR(15) NOT NULL,
  drug_store_name VARCHAR(60) NULL,
  drug_store_location TEXT NULL,
  PRIMARY KEY (drug_store_id)
);
-- TABEL dimensi drug
CREATE TABLE IF NOT EXISTS dim_drug (
  drug_id VARCHAR(20) NOT NULL,
  drug_name VARCHAR(60) NULL,
  drug_category VARCHAR(45) NULL,
  drug_price_buy INT NULL,
  drug_price_sell INT NULL,
  drug_expired DATE NULL,
  PRIMARY KEY (drug_id)
);
-- TABEL dimensi patient
CREATE TABLE IF NOT EXISTS dim_patient (
  patient_id VARCHAR(15) NOT NULL,
  patient_name VARCHAR(80) NULL,
  patient_dob DATE NULL,
  patient_phone VARCHAR(30) NULL,
  patient_address TEXT NULL,
  PRIMARY KEY (patient_id)
);
-- TABEL dimensi drug_supplier
CREATE TABLE IF NOT EXISTS dim_drug_supplier (
  idx INT NULL,
  drug_supplier_id VARCHAR(20) NOT NULL,
  drug_supplier_name VARCHAR(80) NULL,
  drug_supplier_phone VARCHAR(30) NULL,
  drug_supplier_address TEXT NULL,
  PRIMARY KEY (drug_supplier_id)
);
-- TABEL fact fact_transaction_sale_only_pharmacy
CREATE TABLE fact_transaction_sale_only_pharmacy (
  transaction_sale_only_pharmacy_id varchar(255) not null,
  doctor_id VARCHAR(10) NOT NULL,
  pharmacist_id VARCHAR(15) NOT NULL,
  customer_id VARCHAR(20) NOT NULL,
  drug_store_id VARCHAR(15) NOT NULL,
  date TIMESTAMP,
  drug_id VARCHAR(20) NOT NULL,
  drug_qty INT,
  revenue INT,
  expense INT,
  income INT,
  PRIMARY KEY (transaction_sale_only_pharmacy_id),
  FOREIGN KEY (doctor_id) REFERENCES dim_doctor (doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (pharmacist_id) REFERENCES dim_pharmacist (pharmacist_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES dim_customer (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (drug_store_id) REFERENCES dim_drug_store (drug_store_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (drug_id) REFERENCES dim_drug (drug_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- TABEL fact fact_transaction_sale_pharmacy
CREATE TABLE fact_transaction_sale_pharmacy (
  transaction_sale_pharmacy_id varchar(255) not null,
  doctor_id VARCHAR(10) NOT NULL,
  pharmacist_id VARCHAR(15) NOT NULL,
  patient_id VARCHAR(20) NOT NULL,
  drug_store_id VARCHAR(15) NOT NULL,
  date TIMESTAMP,
  drug_id VARCHAR(20) NOT NULL,
  drug_qty INT,
  revenue INT,
  expense INT,
  income INT,
  PRIMARY KEY (transaction_sale_pharmacy_id),
  FOREIGN KEY (doctor_id) REFERENCES dim_doctor (doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (pharmacist_id) REFERENCES dim_pharmacist (pharmacist_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES dim_patient (patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (drug_store_id) REFERENCES dim_drug_store (drug_store_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (drug_id) REFERENCES dim_drug (drug_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- TABEL fact fact_transaction_logistic_pharmacy
CREATE TABLE fact_transaction_logistic_pharmacy (
  transaction_logistic_pharmacy_id varchar(255) not null,
  date date,
  drug_supplier_id VARCHAR(20) NOT NULL,
  drug_id VARCHAR(20) NOT NULL,
  drug_qty INT,
  revenue INT,
  expense INT,
  income INT,
  PRIMARY KEY (transaction_logistic_pharmacy_id),
  FOREIGN KEY (drug_supplier_id) REFERENCES dim_drug_supplier (drug_supplier_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (drug_id) REFERENCES dim_drug (drug_id) ON DELETE CASCADE ON UPDATE CASCADE
);