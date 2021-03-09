CREATE TABLE mahasiswa (
  nim int NOT NULL,
  nama varchar(20) NOT NULL,
  tgl_lahir varchar(20) NOT NULL,
  kelas_asal varchar(10) NOT NULL
);
CREATE TABLE matkul (
  mk_id varchar(6) NOT NULL,
  nama varchar(111) NOT NULL,
  sks int NOT NULL,
  jenis varchar(22) NOT NULL
);
CREATE TABLE mengambil (
  reg_id varchar(8) NOT NULL,
  nim int NOT NULL,
  mk_id varchar(6) NOT NULL,
  thn_ajaran int NOT NULL,
  semester char(1) NOT NULL,
  nilai char(2) NOT NULL
);
ALTER TABLE mahasiswa
ADD
  PRIMARY KEY (nim);
ALTER TABLE matkul
ADD
  PRIMARY KEY (mk_id);
ALTER TABLE mengambil
ADD
  PRIMARY KEY (reg_id);
ALTER TABLE mengambil
ADD
  CONSTRAINT mengambil_fk1 FOREIGN KEY (nim) REFERENCES mahasiswa (nim) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
  CONSTRAINT mengambil_fk2 FOREIGN KEY (mk_id) REFERENCES matkul (mk_id) ON DELETE CASCADE ON UPDATE CASCADE;