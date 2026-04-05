USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

SELECT
    EVENT_ID,
    AGENT_ID,
    STATUS,
    ERROR_CODE,
    OBJECT_NAME,

    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'You are an AI observability assistant for enterprise agent systems. ',

            'Analyze the following agent event and return exactly seven lines in this format only:\n',

            'ISSUE_TYPE: <TIMEOUT, PERMISSION, DATA_QUALITY, UPSTREAM, SUCCESS, OTHER>\n',
            'SEVERITY: <LOW, MEDIUM, HIGH>\n',
            'ROOT_CAUSE: <short phrase>\n',
            'NEXT_STEP: <short action or NONE>\n',
            'AUTO_REMEDIATE: <YES or NO>\n',
            'CONFIDENCE: <LOW, MEDIUM, HIGH>\n',
            'INCIDENT_LABEL: <short label>\n',

            'Rules: ',
            'If STATUS = SUCCESS, return SUCCESS, LOW severity, ROOT_CAUSE = Successful execution, NEXT_STEP = NONE, AUTO_REMEDIATE = NO. ',
            'If ERROR_CODE indicates timeout, classify as TIMEOUT. ',
            'If ERROR_CODE indicates permission, classify as PERMISSION. ',
            'If ERROR_CODE indicates upstream failure, classify as UPSTREAM. ',
            'If ERROR_CODE indicates null/data issue, classify as DATA_QUALITY. ',

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
    ) AS ADVANCED_DIAGNOSIS

FROM AGENT_EVENT_LOGS
ORDER BY EVENT_TS DESC;