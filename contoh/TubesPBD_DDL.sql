/*##############Table Mahasiswa#################*/
CREATE TABLE Mahasiswa(
    NIM VARCHAR2(10) not null,
    NamaMhs VARCHAR2(50) not null,
    JenisKelamin char(1),
    Alamat Varchar2(50),
    Agama Varchar2(10)
);
Alter Table Mahasiswa Add Constraint Mahasiswa_PK Primary Key(NIM);

Create Table EmailMhs(
    NIM VARCHAR2(10) not null,
    Email Varchar2(50)
);
--Alter Table EmailMhs Add Constraint EmailMhs_PK Primary Key(NIM);
Alter Table EmailMhs Add Constraint EmailMhs_FK1 Foreign Key(NIM) references Mahasiswa(NIM);

Create Table NoHPMhs(
    NIM VARCHAR2(10) not null,
    NoHP Varchar2(25)
);
--Alter Table NoHPMhs Add Constraint NoHPMhs_PK Primary Key(NIM);
Alter Table NoHPMhs Add Constraint NoHPMhs_FK1 Foreign Key(NIM) references Mahasiswa(NIM);

Create Table HobiMhs(
    NIM VARCHAR2(10) not null,
    Hobi Varchar2(50)
);
--Alter Table HobiMhs Add Constraint HobiMhs_PK Primary Key(NIM);
Alter Table HobiMhs Add Constraint HobiMhs_FK1 Foreign Key(NIM) references Mahasiswa(NIM);

/*##############Table Matakuliah#################*/
Create Table Matakuliah(
    KodeMatkul Varchar2(6) not null,
    SKS Number,
    namaMatkul varchar2(25)
);
Alter Table Matakuliah Add Constraint Matakuliah_PK Primary Key(KodeMatkul);

/*##############Table Dosen#################*/
Create Table Dosen(
    NIP VARCHAR2(10) not null,
    NamaDosen VARCHAR2(50),
    KodeDosen Varchar2(3),
    JenisKelamin Char(1),
    Alamat Varchar2(50)
);
Alter Table Dosen Add Constraint Dosen_PK Primary Key(NIP);

/*##############Table Dosen-Matakuliah#################*/
Create Table Mengajar(
    IDMengajar Varchar2(10) not null,
    KodeMatkul Varchar2(6) not null,
    NIP VARCHAR2(10) not null,
    Jadwal Varchar2(15)
);
Alter Table Mengajar Add Constraint Mengajar_PK Primary Key(IDMengajar);
Alter Table Mengajar Add Constraint Mengajar_FK1 Foreign Key (KodeMatkul) references Matakuliah(KodeMatkul);
Alter Table Mengajar Add Constraint Mengajar_FK2 Foreign Key (NIP) references Dosen(NIP);

/*##############Table Mahasiswa-(Dosen-Matakuliah)#################*/
Create Table Perkuliahan (
    IDPerkuliahan Varchar(10) not null,
    IDMengajar Varchar2(10) not null
);
Alter Table Perkuliahan Add Constraint Perkuliahan_PK Primary Key(IDPerkuliahan);
Alter Table Perkuliahan Add constraint Perkuliahan_FK1 Foreign Key(IDMengajar) references Mengajar(IDMengajar);

Create Table PerkuliahanDetail(
    IDPerkuliahan Varchar(10) not null,
    NIM VARCHAR2(10) not null,
    nilaiUTS NUMBER,
    nilaiUAS NUMBER,
    nilaiTUBES NUMBER,
    nilaiTUGAS NUMBER
);
Alter Table PerkuliahanDetail Add Constraint PerkuliahanDetail_FK1 Foreign Key(IDPerkuliahan) references Perkuliahan(IDPerkuliahan);
Alter Table PerkuliahanDetail Add Constraint PerkuliahanDetail_FK2 Foreign Key(NIM) references Mahasiswa(NIM);

/*##############Table UKM#################*/
Create Table UKM(
    namaUKM Varchar(25) not null,
    kategori Varchar(25)
);
Alter Table UKM Add Constraint UKM_PK Primary Key(namaUKM);

/*##############Table UKM-Mahasiswa#################*/
Create Table Keanggotaan(
    IDAnggota Varchar(10) not null,
    NIM VARCHAR2(10) not null,
    namaUKM Varchar(25) not null
);
Alter Table Keanggotaan Add Constraint Keanggotaan_PK Primary Key(IDAnggota);
Alter Table Keanggotaan Add Constraint Keanggotaan_FK1 Foreign Key(NIM) references Mahasiswa(NIM);
Alter Table Keanggotaan Add Constraint Keanggotaan_FK2 Foreign Key(namaUKM) references UKM(namaUKM);

/*##############Table Ruangan#################*/
Create Table Ruangan(
    IDRuangan Varchar(10) not null
);
Alter Table Ruangan Add Constraint Ruangan_PK Primary Key(IDRuangan);

/*##############Table Ruangan-(Mahasiswa-(Dosen-Matakuliah))#################*/
Create Table Menempati(
    IDTempat Varchar(10),
    IDPerkuliahan Varchar(10) not null,
    IDRuangan Varchar(10) not null
);
Alter Table Menempati Add Constraint Menempati_PK Primary Key(IDTempat);
Alter Table Menempati Add Constraint Menempati_FK1 Foreign Key(IDPerkuliahan) references Perkuliahan(IDPerkuliahan);
Alter Table Menempati Add Constraint Menempati_FK2 Foreign Key(IDRuangan) references Ruangan(IDRuangan);

SELECT ALL * FROM TAB;

/*BEGIN

  --Bye Tables!
  FOR i IN (SELECT ut.table_name
              FROM USER_TABLES ut) LOOP
    EXECUTE IMMEDIATE 'drop table '|| i.table_name ||' CASCADE CONSTRAINTS ';
  END LOOP;

END;*/