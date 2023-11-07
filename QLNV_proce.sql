--1
create or replace PROCEDURE TRACUUTTNV(
    i_v_MANV CHAR
)
as
    r_NV NHANVIEN%ROWTYPE;

begin

    select *
    into r_NV
    from NHANVIEN
    where MANV=i_v_MANV;
    DBMS_OUTPUT.PUT_LINE(r_NV.MANV || ' - ' || r_NV.HONV || ' - '  || r_NV.TENNV || ' - ' || r_NV.GIOITINH || ' - ' || r_NV.NGAYSINH || ' - ' || r_NV.SOBHXH || ' - ' || r_NV.MACV || ' - ' || r_NV.MANQL || ' - ' || r_NV.MAPHONG || ' - ' || r_NV.MAHESOLUONG || ' - ' || r_NV.MAHV || ' - ' || r_NV.MACM || ' - ' || r_NV.MALOAINV);
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
end;

set serveroutput on;
begin
    TRACUUTTNV(&MANV);
end;

--2 TRA CUU THONG TIN HD
create or replace PROCEDURE TRACUUTTHD(
    i_v_MAHD CHAR
)
as
    r_HD HOPDONG%ROWTYPE;

begin

    select  *
    into r_HD
    from HOPDONG
    where MAHD=i_v_MAHD;
    DBMS_OUTPUT.PUT_LINE(r_HD.MAHD || ' - ' || r_HD.MANV || ' - '  || r_HD.NGAYKY || ' - ' || r_HD.HANHD || ' - ' || r_HD.TRANGTHAI || ' - ' || r_HD.LUONGHD || ' - ' || r_HD.MALHD );
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
end;

set serveroutput on;
begin
   TRACUUTTHD(&MAHD);
end;

--3
create or replace PROCEDURE TRACUUCCNV
(
    i_v_MANV char
)
as

    v_MANV THONGKECHAMCONG.MANV%TYPE;
    v_TENNV NHANVIEN.TENNV%TYPE;
    v_MACC THONGKECHAMCONG.MANV%TYPE;
    v_SONGAYNGHI THONGKECHAMCONG.SONGAYNGHI%TYPE;
    v_NGHICP THONGKECHAMCONG.NGHICP%TYPE;
    v_NGHIKP THONGKECHAMCONG.NGHIKP%TYPE;
    v_NGHIBHXH THONGKECHAMCONG.NGHIBHXH%TYPE;
    v_THANGTK THONGKECHAMCONG.THANGTK%TYPE;
    v_NAMTK THONGKECHAMCONG.NAMTK%TYPE;
    v_SONGAYDILAM THONGKECHAMCONG.SONGAYDILAM%TYPE;

    CURSOR c_CCNV IS
        select TKCC.MANV, NV.TENNV, TKCC.MACC, SONGAYNGHI, NGHICP, NGHIKP, NGHIBHXH, THANGTK, NAMTK, SONGAYDILAM
        from THONGKECHAMCONG TKCC, NHANVIEN NV
        WHERE  TKCC.MANV=NV.MANV
        and TKCC.MANV=i_v_MANV;
begin
        open c_CCNV;
        loop
            FETCH c_CCNV into v_MANV, v_TENNV, v_MACC, v_SONGAYNGHI, v_NGHICP, v_NGHIKP, v_NGHIBHXH, v_THANGTK, v_NAMTK, v_SONGAYDILAM;
            EXIT WHEN c_CCNV%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_MANV || ' - ' || v_TENNV || ' - ' || v_MACC || ' - SONGAYNGHI: ' || v_SONGAYNGHI || ' - NGHICP: ' || v_NGHICP || ' - NGHIKP: ' ||  v_NGHIKP || ' - NGHIBHXH: ' || v_NGHIBHXH || ' - THANGTK: ' || v_THANGTK || ' - NAMTK: ' || v_NAMTK || ' - NGAYDILAM: ' || v_SONGAYDILAM);
        End loop;
        close c_CCNV;
        EXCEPTION
        when others then
             DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
end;


set serveroutput on;
begin
    TRACUUCCNV(&MANV);
end;

--4
CREATE TYPE TypeCMHV_NV is OBJECT (MANV CHAR(6), TENNV NVARCHAR2(10), TRINHDOCM NVARCHAR2(50), TRINHDOHV NVARCHAR2(50));
CREATE TYPE myTableCMHV_NV  IS TABLE OF TypeCMHV_NV;

CREATE OR REPLACE PROCEDURE  TRACUUHVCM_NV(
    i_v_MANV  CHAR
)
AS 
    v_CM_HVNV myTableCMHV_NV;
BEGIN
    SELECT TypeCMHV_NV(NV.MANV, TENNV, CM.TRINHDOCM, HV.TRINHDOHV) BULK COLLECT
    INTO  v_CM_HVNV 
    FROM NHANVIEN NV, CHUYENMON CM, HOCVAN HV
    WHERE NV.MACM = CM.MACM AND NV.MAHV = HV.MAHV
    AND NV.MANV =  i_v_MANV;
    
    FOR x IN 1.. v_CM_HVNV.count
    loop
        DBMS_OUTPUT.PUT_LINE(v_CM_HVNV(x).MANV || ' - TENNV: ' || v_CM_HVNV(x).TENNV || ' - CHUYENMON: ' || v_CM_HVNV(x).TRINHDOCM || ' - HOCVAN: ' || v_CM_HVNV(x).TRINHDOHV);
    end loop;
    EXCEPTION
    WHEN no_data_found  then
        DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
END;

SET SERVEROUTPUT ON;
BEGIN
    TRACUUHVCM_NV(&MANV);
END;

--5

create or replace PROCEDURE TRACUUCVNV
(
    i_v_MANV char
)
as

    v_MANV NHANVIEN.MANV%TYPE;
    v_TENNV NHANVIEN.TENNV%TYPE;
    v_MACV NHANVIEN.MACV%TYPE;
    v_TENCV CHUCVU.TENCV%TYPE;

    CURSOR c_CVNV IS
        select NV.MANV, NV.TENNV, NV.MACV, CV.TENCV
        from NHANVIEN NV, CHUCVU CV
        WHERE  NV.MACV=CV.MACV
        and NV.MANV=i_v_MANV;
begin
        open c_CVNV;
        loop
            FETCH c_CVNV into v_MANV, v_TENNV, v_MACV, v_TENCV;
            EXIT WHEN c_CVNV%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_MANV || ' - TENNV: ' || v_TENNV || ' - MACV: ' || v_MACV || ' - TENCV: ' || v_TENCV);
        End loop;
        close c_CVNV;
        EXCEPTION
        when others then
             DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
end;


set serveroutput on;
begin
    TRACUUCVNV(&MANV);
end;

--6
create type my_NV_NN is object (MANV char(6), TENNV nvarchar2(10), THANGTK NUMBER(2,0), NAMTK NUMBER(4,0), SONGAYNGHI NUMBER(3,0));
create type my_table_NV_NN is table of my_NV_NN;

DROP TYPE  my_NV_NN;
DROP TYPE my_table_NV_NN;
create or replace PROCEDURE MINNN_TT(
    i_v_THANGTK int
)
as     
    o_v_NV_NN my_table_NV_NN;
begin

    select my_NV_NN(NV.MANV, TENNV, THANGTK, NAMTK, MIN(SONGAYNGHI)) bulk collect
    into o_v_NV_NN
    from NHANVIEN NV, THONGKECHAMCONG TKCC
    where NV.MANV=TKCC.MANV 
    and THANGTK= i_v_THANGTK
    group by NV.MANV, TENNV, THANGTK, NAMTK
    having  MIN(SONGAYNGHI) <= (
                                                     select MIN(SONGAYNGHI)
                                                    from NHANVIEN NV, THONGKECHAMCONG TKCC
                                                    where NV.MANV=TKCC.MANV 
                                                    and THANGTK= i_v_THANGTK
    );
    
    for i in 1..o_v_NV_NN.count
    loop
         DBMS_OUTPUT.PUT_LINE(o_v_NV_NN(i).MANV || ' - TENNV: ' || 
                                                 o_v_NV_NN(i).TENNV || ' - THANGTK: ' ||
                                                  o_v_NV_NN(i).THANGTK || ' - NAMTK: ' ||
                                                    o_v_NV_NN(i).NAMTK || ' - NGAYNGHI: ' ||
                                                  o_v_NV_NN(i).SONGAYNGHI);
    end loop;
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE('Data Not Found');
end;


set serveroutput on;
begin
    MINNN_TT(&THANGTK);
end;

--7

create type my_NV_QL is object (MANV char(6), TENNV nvarchar2(10), MANQL char(6), TENNQL nvarchar2(10), TENCV nvarchar2(30), HESOLUONG FLOAT);
create type my_table_NV_QL is table of my_NV_QL;
drop type  my_NV_QL;
drop type  my_table_NV_QL;

create or replace PROCEDURE NV_QL(
    i_v_MANV char
)
as     
    o_v_NV_QL my_table_NV_QL;
begin

    select my_NV_QL(NV1.MANV, NV1.TENNV, NV2.MANQL, NV2.TENNV, CV.TENCV, HSL.HESOLUONG) bulk collect
    into o_v_NV_QL
    FROM NHANVIEN NV1 LEFT JOIN NHANVIEN NV2 ON NV1.MANQL = NV2.MANV, BANGHESOLUONG HSL, CHUCVU CV
    where NV1.MAHESOLUONG=HSL.MAHESOLUONG 
    and NV1.MACV= CV.MACV
    and NV1.MANV=i_v_MANV;
    
    for i in 1..o_v_NV_QL.count
    loop
         DBMS_OUTPUT.PUT_LINE(o_v_NV_QL(i).MANV || ' - TENNV: ' || 
                                                 o_v_NV_QL(i).TENNV || ' - MANQL: ' ||
                                                  o_v_NV_QL(i).MANQL || ' - TENNQL: ' ||
                                                  o_v_NV_QL(i).TENNQL || ' - CVNV: ' ||
                                                  o_v_NV_QL(i).TENCV || ' - HSLNV: ' ||
                                                  o_v_NV_QL(i).HESOLUONG);
    end loop;
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE(N'Không tìm th?y d? li?u');
end;

set serveroutput on;
begin
    NV_QL(&MANV);
end;

--8.
create type my_NV_PB is object (MANV char(6), TENNV nvarchar2(10), GIOITINH nvarchar2(3), NGAYSINH date, SOBHXH nvarchar2(10), MAPHONG nvarchar2(5));
create type my_table_NV_PB is table of my_NV_PB;

create or replace PROCEDURE TRACUUNVPB(
    i_v_MAPHONG char
)
as     
    o_v_NV_PB my_table_NV_PB;
begin

    select my_NV_PB(NV.MANV, NV.TENNV, GIOITINH, NGAYSINH, SOBHXH, PB.MAPHONG) bulk collect
    into o_v_NV_PB
    from NHANVIEN NV, PHONGBAN PB
    where NV.MAPHONG=PB.MAPHONG
    and PB.MAPHONG= i_v_MAPHONG;
    
    for i in 1..o_v_NV_PB.count
    loop
         DBMS_OUTPUT.PUT_LINE(o_v_NV_PB(i).MANV || ' - TENNV:' || 
                                                   o_v_NV_PB(i).TENNV || ' -GIOITINH: ' ||
                                                   o_v_NV_PB(i).GIOITINH || ' -NGAYSINH: ' ||
                                                   o_v_NV_PB(i).NGAYSINH || ' - SOBHXH:' ||
                                                   o_v_NV_PB(i).SOBHXH || ' -MAPHONG: ' ||
                                                   o_v_NV_PB(i).MAPHONG);
    end loop;
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE('Data Not Found');
end;

set serveroutput on;
begin
   TRACUUNVPB(&MAPB);
end;

--9. 

create or replace PROCEDURE TRACUUTTTP_PB
(
    i_v_MAPB char
)
as

    v_MAPB PHONGBAN.MAPHONG%TYPE;
    v_TENPHONG PHONGBAN.TENPHONG%TYPE;
    v_TRUONGPHONG PHONGBAN.TRUONGPHONG%TYPE;
    v_TENNV NHANVIEN.TENNV%TYPE;
    v_GIOITINH NHANVIEN.GIOITINH%TYPE;
    v_TRINHDOHV HOCVAN.TRINHDOHV%TYPE;
    v_TRINHDOCM CHUYENMON.TRINHDOCM%TYPE;

    CURSOR c_PBQL IS
        select PB.MAPHONG, PB.TENPHONG, PB.TRUONGPHONG, NV.TENNV, NV.GIOITINH, HV.TRINHDOHV, CM.TRINHDOCM
        from PHONGBAN PB, NHANVIEN NV, HOCVAN HV, CHUYENMON CM
        WHERE  NV.MAPHONG=PB.MAPHONG and NV.MAHV=HV.MAHV and CM.MACM=NV.MACM
        and PB.TRUONGPHONG=NV.MANV
        and PB.MAPHONG=i_v_MAPB;
begin
        open c_PBQL;
        loop
            FETCH c_PBQL into v_MAPB, v_TENPHONG, v_TRUONGPHONG, v_TENNV, v_GIOITINH, v_TRINHDOHV, v_TRINHDOCM;
            EXIT WHEN c_PBQL%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_MAPB || ' - TENPHONG: ' || v_TENPHONG || ' - MATP: ' || v_TRUONGPHONG || ' - TENTP: ' || v_TENNV || ' - GIOITINH: ' || v_GIOITINH || ' - TRINHDOHV: ' || v_TRINHDOHV || ' - TRINHDOCM: ' || v_TRINHDOCM);
        End loop;
        close c_PBQL;
        EXCEPTION
        when others then
             DBMS_OUTPUT.PUT_LINE(N'Data Not Found');
end;


set serveroutput on;
begin
    TRACUUTTTP_PB(&MAPB);
end;

--10.
create or replace PROCEDURE THEMCVMOI(
    i_v_MACV char,
    i_v_TENCV char
)
as
begin

    insert into CHUCVU
    VALUES (i_v_MACV,  i_v_TENCV);
    DBMS_OUTPUT.PUT_LINE('CHUC VU DA DUOC THEM');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE('TAO CHUC VU THAT BAI');
end;

set serveroutput on;
begin
    THEMCVMOI(&MACV, &TENCV);
end;

--11 Tao Hop Dong cho NV moi

create or replace PROCEDURE HOPDONGMOI(
    i_v_MAHD char,
    i_v_MANV char,
    i_v_NGAYKY date,
    i_v_HANHD char,
    i_v_TRANGTHAI char,
    i_v_LUONGHD float,
    i_v_MALHD char
)
as
begin

    insert into HOPDONG
    VALUES (i_v_MAHD,  i_v_MANV, i_v_NGAYKY, i_v_HANHD, i_v_TRANGTHAI, i_v_LUONGHD, i_v_MALHD);
    DBMS_OUTPUT.PUT_LINE(N'Hop Dong Da Duoc Ki');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE(N'Hp Dong Khong Duoc Ki');
end;

set serveroutput on;
begin
    HOPDONGMOI(&MAHD, &MANV, &NGAYKI, &HANHD, &TRANGTHAI, &LUONGHD, &MALHD);
end;

--12
create or replace PROCEDURE PHONGBANMOI(
    i_v_MAPHONG char,
    i_v_TENPHONG char
)
as
begin

    insert into PHONGBAN
    VALUES (i_v_MAPHONG, i_v_TENPHONG,NULL);
    DBMS_OUTPUT.PUT_LINE(N'DA TAO PHONG BAN MOI');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE(N'TAO PHONG BAN THAT BAI');
end;

set serveroutput on;
begin
  PHONGBANMOI(&MAPHONG, &TENPHONG);
end;

--13 Xoa Hop Dong

create or replace PROCEDURE XOAHD(
    i_v_MAHD char
)
as
begin

    DELETE FROM HOPDONG
    where MAHD=i_v_MAHD;
    DBMS_OUTPUT.PUT_LINE(N'Hop Dong Da Duoc Xoa');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE(N'Xoa That Bai');
end;

set serveroutput on;
begin
  XOAHD(&MAHD);
end;

--14

create or replace PROCEDURE XOANV(
    i_v_MANV char
)
as
begin

    DELETE FROM NHANVIEN
    where MANV=i_v_MANV;
    DBMS_OUTPUT.PUT_LINE(N'Nhan Vien Da Duoc Xoa');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE(N'Xoa That Bai');
end;

set serveroutput on;
begin
  XOANV(&MANV);
end;

--15.

create or replace package THUENV as

    procedure TUYEN_NV(
        i_v_MANV char,
        i_v_HONV char,
        i_v_TENNV char,
        i_v_GIOITINH char,
        i_v_NGAYSINH date,
        i_v_SOBHXH char, 
        i_v_MACV char,
        i_v_MANQL char,
        i_v_MAPHONG char,
        i_v_MAHESOLUONG char,
        i_v_MAHV char,
        i_v_MACM char,
        i_v_MALOAINV char
    );
    procedure KI_HD(
        i_v_MAHD number,
        i_v_MANV char,
        i_v_NGAYKI date,
        i_v_HANHD char,
        i_v_TRANGTHAI char,
        i_v_LUONGHD float,
        i_v_MALOAIHD char
    );
End THUENV;

/

create or replace PACKAGE body THUENV as
    
    procedure TUYEN_NV
    (
        i_v_MANV char,
        i_v_HONV char,
        i_v_TENNV char,
        i_v_GIOITINH char,
        i_v_NGAYSINH date,
        i_v_SOBHXH char, 
        i_v_MACV char,
        i_v_MANQL char,
        i_v_MAPHONG char,
        i_v_MAHESOLUONG char,
        i_v_MAHV char,
        i_v_MACM char,
        i_v_MALOAINV char
    )
    as
    
    begin
        insert into NHANVIEN
        values(i_v_MANV, i_v_HONV, i_v_TENNV, i_v_GIOITINH, i_v_NGAYSINH, i_v_SOBHXH, i_v_MACV, i_v_MANQL, i_v_MAPHONG, i_v_MAHESOLUONG, i_v_MAHV, i_v_MACM, i_v_MALOAINV);
    EXCEPTION
        when others then
             DBMS_OUTPUT.PUT_LINE(N'Nhan Vien Khong Duoc Tuyen');
    end TUYEN_NV;
    
     procedure KI_HD
    (
       i_v_MAHD number,
        i_v_MANV char,
        i_v_NGAYKI date,
        i_v_HANHD char,
        i_v_TRANGTHAI char,
        i_v_LUONGHD float,
        i_v_MALOAIHD char
    )
    as
    
    begin
        insert into HOPDONG
        values(i_v_MAHD, i_v_MANV, i_v_NGAYKI, i_v_HANHD, i_v_TRANGTHAI, i_v_LUONGHD, i_v_MALOAIHD);
    EXCEPTION
        when others then
             DBMS_OUTPUT.PUT_LINE(N'Hop Dong Khong Duoc Ki');
    end KI_HD;
End THUENV;

set serveroutput on;

begin
   THUENV.TUYEN_NV(&MANV, &HONV, &TENNV, &GIOITINH, &NGAYSINH, &SOBHXH, &MACV, &MANQL, &MAPHONG, &MAHESOLUONG, &MAHV, &MACM, &MALOAIHV);
end;

set serveroutput on;

begin
    THUENV.KI_HD(&MAHD, &MANV, &NGAYKI, &HANHD, &TRANGTHAI, &LUONGHD, &MALHD);
end;

--16
create or replace PROCEDURE CAPNHATTTNV(
    i_v_MANV CHAR,
    i_v_HONV CHAR,
    i_v_TENNV CHAR,
    i_v_GIOITINH CHAR,
    i_v_NGAYINH DATE,
    i_v_SOBHXH CHAR

)
as
 
begin

    update NHANVIEN
    set HONV=i_v_HONV, TENNV=i_v_TENNV, GIOITINH=i_v_GIOITINH, NGAYSINH=i_v_NGAYINH, SOBHXH=i_v_SOBHXH
    where MANV=i_v_MANV;
    DBMS_OUTPUT.PUT_LINE(N'THONG TIN DA DUOC CHINH SUA');
    EXCEPTION
    when no_data_found then
             DBMS_OUTPUT.PUT_LINE(N'CAP NHAT THONG TIN THAT BAI');
end;

set serveroutput on;
begin
   CAPNHATTTNV(&MANVCANCAPNHAT, &HONV, &TENNV, &GIOITINH, &NGAYSINH, &SOBHXH);
end;

--17

create or replace PROCEDURE XOAPB(
    i_v_MAPB char
)
as
begin

    DELETE FROM PHONGBAN
    where MAPHONG=i_v_MAPB;
    DBMS_OUTPUT.PUT_LINE(N'Phong Ban Da Duoc Xoa');
    EXCEPTION
    when others then
             DBMS_OUTPUT.PUT_LINE(N'Xoa That Bai');
end;

set serveroutput on;
begin
  XOAPB(&MAPHONG);
end;