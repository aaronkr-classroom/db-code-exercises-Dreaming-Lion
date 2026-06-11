-- DB Final Project Skeleton
-- Student Name: 오인화
-- Student ID: 2326038

-- 실행을 다시 할 때 기존 테이블이 있으면 삭제
DROP TABLE IF EXISTS assign_bus;
DROP TABLE IF EXISTS assign_driver;
DROP TABLE IF EXISTS reserve;
DROP TABLE IF EXISTS tour;
DROP TABLE IF EXISTS driver;
DROP TABLE IF EXISTS tour_bus;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS task_code;
DROP TABLE IF EXISTS class_code;

-- 1. CREATE TABLE

CREATE TABLE class_code (
    code INT PRIMARY KEY,
    class VARCHAR(20),
    basis VARCHAR(50)
);

CREATE TABLE task_code (
    code INT PRIMARY KEY,
    task VARCHAR(50)
);

-- customer
CREATE TABLE customer (
    cus_id VARCHAR(15) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    cell CHAR(13) NOT NULL UNIQUE,
    addr VARCHAR(100),
    c_code INT DEFAULT 3,
    FOREIGN KEY (c_code) REFERENCES class_code(code)
);

-- staff
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday CHAR(6) NOT NULL,
    tel CHAR(12),
    salary INT,
    t_code INT NOT NULL,
    hire_date CHAR(8) NOT NULL,
    FOREIGN KEY (t_code) REFERENCES task_code(code)
);

-- tour
CREATE TABLE tour (
    tour_num CHAR(8) PRIMARY KEY,
    departure VARCHAR(50) NOT NULL,
    arrival VARCHAR(50) NOT NULL,
    program VARCHAR(100),
    start_dt DATE NOT NULL,
    end_dt DATE NOT NULL,
    min_num INT,
    max_num INT,
    expense INT NOT NULL,
    deposit INT,
    dept_yn CHAR(1) DEFAULT 'N',
    staff_id INT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- reserve
CREATE TABLE reserve (
    cus_id VARCHAR(15),
    tour_num CHAR(8),
    res_date DATE DEFAULT CURRENT_DATE,
    dep_yn CHAR(1) DEFAULT 'N',
    exp_yn CHAR(1) DEFAULT 'N',
    PRIMARY KEY (cus_id, tour_num),
    FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num)
);

-- 5. BONUS TABLES (Optional)

-- driver
CREATE TABLE driver (
    driver_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday CHAR(6) NOT NULL,
    cell CHAR(13) NOT NULL UNIQUE,
    pay INT DEFAULT 15000,
    cont_date CHAR(8),
    cont_term INT
);

-- tour_bus
CREATE TABLE tour_bus (
    bus_id INT PRIMARY KEY,
    seat INT,
    del_year INT
);

-- assign_driver
CREATE TABLE assign_driver (
    tour_num CHAR(8),
    driver_id INT,
    work_hour INT,
    PRIMARY KEY (tour_num),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

-- assign_bus
CREATE TABLE assign_bus (
    tour_num CHAR(8),
    bus_id INT,
    PRIMARY KEY (tour_num),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (bus_id) REFERENCES tour_bus(bus_id)
);

-- 2. INSERT DATA

-- class_code: 1 최우수, 2 우수, 3 일반
INSERT INTO class_code VALUES (1, '최우수', '누적 예약 10회 이상');
INSERT INTO class_code VALUES (2, '우수', '누적 예약 5회 이상');
INSERT INTO class_code VALUES (3, '일반', '기본 등급');
INSERT INTO class_code VALUES (4, '신규', '신규 가입 고객');
INSERT INTO class_code VALUES (5, '휴면', '1년 이상 미예약 고객');

-- task_code
INSERT INTO task_code VALUES (1, '여행상품관리');
INSERT INTO task_code VALUES (2, '예약관리');
INSERT INTO task_code VALUES (3, '관광버스배치관리');
INSERT INTO task_code VALUES (4, '직원관리');
INSERT INTO task_code VALUES (5, '고객관리');

-- customer
INSERT INTO customer VALUES ('C001', '김민지', '010-1111-2222', '서울특별시 강남구', 1);
INSERT INTO customer VALUES ('C002', '이준호', '010-2222-3333', '부산광역시 해운대구', 2);
INSERT INTO customer VALUES ('C003', '박서연', '010-3333-4444', '대구광역시 중구', 3);
INSERT INTO customer VALUES ('C004', '최현우', '010-4444-5555', '인천광역시 연수구', 2);
INSERT INTO customer VALUES ('C005', '정하은', '010-5555-6666', '광주광역시 북구', 3);

-- staff
INSERT INTO staff VALUES (10001, '한지훈', '880101', '02-1111-1111', 3200000, 1, '20200105');
INSERT INTO staff VALUES (10002, '오유진', '900215', '02-2222-2222', 3000000, 2, '20210310');
INSERT INTO staff VALUES (10003, '강도윤', '870430', '02-3333-3333', 3100000, 3, '20190520');
INSERT INTO staff VALUES (10004, '문서현', '930612', '02-4444-4444', 2900000, 4, '20220701');
INSERT INTO staff VALUES (10005, '배수아', '950823', '02-5555-5555', 2800000, 5, '20230115');

-- tour
INSERT INTO tour VALUES ('TR000001', '서울', '제주', 'https://tour.example.com/jeju', '2026-07-01', '2026-07-04', 10, 30, 450000, 100000, 'N', 10001);
INSERT INTO tour VALUES ('TR000002', '부산', '강릉', 'https://tour.example.com/gangneung', '2026-07-10', '2026-07-12', 8, 25, 280000, 80000, 'N', 10001);
INSERT INTO tour VALUES ('TR000003', '대전', '여수', 'https://tour.example.com/yeosu', '2026-08-05', '2026-08-08', 12, 35, 390000, 100000, 'N', 10001);
INSERT INTO tour VALUES ('TR000004', '광주', '경주', 'https://tour.example.com/gyeongju', '2026-08-15', '2026-08-17', 10, 28, 320000, 90000, 'N', 10001);
INSERT INTO tour VALUES ('TR000005', '인천', '속초', 'https://tour.example.com/sokcho', '2026-09-01', '2026-09-03', 6, 20, 250000, 70000, 'N', 10001);

-- reserve
INSERT INTO reserve VALUES ('C001', 'TR000001', '2026-06-01', 'Y', 'N');
INSERT INTO reserve VALUES ('C002', 'TR000001', '2026-06-03', 'Y', 'Y');
INSERT INTO reserve VALUES ('C003', 'TR000003', '2026-06-05', 'N', 'N');
INSERT INTO reserve VALUES ('C004', 'TR000004', '2026-06-07', 'Y', 'N');
INSERT INTO reserve VALUES ('C005', 'TR000005', '2026-06-09', 'N', 'N');

-- driver
INSERT INTO driver VALUES (20001, '정우성', '800101', '010-6001-1111', 17000, '20260101', 12);
INSERT INTO driver VALUES (20002, '이하늘', '820202', '010-6002-2222', 16000, '20260115', 12);
INSERT INTO driver VALUES (20003, '박민준', '850303', '010-6003-3333', 15000, '20260201', 6);
INSERT INTO driver VALUES (20004, '최가람', '790404', '010-6004-4444', 18000, '20260215', 12);
INSERT INTO driver VALUES (20005, '김도현', '880505', '010-6005-5555', 15000, '20260301', 6);

-- tour_bus
INSERT INTO tour_bus VALUES (1, 25, 2020);
INSERT INTO tour_bus VALUES (2, 30, 2021);
INSERT INTO tour_bus VALUES (3, 45, 2019);
INSERT INTO tour_bus VALUES (4, 40, 2022);
INSERT INTO tour_bus VALUES (5, 28, 2023);

-- assign_driver
INSERT INTO assign_driver VALUES ('TR000001', 20001, 24);
INSERT INTO assign_driver VALUES ('TR000002', 20002, 18);
INSERT INTO assign_driver VALUES ('TR000003', 20003, 30);
INSERT INTO assign_driver VALUES ('TR000004', 20004, 20);
INSERT INTO assign_driver VALUES ('TR000005', 20005, 16);

-- assign_bus
INSERT INTO assign_bus VALUES ('TR000001', 3);
INSERT INTO assign_bus VALUES ('TR000002', 2);
INSERT INTO assign_bus VALUES ('TR000003', 4);
INSERT INTO assign_bus VALUES ('TR000004', 1);
INSERT INTO assign_bus VALUES ('TR000005', 5);

-- 3. INDEX

-- CREATE INDEX
CREATE INDEX tour_arrival_idx ON tour(arrival);
CREATE INDEX driver_name_idx ON driver(name);

-- 4. TEST QUERIES

-- Customer Grade Search
SELECT c.cus_id, c.name, cc.class, cc.basis
FROM customer c, class_code cc
WHERE c.c_code = cc.code
  AND c.cus_id = 'C001';

-- Employee Task Search
SELECT s.staff_id, s.name, tc.task
FROM staff s, task_code tc
WHERE s.t_code = tc.code
  AND s.staff_id = 10002;

-- Tour Reservation Search
SELECT t.tour_num, t.departure, t.arrival, c.cus_id, c.name, r.res_date
FROM tour t, reserve r, customer c
WHERE t.tour_num = r.tour_num
  AND r.cus_id = c.cus_id
  AND t.tour_num = 'TR000001';

-- Assigned Driver Search
SELECT t.tour_num, t.departure, t.arrival, d.driver_id, d.name, d.cell
FROM tour t, assign_driver ad, driver d
WHERE t.tour_num = ad.tour_num
  AND ad.driver_id = d.driver_id
  AND t.tour_num = 'TR000001';

-- Assigned Bus Search
SELECT t.tour_num, t.departure, t.arrival, b.bus_id, b.seat, b.del_year
FROM tour t, assign_bus ab, tour_bus b
WHERE t.tour_num = ab.tour_num
  AND ab.bus_id = b.bus_id
  AND t.tour_num = 'TR000001';

-- INSERT example
INSERT INTO customer VALUES ('C006', '윤지아', '010-6666-7777', '세종특별자치시', 4);

SELECT *
FROM customer
WHERE cus_id = 'C006';

-- UPDATE example
UPDATE staff
SET salary = salary + 200000
WHERE staff_id = 10002;

SELECT staff_id, name, salary
FROM staff
WHERE staff_id = 10002;

-- DELETE example
DELETE FROM reserve
WHERE cus_id = 'C005'
  AND tour_num = 'TR000005';

SELECT *
FROM reserve
WHERE cus_id = 'C005'
  AND tour_num = 'TR000005';
