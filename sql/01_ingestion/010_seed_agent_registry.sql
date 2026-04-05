USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

INSERT INTO AGENT_REGISTRY (
    AGENT_ID,
    AGENT_NAME,
    AGENT_DOMAIN,
    AGENT_OWNER,
    BUSINESS_CRITICALITY,
    DEFAULT_MODEL,
    ACTIVE_FLAG
)
VALUES
('fraud_detector', 'Fraud Detector', 'Risk', 'RiskOps', 'HIGH', 'llama3.1-8b', 'Y'),
('recommendation_agent', 'Recommendation Agent', 'Sales', 'GrowthOps', 'MEDIUM', 'llama3.1-8b', 'Y'),
('customer_chatbot', 'Customer Chatbot', 'Support', 'CXOps', 'HIGH', 'llama3.1-8b', 'Y'),
('inventory_updater', 'Inventory Updater', 'SupplyChain', 'Ops', 'MEDIUM', 'llama3.1-8b', 'Y'),
('customer_profile_agent', 'Customer Profile Agent', 'Customer360', 'DataOps', 'HIGH', 'llama3.1-8b', 'Y'),
('fraud_score_writer', 'Fraud Score Writer', 'Risk', 'RiskOps', 'HIGH', 'llama3.1-8b', 'Y');