CREATE TABLE UserAccount (
    user_id INT PRIMARY KEY,
    email VARCHAR(100),
    password VARCHAR(100),
    create_at TIMESTAMP
);

CREATE TABLE Character (
    character_id INT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100),
    level INT,
    class VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50)
);

CREATE TABLE Inventory (
    character_id INT,
    item_id INT,
    quantity INT,
    PRIMARY KEY (character_id, item_id),
    FOREIGN KEY (Character_ID) REFERENCES Character(character_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);