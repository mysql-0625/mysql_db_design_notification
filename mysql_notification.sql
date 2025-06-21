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



