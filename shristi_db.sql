-- Creating the database
CREATE DATABASE shristi_db;

-- Connect to the database
\c shristi_db;

-- Define tables
CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  product_description VARCHAR(150),
  price FLOAT NOT NULL,
  category VARCHAR(20)
);

CREATE TABLE store (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  city VARCHAR(50),
  state VARCHAR(20),
  country VARCHAR(50)
);

CREATE TABLE sales (
  id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES product(id) ON DELETE CASCADE,
  store_id INTEGER REFERENCES store(id) ON DELETE CASCADE,
  quantity INTEGER NOT NULL,
  sale_price FLOAT NOT NULL,
  sales_time TIMESTAMP NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    product_id INTEGER REFERENCES product(id) ON DELETE CASCADE
);

-- Rename column in Product table
ALTER TABLE product RENAME COLUMN description TO product_description;

-- Add column to Store table
ALTER TABLE store ADD COLUMN country VARCHAR(50);

-- Insert data into Product table
INSERT INTO product (name, price, product_description, category)
VALUES 
    ('Headphones', 59.99, 'Noise-canceling wireless headphones with excellent sound quality', 'Electronics'),
    ('T-shirt', 14.99, 'Comfortable and stylish cotton T-shirt', 'Clothing'),
    ('Book', 29.95, 'Informative and engaging non-fiction book', 'Books'),
    ('The book of engineering', 45.95, 'Learn engineering from scratch the professional way', 'Books'),
    ('The Python cookbook', 25.95, 'Python Crash Course for Beginners', 'Books'),
    ('Smartwatch', 199.99, 'Fitness tracker and smartwatch', 'Electronics'),
    ('Desk Lamp', 24.99, 'Adjustable LED desk lamp', 'Homeware'),
    ('Sweatshirt', 29.99, 'Cozy and comfortable pullover sweatshirt', 'Clothing'),
    ('Novel', 15.99, 'Award-winning fiction novel', 'Books'),
    ('Cookbook', 22.99, 'Collection of delicious and easy recipes', 'Books');

-- Insert data into Store table
INSERT INTO store (name, city, state, country)
VALUES 
    ('Tech City', 'San Francisco', 'CA', 'USA'),
    ('Bookstore Chain', 'New York', 'NY', 'USA'),
    ('Grocery Market', 'San Diego', 'CA', 'USA'),
    ('Department Store', 'London', 'UK', 'England'),
    ('Bookstore', 'Chicago', 'IL', 'USA'),
    ('Clothing Outlet', 'Berlin', 'DE', 'Germany'),
    ('Electronics Chain', 'Tokyo', 'JP', 'Japan');

-- Create a user and grant privileges
CREATE USER koju WITH ENCRYPTED PASSWORD 'PASSWORD';
GRANT ALL PRIVILEGES ON DATABASE shristi_db TO koju;

-- Establish relationships
ALTER TABLE sales ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE;
ALTER TABLE sales ADD CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES store(id) ON DELETE CASCADE;
ALTER TABLE users ADD CONSTRAINT fk_user_product_id FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE;
