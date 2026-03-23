/*
====================================================
주제: 동아리 관리 시스템 (PostgreSQL 기준)
====================================================

[1. Entities / Properties 나열]

[Entities / 개체]
- Professor

[Properties / 속성]
- prof_id              (BIGSERIAL) PRIMARY KEY -- 교수 고유 번호
- name                 (VARCHAR(30))           -- 교수 이름
- dept                 (VARCHAR(50))           -- 소속 학과
- salary               (NUMERIC(10,2))         -- 급여
- salary_level         (NUMERIC(3))            -- 급여 등급
- hire_date            (DATE)                  -- 임용일
- email                (VARCHAR(100))          -- 이메일


[Entities / 개체]
- Student

[Properties / 속성]
- std_id               (VARCHAR(20)) PRIMARY KEY -- 학번
- name                 (VARCHAR(30))             -- 학생 이름
- major                (VARCHAR(50))             -- 전공
- grade                (INTEGER)                 -- 학년
- phone                (VARCHAR(20))             -- 연락처
- email                (VARCHAR(100))            -- 이메일


[Entities / 개체]
- Club

[Properties / 속성]
- club_id              (BIGSERIAL) PRIMARY KEY -- 동아리 고유 번호
- club_name            (VARCHAR(50))           -- 동아리 이름
- category             (VARCHAR(30))           -- 동아리 분류
- room                 (VARCHAR(30))           -- 동아리방
- founded_date         (DATE)                  -- 창설일
- advisor_prof_id      (BIGINT)                -- 지도교수 번호(FK)


[Entities / 개체]
- Membership

[Properties / 속성]
- membership_id        (BIGSERIAL) PRIMARY KEY -- 가입 고유 번호
- std_id               (VARCHAR(20))           -- 학생 번호(FK)
- club_id              (BIGINT)                -- 동아리 번호(FK)
- role_name            (VARCHAR(20))           -- 역할(회장, 총무, 일반회원 등)
- join_date            (DATE)                  -- 가입일
- active_yn            (CHAR(1))               -- 활동 여부(Y/N)


[Entities / 개체]
- Fee_Payment

[Properties / 속성]
- payment_id           (BIGSERIAL) PRIMARY KEY -- 회비 납부 번호
- membership_id        (BIGINT)                -- 가입 번호(FK)
- fee_year             (INTEGER)               -- 회비 연도
- fee_semester         (INTEGER)               -- 회비 학기(1, 2)
- amount               (NUMERIC(10,2))         -- 회비 금액
- paid_yn              (CHAR(1))               -- 납부 여부(Y/N)
- paid_date            (DATE)                  -- 납부일


====================================================
[테이블 생성 SQL]
====================================================
*/

CREATE TABLE professor (
    prof_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    dept VARCHAR(50) NOT NULL,
    salary NUMERIC(10,2),
    salary_level NUMERIC(3),
    hire_date DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE student (
    std_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    major VARCHAR(50) NOT NULL,
    grade INTEGER CHECK (grade BETWEEN 1 AND 4),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE club (
    club_id BIGSERIAL PRIMARY KEY,
    club_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    room VARCHAR(30),
    founded_date DATE,
    advisor_prof_id BIGINT NOT NULL,
    CONSTRAINT fk_club_professor
        FOREIGN KEY (advisor_prof_id)
        REFERENCES professor(prof_id)
);

CREATE TABLE membership (
    membership_id BIGSERIAL PRIMARY KEY,
    std_id VARCHAR(20) NOT NULL,
    club_id BIGINT NOT NULL,
    role_name VARCHAR(20) DEFAULT '일반회원',
    join_date DATE NOT NULL,
    active_yn CHAR(1) DEFAULT 'Y' CHECK (active_yn IN ('Y', 'N')),
    CONSTRAINT fk_membership_student
        FOREIGN KEY (std_id)
        REFERENCES student(std_id),
    CONSTRAINT fk_membership_club
        FOREIGN KEY (club_id)
        REFERENCES club(club_id),
    CONSTRAINT uq_student_club UNIQUE (std_id, club_id)
);

CREATE TABLE fee_payment (
    payment_id BIGSERIAL PRIMARY KEY,
    membership_id BIGINT NOT NULL,
    fee_year INTEGER NOT NULL,
    fee_semester INTEGER NOT NULL CHECK (fee_semester IN (1, 2)),
    amount NUMERIC(10,2) NOT NULL,
    paid_yn CHAR(1) DEFAULT 'N' CHECK (paid_yn IN ('Y', 'N')),
    paid_date DATE,
    CONSTRAINT fk_payment_membership
        FOREIGN KEY (membership_id)
        REFERENCES membership(membership_id),
    CONSTRAINT uq_fee_payment UNIQUE (membership_id, fee_year, fee_semester)
);

/*
====================================================
[데이터 삽입 SQL]
====================================================
*/

INSERT INTO professor (name, dept, salary, salary_level, hire_date, email) VALUES
('김교수', '컴퓨터공학과', 5200000.00, 1, '2020-03-01', 'kimprof@univ.ac.kr'),
('이교수', '전자공학과',   4800000.00, 2, '2021-09-01', 'leeprof@univ.ac.kr');

INSERT INTO student (std_id, name, major, grade, phone, email) VALUES
('2023001', '홍길동', '컴퓨터공학과', 2, '010-3333-3333', 'hong@univ.ac.kr'),
('2023002', '김민수', '소프트웨어학과', 3, '010-4444-4444', 'kimms@univ.ac.kr'),
('2023003', '박지은', '전자공학과',   1, '010-5555-5555', 'park@univ.ac.kr'),
('2023004', '최유진', '컴퓨터공학과', 4, '010-6666-6666', 'choi@univ.ac.kr');

INSERT INTO club (club_name, category, room, founded_date, advisor_prof_id) VALUES
('AI 동아리',        '학술', '학생회관 201호', '2023-03-01', 1),
('게임 개발 동아리', '학술', '학생회관 202호', '2022-09-01', 2);

INSERT INTO membership (std_id, club_id, role_name, join_date, active_yn) VALUES
('2023001', 1, '회장',     '2024-03-10', 'Y'),
('2023002', 1, '일반회원', '2024-03-12', 'Y'),
('2023003', 2, '총무',     '2024-03-15', 'Y'),
('2023001', 2, '일반회원', '2024-03-20', 'Y'),
('2023004', 1, '일반회원', '2024-03-22', 'N');

INSERT INTO fee_payment (membership_id, fee_year, fee_semester, amount, paid_yn, paid_date) VALUES
(1, 2024, 1, 30000.00, 'Y', '2024-03-11'),
(2, 2024, 1, 30000.00, 'N', NULL),
(3, 2024, 1, 25000.00, 'Y', '2024-03-16'),
(4, 2024, 1, 25000.00, 'Y', '2024-03-21'),
(5, 2024, 1, 30000.00, 'N', NULL);

/*
1) 전체 조회
*/

SELECT * FROM student;
SELECT * FROM professor;
SELECT * FROM club;
SELECT * FROM membership;
SELECT * FROM fee_payment;

/*
2) 정렬 (ORDER BY)
*/

-- 학생을 학년 높은 순으로 정렬
SELECT *
FROM student
ORDER BY grade DESC, name ASC;

-- 교수 급여 높은 순으로 정렬
SELECT *
FROM professor
ORDER BY salary DESC NULLS LAST, name ASC;

-- 동아리를 창설일 빠른 순으로 정렬
SELECT *
FROM club
ORDER BY founded_date ASC, club_name ASC;

-- 회비 금액이 큰 순으로 정렬
SELECT *
FROM fee_payment
ORDER BY amount DESC, payment_id ASC;

-- 학생 이름 가나다순 정렬
SELECT *
FROM student
ORDER BY name ASC;

/*
3) 조건 검색 (WHERE)
*/

-- 컴퓨터공학과 학생 조회
SELECT *
FROM student
WHERE major = '컴퓨터공학과';

-- 3학년 이상 학생 조회
SELECT *
FROM student
WHERE grade >= 3;

-- 학술 동아리 조회
SELECT *
FROM club
WHERE category = '학술';

-- 현재 활동 중인 회원 조회
SELECT *
FROM membership
WHERE active_yn = 'Y';

-- 회비를 납부한 내역 조회
SELECT *
FROM fee_payment
WHERE paid_yn = 'Y';

-- 회비를 아직 내지 않은 내역 조회
SELECT *
FROM fee_payment
WHERE paid_yn = 'N';

/*
4) 조인 조회 예시
*/

-- 학생과 가입 동아리 함께 조회
SELECT s.std_id, s.name, c.club_name, m.role_name, m.join_date
FROM student s
JOIN membership m ON s.std_id = m.std_id
JOIN club c ON m.club_id = c.club_id
ORDER BY s.std_id, c.club_name;

-- 각 동아리의 지도교수 조회
SELECT c.club_name, p.name AS professor_name, p.dept
FROM club c
JOIN professor p ON c.advisor_prof_id = p.prof_id
ORDER BY c.club_id;

-- 회비 납부 여부와 학생 이름, 동아리명 함께 조회
SELECT s.name, c.club_name, f.fee_year, f.fee_semester, f.amount, f.paid_yn, f.paid_date
FROM fee_payment f
JOIN membership m ON f.membership_id = m.membership_id
JOIN student s ON m.std_id = s.std_id
JOIN club c ON m.club_id = c.club_id
ORDER BY f.payment_id;
