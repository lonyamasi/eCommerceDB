CREATE DATABASE eCOMMERCE;
use eCOMMERCE;

CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    brand_description TEXT
);

-- Product category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Color table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);


CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- 5. size_option table (referenced in product_item)
CREATE TABLE size_option (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_name VARCHAR(50)
);

CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    variation_name VARCHAR(100)
);

CREATE TABLE attribute_category (
    attr_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE attribute_type (
    attr_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);


CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id),
    INDEX idx_brand_id (brand_id),
    INDEX idx_category_id (category_id)
);



-- 3. product_image table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(500),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    INDEX idx_product_id_img (product_id)
);


CREATE TABLE product_attribute (
    attr_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attr_category_id INT,
    attr_type_id INT,
    attr_name VARCHAR(100) NOT NULL,
    attr_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attr_category_id) REFERENCES attribute_category(attr_category_id),
    FOREIGN KEY (attr_type_id) REFERENCES attribute_type(attr_type_id),
    INDEX idx_attr_product_id (product_id),
    INDEX idx_attr_category_id (attr_category_id),
    INDEX idx_attr_type_id (attr_type_id)
);




-- 7. product_item table
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_id INT,
    SKU VARCHAR(100),
    variation_id INT,
    stockquantity INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_id) REFERENCES size_option(size_id),
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id),
    INDEX idx_product_id_item (product_id),
    INDEX idx_color_id (color_id),
    INDEX idx_size_id (size_id),
    INDEX idx_variation_id (variation_id),
    UNIQUE INDEX idx_sku_unique (SKU)
);


