create or replace trigger trg_TinhTongNgayNghi
for insert or update on CHAMCONG
compound trigger
    v_old_MACC CHAMCONG.MACC%TYPE;
    v_new_MACC CHAMCONG.MACC%TYPE;
    v_old_MANV CHAMCONG.MANV%TYPE;
    v_new_MANV CHAMCONG.MANV%TYPE;
    v_TONGNGAYNGHI number(3):=0;
after each row is
begin
    if INSERTING THEN
        v_old_MACC:= null;
        v_new_MACC:= :new.MACC;
        v_old_MANV:=null;
        v_new_MANV:=:new.MANV;
    end if;
    if UPDATING then
        v_old_MACC:= :old.MACC;
        v_new_MACC:= :new.MACC;
        v_old_MANV:= :old.MANV;
        v_new_MANV:=:new.MANV;
    end if;
    
end after each row;

after statement is
begin
    select sum(NGAY_1+NGAY_2+NGAY_3+NGAY_4+NGAY_5+NGAY_6+NGAY_7+NGAY_8+NGAY_9+NGAY_10+NGAY_11+NGAY_12+NGAY_13+NGAY_14+NGAY_15+NGAY_16+NGAY_17+NGAY_18+NGAY_19+NGAY_20+NGAY_21+NGAY_22+NGAY_23+NGAY_24+NGAY_25+NGAY_26+NGAY_27+NGAY_28+NGAY_29+NGAY_30+NGAY_31)
    into v_TONGNGAYNGHI
    from CHAMCONG CHC INNER JOIN THONGKECHAMCONG TKCC ON CHC.MACC=TKCC.MACC
    where CHC.MACC=v_old_MACC or CHC.MACC=v_new_MACC;
    
    update THONGKECHAMCONG
    set SONGAYNGHI=v_TONGNGAYNGHI
    where MACC=v_old_MACC or MACC=v_new_MACC;
end after statement;
end;

--------

create or replace trigger trg_TinhNgayDiLam
for insert or update of SONGAYNGHI on THONGKECHAMCONG
compound trigger
    v_old_MACC THONGKECHAMCONG.MACC%TYPE;
    v_new_MACC THONGKECHAMCONG.MACC%TYPE;
    v_old_THANG THONGKECHAMCONG.THANGTK%TYPE;
    v_new_THANG THONGKECHAMCONG.THANGTK%TYPE;
    v_NGAYDILAM number(3):=0;
after each row is
begin
    if INSERTING THEN
        v_old_MACC:= null;
        v_new_MACC:= :new.MACC;
        v_old_THANG:=null;
        v_new_THANG:=:new.THANGTK;
    end if;
    if UPDATING then
        v_old_MACC:= :old.MACC;
        v_new_MACC:= :new.MACC;
        v_old_THANG:= :old.THANGTK;
        v_new_THANG:=:new.THANGTK;
    end if;
    
end after each row;

after statement is
begin
case when v_new_THANG=1 or v_old_THANG=1 then
    select sum(31-SONGAYNGHI)
    into v_NGAYDILAM
    from THONGKECHAMCONG
    where MACC=v_old_MACC or MACC=v_new_MACC;
    
    update THONGKECHAMCONG
    set SONGAYDILAM=v_NGAYDILAM
    where MACC=v_old_MACC or MACC=v_new_MACC;
    
 when v_new_THANG=2 or v_old_THANG=2 then
    select sum(29-SONGAYNGHI)
    into v_NGAYDILAM
    from THONGKECHAMCONG
    where MACC=v_old_MACC or MACC=v_new_MACC;
    
    update THONGKECHAMCONG
    set SONGAYDILAM=v_NGAYDILAM
    where MACC=v_old_MACC or MACC=v_new_MACC;
end case;
end after statement;
end;


-----



