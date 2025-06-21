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





