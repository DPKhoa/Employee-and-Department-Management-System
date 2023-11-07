--- chuc vu 
Create table CHUCVU
(
    MaCV char(6) PRIMARY KEY,
    TenCV nvarchar2(30),
    HeSoPhuCap int
)
-- bang he so luong
Create table BANGHESOLUONG
(
    MaHeSoLuong char(4) PRIMARY KEY,
    NamApDung date,
    Bac int,
    NhomNgach nvarchar2(20),
    HeSoLuong float
)

-- phong ban
drop table phongban;
Create table PHONGBAN
(
    MaPhong nvarchar2(5),
    TenPhong nvarchar2(20),
    TruongPhong char(6)
)
alter table PHONGBAN
add PRIMARY KEY(MaPhong);

alter table PHONGBAN
add CONSTRAINT fk_PB_NV_TP Foreign Key (TRUONGPHONG) REFERENCES NHANVIEN(MaNV);

--nhanvien
Create table NHANVIEN
(
    MaNV char(6) PRIMARY KEY,
    HoNV nvarchar2(20),
    TenNV nvarchar2(10),
    GioiTinh nvarchar2(3),
    NgaySinh date,
    SoBHXH nvarchar2(10),
    CMND nvarchar2(10),
    QuocTich nvarchar2(10),
    DiaChi nvarchar2(50),
    MaCV char(6),
    MaNQL char(6) REFERENCES NHANVIEN(MaNV),
    MaPhong nvarchar2(5), --them khoa ngoai
    MaHeSoLuong char(4),
    MaHV char(4),
    MaCM char(4),
    MaLoaiNV char(5),
    CONSTRAINT FK_NV_HSL Foreign Key (MaHeSoLuong) REFERENCES BANGHESOLUONG(MaHeSoLuong),
    CONSTRAINT FK_NV_CV Foreign Key (MaCV) REFERENCES CHUCVU(MaCV)
)
alter table NHANVIEN
add CONSTRAINT fk_NV_HV Foreign Key (MAHV) REFERENCES HOCVAN(MaHV);

alter table NHANVIEN
add CONSTRAINT fk_NV_CM Foreign Key (MACM) REFERENCES CHUYENMON(MaCM);

alter table NHANVIEN
add CONSTRAINT fk_NV_LNV Foreign Key (MALOAINV) REFERENCES LOAINHANVIEN(MALOAINV);

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NV_P FOREIGN KEY (MaPhong) REFERENCES PHONGBAN(MaPhong) ;

--hocvan
Create table HOCVAN
(
    MaHV char(4) PRIMARY KEY,
    TrinhDoHV nvarchar2(50)
)
--chuyenmon
Create table CHUYENMON
(
    MaCM char(4) PRIMARY KEY,
    TrinhDoCM nvarchar2(50)
)
--loainhanvien
Create table LoaiNhanVien
(
    MaLoaiNV char(5) PRIMARY KEY,
    TenLoaiNV nvarchar2(50)
)
--chamcong
Create table CHAMCONG
(
    MaCC char(3) PRIMARY KEY,
    MaNV char(6),
    ThangTheoDoi int,
    MoTa varchar2(50),
    CONSTRAINT fk_CC_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)
--thanh toan luong
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
    CONSTRAINT fk_TTL_CC Foreign Key (MaCC) REFERENCES CHAMCONG(MaCC),
    MaTU number(3)
)
alter table THANHTOANLUONG
add CONSTRAINT fk_TTL_TU Foreign Key (MaTU) REFERENCES TAMUNG(MaTU); 
--tamung
Create table TamUng
(
    MaTU number(3) Primary key,
    MaNV char(6),
    TenNV NVARCHAR2(10),
    CONSTRAINT FK_TU_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)


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

Create table THAMNIEN
(
    MaHSL char(4),
    MaNV char(6),
    ThoiGianLam number(2),
    TienThamNien number(10),
    Primary Key (MaHSL, MaNV),
    CONSTRAINT FK_TN_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT FK_TU_HSL FOREIGN KEY (MaHSL) REFERENCES BANGHESOLUONG(MAHESOLUONG)
)

Create table HOPDONG
(
    MaHD char(5) PRIMARY KEY,
    MaNV char(6),
    NgayKy date,
    HanHD nvarchar2(10),
    TrangThai char(2),
    LuongHD float,
    MotaCongViec nvarchar2(100),
    MaLHD char(4),
    MaHeSoLuong char(4),
    CONSTRAINT FK_HD_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

create table LOAIHD
(
    MALHD char(4) PRIMARY KEY,
    LOAIHD nvarchar2(50)
)
alter table HOPDONG
add CONSTRAINT fk_HD_LHD Foreign Key (MALHD) REFERENCES LOAIHD(MALHD); 

alter table HOPDONG
modify
(
   MAHD    number(4)
);


create table THONGKECHAMCONG
(
    MANV char(6),
    MACC char(5),
    NGHICP number(3),
    NGHIKP number(3),
    NGHIBHXH number(3),
    ThangTK number(2),
    NamTK number(4),
    SoNgayDiLam number(3),
    PRIMARY KEY(MANV, MACC),
    CONSTRAINT fk_TKCC_NV Foreign Key (MANV) REFERENCES NHANVIEN(MANV),
    CONSTRAINT fk_TKCC_CC Foreign Key (MACC) REFERENCES CHAMCONG(MACC)
)

ALTER TABLE CHUCVU
ADD CONSTRAINT FK_CV_HSL FOREIGN KEY (MAHSL) REFERENCES BANGHESOLUONG(MAHESOLUONG);

ALTER TABLE HOPDONG
ADD CONSTRAINT FK_HD_HSL FOREIGN KEY (MAHSL) REFERENCES BANGHESOLUONG(MAHESOLUONG);

create table BIENDONGHSL(
    MAHSL char(4),
    NAMAPDUNG date,
    Bac number(5),
    NHOMNGACH nvarchar2(20),
    HESOLUONG float,
    PRIMARY KEY (MAHSL, NAMAPDUNG),
    CONSTRAINT FK_BDHSL_HSL FOREIGN KEY (MAHSL) REFERENCES BANGHESOLUONG(MAHESOLUONG)
)

create table CTTTLUONG(
    MACTL number(4) PRIMARY KEY,
    IDLUONG char(5),
    THANGTT number(2),
    NAMTT number(4),
    TIENTHAMNIEN number(10),
    TIENNGHI float,
    CHIPHIKHAC number(10),
    CONSTRAINT FK_CTTTL_TTL FOREIGN KEY (IDLUONG) REFERENCES THANHTOANLUONG(IDLUONG)
)


-- Them Du Lieu bang BANGHESOLUONG
insert into BANGHESOLUONG
values(N'HS02',2, N'Nhóm 2 (A3.2)', 6.11);
insert into BANGHESOLUONG
values(N'HS03',1, N'Nhóm 1 (A2.1)', 4.40);
insert into BANGHESOLUONG
values(N'HS04',2, N'Nhóm 2 (A2.2)', 4.34);
insert into BANGHESOLUONG
values(N'HS05',3, N'Nhóm A1', 3);

-- Them Du lieu bang chucvu
insert into CHUCVU
values(N'CV0001', N'Giám ??c',N'HS01');
insert into CHUCVU
values(N'CV0005', N'Phó Giám ??c',N'HS01');
insert into CHUCVU
values(N'CV0002', N'Tr??ng Phòng', N'HS02');
insert into CHUCVU
values(N'CV0003', N'Th? Kí',N'HS03');
insert into CHUCVU
values(N'CV0004', N'Nhân Viên',N'HS04');
insert into CHUCVU
values(N'CV0006', N'Th?c t?p sinh',N'HS05');

--Them du lieu bang PhongBan
insert into PHONGBAN
values (N'PB001', N'Phòng Hành Chính',null);
insert into PHONGBAN
values (N'PB002', N'Phòng Nhân s?',null);
insert into PHONGBAN
values (N'PB003', N'Phòng Marketing',null);
insert into PHONGBAN
values (N'PB004', N'Phòng Giám ??c',null);
