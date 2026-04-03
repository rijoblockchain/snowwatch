# Structured Prompt Design Decision

## Context
Initial Cortex experiments produced useful but free-form outputs. Success logs also generated unnecessary debugging steps.

## Decision
Adopt a constrained four-line structured diagnosis format:
- ISSUE_TYPE
- SEVERITY
- ROOT_CAUSE
- NEXT_STEP

## Rationale
This makes Cortex output:
- easier to validate
- easier to store
- easier to parse in SQL
- more suitable for analytics and dashboards

## Special Rule
Success logs must return:
- ISSUE_TYPE: SUCCESS
- SEVERITY: LOW
- ROOT_CAUSE: Successful execution
- NEXT_STEP: NONE