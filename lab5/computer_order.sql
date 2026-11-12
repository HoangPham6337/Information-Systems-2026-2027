-- Order form normalized to 3NF (Labwork 5)
-- Mirrors assets/computer_order.pdf
DROP DATABASE IF EXISTS computer_order;
CREATE DATABASE computer_order;
USE computer_order;

CREATE TABLE CityCountry (
    cityId  INT          NOT NULL AUTO_INCREMENT,
    city    VARCHAR(50)  NOT NULL,
    country VARCHAR(50)  NOT NULL,
    PRIMARY KEY (cityId),
    UNIQUE (city, country)          -- the pair is unique, not each column
);

CREATE TABLE Customer (
    customerId INT          NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    phone      VARCHAR(50),
    address    VARCHAR(100),
    cityId     INT          NOT NULL,
    PRIMARY KEY (customerId),
    FOREIGN KEY (cityId) REFERENCES CityCountry (cityId)
);

-- ORDER is a reserved word, hence the backticks
CREATE TABLE `Order` (
    orderNo    VARCHAR(50) NOT NULL,
    date       DATE        NOT NULL,
    customerId INT         NOT NULL,
    PRIMARY KEY (orderNo),
    FOREIGN KEY (customerId) REFERENCES Customer (customerId)
);

CREATE TABLE Product (
    productId   VARCHAR(50)   NOT NULL,
    description VARCHAR(100)  NOT NULL,
    price       DECIMAL(10,2) NOT NULL,   -- open decision: price-at-order (see report)
    PRIMARY KEY (productId)
);

CREATE TABLE OrderProductList (
    orderNo   VARCHAR(50) NOT NULL,
    productId VARCHAR(50) NOT NULL,
    quantity  INT         NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (orderNo, productId),
    FOREIGN KEY (orderNo)   REFERENCES `Order` (orderNo),
    FOREIGN KEY (productId) REFERENCES Product (productId)
);

-- Sample data: the order form
INSERT INTO CityCountry (city, country) VALUES ('Hanoi', 'Vietnam');

INSERT INTO Customer (name, phone, address, cityId)
VALUES ('Tran Giang Son', '+84-4 37 91 69 60', '18 Hoang Quoc Viet', 1);

INSERT INTO `Order` (orderNo, date, customerId)
VALUES ('on7126', '2016-07-11', 1);

INSERT INTO Product (productId, description, price) VALUES
('P101', 'Intel i7 6700K',            349),
('P102', 'ASUS Z170A-P',              149),
('P103', 'Corsair DDR4 4 x 8GB',      469),
('P104', 'Samsung EVO 850 512GB',     249),
('P105', 'GeForce GTX 1080 8G',       725),
('P106', 'Corsair CS750M 80+ Gold',   119),
('P107', 'Corsair Carbide 400R Mid',   85);

INSERT INTO OrderProductList (orderNo, productId, quantity) VALUES
('on7126', 'P101', 1), ('on7126', 'P102', 1), ('on7126', 'P103', 1),
('on7126', 'P104', 1), ('on7126', 'P105', 1), ('on7126', 'P106', 1),
('on7126', 'P107', 1);

-- Rebuild the form from the normalized tables
SELECT o.orderNo, o.date, c.name, c.phone, c.address, cc.city, cc.country,
       p.productId, p.description, l.quantity, p.price
FROM `Order` AS o
JOIN Customer         AS c  ON c.customerId = o.customerId
JOIN CityCountry      AS cc ON cc.cityId    = c.cityId
JOIN OrderProductList AS l  ON l.orderNo    = o.orderNo
JOIN Product          AS p  ON p.productId  = l.productId
WHERE o.orderNo = 'on7126';
