drop table test_member;
create table test_member(
    mNum NUMBER(10) PRIMARY KEY,
    mid VARCHAR2(1000) NOT NULL UNIQUE, 
    mName VARCHAR2(1000)
);

drop sequence mNum_seq;
create sequence mNum_seq;

INSERT INTO test_member(mNum, mid, mName) VALUES(mNum_seq.NEXTVAL,'hong','홍길동');
INSERT INTO test_member(mNum, mid, mName) VALUES(mNum_seq.NEXTVAL,'lee','이순신');
INSERT INTO test_member(mNum, mid, mName) VALUES(mNum_seq.NEXTVAL,'kim','김유신');

commit;
select * from test_member ;

drop table test_cart;
create table test_cart(
    cartId NUMBER(10) PRIMARY KEY, -- 카트번호
    mid VARCHAR2(1000), -- 회원아이디, 외래키
    bookNo NUMBER(10) UNIQUE, -- 책 번호, 외래키
    foreign key(mid) references test_member(mid),
    foreign key(bookNo) references book_table(bookNo)
);

drop sequence cart_seq;
create sequence cart_seq;

commit;
-- lee회원이 일본어책-3, 영어책-7 장바구니에 담기
INSERT INTO test_cart(cartId, mid, bookNo) VALUES(cart_seq.NEXTVAL,'lee','25');
INSERT INTO test_cart(cartId, mid, bookNo) VALUES(cart_seq.NEXTVAL,'lee','7');
-- kim회원이 중국어책-20 장바구니에 담기
INSERT INTO test_cart(cartId, mid, bookNo) VALUES(cart_seq.NEXTVAL,'kim','63');

select * from test_cart where mid='lee';
select * from test_cart where mid='hong';
select * from test_cart where mid='kim';