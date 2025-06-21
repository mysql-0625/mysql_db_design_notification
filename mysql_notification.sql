CREATE DATABASE mysql_notification;

SHOW DATABASES;

USE mysql_notification;

SHOW TABLES;

-- USER
CREATE TABLE user (
	id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO user (id, name) VALUES ("hasan","M. Hasan");
INSERT INTO user (id, name) VALUES ("musa","Muhammad Hasan");

SELECT * FROM user;

-- Notification
CREATE TABLE notification(
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    detail TEXT NOT NULL,
    create_at TIMESTAMP NOT NULL,
    user_id VARCHAR(100),
    PRIMARY KEY (id)
);

ALTER TABLE notification -- Relasi user ke notif -> one to many
ADD CONSTRAINT fk_notification_user
FOREIGN KEY (user_id) REFERENCES user (id);

DESC notification;

INSERT INTO notification (title, detail, create_at, user_id)
VALUES ("Judul Info", "Detail Info", CURRENT_TIMESTAMP(), "hasan"),
		("Judul Promo", "Detail Promo", CURRENT_TIMESTAMP(), null),
		("Judul Info 2", "Detail Info 2", CURRENT_TIMESTAMP(), "musa");

SELECT * FROM notification;

-- query show notification
SELECT * FROM notification WHERE user_id = "hasan";
SELECT * FROM notification WHERE (user_id = "hasan" OR user_id IS NULL);
SELECT * FROM notification WHERE (user_id = "hasan" OR user_id IS NULL) ORDER BY create_at DESC;

-- CATEGORY
CREATE TABLE category (
	id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SHOW TABLES;

ALTER TABLE notification -- add column baru relasi dengan category di notif
ADD COLUMN category_id VARCHAR(100);

DESCRIBE notification;

ALTER TABLE notification -- Relasi kategory ke notif -> one to many
ADD CONSTRAINT fk_notification_category
FOREIGN KEY (category_id) REFERENCES category(id);

SELECT * FROM notification; -- disini field category_id masih kosong

INSERT INTO category (id, name) VALUES ("INFO", "Info");
INSERT INTO category (id, name) VALUES ("PROMO", "Promo");

SELECT * FROM category;

-- add category_id di notification
UPDATE notification SET category_id = "INFO" WHERE id IN (1, 3);
UPDATE notification SET category_id = "PROMO" WHERE id IN (2, 4);

-- show data by join
SELECT * FROM notification n JOIN CATEGORY c ON (n.category_id = c.id) WHERE (n.user_id = "hasan" OR n.user_id IS NULL) ORDER BY create_at DESC; -- notif untuk user hasan
SELECT * FROM notification n JOIN CATEGORY c ON (n.category_id = c.id) WHERE (n.user_id = "hasan" OR n.user_id IS NULL) AND c.id = "PROMO" ORDER BY create_at DESC; -- notif untuk user hasan filter category promo
SELECT * FROM notification n JOIN CATEGORY c ON (n.category_id = c.id) WHERE (n.user_id = "musa" OR n.user_id IS NULL) ORDER BY create_at DESC; -- notif untuk user musa
SELECT * FROM notification n JOIN CATEGORY c ON (n.category_id = c.id) WHERE (n.user_id = "musa" OR n.user_id IS NULL) AND c.id = "INFO" ORDER BY create_at DESC; -- notif untuk user musa filter category info

-- NOTIFICATION READ
CREATE TABLE notification_read(
	id INT NOT NULL AUTO_INCREMENT,
    is_read BOOLEAN NOT NULL,
    notification_id INT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SHOW TABLES;

ALTER TABLE notification_read -- relasi notification ke notification read -> one to many
ADD CONSTRAINT fk_notification_read_notification
FOREIGN KEY (notification_id) REFERENCES notification(id);

ALTER TABLE notification_read -- relasi user ke notification read -> one to many
ADD CONSTRAINT fk_notification_read_user
FOREIGN KEY (user_id) REFERENCES user(id);

DESC notification_read;

SELECT * FROM notification;

-- Set notification read unread
INSERT INTO notification_read (is_read, notification_id, user_id) VALUES (true, 2, "hasan");
INSERT INTO notification_read (is_read, notification_id, user_id) VALUES (true, 2, "musa");

SELECT * FROM notification_read;

-- Show data read unread join 2 table
SELECT * FROM notification n 
JOIN category c ON (n.category_id = c.id) 
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = "hasan" OR n.user_id IS NULL) 
AND (nr.user_id = "hasan" OR nr.user_id IS NULL)
ORDER BY create_at DESC; 

-- Coba add notification lagi dan pastikan dgn query diatas notification yg show bertambah
INSERT INTO notification (title, detail, category_id, create_at, user_id) VALUES ("Tambah Info lagi", "Detail Info", "INFO", CURRENT_TIMESTAMP(), "hasan");
INSERT INTO notification (title, detail, category_id, create_at, user_id) VALUES ("Tambah Promo lagi", "Detail Promo", "PROMO", CURRENT_TIMESTAMP(), null);

-- COUNTER
SELECT COUNT(*) FROM notification n 
JOIN category c ON (n.category_id = c.id) 
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = "hasan" OR n.user_id IS NULL) 
AND (nr.user_id IS NULL)
ORDER BY create_at DESC; 













