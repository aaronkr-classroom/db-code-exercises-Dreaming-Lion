/*
[Entities / 개체]
- Professor

[Properties / 속성]
- id				 (BIGSERIAL) -- 자동으로 증가하는 숫자
- name				 (VARCHAR(30))
- dept 				 (VARCHAR(50))
- salary			 (NUMBERIC)
- salary_level 		 (NUMBERIC)
- hire_date 		 (DATE) -- 'YYYY-MM-DD'
*/

CREATE TABLE prof(
	id bigserial,
	name varchar(30),
	dept varchar(50),
	salary numeric,
	salary_level numeric,
	hire_date date
);


TABLE prof

-- 데이터 삽입하기
INSERT INTO prof (name, dept, salary, salary_level, hire_date)
VALUES ('김정운', '컴퓨터공학', 100000, 2, '1998-12-31'),
	   ('박지선', 'AI공학', 70000, 1, '2001-3-1'),
	   ('이재삭', '정보통신공학', 80000, 1, '2003-4-1'),
	   ('류현지', '간호학', 90000, 1, '2004-4-14'),
	   ('양정효', '소프트웨어학', 1000000, 9, '1998-12-31');

-- 데이터 검색하기
SELECT * FROM prof;

SELECT name, salary FROM prof ORDER BY salary DESC; -- ASC

SELECT name, salary FROM prof WHERE salary > 90000;

SELECT name, salary FROM prof WHERE name LIKE '김%' -- PostgreSQL ILIKE : 대/소문자 상관 없음

SELECT name, dept FROM prof WHERE dept LIKE '%공%' ORDER BY dept DESC;

SELECT name, dept FROM prof WHERE dept LIKE '%공%' ORDER BY dept ASC;

SELECT name, SALARY FROM prof WHERE salary BETWEEN 70000 AND 90000;
