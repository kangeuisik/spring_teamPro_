-- 카테고리 테이블
drop table book_category cascade constraint;
create table book_category(
    cate_id varchar2(1000) PRIMARY KEY, -- 카테고리 아이디
    cate_name varchar2(1000) -- 카테고리 이름
);

drop sequence cate_seq;
create sequence cate_seq;

insert into book_category(cate_id, cate_name) VALUES('information_technology','IT');
insert into book_category(cate_id, cate_name) VALUES('language','언어');
insert into book_category(cate_id, cate_name) VALUES('natural_science','자연과학');
insert into book_category(cate_id, cate_name) VALUES('art','예술');

drop table book_subCategory cascade constraint;
create table book_subCategory(
    cate_id varchar2(1000), -- 외래키
    subCate_id varchar2(1000) PRIMARY KEY,
    subCate_name varchar2(1000),
    foreign key(cate_id) references book_category(cate_id)
    on delete cascade
);

drop sequence subCate_seq;
create sequence subCate_seq;

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'programming_language', '프로그래밍언어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'database', '데이터베이스');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'website', '웹사이트');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'english', '영어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'japanese', '일본어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'chinese', '중국어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'physics', '물리학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'chemistry', '화학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'biology', '생명과학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'earth_science', '지구과학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'building', '건축');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'dancing', '무용');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'music', '음악');

drop table book_table cascade constraint;
create table book_table(
    bookNo NUMBER(10), -- 책 번호
    cate_id VARCHAR2(1000) , -- 카테고리, 외래키
    subCate_id VARCHAR2(1000), -- 하위 카테고리, 외래키
    bookName VARCHAR2(1000) NOT NULL, -- 책 제목
    author VARCHAR2(1000), -- 저자
    publisher VARCHAR2(1000),  -- 출판사
    bookImage VARCHAR2(1000), -- 상품 이미지
    price NUMBER(10), -- 판매가격
    take varchar (300), -- 대여상태
    takePrice int not null, --대여금액
    takeDate DATE DEFAULT sysdate, -- 대여일자
    returnDate DATE DEFAULT sysdate+7, -- 반납일자
    regDate DATE DEFAULT sysdate, -- 상품 등록일
    reason varchar(500), --승인 거절시 사유
     constraint primary_bookNo primary key(bookNo),
    foreign key(cate_id) references book_category(cate_id),
    foreign key(subcate_id) references book_subCategory(subCate_id)
    on delete cascade
);

drop sequence bookNo_seq;
create sequence bookNo_seq;

drop table mem_tbl cascade constraint;
create table mem_tbl(
    mno number(10) primary key, 
    id varchar(20) not null unique,  
    pwd varchar(20) not null,
    name varchar(20) not null,
    age int,
    gender varchar(20),
    email varchar(50),
    profile varchar(50)
);      
DROP SEQUENCE mno;
create sequence mno;

drop table cart_table cascade constraint;
create table cart_table(
    cartNo NUMBER(10) PRIMARY KEY, -- 카트번호
    id varchar(20), -- 회원아이디, 외래키
    bookNo NUMBER(10) UNIQUE, -- 책 번호, 외래키
    amount number(10),
    foreign key(id) references mem_tbl(id),
    foreign key(bookNo) references book_table(bookNo)
);

drop sequence cartNo_seq;
create sequence cartNo_seq;

drop table hopeBook cascade constraint;
create table hopeBook( --비치희망도서 신청 테이블
   rno int not null, --새도서 신청번호
    mno Number(10)not null ,
    id VARCHAR2(1000) not null , 
    name varchar(1000)not null ,-- 멤버번호 신청자는 나중에 회원작성되면 바뀜
    nbookName varchar(500) not null, --새 책이름 차후에 조인필요
    nbookWriter varchar(500) not null, -- 새책의 저자
    npublisher varchar(500) not null, -- 새 책의 출판사
    requestDate Date Default sysdate, -- 신청날짜
    result varchar(500), -- 신청결과 입력받아야함
    etc varchar(500), -- 비고란 (거절시 사유입력받기)
    constraint primary_rno primary key(rno),
    constraint fk_mid foreign key(id)
    references mem_tbl(id)
    on delete cascade
);

drop SEQUENCE rno_seq;
create SEQUENCE rno_seq;

insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,1,'jang','장봉준','홍길동전','허균','대구시','승인대기','');
insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,2,'kang','강의식','그것이 알고싶다','김상중','서울','승인대기','');
insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,3,'park','박성우','수학의정석','김수학','나비출판사','승인대기','');

drop table board_category;
create table board_category(
    tid varchar(100) primary key,
    tname varchar(200)not null
);

insert into board_category(tid,tname)values('notice','공지');
insert into board_category(tid,tname)values('question','문의');
insert into board_category(tid,tname)values('review','리뷰');
insert into board_category(tid,tname)values('etc','기타');

drop table board cascade constraint;
create table board(
    bno int not null,
    tid varchar2(300) not null,
    TITLE VARCHAR2(500) NOT NULL,
    CONTENT VARCHAR2(4000),
    WRITER VARCHAR2(100),
    imageFileName VARCHAR2(100),
    fileType varchar2(500),
    WRITEDATE DATE DEFAULT SYSDATE,
    constraint primary_bno primary key(bno),
    constraint fk_tid foreign key(tid) 
    references board_category(tid)
    on delete cascade
);
drop SEQUENCE bno_seq;
create sequence bno_seq; 

INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다','내용입니다','관리자');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다1','내용입니다1','테스터');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다2','내용입니다2','관리자');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다3','내용입니다3','테스터');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다','내용입니다','회원1');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다1','내용입니다1','회원2');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다2','내용입니다2','회원3');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다3','내용입니다3','회원4');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다','내용입니다','윤동주');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다1','내용입니다1','허균');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다2','내용입니다2','김소월');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다3','내용입니다3','손흥민');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다','내용입니다','홍길동');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다1','내용입니다1','히딩크');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다2','내용입니다2','이순신');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다3','내용입니다3','송중기');

commit;