CREATE TABLE logs_v2 (
log_id BIGINT,
transaction_id BIGINT,
category STRING,
comment STRING,
log_timestamp TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://tempbaket/logs_v2_.txt';



SELECT log_id, transaction_id, category, comment, log_timestamp FROM logs_v2;