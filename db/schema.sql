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
VALUES ('1', '10:00', '10:00', 1),
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
  resturant_id INTEGER REFERENCES resturants (resturant_id)
);
INSERT INTO orders (order_customer_name, order_customer_phone_number, resturant_id)
VALUES ('Sam Leung', '778-681-1234', '1'),
('Sharon Mar', '778-681-4321', '1');



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
VALUES ('Italian Spegetti and Meatballs', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/l8XVGuchuYhnfSdpewAwvQ/n2na29n089hYAZmvAw76dxggTYvRQPaFiLdI0yoB1futLZ88cncwik1JxOVDhLJHSh1BOKa3Z6xAfOi5aGaR7A/QHVOasIeC-2ewVYJsm2USgmdvjvvkRup18VLIGE9Xkk', true, 1, 1),
('Indonesian Mee Goreng', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/AY1dU_4Ds1pjK29Q16jEgQ/NdnLrrq-IJ9oBL1S0Edo2kv50uWTRpeqKg2AcbjZCGt9jqXiOj2JtfqprsPLJzSG5DL3xthOE-YtSgOotF8NOQ/JBAYmhxafkRkGJveqJTiDjn2-au2cXU39WDAF1ape-Y', true, 1, 1),
('Cantonese Chow Mein', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/c7QwB4Ja-w_Kg6CQkG-ykQ/aY0VQpAwuT-6TYKnywguPWZLG43STX1i_IqUsRzmJ3TCxmt6sN4Vtz84HUpp1HBJX5r9o-Gxn9oyuXOBZ7-eGw/sz270a9Ay8vQCi4WfKovZFGxsxKC5IyEJpcwgLLMtGo', true, 1, 1),
('Singaporean Laksa', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/4XP7OKALMXPvenIFuwxIIQ/ZRj7fSevJEzhN8cE6R3Y65XfP1p0yoZURCbhZ_dwW0h-V6irnLHxNwNqBbr6vHS8QAmyc6fVj5meheMki4mPvQ/KiJX3iBq6aNmRlAlAiZZUsXGmwkXj8_4suEsUrpc1fw', true, 1, 1),
('Japanese Sanuki Udon', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/Yuf-cubBBEwClD1pRKQs4A/w_qmS1QIz2ofF7NF1BGp7Vvdj1-PFsiKyV0McqdP0VnXP4uGBcuKe1eYkCASbOn0SRP4T1TRI7hzKXRZyqOGjg/g4MFjmVY8B-I3qstwQkVVSBOLOxLvytkC913umrANVo', true, 1, 1),
('Korean Japchae', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/d20ToHTId1iXyQJxygD9Cg/Kk-7oBuV8Etsi6sgv4YXhjF_Dr3k_DVM41qm5El60DZl892uq_uZ4y5AZ-FbND4tBnP4vDZzDZu8sJ8_xdXt2Q/HXWvkieyjN-wUHVMu98nIy-ubBIuW-qdseRI7QWTmYQ', true, 1, 1),
('Italian Pesto Linguine', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/MEQA3E2SQywSztY46ILGIA/hDiXVj4qd0lJYuLIa3T5AbeisDTYMo6__g4Ohcwm15o9eknRCVjfYC5l-l24haj6857A41VJt0j4aAfbzJKNqg/gctLLETUTO7mmLCi4aZFk2RzDc4HMbuhZOhBxvHQ-bM', true, 1, 1),
('Italian Carbonara Spaghetti', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/uiyqHeiuWZwGAAus1l4XSQ/uRXvCuMX4-GOApAvg3gLDgBlfEfd14TgIbhHiUu51KajzLKCipJNCp_Ka3ULoSmk_85ycuBzo67Kjb6vLW0SoQ/3g9DPZLEOZkFYDVOKotRL32TvAaHz5DZRCj7hYy70UA', true, 1, 1),
('Vietnamese Beef Pho', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/JykWiPreN46xCofovE8E8w/rqFxCuWfmniMNmkbo6F8YOo_oWREHCiAgAezBAx0fTFkmMuYbocneLEiF4qrwjlVbYHF0IDiSI9l7OMz7qRUxQ/CtZ0MjKNcxCkaVguFCU91Uuq9lk8KYVig3Q_xNicSRU', true, 1, 1),
('Cantonese Wonton Soup', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/1tz970L6NKWBlCkPX_CKTA/jbPzgZWmrneoDc2wkL_txl4My7JxDeKmf0K0ZyT-4WNhkkXV4Up2wdWuzYn8VTNCrq0Zdcmfe316yBM9aloqJQ/leIuNK48iDna6qyTxXVeFiA1xu7VoDZJHElHNtml8Js', true, 1, 1),
('Japanese Pork Broth Ramen', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/MiDrQCt-R2_8FG59nako8A/ezTm6urb5GYmP06nLoF8HQTifVY9HDWKqwa1BxKoxzeWlNyRODijGSktoj0wX1hFnzi4DVclK6GRKxKVRS1oXw/yZe4TAZrkLbdVQhOO9QEXNdIe6HQCwp3zFtrTGk5y6E', true, 1, 1),
('American Chicken Noodle Soup', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/I6h4u00qHm6-DTnP2oArRg/dg6e96lghgR9BSfN3Bn_6Z1qLu2A1D_TWrgLzlRrLVmNl_zTCLVx2s47I9ChvkbW_oV-19kKhFrpsIKT7Jd25g/BUMcjAEPnjGYbj9CoGJtzcDjDKGjiXC3CJvgPGWPdXU', true, 1, 1),
('Pervian Tallarin Saltado', 'Malaysian', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/Pmza3aKaV_4Fzs-PiIqewg/anG4Kp_IL_uvUaydMdSYQaSNo17MAbQCNm3XjsU6wxyHzauB8-eKn9BodoaqeK-Cut3iMDG3qHuiomC5kCGxJg/N8RVO30x3Ww0ZoFzFyvInsQY8CwEzSzZGuRILo9cHX0', true, 1, 1),
('Egyptian Koshari', 'Cantonese', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/BwQ3kymVYzBZ0YBZHp58lQ/3kn5QY4JTrZZwFef2BDzKxxbrJyE_JL7RrBJ-wYRhBKOyiRfvCbqlhYzwLyGS_v5twYNcT8rX1fIBqXpSufgcQ/V3S9lfV3g1aO-BdEYBAORcS7eizZDMuFkL8hqRGwy0E', true, 1, 1),
('Japanese Soba Noodles', 'Japanese', 17.99, 'https://v5.airtableusercontent.com/v1/7/7/1662595200000/2focJgaeZkdQkjXlFn9A9g/qnWyySFLZyOxM1O-nZfci6FRK-Mv22_CyYCKLZhoR9RyeIx7Dmi_SGrORGQuB5i9qRn8u-9CpZ-eNXk5ZsyyaA/N1BGwJjY9CM4IXq3YeqOD4TtWX9B7JZn-CPI1NlS1hE', true, 1, 1);


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
