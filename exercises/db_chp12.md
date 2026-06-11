# 12장 연습문제

## 개념퍼즐

**가로**

1. CURRVAL
2. ALTERSEQUENCE
3. DROPSEQUENCE
4. CREATEINDEX
10. TRUNCATETABLE
12. ALTERTABLE
13. CREATEVIEW
14. DROPTABLE
15. 임시테이블
16. INSERT
19. 의사열
20. 가상테이블
22. 단순뷰
23. UPDATE

**세로**

1. CREATESEQUENCE
5. DROPVIEW
6. INSERT
7. DELETE
8. CREATETABLE
9. NEXTVAL
11. CHAR
17. SELECT
18. 기본테이블
21. 복합뷰

## 연습문제

1. 4

2.
CREATE TABLE lab (
    lab_num NUMBER(3) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL UNIQUE,
    building VARCHAR2(50) NOT NULL,
    room_id CHAR(4),
    dept_id CHAR(4),
    CONSTRAINT lab_dept_fk FOREIGN KEY (dept_id)
        REFERENCES dept(id)
);

3. 
ALTER TABLE lab
ADD lab_size NUMBER(4) DEFAULT 50;

4.
CREATE INDEX room_id_idx
ON lab(room_id);

5.
INSERT INTO lab(lab_num, name, building, room_id, dept_id)
VALUES (100, '가상현실', '2공학관', 'B203', 'comp');

INSERT INTO lab(lab_num, name, building, room_id, dept_id)
VALUES (110, '인공지능', '2공학관', 'A101', 'comp');

6.
SELECT name, dept_id
FROM lab
WHERE building = '2공학관';

7.
UPDATE lab
SET room_id = 'B102'
WHERE name = '인공지능';

8.
CREATE VIEW com_lab_view AS
SELECT name, room_id, lab_size
FROM lab
WHERE dept_id = 'comp';

9.
CREATE SEQUENCE lab_num_seq
START WITH 120
INCREMENT BY 10
MAXVALUE 990
NOCYCLE
NOCACHE;

10.
INSERT INTO lab(lab_num, name, building, room_id, dept_id)
VALUES (lab_num_seq.NEXTVAL, '네트워크', '2공학관', 'B201', 'comp');

11.
DROP VIEW com_lab_view;
DROP INDEX room_id_idx;
DROP TABLE lab;
DROP SEQUENCE lab_num_seq;
DROP TABLE dept;








