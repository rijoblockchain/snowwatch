USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

INSERT INTO CORTEX_LOG_LAB (ID, LOG_TEXT) VALUES
(1, 'Agent fraud_detector failed after 12.4 seconds with timeout while querying CUSTOMER_TABLE.'),
(2, 'Agent recommendation_agent completed successfully in 2.1 seconds using SALES_HISTORY and PRODUCT_CATALOG.'),
(3, 'Agent customer_chatbot failed with permission denied error while calling ORDER_SUMMARY_VIEW.'),
(4, 'Agent inventory_updater retried 3 times and failed due to null value in SUPPLY_CHAIN_FEED.');