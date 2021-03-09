# Jika connect ke database postgres, maka import spt di bawah
# ..dan intsal dahulu di terminal dengan cara..
#  ..jalankan pip3 install psycopg2
import psycopg2
# Jika connect nya ke database mysql, maka import mysql.connector dan..
# ..diharuskan untuk menginstal nya, dengan cara, buka terminal, lalu..
# jalankan pip3 install mysql-connector  ..Setelah berhasil terinstal..
# jalankan pip3 install mysql-connector-python ..Selesai. Jangan lupa..
# ..ubah dan sesuaikan data connect di bawah
con = psycopg2.connect(
    host="localhost",
    database="dawer",
    user="postgres",
    password="787898"
)
cur = con.cursor()

# 10 MK Pilihan terfavorit


def no1():
    cur.execute("SELECT mk_id, nama, sks, jenis, COUNT(mk_id) AS jumlah_diambil FROM mengambil JOIN matkul USING(mk_id) WHERE jenis='Pilihan' GROUP BY mengambil.mk_id, matkul.nama, matkul.sks, matkul.jenis ORDER BY COUNT(mk_id) DESC LIMIT 10")
    result = cur.fetchall()
    print("Total Baris: ", len(result))
    print("")
    print("(mk_id, nama, sks, jenis, jumlah_diambil)")
    print("")
    for row in result:
        print(row)
    print("")
    done = input("done? (y for exit | press 'enter' to resume) : ")
    if done == 'y':
        keluar()
    else:
        menu()

# 5 MK Wajib dengan tingkat kelulusan terendah


def no2():
    cur.execute("SELECT mk_id, nama, sks, jenis, COUNT(nilai) AS jml_tidak_lulus FROM mengambil JOIN matkul USING(mk_id) WHERE jenis='Wajib' AND nilai='E' GROUP BY mengambil.mk_id, matkul.nama, matkul.sks, matkul.jenis ORDER BY COUNT(nilai) DESC LIMIT 5")
    result = cur.fetchall()
    print("Total Baris: ", len(result))
    print("")
    print("(mk_id, nama, sks, jenis, jumlah_tidak_lulus)")
    print("")
    for row in result:
        print(row)
    print("")
    done = input("done? (y for exit | press 'enter' to resume) : ")
    if done == 'y':
        keluar()
    else:
        menu()


# 10 Mahasiswa dengan IPK tertinggi
def no3():
    cur.execute("SELECT nim,nama,kelas_asal,COUNT(nilai) AS jml_nilai_A FROM mengambil JOIN mahasiswa USING (nim) WHERE nilai = 'A' GROUP BY nim,nama,kelas_asal ORDER BY COUNT(nilai) DESC LIMIT 10;")
    result = cur.fetchall()
    print("Total Baris: ", len(result))
    print("")
    print("(nim, nama, kelas_asal, jml_nilai_a)")
    print("")
    for row in result:
        print(row)
    print("")
    done = input("done? (y for exit | press 'enter' to resume) : ")
    if done == 'y':
        keluar()
    else:
        menu()
# (Hanya tambahan) Input Query sendiri


def no4():
    try:
        print("1. View \n2. Update")
        choice = int(input("Pilihan : "))
        if choice == 1:
            no4a()
        elif choice == 2:
            no4b()
    except:
        keluar()
# Untuk Query Select


def no4a():
    try:
        query = input("Masukan query: ")
        cur.execute(query)
        result = cur.fetchall()
        print("Total Baris: ", len(result))
        print("")
        for row in result:
            print(row)
        print("")
        done = input(
            "done? (y for exit | q for insert back | press 'enter' for menu) : ")
        if done == 'y':
            keluar()
        elif done == 'q':
            no4()
        else:
            menu()
    except:
        keluar()

# Untuk Query Insert, dan Update


def no4b():
    try:
        query = input("Masukan query: ")
        cur.execute(query)
        con.commit()
        print("Updated!")
        print("")
        done = input(
            "done? y for exit | q for insert back | any key for menu) : ")
        if done == 'y':
            keluar()
        elif done == 'q':
            no4()
        else:
            menu()
    except:
        exit


def menu():
    print("Pilih perintah, \n 1. Tampilkan 10 MK Pilihan Terfavorit \n 2. Tampilkan 5 MK Wajib dengan kelulusan terendah \n 3. Tampilkan 10 Mahasiswa dengan IPK tertinggi \n 4. Masukan Query Lain \n 5. Exit")
    choice = int(input("Pilihan : "))
    if choice == 1:
        no1()
    elif choice == 2:
        no2()
    elif choice == 3:
        no3()
    elif choice == 4:
        no4()
    elif choice == 5:
        keluar()
    else:
        print("Masukan hanya antara angka 1-5")
        menu()


def keluar():
    cur.close()
    con.close()
    exit


menu()
