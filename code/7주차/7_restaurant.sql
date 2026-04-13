-- Customer Table
CREATE TABLE Customer(
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(13),
    address VARCHAR(100)
);

-- Restaurant Table
CREATE TABLE Restaurant(
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(13),
    address VARCHAR(100)
);

-- Orders Table
CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date TIMESTAMP,
    total NUMERIC,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Delivery
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    driver_name VARCHAR(100),
    status INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Data 삽입
INSERT INTO Customer VALUES
(1, 'Alice', '010-1111-2222', '충주'),
(2, '김수민', '010-2222-3333', '청주');

INSERT INTO Restaurant VALUES
(1, 'Pizza Place', '010-1234-5678', '세종'),
(2, '김밥천국', '063-9876-5432', '전주');

INSERT INTO Orders VALUES
(1, 1, 1, '2026-04-13 15:17:00', 24000),
(2, 2, 2. ' 2026-04-13 12:17:00', 8000);

INSERT INTO Delivery VALUES
(1, 1, '지석준', 1), -- 0: 받았다, 1: 조리하다, 2: 배달중, 3: 배달 완료, 4: 취소
(2, 2, '송지현', 3);

-- DB 쿼리
SELECT * FROM Orders;
SELECT * FROM Orders ORDER BY total ASC;
SELECT * FROM Orders WHERE total >= 10000;
SELECT * FROM Delivery WHERE status == 3;
