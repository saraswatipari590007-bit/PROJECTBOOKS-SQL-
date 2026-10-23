
use  PROJECTBOOKS

SELECT * FROM Books


---1) Retrieve all books in the "Fiction" genre  

SELECT *
FROM books
WHERE genre = 'Fiction';

SELECT COUNT(*) AS fiction_book_count
FROM books
WHERE genre = 'Fiction';

--- 2) Find books published after the year 1950  

SELECT *
FROM books
WHERE published_year > 1950;

--- 3) List all customers from the Canada 

SELECT *
FROM customers
WHERE country = 'Canada';

 ---4) Show orders placed in November 2023 


CREATE TABLE date_table(
date_id INT IDENTITY (1,1) PRIMARY KEY,
Full_date DATE,
Year INT,
Month INT,
Month_name VARCHAR (20),
Quarter INT,
Day INT,
week INT
)

SELECT * FROM date_table;

SELECT *
FROM orders
WHERE order_date >= '2023-11-01'
  AND order_date < '2023-12-01';



---5) Retrieve the total stock of books available 


SELECT SUM(stock) AS total_stock
FROM books

---6) Find the details of the most expensive book

SELECT *
FROM books
WHERE price = (SELECT MAX(price) FROM books);

---7) Show all customers who ordered more than 1 quantity of a book                                

SELECT *
FROM orders
WHERE quantity > 1;

---8) Retrieve all orders where the total amount exceeds $20                                             x

SELECT *
FROM orders
WHERE total_amount > 20

---9) List all genres available in the Books table 

SELECT DISTINCT genre
FROM books;


---10) Find the book with the lowest stock 

SELECT *
FROM Books
WHERE stock = (SELECT MIN(stock) FROM Books);

---11) Calculate the total revenue generated from all orders 

SELECT SUM(total_amount) AS total_revenue
FROM orders;






                                                            --------------  # ADVANCED QUESTIONS 

USE PROJECTBOOKS ;

SELECT * FROM ORDERS 

---1) Retrieve the total number of books sold for each genre
 
SELECT b.Genre, SUM(o.Quantity)AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id 
GROUP BY b.Genre 

---2) Find the average price of books in the 'Fantasy' genre

SELECT AVG(price)AS Average_Price
FROM BOOKS 
WHERE Genre = 'Fantasy';

---3) List customers who have placed at least 2 orders 

SELECT o.customer_id, c.name, 
COUNT(o.ORDER_id) AS ORDER_COUNT
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY C.NAME,O.CUSTOMER_ID
HAVING COUNT(order_id) >=2

---4) Find the most frequently ordered book  

SELECT
top 2
o.Book_id,b.title,
COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC 

---5) Show the top most expensive books of 'Fantasy' genre 


SELECT TOP 3 * FROM BOOKS
WHERE GENRE='Fantasy'
ORDER BY Price DESC

---6) Retrieve the total quantity of books sold by each author 


 SELECT b.author,
 SUM(o.quantity) AS total_quantity_sold
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY total_quantity_sold DESC

---7) List the cities where customers who spent over $30 are located 

SELECT DISTINCT c.city
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;

---8) Find the customer who spent the most on orders 

SELECT top 1
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC



---9) Calculate the stock remaining after fulfilling all orders 

Select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0)as order_quantity,
b.stock-coalesce(sum(o.quantity),0)as remaining_quantity
From books b
left join orders o 
On b.book_id=o.book_id
Group By b.book_id ,b.title,b.stock 
Order By b.book_id;;


