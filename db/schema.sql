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
VALUES ('Sam''s Pizzaria', '778-681-3333', '1234 Oak Street', 'Vancouver', 'V9K 2K2');

DROP TABLE IF EXISTS resturant_hours CASCADE;
CREATE TABLE resturant_hours (
  hours_id SERIAL PRIMARY KEY NOT NULL,
  day_of_week INTEGER NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  resturant_id INTEGER REFERENCES resturants (resturant_id) NOT NULL
);

INSERT INTO resturant_hours (day_of_week, start_time, end_time, resturant_id)
VALUES ('1', '10:00', '22:00', 1),
('2', '10:00', '22:00', 1),
('3', '10:00', '22:00', 1),
('4', '10:00', '22:00', 1),
('5', '10:00', '22:00', 1),
('6', '10:00', '22:00', 1),
('7', '10:00', '22:00', 1);


DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY NOT NULL,
  order_customer_name TEXT NOT NULL,
  order_customer_phone_number TEXT NOT NULL,
  order_created_on TIMESTAMP NOT NULL DEFAULT now(),
  order_ready_on TIMESTAMP,
  order_fulfilled_on TIMESTAMP,
  resturant_id INTEGER REFERENCES resturants (resturant_id) NOT NULL
);
INSERT INTO orders (order_customer_name, order_customer_phone_number, resturant_id)
VALUES ('Sam Leung', '7786811234', '1'),
('Sharon Mar', '7786814321', '1');



DROP TABLE IF EXISTS item_categories CASCADE;
CREATE TABLE item_categories (
  category_id SERIAL PRIMARY KEY NOT NULL,
  category_name TEXT NOT NULL
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
  resturant_id INTEGER REFERENCES resturants (resturant_id) NOT NULL,
  category_id INTEGER REFERENCES item_categories (category_id) NOT NULL
);

INSERT INTO items (item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id)
VALUES ('Ham and Cheese', 'Tomato sauce, fresh mozzarella, prosciutto ham and spinach', 17.99, 'https://dl.airtable.com/.attachmentThumbnails/8850ce2f59a49bf5e82487b207ad39a9/a881b64f', true, 1, 1),
('Mushroom and Cheese', 'Tomato sauce, fresh mozzarella, portobello mushroom, tomato and spinach', 18.99, 'https://dl.airtable.com/.attachmentThumbnails/76664031c9338cc0e2b15128f26c2bc2/61e1f398', true, 1, 1),
('Margherita and Chesse', 'Margherita sauce, fresh mozzarella and spinach', 19.99, 'https://dl.airtable.com/.attachmentThumbnails/159161777ab3cf3294ad08d588df47a4/021eb575', true, 1, 1),
('Pulled Pork', 'Tomato sauce, fresh mozzarella, pulled pork, corn and onion', 20.99, 'https://dl.airtable.com/.attachmentThumbnails/c5e6641ef5715ec91c233786c9002f50/70f332d0', true, 1, 1),
('Veggies', 'Tomato sauce, fresh mozzarella, eggplant, tomato and spinach', 20.99, 'https://dl.airtable.com/.attachmentThumbnails/3ce46d9ba0ec349747cf75a55e23f5b8/9eaafcc4', true, 1, 1),
('Four Cheese', 'Tomato sauce, fresh mozzarella, gorgonzola, Parmigiano Reggiano, and goat cheese', 22.99, 'https://dl.airtable.com/.attachmentThumbnails/9c1b4c3eb9d675fcb6e214475ca86f0d/9b64a949', true, 1, 1),
('Meat Lover', 'Tomato sauce, fresh mozzarella, beef, tomato and bell pepper', 20.99, 'https://dl.airtable.com/.attachmentThumbnails/4fc8d175a19c4cd562db18f347d1bd8d/e163ad66', true, 1, 1),
('Philly Cheese Steak', 'Tomato sauce, fresh mozzarella, steak, portobello mushroom and spinach', 18.99, 'https://dl.airtable.com/.attachmentThumbnails/66bdbe106502bde2bf5f4942d9d85d0e/26870967', true, 1, 1),
('Ham, Tomato, Mushroom and Cheese', 'Tomato sauce, fresh mozzarella, ham, tomato and bell pepper', 23.99, 'https://dl.airtable.com/.attachmentThumbnails/80aead4137b716b9e6963dd84da12be5/c4315bca', true, 1, 1);

DROP TABLE IF EXISTS line_items CASCADE;
CREATE TABLE line_items (
  line_item_id SERIAL PRIMARY KEY NOT NULL,
  order_id INTEGER REFERENCES orders (order_id) NOT NULL,
  line_item_name TEXT NOT NULL,
  line_item_price NUMERIC NOT NULL
);

INSERT INTO line_items (order_id, line_item_name, line_item_price)
VALUES (1,'Ham and Cheese', 17.99),
(1,'Ham, Tomato, Mushroom and Cheese', 23.99);

