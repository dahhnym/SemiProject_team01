--- *** 회원 테이블 생성 *** ---
create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,gender             varchar2(1)              -- 성별   남자:1  / 여자:2
,birthday           varchar2(10)             -- 생년월일   
,point              number default 0         -- 포인트
,fk_memberlevel     varchar(20)  default 'sliver'   -- 등급
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);

---- *** 로그인 기록을 위한 테이블 생성 *** ----
create table tbl_loginhistory
(fk_userid   varchar2(40) not null 
,logindate   date default sysdate not null
,clientip    varchar2(20) not null
,constraint FK_tbl_loginhistory foreign key(fk_userid) references tbl_member(userid)  
);

--- *** 회원 등급 테이블 *** ---
create table tbl_memberlevel
(memberlevel    varchar2(20) default 'silver'
,pointpct       number(10)  not null
,constraint PK_tbl_memberlevel primary key(memberlevel)
);

select *
from tbl_member;

select *
from tbl_loginhistory;

delete tbl_member where userid='test';
commit;

alter table tbl_member add adagreements varchar2(1) default 0 not null; -- 마케팅동의여부      1 : 동의  /  0 : 비동의 
commit;

drop table tbl_member purge;
drop table tbl_loginhistory purge;

ALTER TABLE tbl_member MODIFY fk_memberlevel varchar(20) default 'sliver';
COMMIT;








--- *** 제품 테이블 생성 *** ---


/*
   카테고리 테이블명 : tbl_category 

   컬럼정의 
     -- 카테고리 대분류 번호  : 시퀀스(seq_category_cnum)로 증가함.(Primary Key)
     -- 카테고리 코드(unique) : ex) 전자제품  '100000'
                                  의류      '200000'
                                  도서      '300000' 
     -- 카테고리명(not null)  : 전자제품, 의류, 도서           
  
*/ 





create table tbl_category
(cnum    number(8)     not null  -- 카테고리 대분류 번호
,code    varchar2(20)  not null  -- 카테고리 코드
,cname   varchar2(100) not null  -- 카테고리명
,constraint PK_tbl_category_cnum primary key(cnum)
,constraint UQ_tbl_category_code unique(code)
);

-- drop sequence seq_category_cnum;
create sequence seq_category_cnum 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 신상품, 인기상품, 세일상품
create table tbl_spec
(snum    number(8)     not null  -- 스펙번호       
,sname   varchar2(100) not null  -- 스펙명         
,constraint PK_tbl_spec_snum primary key(snum)
,constraint UQ_tbl_spec_sname unique(sname)
);


create sequence seq_spec_snum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'HIT');
insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'NEW');
insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'BEST');



---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_cnum        number(8)                -- 카테고리코드(Foreign Key)의 시퀀스번호 참조
,pcompany       varchar2(50)             -- 제조회사명
,pimage1        varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,pimage2        varchar2(100) default 'noimage.png' -- 제품이미지2   이미지파일명 
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)
,fk_snum        number(8)                -- 'HIT', 'NEW', 'BEST' 에 대한 스펙번호인 시퀀스번호를 참조
,pcontent       varchar2(4000)           -- 제품설명  varchar2는 varchar2(4000) 최대값이므로
                                         --          4000 byte 를 초과하는 경우 clob 를 사용한다.
                                         --          clob 는 최대 4GB 까지 지원한다.                                        
,point          number(8) default 0      -- 포인트 점수                                         
,constraint  PK_tbl_product_pnum primary key(pnum)
,constraint  FK_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint  FK_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
);

create sequence seq_tbl_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


---- *** 제품 상세 테이블 : tbl_productdetail *** ----
create table tbl_proddetail
(pdetailnum     number     --  제품상세번호
,fk_pnum        number(8) not null      -- 제품번호
,optionname     varchar2(10) not null   --옵션명
,pqty           number(8) default 0      -- 제품 재고량
,saleqty        number(8) default 0      -- 누적판매량
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_tbl_proddetail_pdetailnum primary key(pdetailnum)
,constraint FK_tbl_proddetail_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);


create sequence seq_tbl_proddetail_pdetailnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



---- *** q&a 테이블 *** -----

--drop table tbl_faq purge;
create table tbl_faq
(faqNo    number(5) not null
,faqtitle   varchar2(15) not null
,faqcontent varchar2(2000) not null
,fk_fcNo  number(2) not null
,constraint  PK_tbl_faq primary key(faqNo)
,constraint FK_tbl_faqcategory_fk_fcNo foreign key(fk_fcNo) references tbl_faqcategory (fcNo)
);

--drop table tbl_faqcategory purge;
create table tbl_faqcategory 
(fcNo    number(2) not null
,fcname varchar2(30) not null
,constraint  PK_tbl_faqcategory primary key(fcNo)
,constraint UQ_tbl_faqcategory_fcname unique(fcname)
);

create sequence seq_faqcategory_fcNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

DROP SEQUENCE seq_faqcategory_fcNo;

insert into tbl_faqcategory(fcNo, fcname) values(seq_faqcategory_fcNo.nextval, '입금결제');
insert into tbl_faqcategory(fcNo, fcname) values(seq_faqcategory_fcNo.nextval, '배송관련');
insert into tbl_faqcategory(fcNo, fcname) values(seq_faqcategory_fcNo.nextval, '반품/교환');
insert into tbl_faqcategory(fcNo, fcname) values(seq_faqcategory_fcNo.nextval, '배송 전 변경/취소');
insert into tbl_faqcategory(fcNo, fcname) values(seq_faqcategory_fcNo.nextval, '기타문의');
commit;



---------------------------------------------------------------------------------------------------------------------
----------------------------------------테이블/시퀀스 생성 끝-----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------


select *
from tbl_faqcategory;

select *
from tbl_member;

select *
from tbl_proddetail;

select *
from tbl_product;

select *
from tbl_faq;



commit;