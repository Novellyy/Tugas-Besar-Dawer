--1. 5 orang farmasi dengan gaji tertinggi
SELECT
  pharmacist_name,
  pharmacist_rate
FROM dim_pharmacist
ORDER BY
  pharmacist_rate DESC
LIMIT
  5;
--2. 5 obat paling laris
SELECT
  drug_name,
  COUNT(fact_transaction_sale_only_pharmacy.drug_id) AS totalsale
FROM fact_transaction_sale_only_pharmacy AS recap
INNER JOIN dim_drug ON recap.drug_id = dim_drug.drug_id
GROUP BY
  drug_name
ORDER BY
  totalsale DESC
LIMIT
  5;
--3. 5 drug supplier terlaris
SELECT
  drug_supplier_name,
  COUNT(recap.drug_supplier_id) AS penjualan
FROM fact_transaction_logistic_pharmacy AS recap
INNER JOIN dim_drug_supplier as ds ON ds.drug_supplier_id = recap.drug_supplier_id
GROUP BY
  drug_supplier_name
ORDER BY
  penjualan DESC
LIMIT
  5;
--4. Nama-nama drug store diurutkan dari yang terlaris
SELECT
  drug_store_name,
  COUNT(fact_transaction_sale_pharmacy.drug_store_id) AS totalsale
FROM dim_drug_store
JOIN fact_transaction_sale_pharmacy as recap ON dim_drug_store.drug_store_id = recap.drug_store_id
GROUP BY
  drug_store_name
ORDER BY
  drug_store_name DESC;
--5. Besar pengeluaran setiap drug store (biaya) dan jumlah produk yang masuk pada tahun 2018
SELECT
  DISTINCT drug_store_name,
  EXTRACT (YEAR
FROM recap.date) AS year,
  SUM(revenue) AS revenue,
  SUM(drug_qty) AS jmlobatmasuk
FROM fact_transaction_sale_only_pharmacy AS recap
INNER JOIN dim_drug_store as ds ON ds.drug_store_id = recap.drug_store_id
WHERE
  (
    SELECT
      EXTRACT (YEAR
    FROM recap.date)
  ) = '2018'
GROUP BY
  drug_store_name,
  year
ORDER BY
  revenue DESC;
--6. Besar pemasukan setiap drug store dan jumlah produk yang terjual pada tahun 2018
SELECT
  DISTINCT drug_store_name,
  EXTRACT (YEAR
FROM recap.date) AS year,
  SUM(expense) AS expense,
  SUM(drug_qty) AS jmlobatterjual
FROM fact_transaction_sale_only_pharmacy AS recap
INNER JOIN dim_drug_store as ds ON ds.drug_store_id = recap.drug_store_id
WHERE
  (
    SELECT
      EXTRACT (YEAR
    FROM recap.date)
  ) = '2018'
GROUP BY
  drug_store_name,
  year
ORDER BY
  expense DESC;
--7. Besar keuntungan setiap drug store dan jumlah transaksi penjualan pada tahun 2018
SELECT
  DISTINCT drug_store_name,
  EXTRACT (YEAR
FROM recap.date) AS year,
  SUM(income) AS income,
  COUNT(recap.drug_store_id) AS jmlpenjualan
FROM fact_transaction_sale_only_pharmacy AS recap
INNER JOIN dim_drug_store AS ds ON ds.drug_store_id = recap.drug_store_id
WHERE
  (
    SELECT
      EXTRACT (YEAR
    FROM recap.date)
  ) = '2018'
GROUP BY
  drug_store_name,
  year
ORDER BY
  income DESC;
--8. Jumlah Hari Rata-rata obat akan expired setelah dijual kepada pelanggan pada tiap bulannya
select
  avg(drug_expired - date) AS expired
FROM fact_transaction_sale_only_pharmacy AS recap
INNER JOIN dim_drug AS d ON d.drug_id = recap.drug_id --9. Total gaji seluruh dokter dalam sebulan
select
  SUM(doctor_rate) as TotalGaji
from dim_doctor;
--10. Jumlah obat terdaftar
select
  COUNT(drug_id) as ObatTerdaftar
from dim_drug;
--11. Nama-nama drug store terdaftar
select
  drug_store_name
from dim_drug_store
order by
  drug_store_name DESC;
--12. Nama-nama drug supplier terdaftar
select
  drug_supplier_name
from dim_drug_supplier
order by
  drug_supplier_name DESC;