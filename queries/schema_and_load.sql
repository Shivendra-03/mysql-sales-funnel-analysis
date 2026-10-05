CREATE DATABASE IF NOT EXISTS sales_funnel_db;
USE sales_funnel_db;

DROP TABLE IF EXISTS user_events;


CREATE TABLE user_events (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date DATETIME(6) NOT NULL,
    product_id INT NOT NULL,
    amount DECIMAL(10, 2) NULL,
    traffic_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (event_id),
    INDEX idx_user_id (user_id),
    INDEX idx_event_type (event_type),
    INDEX idx_event_date (event_date),
    INDEX idx_traffic_source (traffic_source)
);


SET GLOBAL local_infile = 1;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Sales_funnel_analysis/data/user_events.csv'
INTO TABLE user_events
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(event_id, user_id, event_type, event_date, product_id, @amount, traffic_source)
SET amount = NULLIF(TRIM(@amount), '');

