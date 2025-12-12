-- Creating Books table
create table Books(
	Book_ID Serial primary key,
	Title varchar(100),
	Author varchar(50),
	Genre varchar(50),
	Published_Year Int,
	Price numeric(10,2),
	Stock int
);

-- Creating customer table
create table Customers(
	Customer_ID serial primary key,
	Name varchar(100),
	Email varchar(200),
	Phone varchar(15),
	City varchar(50),
	Country varchar(150)
);

-- Creating table orders
create table Orders(
	Order_ID serial primary key,
	Customer_ID int references Customers(Customer_ID),
	Book_ID int references Books(Book_ID),
	Order_Date date,
	Quantity int,
	Total_Amount numeric(10,2)
);

select * from Books;
select * from Customers;
select * from Orders;

--Importing data from Books table
copy Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
from 'C:\Users\Home\Desktop\Data Analyst\sql\Books.csv'
csv header;

--Importing data from Customer table
copy Customers(Customer_ID,Name,Email,Phone,City,Country)
from 'C:\Users\Home\Desktop\Data Analyst\sql\Customers.csv'
csv header;

--Importing data for Orders table
copy Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
from 'C:\Users\Home\Desktop\Data Analyst\sql\Orders.csv'
csv header;

--1)Retrieve all books in 'Fiction' genre
select * from Books where Genre='Fiction';

--2)Find the books published after year 1950
select * from Books where Published_Year>1950;

--3)List all customers from Canada
select * from Customers where Country='Canada';

--4)Show the orders placed in November 2023
select * from Orders where Order_Date between '2023-11-01' and '2023-11-30';

--5)Retrieve the total stocks of books available
select sum(Stock) from Books;

--6)Find the details of most expensive book
select * from Books where price=(select max(price) from Books);
--or
Select * from Books Order by price desc limit 1;

--7)Show all customers who ordered more than 1 quantity of book
select * from customers where Customer_Id in (select Customer_ID from Orders where Quantity>1);

--8)Retrieve all orders where total amount exceeds $20
select * from Orders where Total_Amount>20;

--9)List all genres available in the books table
select distinct(Genre) from Books;

--10)find the book with the lowest stock
select * from books where stock=(select min(stock) from books);
--or
select * from books order by Stock limit 1;

--11)Calculate the total revenue generated from all orders;
select sum(Total_Amount) from Orders;

--Advanced queries

--1)Retrieve the total number of books sold from each genre
select b.Genre, sum(o.Quantity) as Books_Sold
from Books b join Orders o 
on b.Book_ID=o.Book_ID
group by b.Genre;

--2)Find the average price of books in the 'Fantasy' genre
select avg(price)
from Books
where Genre='Fantasy';

--3)List customers who have placed atleast 2 orders
select * 
from Customers 
where Customer_ID in 
				(select Customer_ID 
				from Orders 
				group by Customer_ID 
				HAVING count(Customer_ID)>=2);

--4)Find the most frequently ordered book
select Book_ID
from Books 
where Book_ID in (select Book_ID 
				  from Orders
			      group by Book_ID
				  order by count(Book_ID) desc limit 1);

select Book_ID,count(Book_ID) from orders group by Book_ID order by count(Book_ID) DESC;
--FOR CHECKING THE LOGIC OF RETIEVING FREQUENTLY ORDERED BOOKS


--5)Show the top 3 most expensive books of 'fantasy' genre
select * 
from Books
where Genre='Fantasy'
order by Price desc limit 3;

--6)Total quantity of Book sold by each author
select b.Author, sum(o.quantity)
from Books b join Orders o
on b.Book_ID=o.Book_ID
group by b.Author;

--7)List the cities where customer who spent over $30 are located
select distinct(City) 
from customers
where Customer_ID in (select Customer_ID 
					  from Orders 
					  where Total_Amount>30);

--8)find the customers who spent the most on orders
select c.Name,c.Customer_ID, sum(o.Total_Amount)
from Customers c join Orders o
on c.Customer_ID=o.Customer_ID
group by c.Customer_ID
order by sum(o.Total_Amount) desc limit 1;

--9)Calculate the stock remaining after fulfilling all the orders
select b.Book_ID,b.Title,b.stock,sum(o.quantity),
	   case
	   when b.stock-sum(o.quantity)>=0 then b.stock-sum(o.quantity)
	   else 0
	   end as Remaining_Stock
from Books b join Orders o
on b.Book_ID=o.Book_ID
group by b.Book_ID;
