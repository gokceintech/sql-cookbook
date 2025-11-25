-- Demo ecommerce schema + seed data (MySQL 8)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(id),
  CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

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
  (1, CURRENT_DATE - INTERVAL 10 DAY),
  (1, CURRENT_DATE - INTERVAL 40 DAY),
  (2, CURRENT_DATE - INTERVAL 20 DAY),
  (3, CURRENT_DATE - INTERVAL 5 DAY);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 1, 2, 10.00),
  (1, 2, 1, 25.00),
  (2, 3, 5, 5.00),
  (3, 2, 2, 25.00),
  (4, 1, 1, 10.00);
