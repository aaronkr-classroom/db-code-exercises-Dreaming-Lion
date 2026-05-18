TABLE users;
TABLE user_items;
TABLE games;
TABLE plays;

SELECT user_level FROM users;

-- 1 : CHECK 유저 레벨은 1~100만 가능하다.
ALTER TABLE users
ADD CONSTRAINT chk_user_level
CHECK (user_level >= 1 AND user_level <= 100);

UPDATE users
SET user_level = 100
WHERE user_id = 1;

-- 2 : 접속 상태는 online 또는 offline만 가능하다.
SELECT status FROM users;

ALTER TABLE users
ADD CONSTRANT chk_user_status
CHECK (status in ('online', 'offline', 'connecting'));

UPDATE users
SET status = 'sleeping'
WHERE user_id = 2;

-- 3 : 아이템 가격은 0원 이상이어야 한다.
SELECT price FROM items;

ALTER TABLE items 
ADD CONSTRANT chk_item_price
CHECK (price >= 0);

UPDATE items
SET price = -10
WHERE item_id = 1001;

-- 4 : 아이템 등급은 정해진 값만 가능하다. (S, A, B, C, D, E, F)
ALTER TABLE items
ADD CONSTRAINT check_item_grade
CHECK (status in ('S', 'A', 'B', 'C', 'D', 'E', 'F'));

-- 5 : 닉네임은 중복되면 안 된다.
ALTER TABLE users
ADD CONSTRAINT uq_user_nickname
UNIQUE (nickname);

INSERT INTO users VALUES
(6, '홍길동', 'DragonKing', 10, '2026-05-18', 'home@home.com', 'offline');

SELECT CONSTRAINT_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
    AND TABLE_NAME = 'players';

SELECT CONSTRAINT_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
    AND TABLE_NAME = 'user_items';

-- plays_user_id_fkey
-- plays_game_id_fkey
-- user_items_user_id_fkey
-- user_items_item_id_fkey

ALTER TABLE plays
DROP CONSTRAINT plays_user_id_fkey;

ALTER TABLE plays
DROP CONSTRAINT plays_game_id_fkey;

ALTER TABLE user_item
DROP CONSTRAINT user_items_user_id_fkey;

ALTER TABLE user_item
DROP CONSTRAINT user_items_item_id_fkey;

-- 새 FK 추가
-- 1 : 유저가 삭제되면 플레이 기록도 삭제되게 하기
ALTER TABLE plays
ADD CONSTRAINT fk_plays_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

-- 2 : 게임은 플레이 기록이 있으면 삭제하지 못 하게 하기
ALTER TABLE plays
ADD CONSTRAINT fk_plays_games
FOREIGN KEY (game_id)
REFERENCES games(game_id)
ON DELETE RESTRICT;

-- 3 : 유저가 삭제되면 보유 아이템 기록도 삭제되게 하기
ALTER TABLE user_items
ADD CONSTRAINT fk_user_items_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

-- 4 : 아이템 누군가 보유 중이면 삭제하지 못 하게 하기
ALTER TABLE user_items
DROP CONSTRAINT fk_user_items_items;

ALTER TABLE user_items
ADD CONSTRAINT fk_user_items_items
FOREIGN KEY (item_id)
REFERENCES items(item_id)
ON DELETE RESTRICT; -- 수정

-- CASCADE 테스트
SELECT * FROM plays WHERE user_id = 1;
SELECT * FROM user_items WHERE user_id = 1;

DELETE FROM users WHERE user_id = 1;

-- RESTRICT 테스트
TABLE games;

DELETE FROM games WHERE game_id = 101;
DELETE FROM items WHERE item_id = 1004;
