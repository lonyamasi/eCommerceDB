-- E-commerce Database Schema with Sample Data


-- Drop tables if they already exist (for testing purposes)
DROP TABLE IF EXISTS product_attribute, product_variation, product_item, product_image, size_option,
size_category, attribute_type, attribute_category, product, product_category, color, brand;

-- Brand table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    brand_description TEXT
);

INSERT INTO brand (brand_name, brand_description) VALUES
('Nike', 'Leading sportswear and athletic brand'),
('Adidas', 'Popular German sportswear brand');

-- Product category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO product_category (category_name, description) VALUES
('Shoes', 'Footwear products including sneakers and boots'),
('Apparel', 'Clothing items like shirts and jackets');

-- Product table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

INSERT INTO product (name, brand_id, category_id, base_price) VALUES
('Air Max 270', 1, 1, 120.00),
('Ultraboost 22', 2, 1, 180.00);

-- Product image table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO product_image (product_id, image_url) VALUES
(1, 'images/airmax270-front.jpg'),
(1, 'images/airmax270-side.jpg'),
(2, 'images/ultraboost22.jpg');

-- Color table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

INSERT INTO color (color_name, hex_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000');

-- Size category table
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO size_category (category_name) VALUES
('Men Shoes'),
('Women Shoes');

-- Size option table
CREATE TABLE size_option (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    size_label VARCHAR(10) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

INSERT INTO size_option (size_category_id, size_label) VALUES
(1, '8'),
(1, '9'),
(2, '7');

-- Product item (actual sellable unit)
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_id) REFERENCES size_option(size_id)
);

INSERT INTO product_item (product_id, color_id, size_id, price, stock_quantity) VALUES
(1, 1, 1, 125.00, 10),
(1, 2, 2, 125.00, 5),
(2, 3, 3, 185.00, 8);

-- Product variation table
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_id) REFERENCES size_option(size_id)
);

INSERT INTO product_variation (product_id, color_id, size_id) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 3);

-- Attribute category table
CREATE TABLE attribute_category (
    attr_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO attribute_category (category_name) VALUES
('Material'),
('Performance');

-- Attribute type table
CREATE TABLE attribute_type (
    attr_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

INSERT INTO attribute_type (type_name) VALUES
('Text'),
('Boolean'),
('Number');

-- Product attributes
CREATE TABLE product_attribute (
    attr_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attr_category_id INT,
    attr_type_id INT,
    attr_name VARCHAR(100) NOT NULL,
    attr_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attr_category_id) REFERENCES attribute_category(attr_category_id),
    FOREIGN KEY (attr_type_id) REFERENCES attribute_type(attr_type_id)
);

INSERT INTO product_attribute (product_id, attr_category_id, attr_type_id, attr_name, attr_value) VALUES
(1, 1, 1, 'Material', 'Mesh'),
(1, 2, 3, 'Heel Drop', '10'),
(2, 1, 1, 'Upper Material', 'Primeknit'),
(2, 2, 2, 'Waterproof', 'Yes');
