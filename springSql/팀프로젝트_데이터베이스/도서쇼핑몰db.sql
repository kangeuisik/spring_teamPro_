-- ī�װ� ���̺�
drop table book_category cascade constraint;
create table book_category(
    cate_id varchar2(1000) PRIMARY KEY, -- ī�װ� ���̵�
    cate_name varchar2(1000) -- ī�װ� �̸�
);

drop sequence cate_seq;
create sequence cate_seq;

insert into book_category(cate_id, cate_name) VALUES('information_technology','IT');
insert into book_category(cate_id, cate_name) VALUES('language','���');
insert into book_category(cate_id, cate_name) VALUES('natural_science','�ڿ�����');
insert into book_category(cate_id, cate_name) VALUES('art','����');

drop table book_subCategory cascade constraint;
create table book_subCategory(
    cate_id varchar2(1000), -- �ܷ�Ű
    subCate_id varchar2(1000) PRIMARY KEY,
    subCate_name varchar2(1000),
    foreign key(cate_id) references book_category(cate_id)
    on delete cascade
);

drop sequence subCate_seq;
create sequence subCate_seq;

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'programming_language', '���α׷��־��');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'database', '�����ͺ��̽�');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'website', '������Ʈ');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'english', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'japanese', '�Ϻ���');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'chinese', '�߱���');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'physics', '������');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'chemistry', 'ȭ��');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'biology', '�������');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'earth_science', '��������');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'building', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'dancing', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'music', '����');

drop table book_table cascade constraint;
create table book_table(
    bookNo NUMBER(10), -- å ��ȣ
    cate_id VARCHAR2(1000) , -- ī�װ�, �ܷ�Ű
    subCate_id VARCHAR2(1000), -- ���� ī�װ�, �ܷ�Ű
    bookName VARCHAR2(1000) NOT NULL, -- å ����
    author VARCHAR2(1000), -- ����
    publisher VARCHAR2(1000),  -- ���ǻ�
    bookImage VARCHAR2(1000), -- ��ǰ �̹���
    price NUMBER(10), -- �ǸŰ���
    take varchar (300), -- �뿩����
    takePrice int not null, --�뿩�ݾ�
    takeDate DATE DEFAULT sysdate, -- �뿩����
    returnDate DATE DEFAULT sysdate+7, -- �ݳ�����
    regDate DATE DEFAULT sysdate, -- ��ǰ �����
    reason varchar(500), --���� ������ ����
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
    cartNo NUMBER(10) PRIMARY KEY, -- īƮ��ȣ
    id varchar(20), -- ȸ�����̵�, �ܷ�Ű
    bookNo NUMBER(10) UNIQUE, -- å ��ȣ, �ܷ�Ű
    amount number(10),
    foreign key(id) references mem_tbl(id),
    foreign key(bookNo) references book_table(bookNo)
);

drop sequence cartNo_seq;
create sequence cartNo_seq;

drop table hopeBook cascade constraint;
create table hopeBook( --��ġ������� ��û ���̺�
   rno int not null, --������ ��û��ȣ
    mno Number(10)not null ,
    id VARCHAR2(1000) not null , 
    name varchar(1000)not null ,-- �����ȣ ��û�ڴ� ���߿� ȸ���ۼ��Ǹ� �ٲ�
    nbookName varchar(500) not null, --�� å�̸� ���Ŀ� �����ʿ�
    nbookWriter varchar(500) not null, -- ��å�� ����
    npublisher varchar(500) not null, -- �� å�� ���ǻ�
    requestDate Date Default sysdate, -- ��û��¥
    result varchar(500), -- ��û��� �Է¹޾ƾ���
    etc varchar(500), -- ���� (������ �����Է¹ޱ�)
    constraint primary_rno primary key(rno),
    constraint fk_mid foreign key(id)
    references mem_tbl(id)
    on delete cascade
);

drop SEQUENCE rno_seq;
create SEQUENCE rno_seq;

insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,1,'jang','�����','ȫ�浿��','���','�뱸��','���δ��','');
insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,2,'kang','���ǽ�','�װ��� �˰�ʹ�','�����','����','���δ��','');
insert into hopeBook(rno,mno,id,name,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,3,'park','�ڼ���','����������','�����','�������ǻ�','���δ��','');

drop table board_category;
create table board_category(
    tid varchar(100) primary key,
    tname varchar(200)not null
);

insert into board_category(tid,tname)values('notice','����');
insert into board_category(tid,tname)values('question','����');
insert into board_category(tid,tname)values('review','����');
insert into board_category(tid,tname)values('etc','��Ÿ');

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
values(bno_seq.nextval,'notice','���������Դϴ�','�����Դϴ�','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�1','�����Դϴ�1','�׽���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�2','�����Դϴ�2','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�3','�����Դϴ�3','�׽���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�','�����Դϴ�','ȸ��1');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�1','�����Դϴ�1','ȸ��2');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�2','�����Դϴ�2','ȸ��3');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�3','�����Դϴ�3','ȸ��4');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�','�����Դϴ�','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�1','�����Դϴ�1','���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�2','�����Դϴ�2','��ҿ�');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�3','�����Դϴ�3','�����');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�','�����Դϴ�','ȫ�浿');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�1','�����Դϴ�1','����ũ');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�2','�����Դϴ�2','�̼���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�3','�����Դϴ�3','���߱�');

commit;