create database batch12;
use batch12;
CREATE TABLE CUSTOMER(CUS_ID VARCHAR(10) PRIMARY KEY, CUS_NAME VARCHAR(20) NOT NULL,EMAIL VARCHAR(30) UNIQUE,PHONE_NO BIGINT UNIQUE);
CREATE TABLE ORDER_TABLE(ORDER_ID VARCHAR(10) PRIMARY KEY, CUS_ID VARCHAR(10), TOTAL_AMOUNT DECIMAL(10,2), ORDER_DATE DATE, FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID));
CREATE TABLE PRODUCT(PRODUCT_ID VARCHAR(10) PRIMARY KEY, PRODUCT_NAME VARCHAR(20) NOT NULL,PRICE DECIMAL(10,2));
CREATE TABLE ORDER_ITEM(ITEM_ID VARCHAR(10) PRIMARY KEY, PRODUCT_ID VARCHAR(10), ORDER_ID VARCHAR(10), QUANTITY INT NOT NULL,FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID), FOREIGN KEY (ORDER_ID) REFERENCES ORDER_TABLE(ORDER_ID));
ALTER TABLE CUSTOMER ADD ADDRESS VARCHAR(50);
ALTER TABLE ORDER_TABLE ADD STATUS VARCHAR(20);
ALTER TABLE PRODUCT ADD PRODUCT_DESC VARCHAR(100);
ALTER TABLE ORDER_ITEM ADD DISCOUNT DECIMAL(10,2);
SET SQL_SAFE_UPDATES=0;
DELETE FROM ORDER_TABLE;
INSERT INTO CUSTOMER(CUS_ID,CUS_NAME,EMAIL,PHONE_NO,ADDRESS)
  VALUES("C101","Gayathri M","mgayathri1192001@gmail.com",9384315918,"46 Muneswara Nagar,Bengaluru"),
        ("C102","Chandhana K","chandhu2001@gmail.com",8965321475,"48 North Street, Bengaluru");
INSERT INTO ORDER_TABLE(ORDER_ID,CUS_ID,TOTAL_AMOUNT,ORDER_DATE) 
  VALUES("O101","C101",102700.00,"2024-03-16"),
		("O102","C102",83250.00,"2024-03-15");
INSERT INTO PRODUCT(PRODUCT_ID,PRODUCT_NAME,PRICE,PRODUCT_DESC)
  VALUES("PD101","Laptop",50000.00,"High Performance Laptop with additional feature"),
        ("PD102","Mobile",35000.00,"Feature-rich smartphone with a sleek design"),
        ("PD103","Headphones",3000.00,"Premium quality headphones with noise cancellation");

SELECT * FROM CUSTOMER;
SELECT * FROM ORDER_TABLE;
SELECT * FROM PRODUCT;
SELECT * FROM ORDER_ITEM;
INSERT INTO ORDER_ITEM(ITEM_ID,PRODUCT_ID,ORDER_ID,QUANTITY,DISCOUNT) 
  VALUES("OI101","PD101","O101",2,0.00),
        ("OI102","PD103","O101",3,0.10),
        ("OI103","PD102","O102",1,0.05),
        ("OI104","PD101","O102",1,0.00);

INSERT INTO CUSTOMER(CUS_ID,CUS_NAME,EMAIL,PHONE_NO,ADDRESS)
  VALUES("C103","LAKSHMI","laksh2001@gmail.com",7896542315,"48 North Street, Bengaluru");

DELETE FROM CUSTOMER WHERE CUS_ID="C103";
UPDATE CUSTOMER SET PHONE_NO=8282331547 WHERE CUS_ID="C102";
GRANT INSERT,UPDATE,SELECT,DELETE ON CUSTOMER TO GAYU;
REVOKE DELETE ON CUSTOMER FROM GAYU;
START TRANSACTION;
INSERT INTO CUSTOMER(CUS_ID,CUS_NAME,EMAIL,PHONE_NO,ADDRESS) 
  VALUES("C103","Lakshmi D","laksh2001@gmail.com",8756321456,"38 South Street, Bengaluru");
COMMIT;
SELECT * FROM CUSTOMER;
ROLLBACK;

START TRANSACTION;
DELETE FROM CUSTOMER WHERE CUS_ID="C103";
SELECT * FROM CUSTOMER;
ROLLBACK;
SELECT * FROM CUSTOMER;

/* operators */
/* increase all the price of the products by 10% */
update product set price=price*1.10;
select * from product;
select * from order_table where total_amount>=100000;
select * from order_table where total_amount<=90000;
update order_table ot set total_amount=(select sum((oi.quantity*p.price)-(oi.quantity*oi.discount)) from order_item oi join product p on oi.product_id=p.product_id where ot.order_id=oi.order_id) where ot.order_id in(select order_id from order_item);
select * from order_table;

select concat(c.cus_name,'ordered item on ', ot.order_date) as "Date of Customer orders" from customer c join order_table ot on c.cus_id=ot.cus_id;
select * from order_item;
select * from order_item where order_id in ('O101');
select * from order_item where order_id not in ('O101');
select * from order_item where quantity > 1 and discount >= 0.05;
select * from product where product_desc like "%rich%";

#Inner join
#Retrieve all orders along with customer details who made those orders.
select * from customer c inner join order_table ot on c.cus_id=ot.cus_id;
#Left Outer join
#Show all customers along with their orders, if they have any. If not, display NULL for order details.
select * from customer c left join order_table ot on c.cus_id=ot.cus_id;
#Right Join:
#Display all orders and their associated customers, ensuring that all orders are included in the result set even if there are no matching customers.
INSERT INTO ORDER_TABLE(ORDER_ID,CUS_ID,TOTAL_AMOUNT,ORDER_DATE) 
  VALUES("O103",null,null,null);
  
select * from order_table ot right join customer c on ot.cus_id=c.cus_id;
#Full Outer Join
#List all customers and their orders, including customers with no orders and orders with no associated customers.
select * from customer c left join order_table ot on c.cus_id=ot.cus_id union all select * from customer c right join order_table ot on c.cus_id=ot.cus_id;
#cross join
#give all combinations of two tables
select * from customer c cross join order_table ot on c.cus_id=ot.cus_id;
#self join
#find the customers who have same address
INSERT INTO CUSTOMER(CUS_ID,CUS_NAME,EMAIL,PHONE_NO,ADDRESS) 
  VALUES("C104","Maara M","maara@gmail.com",8756321456,"46 Muneswara Nagar,Bengaluru");
select * from customer c1 inner join customer c2 on c1.cus_id<>c2.cus_id and c1.address=c2.address;
#natural join
select * from customer natural join order_table;












        