/*
-- dbdiagram.io를 위한 수정하기

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

TABLE Professor{
	professor_id int [PK]
	professor_name varchar
	department varchar
	salary numeric
	salary_level numeric
	hire_date date
}

TABLE Student {
	student_id int [PK]
	student_name varchar
	major varchar
}

TABLE Course {
	course_id int
	section_id int
	professor_id int
	course_name varchar
	indexes {
	 (course_id, section_id) [PK]
	}
}

TABLE Enrollment {
	student_id int
	course_id int
	grade varchar
	point numeric
	enroll_at date
  indexes {
    (student_id, course_id) [PK]
  }
}

Ref: Enrollment.student_id > Student.student_id
Ref: Course.professor_id > Professor.professor_id
