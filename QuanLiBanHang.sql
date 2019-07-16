create database QuanLiBanHang
use QuanLiBanHang

set dateformat dmy

create table KHACHHANG
(
	MAKH char(4) primary key,
	HOTEN varchar (40),
	DCHI varchar (50),
	SODT varchar (20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime
)
--------------------------------
CREATE TABLE NHANVIEN
(
	MANV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	DTHOAI varchar(20),
	NGVL smalldatetime
)
--------------------------------
CREATE TABLE SANPHAM 
(
	MASP char(4) PRIMARY KEY,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money
)
--------------------------------
CREATE TABLE HOADON
(
	SOHD int PRIMARY KEY,
	NGHD smalldatetime,
	MAKH char(4),
	MANV char(4),
	TRIGIA money
)
--------------------------------
 CREATE TABLE CTHD
(
	SOHD int ,
	MASP char(4) ,
	SL int,
	constraint PK_MASP primary key (MASP,SOHD) 
)
--------------------------------
--I. Ngôn ngữ định nghĩa dữ liệu

----1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ
alter table HOADON add 
constraint FK_MAKH foreign key  (MAKH) references KHACHHANG(MAKH),
constraint FK_MANV foreign key  (MANV) references NHANVIEN(MANV) 

alter table CTHD add 
constraint FK_MASP foreign key (MASP) references SANPHAM(MASP),
constraint FK_SOHD foreign key (SOHD) references HOADON(SOHD)

----2. Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM
alter table SANPHAM add GHICHU varchar (20)

----3. Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG
alter table KHACHHANG add LOAIKH tinyint

----4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100)
alter table SANPHAM alter column GHICHU varchar (100)

----5. Xóa thuộc tính GHICHU trong quan hệ SANPHAM
alter table SANPHAM drop column GHICHU

----6. 	Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: 
--------“Vang lai”, “Thuong xuyen”, “Vip”, …
alter table KHACHHANG alter column LOAIKH varchar (15)
alter table KHACHHANG add constraint CK_LOAIKH check (LOAIKH in ('Vang lai','Thuong xuyen','Vip'))

----7. Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
alter table SANPHAM add constraint CK_DVT check (DVT in('cay','hop','cai','quyen','chuc'))

----8. Giá bán của sản phẩm từ 500 đồng trở lên
alter table SANPHAM add constraint CK_GIA check (GIA >= 500)

----9. Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm
alter table CTHD add constraint CK_SL check (SL >=1 and SL <= 200)

----10.	Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó
alter table KHACHHANG add constraint CK_NGDK check (NGDK>NGSINH)

----11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
---Thuộc loại kiểm tra điều kiện và báo lỗi
---Gom lại Thêm và Sửa hóa đơn khi nó cùng 1 thao tác, trên cùng 1 quan hệ

create trigger NGHD_NGDK_THEM_SUA_HD
on HOADON
for insert, update
as declare @NGHD smalldatetime
   declare @NGDK smalldatetime
   select @NGHD = NGHD from inserted
   select @NGDK = NGDK from KHACHHANG, inserted
   where KHACHHANG.MAKH = inserted.MAKH 
if (@NGDK > @NGHD)
   begin 
	rollback tran
	raiserror ('NGAY HOA DON PHAI LON HON HOAC BANG NGAY DANG KY',16,1)---In màu đỏ----
	----print 'NGAY HOA DON PHAI LON HON HOAC BANG NGAY DANG KY'---In màu đen
	return
   end
----test_trigger---
insert into HOADON values (1099 , '23/07/2005' , 'KH01' , 'NV01' , 320000)
------------------------------

create trigger NGHD_NGDK_SUA_KHACHHANG
on KHACHHANG
for update
as declare @NGHD smalldatetime
   declare @NGDK smalldatetime
   select @NGDK = NGDK from inserted
   select @NGHD = NGHD from HOADON, inserted
   where HOADON.MAKH=inserted.MAKH
---declare @MAKH = char(4)
---select @MAKH = MAKH from inserted
---select @NGHD = NGHD from HOADON where MAKH = @MAKH
if (@NGDK > @NGHD)
   begin
	rollback tran
	raiserror ('NGAY HOA DON PHAI LON HON HOAC BANG NGAY DANG KY',16,1)
	return
   end
----Level 16, State 1: Lỗi liên quan người dùng định nghĩa

----12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.

create trigger NGHD_NGVL_SUA_NHANVIEN
on NHANVIEN
for update
as declare @NGVL smalldatetime
   declare @NGHD smalldatetime
   select @NGVL = NGVL from inserted
   select @NGHD = NGHD from HOADON, inserted
   where HOADON.MANV = inserted.MANV
if (@NGHD < @NGVL)
   begin
	rollback tran
	raiserror ('NGAY BAN HANG PHAI LON HON NGAY VAO LAM',16,1)
	return
   end
---------------------
create trigger NGHD_NGVL_THEM_SUA_HOADON
on HOADON
for insert, update
as
   declare @NGHD smalldatetime
   declare @NGVL smalldatetime
   select @NGHD = NGHD from inserted
   select @NGVL = NGVL from NHANVIEN, inserted
   where NHANVIEN.MANV = inserted.MANV
if (@NGHD < @NGVL)
   begin
	rollback tran
	raiserror ('NGAY BAN HANG PHAI LON HON NGAY VAO LAM',16,1)
	return
   end

----13. Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.
 
----14. Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
create trigger TRIGIA_INSERT_HD
on HOADON
for insert
as	declare @SOHD int
	select @SOHD = SOHD from inserted
	update HOADON
	set TRIGIA = 0
	where SOHD = @SOHD
	print('DA CAP NHAT TRI GIA') 
----Có thể gom 2 cái thành 1
create trigger TRIGIA_UPDATE_HD
on HOADON
for update
as	declare @SOHD int
	select @SOHD = SOHD from inserted
	declare @TRIGIA money
	select @TRIGIA = sum(SL*GIA)
	from CTHD, SANPHAM SP
	where CTHD.MASP = SP.MASP and SOHD = @SOHD
	update HOADON
	set TRIGIA = @TRIGIA
	where SOHD = @SOHD
	print('DA CAP NHAT TRI GIA') 
----Thêm mới 1 CTHD, TRIGIA tăng lên
create trigger TRIGIA_INSERT_CTHD
on CTHD
for insert
as	declare @SOHD int
	select @SOHD = SOHD from inserted
	declare @TRIGIA money
	select @TRIGIA = sum(SL*GIA)
	from CTHD, SANPHAM SP
	where CTHD.MASP = SP.MASP and SOHD = @SOHD
	update HOADON
	set TRIGIA = @TRIGIA
	where SOHD = @SOHD
	print('DA CAP NHAT TRI GIA')
----
create trigger TRIGIA_DELETE_CTHD
on CTHD
for delete
as	declare @SOHD int
	select @SOHD = SOHD from deleted
	declare @TRIGIA money
	select @TRIGIA = sum(SL*GIA)
	from CTHD, SANPHAM SP
	where CTHD.MASP = SP.MASP and SOHD = @SOHD
	update HOADON
	set TRIGIA = @TRIGIA
	where SOHD = @SOHD
	print('DA CAP NHAT TRI GIA')
----
create trigger TRIGIA_UPDATE_CTHD
on CTHD
for update
---Sửa SL, MASP, gom vào chung với SOHD
as	declare @SOHD_CU int,
			@SOHD_MOI int,
			@TRIGIA_HD_CU money,
			@TRIGIA_HD_MOI money-----------------Khai báo
	select @SOHD_CU = SOHD from deleted
	select @SOHD_MOI = SOHD from inserted
	select @TRIGIA_HD_CU = sum (SL*GIA)----------Tính
	from CTHD, SANPHAM SP
	where CTHD.MASP = SP.MASP and SOHD = @SOHD_CU
	select @TRIGIA_HD_MOI = sum (SL*GIA)---------
	from CTHD, SANPHAM SP
	where CTHD.MASP = SP.MASP and SOHD = @SOHD_MOI
	print('DA CAP NHAT TRI GIA')
----
create trigger TRIGIA_UPDATE_SANPHAM
on SANPHAM
for update
as
	declare @MASP char(4)------------------
	select @MASP = MASP from inserted
	select SOHD into Temp------------------
	from CTHD
	where MASP = @MASP
	declare @SOHD int
	while
		(exists (select * from Temp))
		 begin
			select top 1 @SOHD = SOHD from Temp
			declare @TRIGIA money
			select @TRIGIA = sum (SL+GIA) from SANPHAM SP, CTHD
			where CTHD.MASP = SP.MASP and SOHD = @SOHD
			update HOADON
			set TRIGIA = @TRIGIA
			where SOHD = @SOHD
			delete from Temp where SOHD = @SOHD
		 end
	print('DA CAP NHAT TRI GIA')
	drop table Temp
--Test
update SANPHAM
set GIA = 5500
where MASP = 'TV02'

----15. Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua. 
 
-------------------------------
--II. Ngôn ngữ thao tác dữ liệu

----1. Nhập dữ liệu cho các quan hệ trên
--KHACHHANG:
insert into KHACHHANG values ( 'KH01' , 'Nguyen Van A' , '731 Tran Hung Dao, Q5, TpHCM' , '08823451' , '22/10/1960' , 13060000 , '22/07/2006' , NULL )
insert into KHACHHANG values ( 'KH02' , 'Tran Ngoc Han' , '23/5 Nguyen Trai, Q5, TpHCM' , '0908256478', '3/4/1974 ',  280000 , '30/07/2006' , NULL ) 
insert into KHACHHANG values ( 'KH03' , 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM','0938776266', '12/6/1980', 3860000 , '05/08/2006' , NULL ) 
insert into KHACHHANG values ( 'KH04' , 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '9/3/1965' , 250000 ,  '02/10/2006' , NULL ) 
insert into KHACHHANG values ( 'KH05' , 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM' , '08246108' ,  '10/3/1950' , 21000 ,  '28/10/2006' , NULL ) 
insert into KHACHHANG values ( 'KH06' , 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31/12/1981', 915000, '24/11/2006' , NULL) 
insert into KHACHHANG values ( 'KH07' , 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '6/4/1971', 12500, '01/12/2006' , NULL) 
insert into KHACHHANG values ( 'KH08' , 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM' , '0938435756', '10/1/1971', 365000, '13/12/2006' , NULL) 
insert into KHACHHANG values ( 'KH09' , 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM' , '08654763', '3/9/1979', 70000, '14/01/2007' , NULL) 
insert into KHACHHANG values ( 'KH10' , 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '2/5/1983', 67500, '16/01/2007' , NULL) 
--NHANVIEN
insert into NHANVIEN values ('NV01' , 'Nguyen Nhu Nhut' , '0927345678' , '13/4/2006')
insert into NHANVIEN values ('NV02' , 'Le Thi Phi Yen' , '0987567390' , '21/4/2006')
insert into NHANVIEN values ('NV03' , 'Nguyen Van B' , '0997047382' , '27/4/2006')
insert into NHANVIEN values ('NV04' , 'Ngo Thanh Tuan' , '0913758498' , '24/6/2006')
insert into NHANVIEN values ('NV05' , 'Nguyen Thi Truc Thanh' , '0918590387' , '20/7/2006')
--SANPHAM
insert into SANPHAM values ('BC01' , 'But chi' , 'cay' , 'Singapore' , 3000)
insert into SANPHAM values ('BC02' , 'But chi' , 'cay' , 'Singapore' , 5000)
insert into SANPHAM values ('BC03' , 'But chi' , 'cay' , 'Viet Nam' , 3500)
insert into SANPHAM values ('BC04' , 'But chi' , 'hop' , 'Viet Nam' , 30000) 
insert into SANPHAM values ('BB01' , 'But bi' ,  'cay' , 'Viet Nam' , 5000 ) 
insert into SANPHAM values ('BB02' , 'But bi' , 'cay' , 'Trung Quoc', 7000) 
insert into SANPHAM values ('BB03' , 'But bi' , 'hop' , 'Thai Lan' , 100000) 
insert into SANPHAM values ('TV01' , 'Tap 100 giay mong'    , 'quyen', 'Trung Quoc', 2500) 
insert into SANPHAM values ('TV02' , 'Tap 200 giay mong'    , 'quyen', 'Trung Quoc', 4500) 
insert into SANPHAM values ('TV03' , 'Tap 100 giay tot'    , 'quyen' , 'Viet Nam'  , 3000) 
insert into SANPHAM values ('TV04' , 'Tap 200 giay tot'    , 'quyen' , 'Viet Nam'  , 5500) 
insert into SANPHAM values ('TV05' , 'Tap 100 trang'    , 'chuc'     , 'Viet Nam'  , 23000) 
insert into SANPHAM values ('TV06' , 'Tap 200 trang'    , 'chuc'     , 'Viet Nam'  , 53000) 
insert into SANPHAM values ('TV07' , 'Tap 100 trang'    , 'chuc'     , 'Trung Quoc', 34000) 
insert into SANPHAM values ('ST01' , 'So tay 500 trang'     , 'quyen', 'Trung Quoc', 40000) 
insert into SANPHAM values ('ST02' , 'So tay loai 1'     , 'quyen'   , 'Viet Nam'  , 55000) 
insert into SANPHAM values ('ST03' , 'So tay loai 2'     , 'quyen'   , 'Viet Nam'  , 51000) 
insert into SANPHAM values ('ST04' , 'So tay'     , 'quyen'          , 'Thai Lan'  , 55000) 
insert into SANPHAM values ('ST05' , 'So tay mong'     , 'quyen'     , 'Thai Lan'  , 20000)
insert into SANPHAM values ('ST06' , 'Phan viet bang'   , 'hop'      , 'Viet Nam'  , 5000) 
insert into SANPHAM values ('ST07' , 'Phan khong bui'   , 'hop'      , 'Viet Nam'  , 7000) 
insert into SANPHAM values ('ST08' , 'Bong bang'   , 'cai'           , 'Viet Nam'  , 1000) 
insert into SANPHAM values ('ST09' , 'But long'    , 'cay'           , 'Viet Nam'  , 5000) 
insert into SANPHAM values ('ST10' , 'But long'    , 'cay'           , 'Trung Quoc', 7000)
--HOADON
insert into HOADON values (1001 , '23/07/2006' , 'KH01' , 'NV01' , 320000)
insert into HOADON values (1002 , '12/08/2006' , 'KH01' , 'NV02' , 840000)
insert into HOADON values (1003 , '23/08/2006' , 'KH02' , 'NV01' , 100000)
insert into HOADON values (1004 , '01/09/2006' , 'KH02' , 'NV01' , 180000) 
insert into HOADON values (1005 , '20/10/2006' , 'KH01' , 'NV02' , 3800000) 
insert into HOADON values (1006 , '16/10/2006' , 'KH01' , 'NV03' , 2430000) 
insert into HOADON values (1007 , '28/10/2006' , 'KH03' , 'NV03' , 510000) 
insert into HOADON values (1008 , '28/10/2006' , 'KH01' , 'NV03' , 440000) 
insert into HOADON values (1009 , '28/10/2006' , 'KH03' , 'NV04' , 200000) 
insert into HOADON values (1010 , '01/11/2006' , 'KH01' , 'NV01' , 5200000) 
insert into HOADON values (1011 , '04/11/2006' , 'KH04' , 'NV03' , 250000) 
insert into HOADON values (1012 , '30/11/2006' , 'KH05' , 'NV03' , 21000) 
insert into HOADON values (1013 , '12/12/2006' , 'KH06' , 'NV01' , 5000) 
insert into HOADON values (1014 , '31/12/2006' , 'KH03' , 'NV02' , 3150000) 
insert into HOADON values (1015 , '01/01/2007' , 'KH06' , 'NV01' , 910000) 
insert into HOADON values (1016 , '01/01/2007' , 'KH07' , 'NV02' , 12500) 
insert into HOADON values (1017 , '02/01/2007' , 'KH08' , 'NV03' , 35000) 
insert into HOADON values (1018 , '13/01/2007' , 'KH08' , 'NV03' , 330000) 
insert into HOADON values (1019 , '13/01/2007' , 'KH01' , 'NV03' , 30000) 
insert into HOADON values (1020 , '14/01/2007' , 'KH09' , 'NV04' , 70000) 
insert into HOADON values (1021 , '16/01/2007' , 'KH10' , 'NV03' , 67500) 
insert into HOADON values (1022 , '16/01/2007' , Null , 'NV03' , 7000) 
insert into HOADON values (1023 , '17/01/2007' , Null , 'NV01' , 330000)
--CTHD
insert into CTHD values (1001 , 'TV02' , 10)
insert into CTHD values (1001 , 'ST01' , 5)
insert into CTHD values (1001 , 'BC01' , 5)
insert into CTHD values (1001 , 'BC02' , 10) 
insert into CTHD values (1001 , 'ST08' , 10) 
insert into CTHD values (1002 , 'BC04' , 20) 
insert into CTHD values (1002 , 'BB01' , 20) 
insert into CTHD values (1002 , 'BB02' , 20) 
insert into CTHD values (1003 , 'BB03' , 10) 
insert into CTHD values (1004 , 'TV01' , 20) 
insert into CTHD values (1004 , 'TV02' , 10) 
insert into CTHD values (1004 , 'TV03' , 10)
insert into CTHD values (1004 , 'TV04' , 10) 
insert into CTHD values (1005 , 'TV05' , 50) 
insert into CTHD values (1005 , 'TV06' , 50) 
insert into CTHD values (1006 , 'TV07' , 20)
insert into CTHD values (1006 , 'ST01' , 30) 
insert into CTHD values (1006 , 'ST02' , 10) 
insert into CTHD values (1007 , 'ST03' , 10) 
insert into CTHD values (1008 , 'ST04' , 8) 
insert into CTHD values (1009 , 'ST05' , 10) 
insert into CTHD values (1010 , 'TV07' , 50) 
insert into CTHD values (1010 , 'ST07' , 50)
insert into CTHD values (1010 , 'ST08' , 100) 
insert into CTHD values (1010 , 'ST04' , 50) 
insert into CTHD values (1010 , 'TV03' , 100) 
insert into CTHD values (1011 , 'ST06' , 50) 
insert into CTHD values (1012 , 'ST07' , 3) 
insert into CTHD values (1013 , 'ST08' , 5) 
insert into CTHD values (1014 , 'BC02' , 80) 
insert into CTHD values (1014 , 'BB02' , 100) 
insert into CTHD values (1014 , 'BC04' , 60) 
insert into CTHD values (1014 , 'BB01' , 50)
insert into CTHD values (1015 , 'BB02' , 30) 
insert into CTHD values (1015 , 'BB03' , 7) 
insert into CTHD values (1016 , 'TV01' , 5) 
insert into CTHD values (1017 , 'TV02' , 1) 
insert into CTHD values (1017 , 'TV03' , 1) 
insert into CTHD values (1017 , 'TV04' , 5) 
insert into CTHD values (1018 , 'ST04' , 6) 
insert into CTHD values (1019 , 'ST05' , 1) 
insert into CTHD values (1019 , 'ST06' , 2) 
insert into CTHD values (1020 , 'ST07' , 10) 
insert into CTHD values (1021 , 'ST08' , 5) 
insert into CTHD values (1021 , 'TV01' , 7) 
insert into CTHD values (1021 , 'TV02' , 10) 
insert into CTHD values (1022 , 'ST07' , 1) 
insert into CTHD values (1023 , 'ST04' , 6) 

----2. Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. 
-------Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
select * into SANPHAM1 from SANPHAM
select * into KHACHHANG1 from KHACHHANG

----3. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
update SANPHAM1 
set GIA = GIA + GIA * (5/100) 
where NUOCSX = 'Thai Lan'

----4. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
update SANPHAM1 
set GIA = GIA - GIA * (5/100) 
where NUOCSX = 'Trung Quoc' and GIA <= 10000

----5. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên 
--hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
update KHACHHANG1 
set LOAIKH = 'Vip' 
where (NGDK < '1/1/2007' and DOANHSO >=10000000) or                                           
	  (NGDK >='1/1/2007' and DOANHSO >=2000000)
--------------------------------
--III. Ngôn ngữ truy vấn dữ liệu

----1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
select MASP, TENSP 
from SANPHAM 
where NUOCSX = 'Trung Quoc'

----2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
select MASP, TENSP 
from SANPHAM 
where DVT ='cay' 
   or DVT = 'quyen'

select MASP, TENSP 
from SANPHAM 
where DVT in ('cay','quyen') 

----3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select MASP, TENSP 
from SANPHAM 
where MASP like 'B%' 
  and MASP like '%01'

select MASP, TENSP 
from SANPHAM 
where MASP like 'B%01' 

----4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP 
from SANPHAM 
where NUOCSX = 'Trung Quoc' and GIA between 30000 and 40000

----5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP 
from SANPHAM 
where (NUOCSX = 'Thai Lan' or NUOCSX = 'Trung Quoc') 
  and (GIA between 30000 and  40000)

----6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
select SOHD, TRIGIA 
from HOADON 
where NGHD = '1/1/2007' 
   or NGHD = '2/1/2007'

select SOHD, TRIGIA 
from HOADON 
where NGHD in ('1/1/2007','2/1/2007')

----7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
select SOHD, TRIGIA 
from HOADON 
where month(NGHD) = 1 and year(NGHD) = 2007 
order by NGHD, TRIGIA desc

----8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
select KH.MAKH, HOTEN 
from KHACHHANG as KH, HOADON as HD 
where KH.MAKH = HD.MAKH and NGHD = '1/1/2007'

----9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
select SOHD, TRIGIA 
from HOADON, NHANVIEN  
where HOTEN = 'Nguyen Van B' and 
	  HOADON.MANV = NHANVIEN.MANV and 
	  NGHD = '28/10/2006'

----10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select SP.MASP, SP.TENSP 
from KHACHHANG as KH,
	 SANPHAM as SP, 
	 HOADON as HD, 
	 CTHD as CT 
where KH.MAKH = HD.MAKH and 
	  SP.MASP = CT.MASP and 
	  CT.SOHD = HD.SOHD 
  and HOTEN = 'Nguyen Van A' and (month(NGHD) = 10 and year(NGHD) = 2006) 
  
----11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
select distinct SOHD
from CTHD
where MASP in ('BB01','BB02')

----12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select distinct SOHD 
from CTHD 
where MASP in ('BB01','BB02') and (SL between 10 and 20)

----13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select SOHD 
from CTHD C1
where (MASP = 'BB01') and (SL between 10 and 20) 
	  and exists (select *
				  from CTHD C2
				  where (MASP = 'BB02') and (SL between 10 and 20) and
						C1.SOHD = C2.SOHD)

select distinct R1.SOHD
from CTHD R1
where (R1.SL between 10 and 20) and 
	not exists (
				 select *
				 from CTHD R2
				 where MASP in('BB01','BB02') and not exists(
															select *
															from CTHD R
															where R.MASP = R2.MASP and R.SOHD=R1.SOHD))

----14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc'
union
select MASP, TENSP
from SANPHAM 
where MASP in (select MASP
			   from CTHD C join HOADON H on C.SOHD = H.SOHD
			   where NGHD = '1/1/2007')

----15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
select MASP, TENSP
from SANPHAM S
where not exists (select *
				  from CTHD C
				  where S.MASP = C.MASP)

select MASP, TENSP
from SANPHAM
where MASP not in (select MASP
					from CTHD)

----16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006. 
select MASP, TENSP
from SANPHAM
where MASP not in (select MASP
					from CTHD C join HOADON H on C.SOHD = H.SOHD
					where year(NGHD) = 2006)

----17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006. 
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and 
	  MASP not in (select MASP
					from CTHD C join HOADON H on C.SOHD = H.SOHD
					where year(NGHD) = 2006)

----18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất
select SOHD 
from HOADON HD
where not exists(
				select * 
				from SANPHAM SP
				where NUOCSX='Singapore' and not exists (
														select * 
														from CTHD
														where CTHD.MASP = SP.MASP and CTHD.SOHD = HD.SOHD))

----19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất
select SOHD 
from HOADON HD
where year(NGHD)=2006 and not exists (
									  select * 
                                      from SANPHAM SP
									  where NUOCSX='Singapore' 
									  and not exists (
													 select * 
													 from CTHD
													 where CTHD.MASP = SP.MASP and CTHD.SOHD = HD.SOHD))

----20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
select count(*) as SoHoaDon
from HOADON H
where MAKH not in (select MAKH
				   from KHACHHANG K
				   where K.MAKH = H.MAKH)

----21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006
select count(distinct MASP) as SLSP
from CTHD ,HOADON
where year(NGHD)=2006  and HOADON.SOHD = CTHD.SOHD

----22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
select max(TRIGIA) as TRIGIA_MAX, min(TRIGIA) as TRIGIA_MIN
from HOADON

----23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select avg(TRIGIA) TB
from HOADON
where year(NGHD) = 2006

----24. Tính doanh thu bán hàng trong năm 2006
select sum(TRIGIA) as DOANHTHU
from HOADON
where year(NGHD) = 2006

----25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006
select SOHD
from HOADON
where year(NGHD)=2006 and TRIGIA = (select max(TRIGIA)
		                            from HOADON
									where year (NGHD)=2006)

----26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006
select HOTEN
from KHACHHANG K inner join HOADON H
on K.MAKH = H.MAKH 
and SOHD = (select SOHD
			from HOADON
			where TRIGIA = (select max(TRIGIA)
							from HOADON
							where year(NGHD)=2006))
							
----27. In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần
select top 3 MAKH, HOTEN
from KHACHHANG 
order by DOANHSO desc

----28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất
select MASP, TENSP
from SANPHAM
where GIA in (select distinct top 3 GIA
			  from SANPHAM
			  order by GIA desc)

----29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất 
--------có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm)
select MASP, TENSP
from SANPHAM
where NUOCSX ='Thai Lan' and GIA in (select distinct top 3 GIA
									 from SANPHAM
									 order by GIA desc)

----30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất 
--------có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất)
select MASP, TENSP
from SANPHAM
where NUOCSX ='Trung Quoc' and GIA in (select distinct top 3 GIA
									   from SANPHAM
									   where NUOCSX = 'Trung Quoc'
									   order by GIA desc)

----31. *In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số)
select MAKH, HOTEN
from KHACHHANG
where DOANHSO in (select distinct top 3 DOANHSO
				  from KHACHHANG
				  order by DOANHSO desc)

----32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất
select count (MASP) as SOSP
from SANPHAM
where NUOCSX='Trung Quoc'

----33. Tính tổng số sản phẩm của từng nước sản xuất
select NUOCSX, count (MASP) as SOSP
from SANPHAM
group by NUOCSX

----34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm
select NUOCSX, max(GIA) as GiaCaoNhat, min(GIA) as GiaThapNhat, avg(GIA) as TrungBinh
from SANPHAM
group by NUOCSX

----35. Tính doanh thu bán hàng mỗi ngày
select NGHD, sum(TRIGIA) as DOANHTHU
from HOADON
group by NGHD

----36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006
select MASP, sum(SL) as TongSo
from CTHD, HOADON
where CTHD.SOHD = HOADON.SOHD
and month(NGHD)=10
and year(NGHD)=2006
group by MASP

----37. Tính doanh thu bán hàng của từng tháng trong năm 2006
select month(NGHD) as Thang, sum(TRIGIA) as DOANHTHU
from HOADON 
where year(NGHD)=2006
group by month(NGHD)

----38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau
select SOHD, count (MASP) as SLSP
from CTHD
group by SOHD
having count(MASP) >=4

----39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau)
select SOHD, count (CTHD.MASP) as SLSP
from CTHD, SANPHAM
where NUOCSX ='Viet Nam' and SANPHAM.MASP=CTHD.MASP
group by SOHD
having count(CTHD.MASP)=3

----40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất
select KH.MAKH, HOTEN, count(SOHD) as SoLanMua
from KHACHHANG KH, HOADON HD
where KH.MAKH = HD.MAKH
group by KH.MAKH, HOTEN
having count(SOHD)=(select top 1 count(SOHD)
					from HOADON
					group by MAKH
					order by count(SOHD) desc)

select top 1 with ties KH.MAKH, HOTEN, count(SOHD) as SoLanMua
from KHACHHANG KH, HOADON HD
where KH.MAKH = HD.MAKH
group by KH.MAKH, HOTEN
order by count(SOHD) desc

--or: >= all

----41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ? 
select month(NGHD) as Thang, sum(TRIGIA) as DoanhSo
from HOADON
where year(NGHD)=2006
group by month(NGHD)
having sum(TRIGIA)>=all (select sum(TRIGIA)
						 from HOADON
						 group by month(NGHD)) 

----42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006
select SP.MASP, TENSP, sum(CTHD.SL) as TongSL
from SANPHAM SP, HOADON, CTHD
where year(NGHD)=2006 and 
	  SP.MASP=CTHD.MASP and 
	  CTHD.SOHD = HOADON.SOHD
group by SP.MASP,TENSP
having sum(SL) <= all (select sum(SL) 
					   from CTHD, HOADON
					   where year(NGHD)=2006 and HOADON.SOHD = CTHD.SOHD
					   group by MASP)

----43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất. 
select NUOCSX, MASP, TENSP, GIA
from SANPHAM SP1
where GIA = (select max(GIA)
			  from SANPHAM SP2
			  where SP2.NUOCSX = SP1.NUOCSX)

select NUOCSX, MASP, TENSP, GIA
from SANPHAM SP1
group by NUOCSX, MASP, TENSP, GIA
having GIA >= all (select GIA
				   from SANPHAM SP2
				   where SP2.NUOCSX = SP1.NUOCSX)

----44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
select NUOCSX, count (distinct GIA) as SOSP
from SANPHAM
group by NUOCSX
having count (distinct GIA) >=3

----45. *Trong các khách hàng có doanh số thuộc top 3 cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất. 
select KH.MAKH, HOTEN, count (SOHD) as SLMUA
from KHACHHANG KH inner join HOADON on KH.MAKH=HOADON.MAKH
where DOANHSO in (select distinct top 3 DOANHSO
				  from KHACHHANG
				  order by DOANHSO desc)
group by KH.MAKH, HOTEN
having count(SOHD) >= all( select count(SOHD)
						   from HOADON, KHACHHANG
						   where HOADON.MAKH=KHACHHANG.MAKH and
								 DOANHSO in( select distinct top 3 DOANHSO
											 from KHACHHANG
											 order by DOANHSO desc)
						   group by KHACHHANG.MAKH)