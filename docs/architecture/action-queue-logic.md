# Action Queue Logic

## Purpose
`INCIDENT_ACTION_QUEUE` converts prioritized incidents into candidate operational actions.

## Inputs
- AGENT_INCIDENT_PRIORITY

## Action mapping
- TIMEOUT + AUTO_REMEDIATE=YES -> RETRY_WITH_BACKOFF
- PERMISSION -> VALIDATE_ROLE_AND_GRANTS
- DATA_QUALITY -> QUARANTINE_INPUT_AND_NOTIFY_OWNER
- UPSTREAM -> CHECK_UPSTREAM_AGENT
- otherwise -> MANUAL_REVIEW

## Approval rule
If auto-remediation is allowed, human approval is not required.
Otherwise, action requires human approval.

## Design rationale
Use a persisted table because action queues are operational workflow records, not just analytical views.