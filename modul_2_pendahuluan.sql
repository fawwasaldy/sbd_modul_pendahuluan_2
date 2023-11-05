CREATE DATABASE Modul_2_Pendahuluan;

USE Modul_2_Pendahuluan;

-- no.1
CREATE TABLE Pegawai(
    NIK CHAR(16) NOT NULL,
    Nama_pegawai VARCHAR(100) NOT NULL,
    Jenis_kelamin CHAR(1),
    Email VARCHAR(50),
    Umur INTEGER NOT NULL,
    CONSTRAINT Pegawai_PK PRIMARY KEY (NIK)
);
CREATE TABLE Customer(
    ID_customer CHAR(6) NOT NULL,
    Nama_customer VARCHAR(100) NOT NULL,
    CONSTRAINT Customer_PK PRIMARY KEY (ID_customer)
);
CREATE TABLE Menu_minuman(
    ID_minuman CHAR(6) NOT NULL,
    Nama_minuman VARCHAR(50) NOT NULL,
    Harga_minuman FLOAT(2) NOT NULL,
    CONSTRAINT Menu_minuman_PK PRIMARY KEY (ID_minuman)
);
CREATE TABLE Telepon(
    No_telp_pegawai VARCHAR(15) NOT NULL,
    Pegawai_NIK CHAR(16) NOT NULL,
    CONSTRAINT Telepon_PK PRIMARY KEY (No_telp_pegawai),
    CONSTRAINT Telepon_Pegawai_FK FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);
CREATE TABLE Transaksi(
    ID_transaksi CHAR(10) NOT NULL,
    Tanggal_transaksi DATE NOT NULL,
    Metode_pembayaran VARCHAR(15) NOT NULL,
    Customer_ID_customer CHAR(6) NOT NULL,
    Pegawai_NIK CHAR(16) NOT NULL,
    CONSTRAINT Transaksi_PK PRIMARY KEY (ID_transaksi),
    CONSTRAINT Transaksi_Customer_FK FOREIGN KEY (Customer_ID_customer) REFERENCES Customer(ID_customer),
    CONSTRAINT Transaksi_Pegawai_FK FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);
CREATE TABLE Transaksi_minuman(
    TM_Menu_minuman_ID CHAR(6) NOT NULL,
    TM_Transaksi_ID CHAR(10) NOT NULL,
    Jumlah_cup INT NOT NULL,
    CONSTRAINT Transaksi_minuman_PK PRIMARY KEY (TM_Menu_minuman_ID, TM_Transaksi_ID),
    CONSTRAINT TM_ID_Menu_minuman_FK FOREIGN KEY (TM_Menu_minuman_ID) REFERENCES Menu_minuman(ID_minuman),
    CONSTRAINT TM_ID_Transaksi_FK FOREIGN KEY (TM_Transaksi_ID) REFERENCES Transaksi(ID_transaksi)
);

-- no.2
CREATE TABLE Membership(
    id_membership CHAR(6) NOT NULL,
    no_telepon_customer VARCHAR(15) NOT NULL,
    alamat_customer VARCHAR(100) NOT NULL,
    tanggal_pembuatan_kartu_membership DATE NOT NULL,
    tanggal_kedaluawarsa_kartu_membership DATE,
    total_poin INT NOT NULL,
    customer_id_customer CHAR(6) NOT NULL
);
-- a
ALTER TABLE Membership
ADD PRIMARY KEY (id_membership);
-- b
ALTER TABLE Membership
ADD FOREIGN KEY (customer_id_customer) REFERENCES Customer(ID_customer)
ON UPDATE CASCADE
ON DELETE RESTRICT;
-- c
ALTER TABLE Transaksi
ADD FOREIGN KEY (Customer_ID_customer) REFERENCES Customer(ID_customer)
ON UPDATE CASCADE
ON DELETE CASCADE;
-- d
ALTER TABLE Membership
MODIFY tanggal_pembuatan_kartu_membership DATE DEFAULT CURRENT_DATE NOT NULL;
-- e
ALTER TABLE Membership
ADD CHECK (total_poin >= 0);
-- f
ALTER TABLE Membership
MODIFY alamat_customer VARCHAR(150) NOT NULL;

-- no.3
DROP TABLE Telepon;
ALTER TABLE Pegawai
ADD No_telp_pegawai VARCHAR(15) NOT NULL;

-- no.4
INSERT INTO Customer (ID_customer, Nama_customer)
VALUES
    ('CTR001', 'Budi Santoso'),
    ('CTR002', 'Sisil Triana'),
    ('CTR003', 'Davi Liam'),
    ('CTRo04', 'Sutris Ten An'),
    ('CTR005', 'Hendra Asto');
INSERT INTO Membership (id_membership, no_telepon_customer, alamat_customer, tanggal_pembuatan_kartu_membership, tanggal_kedaluawarsa_kartu_membership, total_poin, customer_id_customer)
VALUES
    ('MBR001', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', 0, 'CTR001'),
    ('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', 3, 'CTR002'),
    ('MBR003', '081234567890', 'Jl. Abah Ojak', '2023-10-25', '2023-12-01', 2, 'CTR003'),
    ('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-02', 6, 'CTR005');
INSERT INTO Pegawai (NIK, Nama_pegawai, Jenis_kelamin, Email, Umur, No_telp_pegawai)
VALUES
    ('1234567890123456', 'Naufal Raf', 'Laki-Laki', 'naufal@gmail.com', 19, '62123456789'),
    ('2345678901234561', 'Surinala', 'Perempuan', 'surinala@gmail.com', 24, '621234567890'),
    ('3456789012345612', 'Ben John', 'Laki-Laki', 'benjohn@gmail.com', 22, '6212345678');
INSERT INTO Transaksi (ID_transaksi, Tanggal_transaksi, Metode_pembayaran, Pegawai_NIK, Customer_ID_customer)
VALUES
    ('TRX0000001', '2023-10-01', 'Kartu kredit', '2345678901234561', 'CTR002'),
    ('TRX0000002', '2023-10-03', 'Transfer bank', '3456789012345612', 'CTRo04'),
    ('TRX0000003', '2023-10-05', 'Tunai', '3456789012345612', 'CTR001'),
    ('TRX0000004', '2023-10-15', 'Kartu debit', '1234567890123456', 'CTR003'),
    ('TRX0000005', '2023-10-15', 'E-wallet', '1234567890123456', 'CTRo04'),
    ('TRX0000006', '2023-10-21', 'Tunai', '2345678901234561', 'CTR001');
INSERT INTO Menu_minuman (ID_minuman, Nama_minuman, Harga_minuman)
VALUES
    ('MNM001', 'Expresso', 18000.00),
    ('MNM002', 'Cappuccino', 20000.00),
    ('MNM003', 'Latte', 21000.00),
    ('MNM004', 'Americano', 19000.00),
    ('MNM005', 'Mocha', 22000.00),
    ('MNM006', 'Macchiato', 23000.00),
    ('MNM007', 'Cold Brew', 21000.00),
    ('MNM008', 'Iced Coffee', 18000.00),
    ('MNM009', 'Affogato', 23000.00),
    ('MNM010', 'Coffee Frappe', 22000.00);
INSERT INTO Transaksi_minuman (TM_Transaksi_ID, TM_Menu_minuman_ID, Jumlah_cup)
VALUES
    ('TRX0000005', 'MNM006', 2),
    ('TRX0000001', 'MNM010', 1),
    ('TRX0000002', 'MNM005', 1),
    ('TRX0000005', 'MNM009', 1),
    ('TRX0000003', 'MNM001', 3),
    ('TRX0000006', 'MNM003', 2),
    ('TRX0000004', 'MNM004', 2),
    ('TRX0000004', 'MNM010', 1),
    ('TRX0000002', 'MNM003', 2),
    ('TRX0000001', 'MNM007', 1),
    ('TRX0000005', 'MNM001', 1),
    ('TRX0000003', 'MNM003', 1);

-- no.5
INSERT INTO Transaksi (ID_transaksi, Tanggal_transaksi, Metode_pembayaran, Pegawai_NIK, Customer_ID_customer)
VALUES
    ('TRX0000007', '2023-10-03', 'Transfer bank', '2345678901234561', 'CTRo04');
INSERT INTO Transaksi_minuman (TM_Transaksi_ID, TM_Menu_minuman_ID, Jumlah_cup)
VALUES
    ('TRX0000007', 'MNM005', 1);

-- no.6
INSERT INTO Pegawai (NIK, Nama_pegawai, Umur)
VALUES ('1111222233334444', 'Maimunah', 25);

-- no.7
INSERT INTO Customer (ID_customer, Nama_customer)
VALUES ('CTR004', 'Sutris Ten An');
UPDATE Transaksi
SET Customer_ID_customer = 'CTR004'
WHERE Customer_ID_customer = 'CTRo04';
DELETE FROM Customer
WHERE ID_customer = 'CTRo04';

-- no.8
UPDATE Pegawai
SET Jenis_kelamin = 'P',
    Email = 'maimunah@gmail.com',
    No_telp_pegawai = '621234567'
WHERE Nama_pegawai = 'Maimunah';

-- no.9
UPDATE Membership
SET total_poin = 0
WHERE tanggal_kedaluawarsa_kartu_membership < '2023-12-01';

-- no.10
DELETE FROM Membership;

-- no.11
DELETE FROM Pegawai WHERE Nama_pegawai = 'Maimunah';

-- drop database Modul_2_test;