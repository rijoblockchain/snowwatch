USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

INSERT INTO AGENT_DEPENDENCIES (
    PARENT_AGENT_ID,
    CHILD_AGENT_ID,
    DEPENDENCY_TYPE,
    CRITICALITY
)
VALUES
('customer_profile_agent', 'fraud_detector', 'DATA_CONTEXT', 'HIGH'),
('fraud_detector', 'fraud_score_writer', 'UPSTREAM_OUTPUT', 'HIGH'),
('customer_profile_agent', 'recommendation_agent', 'FEATURE_INPUT', 'MEDIUM'),
('inventory_updater', 'recommendation_agent', 'DATA_FEED', 'MEDIUM');