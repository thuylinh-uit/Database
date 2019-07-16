create database QuanLiGiaoVu
use QuanLiGiaoVu

set dateformat dmy

create table HOCVIEN
(
	MAHV char(5) primary key,
	HO varchar(40),
	TEN varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3)
)

create table LOP
(
	MALOP char(3) primary key,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4)
)

create table KHOA
(
	MAKHOA varchar(4) primary key,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
)

create table MONHOC
(
	MAMH varchar(10) primary key,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4) 
)

create table DIEUKIEN
(
	MAMH varchar(10), 
	MAMH_TRUOC varchar(10),
	constraint PK_MAMH_MAMH_TRUOC primary key(MAMH, MAMH_TRUOC) 
)

create table GIAOVIEN
(
	MAGV char(4) primary key,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4)
)

create table GIANGDAY
(
	MALOP char(3),
	MAMH varchar(10),
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	constraint PK_MALOP_MAMH primary key(MALOP, MAMH)
)

create table KETQUATHI
(
	MAHV char(5),
	MAMH varchar(10),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	constraint PK_MAHV_MAMH_LANTHI primary key(MAHV, MAMH, LANTHI)
)
-----------------INSERT-------------------
----HOCVIEN:
insert into HOCVIEN values('K1101', 'Nguyen Van'     ,'A'     ,'27/1/1986' , 'Nam' ,'TpHCM'     ,'K11') 
insert into HOCVIEN values('K1102', 'Tran Ngoc'      ,'Han'   ,'14/3/1986' , 'Nu'  ,'Kien Giang','K11')
insert into HOCVIEN values('K1103', 'Ha Duy'         ,'Lap'   ,'18/4/1986' , 'Nam' ,'Nghe An'   ,'K11') 
insert into HOCVIEN values('K1104', 'Tran Ngoc'      ,'Linh'  ,'30/3/1986' , 'Nu'  ,'Tay Ninh'  ,'K11') 
insert into HOCVIEN values('K1105', 'Tran Minh'      ,'Long'  ,'27/2/1986' , 'Nam' ,'TpHCM'     ,'K11') 
insert into HOCVIEN values('K1106', 'Le Nhat'        ,'Minh'  ,'24/1/1986' , 'Nam' ,'TpHCM'     ,'K11') 
insert into HOCVIEN values('K1107', 'Nguyen Nhu'     ,'Nhut'  ,'27/1/1986' , 'Nam' ,'Ha Noi'    ,'K11') 
insert into HOCVIEN values('K1108', 'Nguyen Manh'    ,'Tam'   ,'27/2/1986' , 'Nam' ,'Kien Giang','K11') 
insert into HOCVIEN values('K1109', 'Phan Thi Thanh' ,'Tam'   ,'27/1/1986' , 'Nu'  ,'Vinh Long' ,'K11') 
insert into HOCVIEN values('K1110', 'Le Hoai'        ,'Thuong','5/2/1986 ' , 'Nu'  ,'Can Tho'   ,'K11') 
insert into HOCVIEN values('K1111', 'Le Ha'          ,'Vinh'  ,'25/12/1986', 'Nam' ,'Vinh Long' ,'K11') 
insert into HOCVIEN values('K1201', 'Nguyen Van'     ,'B'     ,'11/2/1986' , 'Nam' ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1202', 'Nguyen Thi Kim' ,'Duyen' ,'18/1/1986' , 'Nu'  ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1203', 'Tran Thi Kim'   ,'Duyen' ,'17/9/1986' , 'Nu'  ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1204', 'Truong My'      ,'Hanh'  ,'19/5/1986' , 'Nu'  ,'Dong Nai'  ,'K12') 
insert into HOCVIEN values('K1205', 'Nguyen Thanh'   ,'Nam'   ,'17/4/1986' , 'Nam' ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1206', 'Nguyen Thi Truc','Thanh' ,'4/3/1986'  , 'Nu'  ,'Kien Giang','K12') 
insert into HOCVIEN values('K1207', 'Tran Thi Bich'  ,'Thuy'  ,'8/2/1986'  , 'Nu'  ,'Nghe An'   ,'K12') 
insert into HOCVIEN values('K1208', 'Huynh Thi Kim'  ,'Trieu' ,'8/4/1986'  , 'Nu'  ,'Tay Ninh'  ,'K12') 
insert into HOCVIEN values('K1209', 'Pham Thanh'     ,'Trieu' ,'23/2/1986' , 'Nam' ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1210', 'Ngo Thanh'      ,'Tuan'  ,'14/2/1986' , 'Nam' ,'TpHCM'     ,'K12') 
insert into HOCVIEN values('K1211', 'Do Thi'         ,'Xuan'  ,'9/3/1986'  , 'Nu'  ,'Ha Noi'    ,'K12') 
insert into HOCVIEN values('K1212', 'Le Thi Phi'     ,'Yen'   ,'12/3/1986' , 'Nu'  ,'TpHCM'     ,'K12')
insert into HOCVIEN values('K1301', 'Nguyen Thi Kim' ,'Cuc'   ,'9/6/1986'  , 'Nu'  ,'Kien Giang','K13') 
insert into HOCVIEN values('K1302', 'Truong Thi My'  ,'Hien'  ,'18/3/1986' , 'Nu'  ,'Nghe An'   ,'K13') 
insert into HOCVIEN values('K1303', 'Le Duc'         ,'Hien'  ,'21/3/1986' , 'Nam' ,'Tay Ninh'  ,'K13') 
insert into HOCVIEN values('K1304', 'Le Quang'       ,'Hien'  ,'18/4/1986' , 'Nam' ,'TpHCM'     ,'K13') 
insert into HOCVIEN values('K1305', 'Le Thi'         ,'Huong' ,'27/3/1986' , 'Nu'  ,'TpHCM'     ,'K13') 
insert into HOCVIEN values('K1306', 'Nguyen Thai'    ,'Huu'   ,'30/3/1986' , 'Nam' ,'Ha Noi'    ,'K13') 
insert into HOCVIEN values('K1307', 'Tran Minh'      ,'Man'   ,'28/5/1986' , 'Nam' ,'TpHCM'     ,'K13') 
insert into HOCVIEN values('K1308', 'Nguyen Hieu'    ,'Nghia' ,'8/4/1986'  , 'Nam' ,'Kien Giang','K13') 
insert into HOCVIEN values('K1309', 'Nguyen Trung'   ,'Nghia' ,'18/1/1987' , 'Nam' ,'Nghe An'   ,'K13') 
insert into HOCVIEN values('K1310', 'Tran Thi Hong'  ,'Tham'  ,'22/4/1986' , 'Nu'  ,'Tay Ninh'  ,'K13') 
insert into HOCVIEN values('K1311', 'Tran Minh'      ,'Thuc'  ,'4/4/1986'  , 'Nam' ,'TpHCM'     ,'K13') 
insert into HOCVIEN values('K1312', 'Nguyen Thi Kim' ,'Yen'   ,'7/9/1986'  , 'Nu'  ,'TpHCM'     ,'K13')
-----LOP:
insert into LOP values('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07') 
insert into LOP values('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09') 
insert into LOP values('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14') 
----KHOA:
insert into KHOA values('KHMT', 'Khoa hoc may tinh'   ,'7/6/2005'  ,'GV01') 
insert into KHOA values('HTTT', 'He thong thong tin'  ,'7/6/2005'  ,'GV02')
insert into KHOA values('CNPM', 'Cong nghe phan mem'  ,'7/6/2005'  ,'GV04')
insert into KHOA values('MTT' , 'Mang va truyen thong','20/10/2005','GV03') 
insert into KHOA values('KTMT', 'Ky thuat may tinh'   ,'20/12/2005', Null) 
----MONHOC:
insert into MONHOC values('THDC'    ,'Tin hoc dai cuong'                    ,4, 1, 'KHMT') 
insert into MONHOC values('CTRR'    ,'Cau truc roi rac'                     ,5, 0, 'KHMT') 
insert into MONHOC values('CSDL'    ,'Co so du lieu'                        ,3, 1, 'HTTT') 
insert into MONHOC values('CTDLGT'  ,'Cau truc du lieu va giai thuat'       ,3, 1, 'KHMT') 
insert into MONHOC values('PTTKTT'  ,'Phan tich thiet ke thuat toan'        ,3, 0, 'KHMT') 
insert into MONHOC values('DHMT'    ,'Do hoa may tinh'                      ,3, 1, 'KHMT') 
insert into MONHOC values('KTMT'    ,'Kien truc may tinh'                   ,3, 0, 'KTMT') 
insert into MONHOC values('TKCSDL'  ,'Thiet ke co so du lieu'               ,3, 1, 'HTTT') 
insert into MONHOC values('PTTKHTTT','Phan tich thiet ke he thong thong tin',4, 1, 'HTTT') 
insert into MONHOC values('HDH'     ,'He dieu hanh'                         ,4, 0, 'KTMT') 
insert into MONHOC values('NMCNPM'  ,'Nhap mon cong nghe phan mem'          ,3, 0, 'CNPM') 
insert into MONHOC values('LTCFW'   ,'Lap trinh C for win'                  ,3, 1, 'CNPM') 
insert into MONHOC values('LTHDT'   ,'Lap trinh huong doi tuong'            ,3, 1, 'CNPM')
----DIEUKIEN:
insert into DIEUKIEN values ('CSDL'    ,'CTRR'  )
insert into DIEUKIEN values ('CSDL'    ,'CTDLGT') 
insert into DIEUKIEN values ('CTDLGT'  ,'THDC'  )
insert into DIEUKIEN values ('PTTKTT'  ,'THDC'  )
insert into DIEUKIEN values ('PTTKTT'  ,'CTDLGT') 
insert into DIEUKIEN values ('DHMT'    ,'THDC'  )
insert into DIEUKIEN values ('LTHDT'   ,'THDC'  )
insert into DIEUKIEN values ('PTTKHTTT','CSDL'  )
----GIAOVIEN:
insert into GIAOVIEN values ('GV01', 'Ho Thanh Son'    ,'PTS','GS' ,'Nam','2/5/1950'  ,'11/1/2004',5.00, 2250000,'KHMT') 
insert into GIAOVIEN values ('GV02', 'Tran Tam Thanh'  ,'TS' ,'PGS','Nam','17/12/1965','20/4/2004',4.50, 2025000,'HTTT') 
insert into GIAOVIEN values ('GV03', 'Do Nghiem Phung' ,'TS' ,'GS' ,'Nu' ,'1/8/1950'  ,'23/9/2004',4.00, 1800000,'CNPM') 
insert into GIAOVIEN values ('GV04', 'Tran Nam Son'    ,'TS' ,'PGS','Nam','22/2/1961' ,'12/1/2005',4.50, 2025000,'KTMT') 
insert into GIAOVIEN values ('GV05', 'Mai Thanh Danh'  ,'ThS','GV' ,'Nam','12/3/1958' ,'12/1/2005',3.00, 1350000,'HTTT') 
insert into GIAOVIEN values ('GV06', 'Tran Doan Hung'  ,'TS' ,'GV' ,'Nam','11/3/1953' ,'12/1/2005',4.50, 2025000,'KHMT') 
insert into GIAOVIEN values ('GV07', 'Nguyen Minh Tien','ThS','GV' ,'Nam','23/11/1971','1/3/2005' ,4.00, 1800000,'KHMT') 
insert into GIAOVIEN values ('GV08', 'Le Thi Tran'     ,'KS' ,Null ,'Nu' ,'26/3/1974' ,'1/3/2005' ,1.69, 760500 ,'KHMT') 
insert into GIAOVIEN values ('GV09', 'Nguyen To Lan'   ,'ThS','GV' ,'Nu' ,'31/12/1966','1/3/2005' ,4.00, 1800000,'HTTT') 
insert into GIAOVIEN values ('GV10', 'Le Tran Anh Loan','KS' ,Null ,'Nu' ,'17/7/1972' ,'1/3/2005' ,1.86, 837000 ,'CNPM') 
insert into GIAOVIEN values ('GV11', 'Ho Thanh Tung'   ,'CN' ,'GV' ,'Nam','12/1/1980' ,'15/5/2005',2.67, 1201500,'MTT' ) 
insert into GIAOVIEN values ('GV12', 'Tran Van Anh'    ,'CN' ,Null ,'Nu' ,'29/3/1981' ,'15/5/2005',1.69, 760500 ,'CNPM') 
insert into GIAOVIEN values ('GV13', 'Nguyen Linh Dan' ,'CN' ,Null ,'Nu' ,'23/5/1980' ,'15/5/2005',1.69, 760500 ,'KTMT')
insert into GIAOVIEN values ('GV14', 'Truong Minh Chau','ThS','GV' ,'Nu' ,'30/11/1976','15/5/2005',3.00, 1350000,'MTT' )
insert into GIAOVIEN values ('GV15', 'Le Ha Thanh'     ,'ThS','GV' ,'Nam','4/5/1978'  ,'15/5/2005',3.00, 1350000,'KHMT')
----GIANGDAY:
insert into GIANGDAY values ('K11', 'THDC'  ,'GV07', 1, 2006, '2/1/2006' ,'12/5/2006' ) 
insert into GIANGDAY values ('K12', 'THDC'  ,'GV06', 1, 2006, '2/1/2006' ,'12/5/2006' )
insert into GIANGDAY values ('K13', 'THDC'  ,'GV15', 1, 2006, '2/1/2006' ,'12/5/2006' )
insert into GIANGDAY values ('K11', 'CTRR'  ,'GV02', 1, 2006, '9/1/2006' ,'17/5/2006' )
insert into GIANGDAY values ('K12', 'CTRR'  ,'GV02', 1, 2006, '9/1/2006' ,'17/5/2006' )
insert into GIANGDAY values ('K13', 'CTRR'  ,'GV08', 1, 2006, '9/1/2006' ,'17/5/2006' )
insert into GIANGDAY values ('K11', 'CSDL'  ,'GV05', 2, 2006, '1/6/2006' ,'15/7/2006' )
insert into GIANGDAY values ('K12', 'CSDL'  ,'GV09', 2, 2006, '1/6/2006' ,'15/7/2006' )
insert into GIANGDAY values ('K13', 'CTDLGT','GV15', 2, 2006, '1/6/2006' ,'15/7/2006' )
insert into GIANGDAY values ('K13', 'CSDL'  ,'GV05', 3, 2006, '1/8/2006' ,'15/12/2006')
insert into GIANGDAY values ('K13', 'DHMT'  ,'GV07', 3, 2006, '1/8/2006' ,'15/12/2006') 
insert into GIANGDAY values ('K11', 'CTDLGT','GV15', 3, 2006, '1/8/2006' ,'15/12/2006') 
insert into GIANGDAY values ('K12', 'CTDLGT','GV15', 3, 2006, '1/8/2006' ,'15/12/2006') 
insert into GIANGDAY values ('K11', 'HDH'   ,'GV04', 1, 2007, '2/1/2007' ,'18/2/2007' )
insert into GIANGDAY values ('K12', 'HDH'   ,'GV04', 1, 2007, '2/1/2007' ,'20/3/2007' )
insert into GIANGDAY values ('K11', 'DHMT'  ,'GV07', 1, 2007, '18/2/2007','20/3/2007' )
----KETQUATHI:
insert into KETQUATHI values('K1101', 'CSDL'  ,1, '20/7/2006' ,10.00,'Dat'      )
insert into KETQUATHI values('K1101', 'CTDLGT',1, '28/12/2006',9.00 ,'Dat'      )
insert into KETQUATHI values('K1101', 'THDC'  ,1, '20/5/2006' ,9.00 ,'Dat'      )
insert into KETQUATHI values('K1101', 'CTRR'  ,1, '13/5/2006' ,9.50 ,'Dat'      )
insert into KETQUATHI values('K1102', 'CSDL'  ,1, '20/7/2006' ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1102', 'CSDL'  ,2, '27/7/2006' ,4.25 ,'Khong Dat') 
insert into KETQUATHI values('K1102', 'CSDL'  ,3, '10/8/2006' ,4.50 ,'Khong Dat') 
insert into KETQUATHI values('K1102', 'CTDLGT',1, '28/12/2006',4.50 ,'Khong Dat') 
insert into KETQUATHI values('K1102', 'CTDLGT',2, '5/1/2007'  ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1102', 'CTDLGT',3, '15/1/2007' ,6.00 ,'Dat'      )
insert into KETQUATHI values('K1102', 'THDC'  ,1, '20/5/2006' ,5.00 ,'Dat'      )
insert into KETQUATHI values('K1102', 'CTRR'  ,1, '13/5/2006' ,7.00 ,'Dat'      )
insert into KETQUATHI values('K1103', 'CSDL'  ,1, '20/7/2006' ,3.50 ,'Khong Dat') 
insert into KETQUATHI values('K1103', 'CSDL'  ,2, '27/7/2006' ,8.25 ,'Dat'      )
insert into KETQUATHI values('K1103', 'CTDLGT',1, '28/12/2006',7.00 ,'Dat'      )
insert into KETQUATHI values('K1103', 'THDC'  ,1, '20/5/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1103', 'CTRR'  ,1, '13/5/2006' ,6.50 ,'Dat'      )
insert into KETQUATHI values('K1104', 'CSDL'  ,1, '20/7/2006' ,3.75 ,'Khong Dat') 
insert into KETQUATHI values('K1104', 'CTDLGT',1, '28/12/2006',4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1104', 'THDC'  ,1, '20/5/2006' ,4.00 ,'Khong Dat')
insert into KETQUATHI values('K1104', 'CTRR'  ,1, '13/5/2006' ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1104', 'CTRR'  ,2, '20/5/2006' ,3.50 ,'Khong Dat') 
insert into KETQUATHI values('K1104', 'CTRR'  ,3, '30/6/2006' ,4.00 ,'Khong Dat')  
insert into KETQUATHI values('K1201', 'CSDL'  ,1, '20/7/2006' ,6.00 ,'Dat'      )
insert into KETQUATHI values('K1201', 'CTDLGT',1, '28/12/2006',5.00 ,'Dat'      )
insert into KETQUATHI values('K1201', 'THDC'  ,1, '20/5/2006' ,8.50 ,'Dat'      )
insert into KETQUATHI values('K1201', 'CTRR'  ,1, '13/5/2006' ,9.00 ,'Dat'      )
insert into KETQUATHI values('K1202', 'CSDL'  ,1, '20/7/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1202', 'CTDLGT',1, '28/12/2006',4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1202', 'CTDLGT',2, '5/1/2007'  ,5.00 ,'Dat'      )
insert into KETQUATHI values('K1202', 'THDC'  ,1, '20/5/2006' ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1202', 'THDC'  ,2, '27/5/2006' ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1202', 'CTRR'  ,1, '13/5/2006' ,3.00 ,'Khong Dat') 
insert into KETQUATHI values('K1202', 'CTRR'  ,2, '20/5/2006' ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1202', 'CTRR'  ,3, '30/6/2006' ,6.25 ,'Dat'      )
insert into KETQUATHI values('K1203', 'CSDL'  ,1, '20/7/2006' ,9.25 ,'Dat'      )
insert into KETQUATHI values('K1203', 'CTDLGT',1, '28/12/2006',9.50 ,'Dat'      )
insert into KETQUATHI values('K1203', 'THDC'  ,1, '20/5/2006' ,10.00,'Dat'      )
insert into KETQUATHI values('K1203', 'CTRR'  ,1, '13/5/2006' ,10.00,'Dat'      )
insert into KETQUATHI values('K1204', 'CSDL'  ,1, '20/7/2006' ,8.50 ,'Dat'      )
insert into KETQUATHI values('K1204', 'CTDLGT',1, '28/12/2006',6.75 ,'Dat'      )
insert into KETQUATHI values('K1204', 'THDC'  ,1, '20/5/2006' ,4.00 ,'Khong Dat')
insert into KETQUATHI values('K1204', 'CTRR'  ,1, '13/5/2006' ,6.00 ,'Dat'      )
insert into KETQUATHI values('K1301', 'CSDL'  ,1, '20/12/2006',4.25 ,'Khong Dat')
insert into KETQUATHI values('K1301', 'CTDLGT',1, '25/7/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1301', 'THDC'  ,1, '20/5/2006' ,7.75 ,'Dat'      )
insert into KETQUATHI values('K1301', 'CTRR'  ,1, '13/5/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1302', 'CSDL'  ,1, '20/12/2006',6.75 ,'Dat'      )
insert into KETQUATHI values('K1302', 'CTDLGT',1, '25/7/2006' ,5.00 ,'Dat'      )
insert into KETQUATHI values('K1302', 'THDC'  ,1, '20/5/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1302', 'CTRR'  ,1, '13/5/2006' ,8.50 ,'Dat'      )
insert into KETQUATHI values('K1303', 'CSDL'  ,1, '20/12/2006',4.00 ,'Khong Dat')
insert into KETQUATHI values('K1303', 'CTDLGT',1, '25/7/2006' ,4.50 ,'Khong Dat')
insert into KETQUATHI values('K1303', 'CTDLGT',2, '7/8/2006'  ,4.00 ,'Khong Dat') 
insert into KETQUATHI values('K1303', 'CTDLGT',3, '15/8/2006' ,4.25 ,'Khong Dat') 
insert into KETQUATHI values('K1303', 'THDC'  ,1, '20/5/2006' ,4.50 ,'Khong Dat') 
insert into KETQUATHI values('K1303', 'CTRR'  ,1, '13/5/2006' ,3.25 ,'Khong Dat') 
insert into KETQUATHI values('K1303', 'CTRR'  ,2, '20/5/2006' ,5.00 ,'Dat'      )
insert into KETQUATHI values('K1304', 'CSDL'  ,1, '20/12/2006',7.75 ,'Dat'      )
insert into KETQUATHI values('K1304', 'CTDLGT',1, '25/7/2006' ,9.75 ,'Dat'      ) 
insert into KETQUATHI values('K1304', 'THDC'  ,1, '20/5/2006' ,5.50 ,'Dat'      ) 
insert into KETQUATHI values('K1304', 'CTRR'  ,1, '13/5/2006' ,5.00 ,'Dat'      ) 
insert into KETQUATHI values('K1305', 'CSDL'  ,1, '20/12/2006',9.25 ,'Dat'      ) 
insert into KETQUATHI values('K1305', 'CTDLGT',1, '25/7/2006' ,10.00,'Dat'      ) 
insert into KETQUATHI values('K1305', 'THDC'  ,1, '20/5/2006' ,8.00 ,'Dat'      )
insert into KETQUATHI values('K1305', 'CTRR'  ,1, '13/5/2006' ,10.00,'Dat'      ) 
-----------------

--I/NGÔN NGỮ ĐỊNH NGHĨA DỮ LIỆU

----1.
----Tạo khóa ngoại:
alter table HOCVIEN add constraint FK_MALOP foreign key(MALOP) references LOP(MALOP)

alter table LOP add 
constraint FK_TRGLOP foreign key (TRGLOP) references HOCVIEN(MAHV),
constraint FK_MAGVCN foreign key (MAGVCN) references GIAOVIEN(MAGV)

alter table KHOA add constraint FK_TRGKHOA foreign key(TRGKHOA) references GIAOVIEN(MAGV)

alter table MONHOC add constraint FK_MH_MAKHOA foreign key(MAKHOA) references KHOA(MAKHOA) 

alter table DIEUKIEN add
constraint FK_MAMH foreign key(MAMH) references MONHOC(MAMH),
constraint FK_MAMH_TRUOC foreign key(MAMH_TRUOC) references MONHOC(MAMH)

alter table GIAOVIEN add constraint FK_GV_MAKHOA foreign key(MAKHOA) references KHOA(MAKHOA)

alter table GIANGDAY add
constraint FK_GD_MALOP foreign key(MALOP) references LOP(MALOP),
constraint FK_GD_MAMH foreign key(MAMH) references MONHOC(MAMH),
constraint FK_GD_MAGV foreign key(MAGV) references GIAOVIEN(MAGV)

alter table KETQUATHI add
constraint FK_KQT_MAHV foreign key(MAHV) references HOCVIEN(MAHV),
constraint FK_KQT_MAMH foreign key(MAMH) references MONHOC(MAMH)

----Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN:
alter table HOCVIEN add GHICHU varchar(20), DIEMTB numeric(4,2), XEPLOAI varchar(10)

----2*. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101”
--alter table HOCVIEN add constraint CK_MAHV check (left(MAHV, 3) = MALOP) and isnumeric(last(MAHV) is int)=1

----3*. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”
alter table HOCVIEN add constraint CK_HV_GIOITINH check((GIOITINH) in ('Nam','Nu'))
alter table GIAOVIEN add constraint CK_GV_GIOITINH check((GIOITINH) in ('Nam','Nu'))

----4*. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22)
alter table KETQUATHI add constraint CK_DIEM check ( DIEM >=0 and DIEM <=10)

----5*. Kết quả thi là “Dat” nếu điểm từ 5 đến 10  và “Khong dat” nếu điểm nhỏ hơn 5


----6. Học viên thi một môn tối đa 3 lần
alter table KETQUATHI add constraint CK_LANTHI check(LANTHI in(1,2,3))

----7. Học kỳ chỉ có giá trị từ 1 đến 3
alter table GIANGDAY add constraint CK_HOCKY check (HOCKY in(1,2,3))

----8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”
alter table GIAOVIEN add constraint CK_HOCVI check (HOCVI in('CN','KS','ThS','TS','PTS'))

----9*. Lớp trưởng của một lớp phải là học viên của lớp đó

create trigger C9_SUA_THEM_LOP
on LOP
for insert, update
as declare @MALOP_LOP char(3),
		   @MALOP_HV char(3),
		   @TRGLOP char(5)
   select @MALOP_LOP = MALOP,
		  @TRGLOP = TRGLOP
   from inserted
   select @MALOP_HV = MAHV from HOCVIEN, inserted
   where @TRGLOP = MAHV
   if(@MALOP_LOP <> @MALOP_HV )
   begin
		rollback tran
		raiserror('LOP TRUONG CUA MOT LOP PHAI THUOC LOP DO',16,1)
		return
   end
   else
   begin
		raiserror('THEM THANH CONG',16,1)
   end

create trigger C9_SUA_HOCVIEN
on HOCVIEN
for update
as
begin
	if(select count(*)
	   from inserted I, LOP L
	   where L.TRGLOP = I.MAHV) <> 0
	begin
		rollback tran
		raiserror('KHONG DUOC SUA HOC VIEN NAY',16,1)
	end
	else
		print'SUA THANH CONG'
end

----10*. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”
create trigger C10_SUA_THEM_KHOA
on KHOA
for insert, update
as declare @MAKHOA_KH char(3),
		   @MAKHOA_GV char(3),
		   @TRGKHOA char(5),
		   @HOCVI varchar(10)
   select @MAKHOA_KH = MAKHOA,
		  @TRGKHOA = TRGKHOA
   from inserted
   select @MAKHOA_GV = MAGV, 
		  @HOCVI = HOCVI 
   from GIAOVIEN, inserted
   where @TRGKHOA = MAGV
   if(@MAKHOA_KH = @MAKHOA_GV and @HOCVI in ('TS','PTS') )
   begin
		raiserror('THEM THANH CONG',16,1)
   end
   else
   begin
		rollback tran
		raiserror('TRUONG KHOA PHAI LA GIAO VIEN THUOC KHOA VA CO HOC VI "TS" HOAC "PTS"',16,1)
		return
   end

create trigger C10_SUA_GIAOVIEN
on GIAOVIEN
for update
as
begin
	if(select count(*)
	   from inserted I, KHOA K
	   where K.TRGKHOA = I.MAGV) <> 0
	begin
		rollback tran
		raiserror('KHONG DUOC SUA GIAO VIEN NAY',16,1)
	end
	else
		print'SUA THANH CONG'
end

----11. Học viên ít nhất là 18 tuổi
alter table HOCVIEN add check(year(GETDATE()) - year(NGSINH) >=18)

----12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY)
alter table GIANGDAY add check(TUNGAY < DENNGAY)

----13. Giáo viên khi vào làm ít nhất là 22 tuổi
alter table GIAOVIEN add check(year(NGVL)-year(NGSINH) >= 22)

----14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3
alter table MONHOC add check(TCLT - TCTH <=3)

----15*. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này

----16*. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn
create trigger C16_THEM_SUA_GIANGDAY
on GIANGDAY
for insert, update
as
begin
	if(select count(*)
	   from inserted I, GIANGDAY G
	   where I.MALOP = G.MALOP and
			 I.HOCKY = G.HOCKY and
			 I.NAM = G.NAM)>3
	begin
		rollback tran
		raiserror('MOI HOC KY CUA MOT NAM HOC, MOT LOP CHI DUOC HOC TOI DA 3 MON',16,1)
		return
	end
	else
		print'THANH CONG'
end

----17*. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó
create trigger C17_THEM_LOP
on LOP
for insert
as
begin
	declare @MALOP char(3)
	select @MALOP = MALOP from inserted
	update LOP
	set SISO = 0
	where MALOP = @MALOP
	print('THEM VAO 1 LOP THI SISI = 0')
end
--có thể gom 2 cái thành 1
create trigger C17_SUA_LOP --sửa SISO
on LOP
for update
as
begin
	declare @MALOP char(3)
	select @MALOP = MALOP from inserted
	declare @SISO tinyint
	select @SISO = count(MAHV)
	from HOCVIEN H
	where H.MALOP = @MALOP
	update LOP
	set SISO = @SISO
	where MALOP = @MALOP
	print('DA CAP NHAT SI SI CUA LOP')
end
--Thêm mới 1 HOCVIEN, SISO tăng lên
create trigger C17_THEM_HOCVIEN
on HOCVIEN
for insert
as
begin
	declare @MALOP char(3)
	select @MALOP = MALOP from inserted
	declare @SISO tinyint
	select @SISO = count(MAHV)
	from HOCVIEN H
	where H.MALOP = @MALOP
	update LOP
	set SISO = @SISO
	where MALOP = @MALOP
	print('DA CAP NHAT SI SI CUA LOP')
end
--Xóa 1 HOCVIEN, SISO giảm
create trigger C17_XOA_HOCVIEN
on HOCVIEN
for delete
as
begin
	declare @MALOP char(3)
	select @MALOP = MALOP from deleted
	declare @SISO tinyint
	select @SISO = count(MAHV)
	from HOCVIEN H
	where H.MALOP = @MALOP
	update LOP
	set SISO = @SISO
	where MALOP = @MALOP
	print('DA CAP NHAT SI SI CUA LOP')
end
--Sửa 1 HOCVIEN, SISO thay đổi
create trigger C17_SUA_HOCVIEN--sửa MALOP
on HOCVIEN
for update
as
begin
	declare @MALOP_CU char(3),
			@MALOP_MOI char(3),
			@SISO_LOP_CU tinyint,
			@SISO_LOP_MOI tinyint
	select @MALOP_CU = MALOP from deleted
	select @MALOP_MOI = MALOP from inserted
	select @SISO_LOP_CU = count(MAHV)
	from HOCVIEN
	where MALOP = @MALOP_CU
	select @SISO_LOP_MOI = count(MAHV)
	from HOCVIEN
	where MALOP = @MALOP_MOI
	print('DA CAP NHAT SISO CUA LOP')
end

----18*. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) 
--và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”)

----19*. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau
create trigger C19_THEM_SUA_GV
on GIAOVIEN
for insert, update
as
begin
	if (select count(*)
		from inserted I, GIAOVIEN G
		where I.HOCVI = G.HOCVI and
			  I.HOCHAM = G.HOCHAM and
			  I.HESO = G.HESO and
			  I.MUCLUONG = G.MUCLUONG) > 0
	print'THANHCONG'
	else
	begin
		rollback tran
		print'ERROR'
		return
	end
end

----20*. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5
create trigger C20_THEM_KETQUATHI
on KETQUATHI
for insert
as
begin
	declare @LANTHI tinyint,
			@MAHV char(5),
			@DIEM numeric(4,2)
	select @LANTHI = KETQUATHI.LANTHI + 1,
		   @MAHV = I.MAHV,
		   @DIEM = KETQUATHI.DIEM
	from inserted I join KETQUATHI on I.MAHV = KETQUATHI.MAHV
	where I.MAMH = KETQUATHI.MAMH
	if (@DIEM >5)
	begin
		raiserror('LAN THI TRUOC DA DAT, KHONG DUOC THI NUA',16,1)
		rollback tran
		return
	end
	else
		print'THEM THANH CONG'
end
--CHƯA CHECK
----21*. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học)
create trigger C21_THEM_SUA_KETQUATHI
on KETQUATHI
for insert, update
as
begin
	if(select count(*)
	   from inserted I, KETQUATHI K
	   where I.LANTHI > K.LANTHI and
			 I.MAHV = K.MAHV and
			 I.MAMH = K.MAMH and
			 I.NGTHI > K.NGTHI) >0
	print'THANH CONG'
	else
	begin
		rollback tran
		raiserror('LOI',16,1)
	end	 
end

----22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong - giống 15

----23*. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học 
--(sau khi học xong những môn học phải học trước mới được học những môn liền sau)

----24*. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách


--II/ NGÔN NGỮ THAO TÁC DỮ LIỆU

----1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
update GIAOVIEN
set HESO = HESO + 0.2
where MAGV in (select TRGKHOA
			   from KHOA
			   where MAGV = TRGKHOA)

----2. Cập nhật giá trị điểm trung bình tất cả các môn học  (DIEMTB) của mỗi học viên 
--(tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng)
update HOCVIEN
set DIEMTB = (select avg(DIEM)
			  from (select MAHV, MAMH, max(LANTHI) MAX_LANTHI
					from KETQUATHI
					group by MAHV, MAMH) K, KETQUATHI KQ
			  where K.MAHV = KQ.MAHV and
					MAX_LANTHI = KQ.LANTHI
			  group by K.MAHV
			  having K.MAHV = HOCVIEN.MAHV)

----3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm
update HOCVIEN
set GHICHU = 'Cam Thi'
where MAHV in (select MAHV
			   from KETQUATHI
			   where LANTHI = 3 and DIEM < 5)
 
----4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
--------Nếu         DIEMTB >= 9  thì XEPLOAI =”XS” 
--------Nếu  8   <= DIEMTB < 9   thì XEPLOAI = “G” 
--------Nếu  6.5 <= DIEMTB < 8   thì XEPLOAI = “K” 
--------Nếu  5   <= DIEMTB < 6.5 thì XEPLOAI = “TB” 
--------Nếu         DIEMTB < 5   thì XEPLOAI = ”Y”
update HOCVIEN
set XEPLOAI = 'XS'
where DIEMTB >=9

update HOCVIEN 
set XEPLOAI ='G'
where DIEMTB >=8 and DIEMTB <9

update HOCVIEN
set XEPLOAI = 'K'
where DIEMTB >= 6.5 and DIEMTB <8

update HOCVIEN
set XEPLOAI = 'TB'
where DIEMTB >= 5 and DIEMTB <6.5

update HOCVIEN
set XEPLOAI = 'Y'
where DIEMTB <5

--III/ NGÔN NGỮ TRUY VẤN DỮ LIỆU

----1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
select MAHV, HO,TEN, NGSINH, H.MALOP as LOPTRUONG_LOP
from HOCVIEN H, LOP
where H.MAHV = LOP.TRGLOP

----2. In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
select H.MAHV, HO, TEN, LANTHI, DIEM
from HOCVIEN H, KETQUATHI K
where K.MAMH = 'CTRR' and
	  H.MALOP = 'K12' and
	  H.MAHV = K.MAHV

----3. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
select H.MAHV, HO, TEN, MAMH
from HOCVIEN H, KETQUATHI K
where LANTHI = 1 and
	  KQUA = 'Dat' and
	  H.MAHV = K.MAHV

----4. In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1)
select H.MAHV, HO, TEN
from HOCVIEN H, KETQUATHI K
where MAMH ='CTRR' and
	  LANTHI = 1 and
	  KQUA ='Khong Dat' and
	  H.MAHV = K.MAHV

----5. * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi)
select H.MAHV, HO, TEN
from HOCVIEN H, KETQUATHI K
where MAMH = 'CTRR' and
	  H.MAHV = K.MAHV
except
select H.MAHV, HO, TEN
from HOCVIEN H, KETQUATHI K
where MAMH = 'CTRR' and
	  KQUA = 'Dat' and
	  H.MAHV = K.MAHV

----6. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006
select distinct TENMH
from MONHOC M, GIANGDAY D, GIAOVIEN V
where HOTEN ='Tran Tam Thanh' and
	  HOCKY = 1 and
	  NAM = 2006 and
	  D.MAGV = V.MAGV and D.MAMH = M.MAMH

----7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006
select M.MAMH, TENMH
from MONHOC M, LOP L, GIANGDAY G
where L.MAGVCN ='K11' and
	  HOCKY = 1 and 
	  NAM = 2006 and
	  G.MAGV = L.MAGVCN and G.MAMH = M.MAMH
--->SAI

select M.MAMH, TENMH
from MONHOC M, GIANGDAY G
where HOCKY = 1 and 
	  NAM = 2006 and
	  G.MAMH = M.MAMH and
	  MAGV = (select MAGVCN
			   from LOP
			   where MALOP ='K11')

----8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”
select HO, TEN
from HOCVIEN 
where MAHV in( select TRGLOP
			   from LOP
			   where MALOP in ( select MALOP
								from GIANGDAY
								where MAGV in (select MAGV
											   from GIAOVIEN
											   where HOTEN ='Nguyen To Lan')
								  and MAMH in (select MAMH
											   from MONHOC
											   where TENMH ='Co So Du Lieu')
							   )
			  )

----9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”
select MAMH, TENMH
from MONHOC
where MAMH in (select MAMH_TRUOC
			   from DIEUKIEN
			   where MAMH = 'CSDL')

----10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào
select MAMH, TENMH
from MONHOC
where MAMH in (select MAMH
			   from DIEUKIEN
			   where MAMH_TRUOC = 'CTRR')

----11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006
select HOTEN
from GIAOVIEN V, GIANGDAY D
where V.MAGV = D.MAGV and
	  D.MALOP = 'K11' and
	  D.MAMH = 'CTRR'
intersect
select HOTEN
from GIAOVIEN V, GIANGDAY D
where V.MAGV = D.MAGV and
	  D.MALOP = 'K12' and
	  D.MAMH = 'CTRR'

----12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này
select MAHV, HO, TEN
from HOCVIEN
where MAHV in (select MAHV
			   from KETQUATHI
			   where MAMH = 'CSDL' and
					 KQUA = 'Khong Dat'
			   except
			   select MAHV
			   from KETQUATHI
			   where MAMH = 'CSDL' and
					 LANTHI > 1)

----13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
select MAGV, HOTEN
from GIAOVIEN
where MAGV not in (select MAGV
				   from GIANGDAY)

----14*. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách
select MAGV, HOTEN
from GIAOVIEN
where MAGV not in (select MAGV
				   from GIANGDAY)
union
select MAGV, HOTEN
from GIAOVIEN
where MAGV in (select MAGV
			   from GIANGDAY G, MONHOC M
			   where G.MAMH = M.MAMH
			   except
			   select MAGV
			   from GIANGDAY G, MONHOC M
			   where G.MAMH = M.MAMH and
					 M.MAKHOA = GIAOVIEN.MAKHOA)

----15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm
select HO, TEN
from HOCVIEN
where MALOP = 'K11' and
	  MAHV in ( select MAHV
				from KETQUATHI
				where (LANTHI = 3 and KQUA = 'Khong Dat') or
					  (LANTHI = 2 and MAMH = 'CTRR' and DIEM = 5))

----16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học
select HOTEN
from GIAOVIEN
where MAGV in (select MAGV
			  from GIANGDAY
			  where MAMH = 'CTRR'
			  group by MAGV, HOCKY, NAM
			  having count(distinct MALOP) >=2)					

----17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng)
select MAHV, DIEM, LANTHI
from KETQUATHI K
where MAMH = 'CSDL' and
	  LANTHI = (select max(LANTHI)
				from KETQUATHI K1
				where K1.MAHV = K.MAHV)

----18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi)
select MAHV, max(DIEM) as DIEM
from KETQUATHI
where MAMH = 'CSDL'
group by MAHV

----19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất
select MAKHOA, TENKHOA
from KHOA
where NGTLAP <= all (select NGTLAP
					 from KHOA)

----20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”
select count(MAGV)
from GIAOVIEN
where HOCHAM in ('GS','PGS')

----21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa
select MAKHOA, HOCVI, count(MAGV) SL
from GIAOVIEN
group by MAKHOA, HOCVI

----22*. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt)
select A.MAMH, A.SL_DAT, B.SL_KHONGDAT
from (select K.MAMH, count(K.MAHV) as SL_DAT
	  from KETQUATHI K
	  where K.KQUA = 'Dat' and
			K.LANTHI = (select max(LANTHI)
						from KETQUATHI K1
						where K.MAHV = K1.MAHV)
	  group by MAMH) as A join (select K.MAMH, count(K.MAHV) as SL_KHONGDAT
								from KETQUATHI K
								where K.KQUA = 'khong Dat' and
									  K.LANTHI = (select max(LANTHI)
												  from KETQUATHI K1
												  where K.MAHV = K1.MAHV)
								group by MAMH) as B on A.MAMH=B.MAMH
-->SAI

----23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học
select distinct GIAOVIEN.MAGV, HOTEN
from (LOP join GIAOVIEN on LOP.MAGVCN = GIAOVIEN.MAGV) join GIANGDAY on GIANGDAY.MAGV = GIAOVIEN.MAGV
where LOP.MALOP = GIANGDAY.MALOP

----24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất
select HO, TEN
from HOCVIEN
where MAHV in (select TRGLOP
			   from LOP
			   where SISO = (select max(SISO)
							 from LOP))
							 
----25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi)
select HO, TEN
from (LOP join KETQUATHI K on TRGLOP = MAHV) join HOCVIEN H on TRGLOP = H. MAHV
group by TRGLOP, HO, TEN, MAMH
having count(distinct MAMH) >= 3 and
	   max(LANTHI) = (select count(KQUA)
					  from KETQUATHI K1
					  where KQUA = 'Khong Dat' and
							TRGLOP = K1.MAHV and
							K.MAMH = K1.MAMH
					  group by K1.MAHV, MAMH)
--SAI: count(distinct MAMH) >= 3 - group by TRGLOP, HO, TEN
-------max(LANTHI) = (select count(KQUA) - group by TRGLOP, HO, TEN, MAMH

----26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất
select K.MAHV, HO, TEN, count(DIEM) as SO_DIEM_9_10
from KETQUATHI K join HOCVIEN H on K.MAHV = H.MAHV
where DIEM in ('9','10')
group by K.MAHV, HO, TEN
having count(DIEM) >= all (select count(DIEM)
						   from KETQUATHI
						   where DIEM in ('9','10')
						   group by MAHV)

----27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất
select MALOP, HO, TEN, count(DIEM) as SO_DIEM_9_10
from KETQUATHI K1, HOCVIEN H1
where DIEM in ('9','10') and
	  K1.MAHV = H1.MAHV
group by MALOP, HO, TEN
having count(DIEM) >= all (select count(DIEM)
						   from KETQUATHI K2, HOCVIEN H2
						   where DIEM in ('9','10') and
								 K2.MAHV = H2.MAHV and
								 H1.MALOP = H2.MALOP
						   group by MALOP, HO, TEN)
						
----28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp
select MAGV, HOCKY, NAM, count (distinct MAMH) as SO_MH, count(MALOP) as SOLOP
from GIANGDAY
group by MAGV, HOCKY, NAM

----29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất
select NAM, HOCKY,D.MAGV, HOTEN, count(MALOP) SOLOP
from GIANGDAY D join GIAOVIEN V on D.MAGV = V.MAGV
group by NAM, HOCKY, D.MAGV, HOTEN
having count(MALOP) >= all (select count(MALOP)
							from GIANGDAY
							group by HOCKY, NAM, MAGV)

select top 1 with ties NAM, HOCKY, D.MAGV, HOTEN, count(MALOP) SOLOP
from GIANGDAY D join GIAOVIEN V on D.MAGV = V.MAGV
group by NAM, HOCKY, D.MAGV, HOTEN
order by count(MALOP) desc

----30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất
select K.MAMH, TENMH, count (MAHV) SL_Khong_Dat
from KETQUATHI K join MONHOC M on K.MAMH = M.MAMH
where LANTHI = 1 and
	  KQUA = 'Khong Dat'
group by K.MAMH, TENMH
having count(MAHV) >= all (select count(MAHV)
						   from KETQUATHI
						   where LANTHI = 1 and
								 KQUA = 'Khong Dat'
						   group by MAMH)

----31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1)
select K.MAHV, HO, TEN, count(MAMH) S0_MON_DAT
from KETQUATHI K join HOCVIEN H on K.MAHV = H.MAHV
where LANTHI = 1 and
	  KQUA = 'Dat'
group by K.MAHV, HO, TEN
having count(MAMH) = (select count(distinct MAMH)
					  from KETQUATHI K2
					  where K.MAHV = K2.MAHV
					  group by MAHV)

----32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng)
select distinct KQT.MAHV, HO, TEN, count(MAMH) as SO_MON_DAT
from (select MAHV, MAMH, KQUA, max(LANTHI) as LANTHIMAX
	  from KETQUATHI
	  group by MAHV, MAMH, KQUA) as KQT join HOCVIEN H on KQT.MAHV = H.MAHV
where KQUA = 'Dat'
group by KQT.MAHV, HO, TEN
having count(MAMH) = (select count(distinct MAMH)
					  from KETQUATHI K2
					  where KQT.MAHV = K2.MAHV
					  group by MAHV)	  			  

----33. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1)
--NHƯ CÂU 31

----34. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng)
--NHƯ CÂU 32

----35. ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng)
select distinct MAMH, KQT.MAHV, HO, TEN, DIEM
from (select MAHV, MAMH, max(LANTHI) as LANTHIMAX, DIEM
	  from KETQUATHI
	  group by MAHV, MAMH, DIEM) as KQT join HOCVIEN H on KQT.MAHV = H.MAHV
group by MAMH, KQT.MAHV, HO, TEN, DIEM
having DIEM = (select max(DIEM)
			   from KETQUATHI K2
			   where KQT.MAMH = K2.MAMH
			   group by MAMH)
