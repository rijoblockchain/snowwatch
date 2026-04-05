# Agent Registry Model

## Purpose
`AGENT_REGISTRY` stores metadata about monitored agents in SnowWatch.

It supports:
- agent ownership mapping
- business domain grouping
- criticality-aware incident prioritization
- more informative dashboards and reports

## Design Principle
Keep agent identity and metadata separate from runtime event logs so operational context can evolve independently of telemetry data.