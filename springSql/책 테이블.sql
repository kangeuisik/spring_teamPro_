-- 카테고리
drop table book_category CASCADE CONSTRAINTS;
create table book_category(
    cate_id varchar2(1000) PRIMARY KEY,
    cate_name varchar2(1000)
);
drop sequence cate_seq;
create sequence cate_seq;

insert into book_category(cate_id,cate_name) VALUES('language','언어');
insert into book_category(cate_id,cate_name) VALUES('natural_science','자연과학');
commit;
select * from book_category;

-- 서브카테고리
drop table book_subCategory CASCADE CONSTRAINTS;
create table book_subCategory(
    cate_id varchar2(1000),
    subCate_id varchar2(1000) PRIMARY KEY,
    subCate_name varchar2(1000),
    foreign key(cate_id) references book_category(cate_id)
    on delete cascade
);
drop sequence subCate_seq;
create sequence subCate_seq;

insert into book_subCategory(cate_id,subCate_id,subCate_name) VALUES('language','english','영어');
insert into book_subCategory(cate_id,subCate_id,subCate_name) VALUES('language','japanese','일본어');
insert into book_subCategory(cate_id,subCate_id,subCate_name) VALUES('language','chinese','중국어');
insert into book_subCategory(cate_id,subCate_id,subCate_name) VALUES('natural_science','physics','물리학');
commit;
select * from book_subCategory;

-- book 테이블
drop table book_table CASCADE CONSTRAINTS;
create table book_table(
    bookNo NUMBER(10) PRIMARY KEY, -- 책번호
    cate_id VARCHAR2(1000) , -- 카테고리
    subCate_id VARCHAR2(1000), -- 서브카테고리
    bookName VARCHAR2(1000) NOT NULL, -- 책 제목
--    book_writer VARCHAR2(1000), -- 저자
--    publisher VARCHAR2(1000), -- 출판사
--    bookInfo VARCHAR2(4000), -- 책소개
--   price NUMBER(10), -- 판매가격
--    bookImage VARCHAR2(1000), -- 이미지
--    regDate DATE DEFAULT sysdate, -- 등록일
    foreign key(cate_id) references book_category(cate_id),
    foreign key(subcate_id) references book_subCategory(subcate_id)
    on delete cascade
);

drop sequence bookNo_seq;
create sequence bookNo_seq;

commit;
select * from book_table;


select 
    rn, bookNo, cate_id, subCate_id, bookName 
from
(
    select 
        rownum as rn, bookNo, cate_id, subCate_id, bookName
    from 
        book_table
    where rownum <= 10
)
where rn > 0;