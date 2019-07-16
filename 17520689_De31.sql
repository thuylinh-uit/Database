
--NGUYỄN THÙY LINH
--17520689
--ĐỀ: 31

--1. Viết các câu lệnh SQL tạo các quan hệ với các kiểu dữ liệu mô tả trong bảng:

create database QLGV
use QLGV

create table SINHVIEN
(
	MASV char(4) primary key,
	HOTEN varchar(50),
	MALOP char(8),
	DIEMTB float
)

create table LOP
(
	MALOP char(8) primary key,
	TENLOP varchar(20),
	KHOAHOC int,
	MAKHOA char(4)
)

create table KHOA
(
	MAKHOA char(4) primary key,
	TENKHOA varchar(40)
)

create table MONHOC
(
	MAMON char(6) primary key,
	TENMON varchar(30),
	MAKHOA char(4),
	SOTC int
)

create table DIEMTHI
(
	MAMON char(6),
	MASV char(4),
	DIEM float,
	constraint PK_MAMON_MASV primary key(MAMON, MASV)
)
--SINHVIEN:
insert into SINHVIEN values ('SV01','Nguyen Van A','HTTT2017',8)
insert into SINHVIEN values ('SV02','Tran Thi B'  ,'MMTT2018',6)
insert into SINHVIEN values ('SV03','Pham Van C'  ,'HTTT2018',7)

--LOP:
insert into LOP values ('HTTT2017','HTTT2017',2017,'HTTT')
insert into LOP values ('HTTT2018','HTTT2018',2018,'HTTT')
insert into LOP values ('MMTT2018','MMTT2018',2018,'MMTT')

--KHOA:
insert into KHOA values ('HTTT','He thong Thong tin')
insert into KHOA values ('MMTT','Mang may tinh va truyen thong')

--MONHOC:
insert into MONHOC values ('IT0001','Co so Du lieu'     ,'HTTT',4)
insert into MONHOC values ('IT0002','Cau truc Du lieu'  ,'HTTT',5)
insert into MONHOC values ('IT0003','Mang can ban'      ,'MMTT',4)
insert into MONHOC values ('IT0004','Kien truc May tinh','MMTT',3)

--DIEMTHI:
insert into DIEMTHI values ('IT0001','SV01',8)
insert into DIEMTHI values ('I10002','SV01',7)
insert into DIEMTHI values ('I10003','SV01',9)
insert into DIEMTHI values ('IT0001','SV02',8)
insert into DIEMTHI values ('IT0003','SV02',4)
insert into DIEMTHI values ('IT0001','SV03',9)
insert into DIEMTHI values ('IT0002','SV03',8)
insert into DIEMTHI values ('IT0004','SV03',4)

--Khóa ngoại:
alter table SINHVIEN add constraint FK_MALOP_LOP foreign key(MALOP) references LOP(MALOP)

alter table LOP add constraint FK_MAKHOA_LOP foreign key(MAKHOA) references KHOA(MAKHOA)

alter table MONHOC add constraint FK_MAKHOA_MH foreign key(MAKHOA) references KHOA(MAKHOA)

alter table DIEMTHI add
constraint FK_MAMON_DT foreign key (MAMON) references MONHOC(MAMON),
constraint FK_MASV_DT foreign key (MASV) references SINHVIEN(MASV)

--2. Tạo các ràng buộc và lệnh test vi phạm ràng buộc cho các yêu cầu sau:

--2.1. Số tín chỉ của một môn học có giá trị từ 3 đến 5:
alter table MONHOC add constraint CK_TC check (SOTC in(3,4,5))

--2.2. Điểm trung bình của một sinh viên là điểm trung bình của tất cả các môn mà sinh viên đó đã học.
----- Tạo ràng buộc cho thao tác thêm điểm thi một môn học của một sinh viên

create trigger DIEMTRUNGBINH
on DIEMTHI
for insert
as 
 begin
	declare @MASV char(4)
	select @MASV = MASV from inserted
	declare @DIEMTB float
	select @DIEMTB = AVG(DIEM)
	from DIEMTHI
	where MASV = @MASV
	update SINHVIEN
	set DIEMTB = @DIEMTB
	where MASV = @MASV
	print('DA CAP NHAT DIEM TRUNG BINH')
 end
 
 insert into DIEMTHI values('IT0004','SV01',10)

 --3. Thực hiện các câu truy vấn sau:

 --3.1. Liệt kê danh sách sinh viên(MASV, HOTEN, TENKHOA) khóa 2018 và đang học khoa "He thong Thong tin".
 select MASV, HOTEN, TENKHOA
 from SINHVIEN S, LOP L, KHOA K
 where S.MALOP = L.MALOP and
	   L.MAKHOA = K.MAKHOA and
	   KHOAHOC = 2018 and TENKHOA = 'He thong Thong tin'

--3.2. Liệt kê danh sách sinh viên (MASV, HOTEN, TENKHOA) có điểm thi môn "Co so Du lieu" và môn "Cau truc Du lieu" trên 8 điểm.
 (select distinct S.MASV, HOTEN, TENKHOA
 from SINHVIEN S, LOP L, KHOA K, MONHOC M, DIEMTHI D
 where S.MALOP = L.MALOP and
	   L.MAKHOA = K.MAKHOA and
	   S.MASV = D.MASV and
	   D.MAMON = M.MAMON and
	   TENMON = 'Co so Du lieu' and DIEM >=8)
intersect 
 (select distinct S.MASV, HOTEN, TENKHOA
 from SINHVIEN S, LOP L, KHOA K, MONHOC M, DIEMTHI D
 where S.MALOP = L.MALOP and
	   L.MAKHOA = K.MAKHOA and
	   S.MASV = D.MASV and
	   D.MAMON = M.MAMON and
	   TENMON = 'Cau truc Du lieu' and DIEM >=8)

--3.3. Liệt kê danh sách sinh viên (MASV, HOTEN, TENKHOA) của khoa "He thong Thong tin" đã học tất cả các môn của khoa "He thong Thong tin".
select MASV, HOTEN, TENKHOA
from (SINHVIEN S join LOP L on S.MALOP = L.MALOP) join KHOA K on L.MAKHOA = K.MAKHOA
where K.MAKHOA = 'HTTT' and
	  MASV in (select MASV
			   from DIEMTHI D1, MONHOC M1
			   where D1.MAMON = M1.MAMON and
					 M1.MAKHOA = 'HTTT'
			   group by MASV
			   having count(D1.MAMON) = (select count(MAMON)
									  from MONHOC
									  where MAKHOA = 'HTTT'))	

select MASV, HOTEN, TENKHOA
from (SINHVIEN S join LOP L on S.MALOP = L.MALOP) join KHOA K on L.MAKHOA = K.MAKHOA
where TENKHOA = 'He thong Thong tin' and
	  MASV in (select MASV
			   from DIEMTHI D1
			   where not exists (select MAMON
								 from MONHOC M
								 where M.MAKHOA = 'HTTT' and
									   not exists ( select MAMON, MASV
													from DIEMTHI D
													where D.MAMON = M.MAMON and
														  D.MASV = D1.MASV)))
								 	    
--3.4. Thống kê số lượng sinh viên có điểm lớn hơn 5.0 theo từng môn (MAMON, TENMON, MAKHOA,SL), sắp xếp theo số lượng sinh viên giảm dần.
select D.MAMON, TENMON, MAKHOA, count(MASV) as SL
from MONHOC M, DIEMTHI D
where M.MAMON = D.MAMON and
	  DIEM > 5
group by D.MAMON, TENMON, MAKHOA
order by SL desc

--3.5. Trong các sinh viên có điểm trung bình lớn hơn 7, liệt kê danh sách các sinh viên(MASV, HOTEN, TENKHOA) không có môn nào đã học dưới 5.
select S.MASV, HOTEN, TENKHOA
from SINHVIEN S, LOP L, KHOA K
where DIEMTB > 7 and
	  S.MALOP = L.MALOP and
	  L.MAKHOA = K.MAKHOA and
	  MASV not in (select MASV
			   from DIEMTHI
			   where DIEM <5)
