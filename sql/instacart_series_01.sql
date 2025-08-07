CREATE TABLE aisle (
    aisle_id INT PRIMARY KEY,
    aisle VARCHAR
);

COPY aisle FROM '/aisles.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department VARCHAR
);

COPY department FROM '/departments.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE order_product (
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    add_to_cart_order INT,
    reordered INT,

    PRIMARY KEY (order_id, product_id)
);

COPY order_product FROM '/order_products.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    eval_set VARCHAR,
    order_number INT,
    order_dow INT,
    order_hour_of_day VARCHAR,
    days_since_prior_order FLOAT
);

COPY orders FROM '/orders.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR,
    aisle_id INT,
    department_id INT
);

COPY product FROM '/products.csv' DELIMITER ',' CSV HEADER;



