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
,totalpurchase      number default 0         -- 누적구매금액
,point              number default 0         -- 포인트
,fk_memberlevel     varchar2(1)  default '1' not null    -- 등급
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             varchar2(1) default '1' not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               varchar2(1) default '0' not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중
,adagreements       varchar2(1) default '0' not null     -- 마케팅동의여부      1 : 동의  /  0 : 비동의
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in('0','1') )
,constraint CK_tbl_member_idle check( idle in('0','1') )
,constraint CK_tbl_member_adagreements check( idle in('0','1') )
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
(memberlevel    number(1)  -- 1이면 sliver, 2이면 gold, 3이면 platinum
,levelname      varchar2(20) not null
,pointpct       number(1,2)  not null  -- 0.01, 0.02, 0.03
,constraint PK_tbl_memberlevel primary key(memberlevel)
);

select *
from tbl_member;

select *
from tbl_loginhistory;

select *
from tbl_memberlevel;


insert into tbl_memberlevel(memberlevel,levelname,pointpct)
values(1,'sliver','0.01');
insert into tbl_memberlevel(memberlevel,levelname,pointpct)
values(2,'gold','0.03');
insert into tbl_memberlevel(memberlevel,levelname,pointpct)
values(3,'platinum','0.05');

commit;

delete tbl_member where userid='test';
commit;

alter table tbl_member add  
commit;

drop table tbl_member purge;
drop table tbl_loginhistory purge;
drop table tbl_memberlevel purge;


ALTER TABLE tbl_member MODIFY fk_memberlevel varchar(20) default 'sliver';
COMMIT;


select trunc((sysdate-lastpwdchangedate)/60)
from tbl_member
where userid='test';

update tbl_member set lastpwdchangedate='19/12/12'
where userid='test';



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


commit;



select *
from tbl_member;

select *
from tbl_proddetail;

select *
from tbl_product;

select *
from tbl_faq;

commit;

--drop table tbl_faq purge;
create table tbl_faq
(faqNo    number(5) not null
,faqtitle   varchar2(150) not null
,faqcontent varchar2(2000) not null
,fk_fcNo  number(2) not null
,constraint  PK_tbl_faq primary key(faqNo)
,constraint FK_tbl_faqcategory_fk_fcNo foreign key(fk_fcNo) references tbl_faqcategory (fcNo)
);

--drop table tbl_faqcategory purge;
create table tbl_faqcategory 
(fcNo    number(2) not null
,fcname varchar2(30) not null
,fccode  varchar2(10) not null
,constraint  PK_tbl_faqcategory primary key(fcNo)
,constraint UQ_tbl_faqcategory_fcname unique(fcname)
,constraint UQ_tbl_faqcategory_fccode unique(fccode)
);

create sequence seq_faq_faqNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_faqcategory_fcNo
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

DROP SEQUENCE seq_faqcategory_fcNo;
DROP SEQUENCE seq_faq_faqNo;

insert into tbl_faqcategory(fcNo, fcname, fccode) values(seq_faqcategory_fcNo.nextval, '입금결제', 'payment');
insert into tbl_faqcategory(fcNo, fcname, fccode) values(seq_faqcategory_fcNo.nextval, '배송관련', 'shipping');
insert into tbl_faqcategory(fcNo, fcname, fccode) values(seq_faqcategory_fcNo.nextval, '반품/교환', 'exchange');
insert into tbl_faqcategory(fcNo, fcname, fccode) values(seq_faqcategory_fcNo.nextval, '배송 전 변경/취소', 'cancel');
insert into tbl_faqcategory(fcNo, fcname, fccode) values(seq_faqcategory_fcNo.nextval, '기타문의', 'acc');
commit;

select fcNo, fcname, fccode
from tbl_faqcategory
order by fcNo asc ;

ALTER TABLE tbl_faq MODIFY faqtitle VARCHAR2(150);


insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '카드취소 했는데 카드사에서는 취소가 되지 않았어요.', '카드결제의 경우 고객님의 주문건에 대한 환불금액을 카드취소 요청 하더라도, 카드대행사를 통해 승인취소가 고객님의 카드사로 전달되는 과정을 거치기 때문에, 정상적인 환불완료까지는 카드사영업일 기준으로 3-5일 정도가 소요됩니다. (공휴일제외)
이로 인해, 소요되는 기간 내 에 고객님의 결제대금 확정 일이 포함되는 경우 카드 청구서에 해당 금액이 포함되어 나올 수 있습니다. 청구된 금액은 지불을 하시더라도 카드사의 정책에 따라 익월 고객님의 청구서에서 차감되거나 환불 진행되므로 참고 부탁 드립니다.
자세한 환불 관련된 내용은 개인정보 보호법상 본인확인 절차를 거친 뒤에 확인이 가능하여 고객님의 카드사로 직접 문의 주시면 자세하고 정확하게 안내 받으실 수 있습니다.', '1');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '결제 방식을 변경하고 싶어요.', '죄송하게도 결제 방식의 변경은 가능하지 않습니다.
따라서 결제 방식을 변경 하고자 할 경우엔 취소 후 재 주문해 주시기 바랍니다.
다만, 취소 후 재주문하는 과정에서 구매하시고자 하는 상품이 품절될 수 있으니 최초 주문 단계에서 원하시는 결제 방식을 정확히 선택하여 주시기 바랍니다.', '1');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '주문자와 입금자 이름이 달라요.', '주문자와 입금자명이 다를 경우 자동으로 입금 확인이 불가능 하기 때문에, "입금자명,입금액,입금일,입금은행"을 확인하시어 고객센터로 연락 주시기 바랍니다.', '1');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '입금했는데 입금확인이 되지 않아요.', '결제방식이 무통장 입금인 경우 주문시 기재해 주신 정보와 100% 일치한 경우에만 자동으로 확인 가능합니다. (확인까지 입금 후 1~2시간 소요)
만일 기재하신 정보와 다른 내용으로 입금 하신 경우,
자동으로 입금 확인이 가능하지 않아 수기로 확인해야 하니 "입금자명, 입금액, 입금일, 입금은행명"을 기재하시어 고객센터로 연락 주시기바랍니다.', '1');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '상품을 여러 개 주문했는데 상품마다 배송비가 결제됐어요.', '배송비 부과 기준은 주문번호 입니다.
따라서 동일 ID로 다수의 상품을 따로따로 주문하여 주문번호가 별도로 생성된 경우엔, 주문번호마다 배송료가 부과됩니다. 또한, 무료배송비의 혜택도 주문번호당 실 결제 금액이 5만원 이상인 경우에만 제공되므로 다수의 상품을 구매하고자 하실 때에는 해당 상품을 장바구니로 이동 후, 한번에 결제하여 주시기 바랍니다.
다수의 상품을 각각 주문하여 각 주문번호마다 배송료가 부과된 경우 게시판에 문의 주시면 고객센터 확인 후 묶음 배송 가능여부를 확인하실 수 있습니다.', '1');
commit;


insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '택배를 받았는데 상품이 누락되거나 분실 된 것 같아요.', '1. 다음의 경우엔 분실 가능성이 있으니 고객센터로 연락 주시기 바랍니다.<br>
1) 마이 페이지에서 전 상품 모두 "배송 중" 또는 "배송완료"로 표기된 경우<br>
2) 상품을 수령하지 못하였는데, 운송장 조회 결과가 3일이 지나도록 운송장 조회 결과가 업데이트 되지 않는 경우<br><br>

2. 상품 누락 또는 일부 분실로 추정되는 경우<br>
1) 액세서리와 같은 작은 상품은 함께 주문하신 옷에 부착되어 있거나 별도로 포장하여 박스 안쪽에 위치해 있을 가능성이 높으니, 함께 주문하신 상품과 박스 안을 다시 한번 확인하여 주시기 바랍니다.<br>
2) 위 1)의 방법으로도 주문하신 상품이 확인되지 않는다면, CCTV 영상 확인하여 택배사의 분실로 추정될 경우 택배사와의 협의를 통해 고객님께서 피해가 발생하지 않도록 조치하고 있습니다.<br><br>

3. 택배사의 분실로 추정되는 경우<br>
택배사의 분실 사고로 상품을 일절 받아보시지 못 한 경우. CJ대한통운택배에 분실 접수 후 반하루 고객센터로 연락 주시기 바랍니다.', '2');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '배송 메세지에 옵션, 주소 바꿔달라고 했는데 변경이 안됐어요.', '배송메시지는 택배기사님께서 배송시 참고 하시는 항목으로 반하루에서는 별도로 확인 하지 않습니다.<br>따라서 상품, 주소, 연락처 변경 등의 조치가 필요한 경우엔 꼭 반하루 게시판이나 고객센터로 연락 주셔야 변경 가능합니다.', '2');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '주문한 상품 중에 일부만 받았어요.', '1. 고객센터로 연락주시지 않아도 되는 경우<Br>
주문 후 배송을 기다리고 계실 고객님의 마음을 너무나 잘 알기에, 우선 준비된 상품만 먼저 발송하여 드렸습니다. 배송되지 않은 상품은 준비되는 즉시 꼼꼼히 검수하여 발송될 예정이니 고객님의 양해를 부탁 드립니다. 이 경우 마이 페이지에서 일부 상품만 "배송중" 또는 "배송 완료"로 표기됩니다.<br><br>

2. 고객센터로 연락 주셔야 하는 경우<br>
마이 페이지에서 전 상품 모두 "배송 중" 또는 "배송완료" 로 표기된 경우엔 상품 분실일 수 있으니, 반드시 게시판이나 고객센터로 문의 주시기 바랍니다.', '2');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '주문한 상품을 받지 못했는데 배송완료라고 표시됩니다.', '간혹 여러 사유로 (고객 부재 등) 택배사에서 배송완료를 먼저 입력한 후, 실제로는 그 다음날 배송하는 경우가 있습니다. 이 경우 운송장 번호 조회 시 확인되는 담당 택배 기사님께 문의하시면 정확한 배송 일정을 확인하실 수 있습니다.', '2');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '여러 상품을 따로 따로 주문했는데 묶음배송 가능한가요?', '게시판이나 고객센터로 연락 주시면 묶음배송 가능 여부 확인 후에 안내 드리겠습니다.', '2');
commit;

insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '모든 상품이 교환 및 반품이 가능한가요?', '저희는 전자상거래 등에서의 소비자 보호에 관한 법률" 에 따라 교환 및 반품이 가능한 쇼핑몰입니다.<br>
소비자가 통상적인 주의력을 갖고도 하자를 확인하기 어려운 상태에서 상품을 착용,수선,세탁한 경우에는 청약철회가 가능합니다.(법 제17조 제3항)<br><br>

단, 위 법률에 의거하여 다음의 경우엔 교환 및 반품이 가능하지 않습니다.<br><br>

1. 소비자에게 책임 있는 사유로 재화 등이 멸실 되거나 훼손된 경우<br>
2. 시간이 지나 다시 판매하기 곤란 할 정도로 재화 등의 가치가 현저히 감소한 경우<br>
3. 소비자의 사용 또는 일부 소비로 재화 등의 가치가 현저히 감소한 경우<br><br>

*단, 재화 등의 내용 확인을 위해 포장을 훼손한 경우는 제외 됨<br>
*대량 생산으로 인해 미세한 실밥 및 본드자국은 불량으로 처리 불가하십니다.<br>
상세 문의는 고객센터로 연락 주시기 바랍니다.', '3');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '주문 취소하였는데 신용카드 대금이 청구되었어요.', '카드결제의 경우 반하루에서 결제 취소를 하더라도 해당 카드사의 전산에 반영까지 평균 3~5일 정도가 소요됩니다. (영업일 기준) 
따라서 반하루에서는 결제 취소가 되었더라도 카드 청구서에 내역이 포함될 수 있으며, 이 경우 그 다음달 카드 청구서에서 상계처리 되오니 관련 상세내용은 해당 카드사로 문의해 주시기 바랍니다.<br><br>

* 개인정보보호법에 따라 카드사를 포함한 금융거래와 관련된 상담은 명의자 본인만 가능', '3');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '교환/반품시 배송비는 어떻게 되나요?', '1.교환 배송비<br>
단순 변심에 의한 교환: 왕복 배송비 5,000원<br><br>

2.반품 배송비 [실결제금액기준]<br>
1)단순 변심에 인한 전체 반품일 경우 5,000원<br>
2)단순 변심에 인한 부분 반품일 경우<br>
*구매 확정상품이 5만원 미만일 경우 5,000원<br>
*구매 확정상품이 5만원 이상일 경우 2,500원<br><br>

3.상품 하자 또는 오배송의 의한 교환/반품 : 반하루 부담<br><br>

◆저희 반하루의 계약택배는 CJ대한통운택배이며, 그 외 택배로 보내주실경우 선불로 꼭 접수 부탁드립니다.
*불량 및 오배송이더라도 타택배 이용시 선불로 접수 하여 보내주세요', '3');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '반품 했는데 환불 처리가 되지 않았어요.', '1. CJ대한통운택배로 반송한 경우<br>
수거된 상품을 처리 부서에 전달하고 검수 및 고객 정보 확인 후에 환불 처리를 진행하므로, 수거일로부터 실제 처리 완료까지 평균 3일 정도의 시간이 소요됩니다. (영업일 기준)<br><br>

2. 타사 택배로 반송한 경우 ( CJ대한통운택배가 아닌 경우 )<br>
저희와 계약된 CJ대한통운택배가 아닌 다른 택배사를 이용하신 경우(편의점 택배 포함), 운송장 번호로 확인되는 수거일로부터 실제 반하루의 상품 인계까지 평균 일주일의 시간이 소요됩니다. 따라서 실제 처리 완료까지는 최소 일주일 이상의 시간이 소요되오니, 그 때까지 시간 양해 부탁 드리며 가급적 CJ대한통운택배를 이용하여 반송해 주시기 바랍니다.', '3');
commit;

insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '배송전 주문취소하고 싶어요.', '주문/결제 완료후 취소를 원하실경우 주문서 상태가 입금전일 경우에만 고객님이 직접 주문취소가 가능하시며, 결제완료되어 배송 준비중 단계로 넘어가게 되면 직접 주문취소가 불가능하기 때문에 고객센터(☎1544-6105) 또는 게시판 배송전 취소/변경 문의글로 요청사항 남겨주시면 확인후 안내 도움드리겠습니다.단, 주문상태는 발송준비중이나, 이미 포장단계를 거쳐 택배사로 넘어간경우 배송전 주문건 취소 및 변경이 불가하십니다.', '4');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '주문 상품이 아직 배송전인데 다른 상품으로 교환하고 싶어요.', '결제 완료와 동시에 상품 및 배송 준비 작업을 진행하게 됩니다.<br>
다만, 실제 작업 중인 내용이 전산에 반영되기까지 다소의 시간 차가 있어 실제로는 상품이 배송되었어도 마이 페이지에서는"상품 준비중"으로 표기될 수 있습니다.<br>
따라서 배송 전, 상품 변경 및 교환을 하고자 하실 경우 게시판 문의글을 남겨 주시거나 고객센터로 연락 주시면 상세히 답변 드리겠습니다.', '4');
commit;

insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '전화상담이 안되는 데 어떻게 하나요?', '고객님의 문의가 많아서 전화연결이 어려우실 경우에는 게시판으로 문의 해주시면 실시간으로 답변 드리고 있습니다.<br>
상담시간 : AM 10:00 - PM 04:00 점심시간 : PM 12:00 - PM 13:00 / 주말, 공휴일 휴무', '5');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '가방냄새가 너무많이나요 이유가뭔가요?', '전 제품은 주문 들어온 후 주문제작으로 즉시 생산후 고객님에게 바로 발송 되기 때문에 제품에따라 합성피혁의 냄새가 더 나실수있습니다.', '5');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '품절 연락을 받았어요.', '먼저 품절로 불편드려 죄송합니다.<br>
재고를 두고 판매하지 않는 방식으로, 고객님들께서 주문/결제 해주신 그 다음날부터 상품준비에 들어갑니다.<br>
갑자기 거래처 사정에 의해 품절되는 경우가 부득이하게 생길 수 있으며, 품절될경우 고객님께 바로 연락을 드리고 있습니다. 품절된 상품은 다른 상품으로 교환 혹은 환불등 요청하시는 대로 처리해드리고 있습니다.', '5');
insert into tbl_faq(faqNo, faqtitle, faqcontent,fk_fcNo) 
values(seq_faq_faqNo.nextval, '현금영수증 신청은 어떻게 하나요?', '현금영수증 신청은 현금결제만 신청가능하며, 고객센터/게시판으로 사업자번호, 핸드폰번호 와 함께 신청해 주시면 발행 가능 합니다. 배송 완료된 상태에서만 신청이 가능하며 현금 영수증 발행 기간은 상품 수령 후 일주일 후 입니다.', '5');

commit;

select fccode, fcname,  faqNo, faqtitle, faqcontent, fk_fcNo
from tbl_faq JOIN tbl_faqcategory
where fk_fcNo = 1;