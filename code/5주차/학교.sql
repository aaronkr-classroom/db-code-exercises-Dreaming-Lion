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

CREATE TABLE Professor(
	professor_id int PRIMARY KEY,
	professor_name varchar(100),
	department varchar(100),
	salary numeric,
	salary_level numeric,
	hire_date date
);

CREATE TABLE Student (
	student_id int PRIMARY KEY,
	student_name varchar(100),
	major varchar(100)
);

 CREATE TABLE Course (
	course_id int,
	section_id int,
	professor_id int,
	course_name varchar(100),
	PRIMARY KEY(course_id, section_id) -- 복합키
	FOREIGN KEY(professor_id) REFERENCES Professor(Professor_id)
);

CREATE TABLE Enrollment (
	student_id int,
	course_id int,
	grade varchar(2),
	point numeric, --99.65
	enroll_at DATE,
	PRIMARY KEY(student_id, course_id),
	FOREIGN KEY(student_id) REFERENCES Student(student_id),
	-- FOREIGN KEY(course_id) REFERENCES Course(course_id) -- course의 복합키 때문에 오류
);
