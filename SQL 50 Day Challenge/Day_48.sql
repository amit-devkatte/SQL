--Day 48

/*
Write an SQL query to retrive customer details along with their total order amounts
(if any). 
    
Include the customer's name, city, country, and total order amount. 
    
If a customer hasn't placed any orders, display 'NULL' for the total order amount."
customers has columns cx_id, cx_name, city, country
orders table has columns order_id, cx_id, order_date, totalamount
*/


select * from customers_1;
select * from orders;

select c.*, sum(o.totalamount) as total_amount
from customers_1 c
left join orders o
on o.customerid = c.customerid
group by 1;













DROP TABlE IF EXISTS Customers_1;
DROP TABlE IF EXISTS Orders;


CREATE TABLE Customers_1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers_1(CustomerID)
);

-- Insert records into the 'Customers' table
INSERT INTO Customers_1 (CustomerID, CustomerName, City, Country) 
VALUES 
(1, 'John Doe', 'New York', 'USA'),
(2, 'Jane Smith', 'Los Angeles', 'USA'),
(3, 'Michael Johnson', 'Chicago', 'USA'),
(4, 'Emily Brown', 'Houston', 'USA');

-- Insert records into the 'Orders' table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES 
(101, 1, '2024-05-10', 150.00),
(102, 2, '2024-05-11', 200.00),
(103, 1, '2024-05-12', 100.00),
(104, 3, '2024-05-13', 300.00);