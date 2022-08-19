DROP TABLE IF EXISTS resturants CASCADE;

CREATE TABLE resturants (
  resturant_id SERIAL PRIMARY KEY NOT NULL,
  resturant_name TEXT NOT NULL,
  resturant_phone_number TEXT NOT NULL,
  resturant_street_address TEXT NOT NULL,
  resturant_city_address TEXT NOT NULL,
  resturant_postal_code_address TEXT NOT NULL
);

INSERT INTO resturants (resturant_name, resturant_phone_number, resturant_street_address, resturant_city_address,resturant_postal_code_address)
VALUES ('Noodles World', '778-681-3333', '1234 Oak Street', 'Vancouver', 'V9K 2K2');

DROP TABLE IF EXISTS resturant_hours CASCADE;
CREATE TABLE resturant_hours (
  hours_id SERIAL PRIMARY KEY NOT NULL,
  day_of_week INTEGER NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  resturant_id INTEGER REFERENCES resturants (resturant_id)
);

INSERT INTO resturant_hours (day_of_week, start_time, end_time, resturant_id)
VALUES ('1', '10:00AM', '10:00PM', 1),
('2', '10:00AM', '10:00PM', 1),
('3', '10:00AM', '10:00PM', 1),
('4', '10:00AM', '10:00PM', 1),
('5', '10:00AM', '10:00PM', 1),
('6', '10:00AM', '10:00PM', 1),
('7', '10:00AM', '10:00PM', 1);


DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY NOT NULL,
  order_customer_name TEXT NOT NULL,
  order_customer_phone_number TEXT NOT NULL,
  order_created_on TIMESTAMP NOT NULL DEFAULT now(),
  order_ready_on TIMESTAMP,
  order_fulfilled_on TIMESTAMP,
  resturant_id INTEGER REFERENCES resturants (resturant_id)
);
INSERT INTO orders (order_customer_name, order_customer_phone_number, resturant_id)
VALUES ('Sam Leung', '778-681-1234', '1');



DROP TABLE IF EXISTS item_categories CASCADE;
CREATE TABLE item_categories (
  category_id SERIAL PRIMARY KEY NOT NULL,
  category_name TEXT  NOT NULL
);
INSERT INTO item_categories (category_name)
VALUES ('food'),
('drinks');

DROP TABLE IF EXISTS items CASCADE;
CREATE TABLE items (
  item_id SERIAL PRIMARY KEY NOT NULL,
  item_name TEXT NOT NULL,
  item_description TEXT NOT NULL,
  item_price NUMERIC NOT NULL,
  item_image_url TEXT NOT NULL,
  item_visible BOOLEAN NOT NULL,
  resturant_id INTEGER REFERENCES resturants (resturant_id),
  category_id INTEGER REFERENCES item_categories (category_id)
);
INSERT INTO items (item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id)
VALUES ('Mee Goreng', 'Malaysian', 17.99, 'www.google.com', true, 1, 1), 
('Wonton Noodles', 'Cantonese', 18.99, 'www.google.com', true, 1, 1);



DROP TABLE IF EXISTS line_items CASCADE;
CREATE TABLE line_items (
  line_item_id SERIAL PRIMARY KEY NOT NULL,
  order_id INTEGER REFERENCES orders (order_id),
  line_item_name TEXT NOT NULL,
  line_item_description TEXT NOT NULL,
  line_item_price NUMERIC NOT NULL
);

INSERT INTO line_items (order_id, line_item_name, line_item_description, line_item_price)
VALUES (1,'Mee Goreng', 'Malaysian', 19.99),
(1,'Mee Goreng', 'Malaysian', 19.99);
