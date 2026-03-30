# Step 1 : 시스템 선택
# - 온라인 쇼핑몰

---

# Step 2 : 요구사항 작성
## 1. 요구사항 작성

1. 고객은 회원 정보를 등록할 수 있어야 한다.
2. 관리자는 상품 정보를 등록하고 수정할 수 있어야 한다.
3. 고객은 상품 목록을 조회할 수 있어야 한다.
4. 고객은 하나 이상의 상품을 주문할 수 있어야 한다.
5. 하나의 주문에는 여러 개의 상품이 포함될 수 있어야 한다.
6. 고객은 자신의 주문 내역을 조회할 수 있어야 한다.
7. 주문이 발생하면 주문한 수량만큼 상품 재고가 차감되어야 한다.
8. 관리자는 전체 주문 내역과 주문 상태를 조회할 수 있어야 한다.

---

# Step 3 : 데이터 설계
## 2. 데이터 설계

### 2.1 엔터티 정의

#### (1) Customer (고객)
- customer_id : 고객 번호 (PK)
- name : 고객 이름
- email : 이메일
- phone : 전화번호
- address : 주소

#### (2) Product (상품)
- product_id : 상품 번호 (PK)
- product_name : 상품명
- price : 가격
- stock : 재고 수량
- category : 카테고리

#### (3) Orders (주문)
- order_id : 주문 번호 (PK)
- customer_id : 고객 번호 (FK)
- order_date : 주문일
- status : 주문 상태
- total_amount : 총 주문 금액

#### (4) OrderItem (주문상세)
- order_item_id : 주문상세 번호 (PK)
- order_id : 주문 번호 (FK)
- product_id : 상품 번호 (FK)
- quantity : 주문 수량
- item_price : 주문 당시 상품 가격


### 2.2 엔터티 간 관계

- 한 명의 고객(Customer)은 여러 번 주문(Orders)할 수 있다.  
  → Customer : Orders = 1 : N

- 하나의 주문(Orders)에는 여러 개의 주문상세(OrderItem)가 포함될 수 있다.  
  → Orders : OrderItem = 1 : N

- 하나의 상품(Product)은 여러 주문상세(OrderItem)에 포함될 수 있다.  
  → Product : OrderItem = 1 : N

즉, 고객과 상품은 직접 연결되지 않고 주문(Orders) 및 주문상세(OrderItem)를 통해 연결된다.

### 2.3 스키마 정리

/*
[Project]
- 온라인 쇼핑몰

[Entities]
- customer
- product
- orders
- order_item

[customer Properties]
- customer_id (INT)
- name (TEXT)
- email (TEXT)
- phone (TEXT)
- address (TEXT)

[product Properties]
- product_id (INT)
- product_name (TEXT)
- price (INT)
- stock (INT)
- category (TEXT)

[orders Properties]
- order_id (INT)
- customer_id (INT)
- order_date (DATE)
- status (TEXT)
- total_amount (INT)

[order_item Properties]
- order_item_id (INT)
- order_id (INT)
- product_id (INT)
- quantity (INT)
- item_price (INT)
*/

---

# Step 4 : SQL 작성

-- 1. 고객 테이블 생성
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT
);

-- 2. 상품 테이블 생성
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name TEXT NOT NULL,
    price INT NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category TEXT
);

-- 3. 주문 테이블 생성
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status TEXT NOT NULL,
    total_amount INT NOT NULL CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
);

-- 4. 주문상세 테이블 생성
CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    item_price INT NOT NULL CHECK (item_price >= 0),
    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

-- 5. 고객 데이터 삽입
INSERT INTO customer (customer_id, name, email, phone, address)
VALUES
    (1, '김민수', 'minsu@test.com', '010-1111-2222', '서울시 강남구'),
    (2, '이수진', 'sujin@test.com', '010-3333-4444', '부산시 해운대구');

-- 6. 상품 데이터 삽입
INSERT INTO product (product_id, product_name, price, stock, category)
VALUES
    (1, '무선 마우스', 25000, 50, '전자기기'),
    (2, '기계식 키보드', 70000, 30, '전자기기'),
    (3, '노트북 파우치', 20000, 40, '패션잡화');

-- 7. 주문 데이터 삽입
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
VALUES
    (1, 1, '2025-09-10', '주문완료', 95000),
    (2, 2, '2025-09-11', '배송중', 40000);

-- 8. 주문상세 데이터 삽입
INSERT INTO order_item (order_item_id, order_id, product_id, quantity, item_price)
VALUES
    (1, 1, 1, 1, 25000),
    (2, 1, 2, 1, 70000),
    (3, 2, 3, 2, 20000);

-- 9. 주문 발생에 따른 재고 차감
UPDATE product
SET stock = stock - 1
WHERE product_id = 1;

UPDATE product
SET stock = stock - 1
WHERE product_id = 2;

UPDATE product
SET stock = stock - 2
WHERE product_id = 3;

-- 10. 전체 상품 조회
SELECT * FROM product;

-- 11. 상품명과 가격 조회
SELECT product_name, price
FROM product;

-- 12. 가격이 높은 순으로 상품 조회
SELECT *
FROM product
ORDER BY price DESC;

-- 13. 재고가 40개 이하인 상품 조회
SELECT *
FROM product
WHERE stock <= 40
ORDER BY stock ASC;

-- 14. 고객별 주문 내역 조회
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status,
    o.total_amount
FROM orders o
JOIN customer c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- 15. 특정 고객(김민수)의 주문 내역 조회
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status,
    o.total_amount
FROM orders o
JOIN customer c
    ON o.customer_id = c.customer_id
WHERE c.name = '김민수'
ORDER BY o.order_date DESC;

-- 16. 주문 상세 조회
SELECT
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.item_price,
    (oi.quantity * oi.item_price) AS subtotal
FROM order_item oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customer c
    ON o.customer_id = c.customer_id
JOIN product p
    ON oi.product_id = p.product_id
ORDER BY o.order_id ASC, p.product_name ASC;
