Create table CHUCVU
(
    MaCV char(6) PRIMARY KEY,
    TenCV nvarchar2(30),
    HeSoPhuCap float
)

Create table NHANVIEN
(
    MaNV char(6) PRIMARY KEY,
    TenNV nvarchar2(10),
    HoNV nvarchar2(20),
    GioiTinh nvarchar2(3),
    NgaySinh date,
    SoBHXH nvarchar2(10),
    MaCV char(6),
    SoNgayNghi date,
    MaHeSoLuong char(4), --them khoa ngoai
    MaCong char(4), --them khoa ngoai 
    CONSTRAINT FK_NV_CV Foreign Key (MaCV) REFERENCES CHUCVU(MaCV)
)

Create table BANGTHANHTOANLUONG
(
    IDLuong char(5) PRIMARY KEY,
    ThangTT int,
    NamTT int,
    MaNV char(6),
    ThueTNCN float,
    TongLuong float,
    LyDo nvarchar2(20),
    LuongBD float
)

alter table BANGTHANHTOANLUONG
add CONSTRAINT FK_BTTL_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV);

Create table BANGHESOLUONG
(
    MaHeSoLuong char(4) PRIMARY KEY,
    NamApDung date,
    Bac int,
    NhomNgach nvarchar2(10),
    MucLuongTheoThoiGian float,
    HeSoLuong float
)

Create table CONG
(
    MaCong char(4) PRIMARY KEY,
    CongNhanVien int
)

alter table NHANVIEN
    add CONSTRAINT FK_NV_HSL FOREIGN KEY (MaHeSoLuong) REFERENCES BANGHESOLUONG(MaHeSoLuong);
alter table NHANVIEN
    add CONSTRAINT FK_NV_C FOREIGN KEY (MaCong) REFERENCES CONG(MaCong);
    

Create table HOPDONG
(
    MaHD char(5) PRIMARY KEY,
    MaNV char(6),
    NgayKi date,
    HanHD nvarchar2(10),
    TrangThai char(2),
    CONSTRAINT FK_HD_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)
    
Create table BANGTHONGKELUONG
(
    NamTK int PRIMARY KEY,
    ThangTK int,
    LuongTTT float,
    LuongTCTNT float,
    IDLuong char(5),
    CONSTRAINT fk_TKL_BTTL Foreign Key (IDLuong) REFERENCES BANGTHANHTOANLUONG(IDLuong)
)

Create table THEODOISONGAYNGHI
(
    MaNN char(3) PRIMARY KEY,
    MaNV char(6),
    ThangBL int,
    NghiKP int,
    NghiBHXH int,
    NghiCP int,
    CONSTRAINT fk_TDSNN_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table TINHTIENSINHHOAT
(
    MaNV char(6) PRIMARY KEY,
    DienTich float,
    SoCTD float, --So chi tieu dien
    SoDHN float, --So dong ho nuoc
    ChiPhiKhac float,
    TongCPSH float,
    CONSTRAINT fk_TTSH_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table CT_NHANVIEN
(
    MaNV char(6) PRIMARY KEY,
    ThoiGianVoLam date,
    MoTaCongViec nvarchar2(50),
    NoiSinh nvarchar2(15),
    NguyenQuan nvarchar2(15),
    HoKhauThuongTru nvarchar2(30),
    HoKhauTamTu nvarchar2(30),
    CMND char(10),
    QuocTich nvarchar2(15),
    TonGiao nvarchar2(15),
    TrinhDoHocVan nvarchar2(10),
    TrinhDoChuyenMon nvarchar2(10),
    CONSTRAINT fk_CTNV_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table PHIEUDANGKINHATAPTHE
(
    SoDangKi char(10) PRIMARY KEY,
    MaNV char(6),
    DienTichThue float,
    SoLuongNguoiDK int,
    CONSTRAINT fk_PDKNTT_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table THANHNHAN
(
    MaNV char(6) PRIMARY KEY,
    QuanHe nvarchar2(10),
    NgheNghiep nvarchar2(10),
    NoiCongTac nvarchar2(10),
    CONSTRAINT fk_TN_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table CONGTAC
(
    SoQuyetDinhCongTac char(10) PRIMARY KEY,
    MaNV char(6),
    MaPhong nvarchar2(5), --them FK sau
    NgayBD date,
    NgayKT date,
    LyDO nvarchar2(10),
    CONSTRAINT fk_CT_NV Foreign Key (MaNV) REFERENCES NHANVIEN(MaNV)
)

Create table PHONG
(
    MaPhong nvarchar2(5),
    TenPhong nvarchar2(20)
)
alter table PHONG
add PRIMARY KEY(MaPhong); 
alter table CONGTAC
    add CONSTRAINT FK_CT_PHONG FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong)