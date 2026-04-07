# Incident Queue Layer

## Purpose
`SNOWWATCH_INCIDENT_QUEUE` is the operator-facing serving view for prioritized incidents.

## Inputs
- AGENT_INCIDENT_PRIORITY

## Behavior
- includes only non-success incidents
- sorts by priority score descending
- breaks ties using latest event timestamp

## Value
This view provides a dashboard-ready operational queue for incident triage.