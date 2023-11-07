Create table CHUCVU
(
    MaCV char(6) PRIMARY KEY,
    TenCV nvarchar2(30),
    HeSoPhuCap int
)

Create table BANGHESOLUONG
(
    MaHeSoLuong char(4) PRIMARY KEY,
    NamApDung date,
    Bac int,
    NhomNgach nvarchar2(20),
    HeSoLuong float
)

Create table PHONGBAN
(
    MaPhong nvarchar2(5),
    TenPhong nvarchar2(20)
)

Create table NHANVIEN
(
    MaNV char(6) PRIMARY KEY,
    HoNV nvarchar2(20),
    TenNV nvarchar2(10),
    GioiTinh nvarchar2(3),
    NgaySinh date,
    SoBHXH nvarchar2(10),
    MaCV char(6),
    MaNQL char(6) REFERENCES NHANVIEN(MaNV),
    MaPhong nvarchar2(5), --them khoa ngoai
    MaHeSoLuong char(4), 
    CONSTRAINT FK_NV_HSL Foreign Key (MaHeSoLuong) REFERENCES BANGHESOLUONG(MaHeSoLuong),
    CONSTRAINT FK_NV_CV Foreign Key (MaCV) REFERENCES CHUCVU(MaCV)
)

alter table PHONGBAN
add PRIMARY KEY(MaPhong);

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NV_P FOREIGN KEY (MaPhong) REFERENCES PHONGBAN(MaPhong) ;


Create table CHAMCONG
(
    MaCC char(3) PRIMARY KEY,
    MaNV char(6),
    ThangTheoDoi int,
    NghiKP int,
    NghiCP int,
    NghiBHXH int,
    SoNgayDiLam int,
    CONSTRAINT fk_CC_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table THANHTOANLUONG
(
    IDLuong char(5) PRIMARY KEY,
    ThangTT int,
    NamTT int,
    MaNV char(6),
    MaCC  char(3),
    ThueTNCN float, --Thu? thu nh?p cá nhân
    LuongBD float,
    TongLuong float,
    LyDo nvarchar2(20),
    CONSTRAINT fk_TTL_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT fk_TTL_CC Foreign Key (MaCC) REFERENCES CHAMCONG(MaCC)
)

Create table HOPDONG
(
    MaHD char(5) PRIMARY KEY,
    MaNV char(6),
    NgayKy date,
    HanHD nvarchar2(10),
    TrangThai char(2),
    CONSTRAINT FK_HD_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table THONGKELUONG
(
    MaTKL nvarchar2(5) PRIMARY KEY,
    NamTK int,
    ThangTK int,
    LuongTONG float,
    LuongTCTNT float,
    IDLuong char(5),
    CONSTRAINT fk_TKL_BTTL Foreign Key (IDLuong) REFERENCES THANHTOANLUONG(IDLuong)
)
alter table THONGKELUONG
set unused(THANGTK, IDLUONG);

alter table THONGKELUONG
add MaNV char(6);

alter table THONGKELUONG
add CONSTRAINT fk_TTKL_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV);


alter table THANHTOANLUONG
add MaTT nvarchar2(5);

alter table THANHTOANLUONG
ADD CONSTRAINT FK_TTL_TT FOREIGN KEY (MaTT) REFERENCES TINHTIENSINHHOAT(MaTT) ;







Create table CONGTAC
(
    SoQuyetDinhCT char(5) PRIMARY KEY,
    MaNV char(6),
    MaPhong nvarchar2(5),
    NgayBD date,
    NgayKT date,
    LyDO nvarchar2(20),
    CONSTRAINT fk_CT_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT fk_CT_P Foreign Key (MaPhong) REFERENCES PhongBan(MaPhong)
)

alter table CHUCVU
set UNUSED COLUMN HeSoPhuCap;
alter table CHUCVU
DROP UNUSED COLUMNS;
-- Them Du Lieu bang CHUCVU
insert into CHUCVU
values(N'CV0001', N'Giám ??c');
insert into CHUCVU
values(N'CV0002', N'Tr??ng Phòng');
insert into CHUCVU
values(N'CV0003', N'Th? Kí');
insert into CHUCVU
values(N'CV0004', N'Nhân Viên');
-- Them du lieu bang BANGHESOLUONG
insert into BANGHESOLUONG
values(N'HS01', TO_DATE('10/11/2010', 'dd/mm/yyyy'), 1, N'Nhóm 1 (A3.1)', 6.2);
insert into BANGHESOLUONG
values(N'HS02', TO_DATE('10/11/2010', 'dd/mm/yyyy'), 2, N'Nhóm 2 (A3.2)', 6.11);
insert into BANGHESOLUONG
values(N'HS03', TO_DATE('10/11/2010', 'dd/mm/yyyy'), 1, N'Nhóm 1 (A2.1)', 4.40);
insert into BANGHESOLUONG
values(N'HS04', TO_DATE('10/11/2010', 'dd/mm/yyyy'), 2, N'Nhóm 2 (A2.2)', 4.34);
insert into BANGHESOLUONG
values(N'HS05', TO_DATE('10/11/2010', 'dd/mm/yyyy'), 3, N'Nhóm A1', 3);

--Them du lieu bang PhongBan
insert into PHONGBAN
values (N'PB001', N'Phòng Hành Chính');
insert into PHONGBAN
values (N'PB002', N'Phòng Nhân S?');
insert into PHONGBAN
values (N'PB003', N'Phòng Marketing');
insert into PHONGBAN
values (N'PB004', N'Phòng Giám ??c');

--Them du lieu vao bang Nhanvien
insert into NHANVIEN
values(N'NV0001', N'Nguy?n', N'??ng Khoa', N'Nam', TO_DATE('17/11/1995', 'dd/mm/yyyy'), null, N'CV0001', null, N'PB004', N'HS01' );

insert into NHANVIEN
values(N'NV0002', N'Nguy?n', N'Anh Khoa', N'Nam', TO_DATE('3/10/1998', 'dd/mm/yyyy'), null, N'CV0002', N'NV0001', N'PB002', N'HS02' );

insert into NHANVIEN
values(N'NV0003', N'??', N'Phúc Tân', N'Nam', TO_DATE('1/11/1999', 'dd/mm/yyyy'), null, N'CV0003', N'NV0002', N'PB002', N'HS03' );

insert into NHANVIEN
values(N'NV0004', N'Nguy?n', N'Thành ??t', N'Nam', TO_DATE('27/3/2000', 'dd/mm/yyyy'), null, N'CV0004', 'NV0002', N'PB002', N'HS04' );


insert into NHANVIEN
values(N'NV0005', N'Hà Bùi', N'M?nh Hùng', N'Nam', TO_DATE('12/11/1999', 'dd/mm/yyyy'), null, N'CV0002', 'NV0001', N'PB003', N'HS02' );

insert into NHANVIEN
values(N'NV0006', N'Ph?m Th?', N'Di?u Linh', N'N?', TO_DATE('20/11/1998', 'dd/mm/yyyy'), null, N'CV0002', 'NV0001', N'PB001', N'HS02' );

insert into NHANVIEN
values(N'NV0007', N'Tr?n', N'Thanh Long', N'Nam', TO_DATE('23/01/1996', 'dd/mm/yyyy'), null, N'CV0004', 'NV0006', N'PB001', N'HS05' );

insert into NHANVIEN
values(N'NV0008', N'V?n', N'Minh Nhân', N'Nam', TO_DATE('12/8/1995', 'dd/mm/yyyy'), null, N'CV0003', 'NV0005', N'PB003', N'HS03' );

insert into NHANVIEN
values(N'NV0009', N'??ng V?;', N'Nh?t Tú', N'Nam', TO_DATE('10/9/1999', 'dd/mm/yyyy'), null, N'CV0004', 'NV0005', N'PB003', N'HS05' );

insert into NHANVIEN
values(N'NV0010', N'Tr?n', N'Ti?u Bình', N'N?', TO_DATE('10/9/1999', 'dd/mm/yyyy'), null, N'CV0004', 'NV0006', N'PB001', N'HS04' );

--them du lieu vao bang HOPDONG
insert into HOPDONG
values(N'HD002', N'NV0002', TO_DATE('20/11/2019', 'dd/mm/yyyy'), N'2 n?m', N'CH');


insert into HOPDONG
values(N'HD003', N'NV0003', TO_DATE('23/12/2019', 'dd/mm/yyyy'), N'3 n?m', N'CH');


insert into HOPDONG
values(N'HD004', N'NV0004', TO_DATE('12/4/2020', 'dd/mm/yyyy'), N'5 n?m', N'CH');


insert into HOPDONG
values(N'HD005', N'NV0005', TO_DATE('3/12/2019', 'dd/mm/yyyy'), N'6 n?m', N'CH');


insert into HOPDONG
values(N'HD006', N'NV0006', TO_DATE('15/11/2019', 'dd/mm/yyyy'), N'6 n?m', N'CH');


insert into HOPDONG
values(N'HD007', N'NV0007', TO_DATE('22/1/2020', 'dd/mm/yyyy'), N'5 n?m', N'CH');


insert into HOPDONG
values(N'HD008', N'NV0008', TO_DATE('13/3/2020', 'dd/mm/yyyy'), N'3 n?m', N'CH');


insert into HOPDONG
values(N'HD009', N'NV0009', TO_DATE('5/5/2020', 'dd/mm/yyyy'), N'4 n?m', N'CH');


insert into HOPDONG
values(N'HD010', N'NV0010', TO_DATE('29/4/2020', 'dd/mm/yyyy'), N'4 n?m', N'CH');



--them du lieu vao bang cham cong

insert into CHAMCONG
values(N'CC001', N'NV0002', 1, 1, 2, 0, 28);


insert into CHAMCONG
values(N'CC002', N'NV0002', 2, 1, 1, 1, 26);


insert into CHAMCONG
values(N'CC003', N'NV0003', 1, 0, 2, 2, 27);


insert into CHAMCONG
values(N'CC004', N'NV0003', 2, 1, 2, 0, 26);


insert into CHAMCONG
values(N'CC005', N'NV0004', 1, 2, 0, 0, 29);


insert into CHAMCONG
values(N'CC006', N'NV0004', 2, 1, 0, 1, 27);


insert into CHAMCONG
values(N'CC007', N'NV0005', 1, 1, 1, 2, 27);


insert into CHAMCONG
values(N'CC008', N'NV0005', 2, 2, 0, 0, 27);


insert into CHAMCONG
values(N'CC009', N'NV0006', 1, 0, 1, 1, 29);


insert into CHAMCONG
values(N'CC010', N'NV0006', 2, 0, 0, 1, 28);


insert into CHAMCONG
values(N'CC011', N'NV0007', 1, 2, 2, 2, 25);


insert into CHAMCONG
values(N'CC012', N'NV0007', 2, 1, 1, 1, 26);


insert into CHAMCONG
values(N'CC013', N'NV0008', 1, 1, 0, 2, 28);


insert into CHAMCONG
values(N'CC014', N'NV0008', 2, 0, 0, 0, 29);


insert into CHAMCONG
values(N'CC015', N'NV0009', 1, 1, 1, 0, 29);


insert into CHAMCONG
values(N'CC016', N'NV0009', 2, 0, 2, 2, 25);


insert into CHAMCONG
values(N'CC017', N'NV0010', 1, 1, 1, 1, 28);


insert into CHAMCONG
values(N'CC018', N'NV0010', 2, 0, 0, 0, 29);

--Them du lieu vao bang cong tac

insert into CONGTAC
values(N'QD001', N'NV0002', N'PB002', TO_DATE('17/11/2022', 'dd/mm/yyyy'), N'Th?ng ch?c thành tr??ng phòng');

alter table CONGTAC
MODIFY LYDO nvarchar2(50);

insert into CONGTAC
values(N'QD002', N'NV0007', N'PB001', TO_DATE('27/11/2022', 'dd/mm/yyyy'), N'Phòng Marketing chuy?n sang phòng hành chính');

insert into CONGTAC
values(N'QD003', N'NV0009', N'PB003', TO_DATE('1/11/2022', 'dd/mm/yyyy'), N'Chuy?n t? phòng nhân s? sang marketing');



alter table THANHTOANLUONG
modify THUETNCN float;

--them du lieu THANHTOANLUONG

insert into THANHTOANLUONG
values(N'L0001', 1, 2022, N'NV0002', N'CC001', 14726700, 68589000, 53862300, null, null);

insert into THANHTOANLUONG
values(N'L0002', 2, 2022, N'NV0002', N'CC002', 13870500, 65735000, 51864500, null, null);

insert into THANHTOANLUONG
values(N'L0003', 1, 2022, N'NV0003', N'CC003', 3713200, 26816000, 22486800, null, N'TT001');

insert into THANHTOANLUONG
values(N'L0004', 2, 2022, N'NV0003', N'CC004', 3872800, 27614000, 23076360, null, N'TT002');

insert into THANHTOANLUONG
values(N'L0005', 1, 2022, N'NV0004', N'CC005', 2410000, 20300000, 17331840, null, N'TT003');

insert into THANHTOANLUONG
values(N'L0006', 2, 2022, N'NV0004', N'CC006', 2390800, 20204000, 17301260, null, N'TT004');

insert into THANHTOANLUONG
values(N'L0007', 1, 2022, N'NV0005', N'CC007', 13307700, 63859000, 50551300, null, null);


insert into THANHTOANLUONG
values(N'L0008', 2, 2022, N'NV0005', N'CC008', 14629200, 68264000, 53634800, null, null);

insert into THANHTOANLUONG
values(N'L0009', 1, 2022, N'NV0006', N'CC009', 14026500, 66255000, 52228500, null, null);

insert into THANHTOANLUONG
values(N'L0010', 2, 2022, N'NV0006', N'CC010', 15387600, 70792000, 55404400, null, null);

insert into THANHTOANLUONG
values(N'L0011', 1, 2022, N'NV0007', N'CC011', 1064550, 12097000, 10020450, null,N'TT005');
insert into THANHTOANLUONG
values(N'L0012', 2, 2022, N'NV0007', N'CC012', 1267200, 13448000, 11318800, null,N'TT005');

insert into THANHTOANLUONG
values(N'L0013', 1, 2022, N'NV0008', N'CC013', 3913800, 27819000, 23294200, null,N'TT007');

insert into THANHTOANLUONG
values(N'L0014', 2, 2022, N'NV0008', N'CC014', 4510000, 30800000, 25595000, null,N'TT008');

insert into THANHTOANLUONG
values(N'L0015', 1, 2022, N'NV0009', N'CC015', 1354800, 14032000, 12677200, null,null);

insert into THANHTOANLUONG
values(N'L0016', 2, 2022, N'NV0009', N'CC016', 1189650, 12931000, 11741350, null,null);

insert into THANHTOANLUONG
values(N'L0017', 1, 2022, N'NV0010', N'CC017', 2270000, 19600000, 17330000, null,null);

insert into THANHTOANLUONG
values(N'L0018', 2, 2022, N'NV0010', N'CC018', 2690000, 21700000, 19010000, null,null);

--them du lieu thongkeluong

insert into THONGKELUONG
values(N'TK001', 2022, 105726800, N'NV0002');


insert into THONGKELUONG
values(N'TK002', 2022, 45563160, N'NV0003');

insert into THONGKELUONG
values(N'TK003', 2022, 34633100, N'NV0004');

insert into THONGKELUONG
values(N'TK004', 2022, 104186100, N'NV0005');

insert into THONGKELUONG
values(N'TK005', 2022, 107632900, N'NV0006');

insert into THONGKELUONG
values(N'TK006', 2022, 21339250, N'NV0007');

insert into THONGKELUONG
values(N'TK007', 2022, 48889200, N'NV0008');

insert into THONGKELUONG
values(N'TK008', 2022, 11741350, N'NV0009');

insert into THONGKELUONG
values(N'TK009', 2022, 36340000, N'NV0010');






---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Create table HOCVAN
(
    MaHV char(4) PRIMARY KEY,
    TrinhDoHV nvarchar2(50)
)

Create table CHUYENMON
(
    MaCM char(4) PRIMARY KEY,
    TrinhDoCM nvarchar2(50)
)

Create table LoaiNhanVien
(
    MaLoaiNV char(5) PRIMARY KEY,
    TenLoaiNV nvarchar2(50)
)

Create table TamUng
(
    MaTU char(5) Primary key,
    MaNV char(6),
    TenNV NVARCHAR2(10),
    CONSTRAINT FK_TU_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table THAMNIEN
(
    MaHSL char(4),
    MaNV char(6),
    ThoiGianLam nvarchar2(20),
    Primary Key (MaHSL, MaNV),
    CONSTRAINT FK_TN_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT FK_TU_HSL FOREIGN KEY (MaHSL) REFERENCES BANGHESOLUONG(MAHESOLUONG)
)

alter table PHONGBAN
add CONSTRAINT fk_PB_NV_TP Foreign Key (TRUONGPHONG) REFERENCES NHANVIEN(MaNV);

alter table NHANVIEN
add CONSTRAINT fk_NV_HV Foreign Key (MAHV) REFERENCES HOCVAN(MaHV);

alter table NHANVIEN
add CONSTRAINT fk_NV_CM Foreign Key (MACM) REFERENCES CHUYENMON(MaCM);

alter table NHANVIEN
add CONSTRAINT fk_NV_LNV Foreign Key (MALOAINV) REFERENCES LOAINHANVIEN(MALOAINV);

create table THONGKECHAMCONG
(
    MANV char(6),
    MACC char(5),
    SONGAYDILAM number(3),
    NGHICP number(3),
    NGHIKP number(3),
    NGHIBHXH number(3),
    PRIMARY KEY (MANV, MACC),
    CONSTRAINT fk_TKCC_NV Foreign Key (MANV) REFERENCES NHANVIEN(MANV),
    CONSTRAINT fk_TKCC_CC Foreign Key (MACC) REFERENCES CHAMCONG(MACC)
)

