create database ecomerce;
use ecomerce;
# creating tables ?*

CREATE TABLE Users
(
    userid INT NOT NULL primary key
    ,name VARCHAR(20)
    ,phoneNumber VARCHAR(20)
);

CREATE TABLE Buyer
(
    userid INT NOT NULL PRIMARY KEY
    ,constraint fk_buyer_id FOREIGN KEY(userid) REFERENCES Users(userid) on update cascade on delete cascade
);

CREATE TABLE Seller
(
 userid INT NOT NULL PRIMARY KEY
    ,constraint fk_seller_id FOREIGN KEY(userid) REFERENCES Users(userid) on update cascade on delete cascade
);

CREATE TABLE BankCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,expiryDate DATE
    ,bank VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
);

CREATE TABLE CreditCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userid INT NOT NULL
    ,organization VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
    ,constraint fk_credit FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber) on update cascade on delete cascade
    ,constraint fk_credit_user FOREIGN KEY(userid) REFERENCES Users(userid) on update cascade on delete cascade
);


CREATE TABLE DebitCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userid INT NOT NULL
    ,PRIMARY KEY(cardNumber)
    ,constraint fk_debit FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber)
    ,constraint fk_debit_user FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE Address
(
    addrid INT NOT NULL
    ,userid INT NOT NULL
    ,name VARCHAR(50)
    ,contactPhoneNumber VARCHAR(20)
    ,province VARCHAR(100)
    ,city VARCHAR(100)
    ,streetaddr VARCHAR(100)
    ,postCode VARCHAR(12)
    ,PRIMARY KEY(addrid),
    constraint fk_adress_user FOREIGN KEY(userid) REFERENCES Users(userid) on update cascade on delete cascade
);

CREATE TABLE Store
(
    sid INT NOT NULL
    ,name VARCHAR(20)
    ,province VARCHAR(20)
    ,city VARCHAR(20)
    ,streetaddr VARCHAR(20)
    ,customerGrade INT
    ,startTime DATE
    ,PRIMARY KEY(sid)
);

CREATE TABLE Brand
(
    brandName VARCHAR(20) NOT NULL
    ,PRIMARY KEY (brandName)
);

CREATE TABLE Product
(
    pid INT NOT NULL
    ,sid INT NOT NULL
    ,brand VARCHAR(50) NOT NULL
    ,name VARCHAR(100)
    ,type VARCHAR(50)
    ,modelNumber VARCHAR(50)
    ,color VARCHAR(50)
    ,amount INT
    ,price INT
    ,PRIMARY KEY(pid)
    ,constraint fk_Pro_store FOREIGN KEY(sid) REFERENCES Store(sid) on update cascade on delete cascade
    ,constraint fk_pro_brand FOREIGN KEY(brand) REFERENCES Brand(brandName) on update cascade on delete cascade
);

CREATE TABLE OrderItem
(
    itemid INT NOT NULL
    ,pid INT NOT NULL
    ,price INT
    ,creationTime DATE
    ,PRIMARY KEY(itemid)
    ,constraint fk_product FOREIGN KEY(pid) REFERENCES Product(pid) on update cascade on delete cascade
);

CREATE TABLE Orders
(
    orderNumber INT NOT NULL
    ,paymentState VARCHAR(12)
    ,creationTime DATE
    ,totalAmount INT
    ,PRIMARY KEY (orderNumber)
);


CREATE TABLE Comments  -- Weak Entity
(
    creationTime DATE NOT NULL
    ,userid INT NOT NULL
    ,pid INT NOT NULL
    ,grade FLOAT
    ,content VARCHAR(500)
    ,PRIMARY KEY(creationTime,userid,pid)
    ,constraint fk_user_comments FOREIGN KEY(userid) REFERENCES Buyer(userid) on update cascade on delete cascade
    ,constraint fk_comment_pro FOREIGN KEY(pid) REFERENCES Product(pid) on update cascade on delete cascade
);


CREATE TABLE ServicePoint
(
    spid INT NOT NULL
    ,streetaddr VARCHAR(40)
    ,city VARCHAR(30)
    ,province VARCHAR(20)
    ,startTime VARCHAR(20)
    ,endTime VARCHAR(20)
    ,PRIMARY KEY(spid)
);
-- Relationship

CREATE TABLE Save_to_Shopping_Cart
(
    userid INT NOT NULL
    ,pid INT NOT NULL
    ,addTime DATE
    ,quantity INT
    ,PRIMARY KEY (userid,pid) -- composite key
    ,constraint fk_user_cart FOREIGN KEY(userid) REFERENCES Buyer(userid) on update cascade on delete cascade
    ,constraint fk_product_cart FOREIGN KEY(pid) REFERENCES Product(pid) on update cascade on delete cascade
);


CREATE TABLE Contain
(
    orderNumber INT NOT NULL
    ,itemid INT NOT NULL
    ,quantity INT
    ,PRIMARY KEY (orderNumber,itemid)
    ,constraint fk_orderNumber FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber) on update cascade on delete cascade
    ,constraint fk_item FOREIGN KEY(itemid) REFERENCES OrderItem(itemid) on update cascade on delete cascade
);

CREATE TABLE Payment
(
    orderNumber INT NOT NULL
    ,creditcardNumber VARCHAR(25) NOT NULL
    ,payTime DATE
    ,PRIMARY KEY(orderNumber,creditcardNumber)
    ,constraint fk_payments_order FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber) on update cascade on delete cascade
    ,constraint fk_credit_order FOREIGN KEY(creditcardNumber) REFERENCES CreditCard(cardNumber) on update cascade on delete cascade
);

CREATE TABLE Deliver_To
(
    addrid INT NOT NULL
    ,orderNumber INT NOT NULL
    ,TimeDelivered DATE
    ,PRIMARY KEY(addrid,orderNumber)
    ,constraint fk_delivery FOREIGN KEY(addrid) REFERENCES Address(addrid) on update cascade on delete cascade
    ,constraint fk_delivery_order FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber) on update cascade on delete cascade
);

CREATE TABLE Manage
(
    userid INT NOT NULL
    ,sid INT NOT NULL
    ,SetUpTime DATE
    ,PRIMARY KEY(userid,sid)
    ,constraint fk_user_manage FOREIGN KEY(userid) REFERENCES Seller(userid) on update cascade on delete cascade
    ,constraint fk_sid_manage FOREIGN KEY(sid) REFERENCES Store(sid) on update cascade on delete cascade
); 

CREATE TABLE After_Sales_Service_At
(
    brandName VARCHAR(20) NOT NULL
    ,spid INT NOT NULL
    ,PRIMARY KEY(brandName, spid)
    ,constraint fk_brand_service FOREIGN KEY(brandName) REFERENCES Brand (brandName) on update cascade on delete cascade
    ,constraint fk_spid_service FOREIGN KEY(spid) REFERENCES ServicePoint(spid) on update cascade on delete cascade
);


