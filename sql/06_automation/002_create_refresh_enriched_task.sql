USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

CREATE OR REPLACE TASK TASK_REFRESH_AGENT_INCIDENT_ENRICHED
    WAREHOUSE = WH_XS
    SCHEDULE = 'USING CRON */15 * * * * UTC'
WHEN
    SYSTEM$STREAM_HAS_DATA('AGENT_EVENT_LOGS_STREAM')
AS
CREATE OR REPLACE TABLE AGENT_INCIDENT_ENRICHED AS
SELECT
    EVENT_ID,
    AGENT_RUN_ID,
    AGENT_ID,
    EVENT_TS,
    STATUS,
    LOG_TEXT,
    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'You are an AI observability assistant for enterprise agent systems. ',
            'Analyze the following agent event and return exactly seven lines in this exact format only:\n',
            'ISSUE_TYPE: <TIMEOUT, PERMISSION, DATA_QUALITY, UPSTREAM, SUCCESS, OTHER>\n',
            'SEVERITY: <LOW, MEDIUM, HIGH>\n',
            'ROOT_CAUSE: <short phrase>\n',
            'NEXT_STEP: <short action or NONE>\n',
            'AUTO_REMEDIATE: <YES or NO>\n',
            'CONFIDENCE: <LOW, MEDIUM, HIGH>\n',
            'INCIDENT_LABEL: <short label>\n',
            'Rules: ',
            'If STATUS = SUCCESS, return ISSUE_TYPE: SUCCESS, SEVERITY: LOW, ROOT_CAUSE: Successful execution, NEXT_STEP: NONE, AUTO_REMEDIATE: NO. ',
            'If ERROR_CODE indicates timeout, classify as TIMEOUT. ',
            'If ERROR_CODE indicates permission, classify as PERMISSION. ',
            'If ERROR_CODE indicates upstream failure, classify as UPSTREAM. ',
            'If ERROR_CODE indicates null or data issue, classify as DATA_QUALITY. ',
            'Do not add anything before or after the seven lines. ',
            'Event Details: ',
            'Agent=', AGENT_ID,
            ', Status=', STATUS,
            ', ErrorCode=', COALESCE(ERROR_CODE, 'NONE'),
            ', Object=', COALESCE(OBJECT_NAME, 'NONE'),
            ', Retries=', RETRY_COUNT,
            ', ExecTimeMs=', EXEC_TIME_MS,
            ', Log=', LOG_TEXT
        )
    ) AS AI_DIAGNOSIS,
    CURRENT_TIMESTAMP() AS ENRICHED_AT
FROM AGENT_EVENT_LOGS;