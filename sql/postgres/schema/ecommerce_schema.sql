-- Demo ecommerce schema + seed data (PostgreSQL)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(id),
  order_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE order_items (
  order_id INT NOT NULL REFERENCES orders(id),
  product_id INT NOT NULL REFERENCES products(id),
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id)
);

-- Indexes
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

-- Seed data
INSERT INTO customers (name) VALUES ('Alice'), ('Bob'), ('Carol'), ('Dave');

INSERT INTO products (name, price) VALUES
  ('Widget', 10.00),
  ('Gadget', 25.00),
  ('Doohickey', 5.00);

-- Orders within last 365 days
INSERT INTO orders (customer_id, order_date) VALUES
  (1, CURRENT_DATE - INTERVAL '10 days'),
  (1, CURRENT_DATE - INTERVAL '40 days'),
  (2, CURRENT_DATE - INTERVAL '20 days'),
  (3, CURRENT_DATE - INTERVAL '5 days');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 1, 2, 10.00),
  (1, 2, 1, 25.00),
  (2, 3, 5, 5.00),
  (3, 2, 2, 25.00),
  (4, 1, 1, 10.00);
