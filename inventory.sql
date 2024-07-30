/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
Details:
- Checks if the database 'Inventory' exists, if not, exit with an error message.
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the 'products' and 'categories' tables.
- Populates the 'categories' table with sample data.
- Populates the 'products' table with sample data.
- Create stored procedure 'GetAllProducts' to get all categories.
- Create a stored procedure to get all products in a specific category.
- Create a stored procudure to get all products in a specific price range sorted by price in ascending order.
*/

-- Check if the database 'Inventory' exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Inventory')
BEGIN
    PRINT 'Database [Inventory] does not exist. Please create the database and run this script again.'
    RETURN
END

-- Set the default database to 'Inventory'
USE Inventory
GO

-- Create a 'categories' table if it does not exist. 
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        id INT PRIMARY KEY,
        name NVARCHAR(50) NOT NULL,
        -- Add a description column 
        description NVARCHAR(255)
    )
END

-- Create a 'products' table if it does not exist.
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE products (
        id INT PRIMARY KEY,
        name NVARCHAR(50) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        category_id INT,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        -- Add a column to represent the creation date
        created_at DATETIME DEFAULT GETDATE(),
        -- Add a column to represent the last updated date
        updated_at DATETIME DEFAULT GETDATE()
    )
END

-- Remove all rows from the 'products' and 'categories' tables
TRUNCATE TABLE products
TRUNCATE TABLE categories

-- Populate the 'categories' table with sample data
INSERT INTO categories (id, name, description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Clothing items and accessories'),
(3, 'Books', 'Books and reading materials')

-- Populate the 'products' table with sample data
INSERT INTO products (id, name, price, category_id) VALUES
(1, 'Laptop', 999.99, 1),
(2, 'Smartphone', 599.99, 1),
(3, 'Headphones', 99.99, 1),
(4, 'T-shirt', 19.99, 2),
(5, 'Jeans', 39.99, 2),
(6, 'Sneakers', 59.99, 2),
(7, 'Programming in C#', 29.99, 3),
(8, 'The Great Gatsby', 9.99, 3),
(9, 'To Kill a Mockingbird', 14.99, 3)

-- Create a stored procedure 'GetAllProducts' to get all products
IF OBJECT_ID('GetAllProducts', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetAllProducts
END
GO

CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT * FROM products
END
GO

-- Create a stored procedure to get all products in a specific category
IF OBJECT_ID('GetProductsByCategory', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetProductsByCategory
END
GO

-- Create a stored procedure to get all products in a specific category
CREATE PROCEDURE GetProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT * FROM products WHERE category_id = @category_id
END
GO

-- Create a stored procedure to get all products in a specific price range sorted by price in ascending order
IF OBJECT_ID('GetProductsByPriceRange', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetProductsByPriceRange
END
GO

-- Create a stored procedure to get all products in a specific price range sorted by price in ascending order
CREATE PROCEDURE GetProductsByPriceRange
    @min_price DECIMAL(10, 2),
    @max_price DECIMAL(10, 2)
AS
BEGIN
    SELECT * FROM products WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC
END
GO

-- End of script

