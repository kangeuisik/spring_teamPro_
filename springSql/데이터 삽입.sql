DECLARE
    I NUMBER(5); 
BEGIN
    -- 언어 / 영어 
    FOR i IN 1 .. 22
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName)
        VALUES (bookNo_seq.NEXTVAL,'language','english', '영어책-'||I); 
    END LOOP; 
    
    -- 언어 / 일본어 
    FOR i IN 1 .. 21
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName)
        VALUES (bookNo_seq.NEXTVAL,'language','japanese', '일본어책-'||I); 
    END LOOP; 
    
    -- 언어 / 중국어 
    FOR i IN 1 .. 27
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName)
        VALUES (bookNo_seq.NEXTVAL,'language','chinese', '중국어책-'||I); 
    END LOOP;     
    
    -- 자연과학 / 물리학
    FOR i IN 1 .. 29
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName)
        VALUES (bookNo_seq.NEXTVAL,'natural_science','physics', '물리학책-'||I); 
    END LOOP;     
END;