# Auto Refresh Pipeline

## Purpose
Automate SnowWatch incident enrichment when new telemetry lands in AGENT_EVENT_LOGS.

## Components
- AGENT_EVENT_LOGS_STREAM
- TASK_REFRESH_AGENT_INCIDENT_ENRICHED

## Trigger
The refresh task runs only when the source stream detects new data.

## Current design
This MVP version uses a full refresh pattern for AGENT_INCIDENT_ENRICHED.

## Future improvement
Replace full refresh with incremental merge-based enrichment for better production efficiency.