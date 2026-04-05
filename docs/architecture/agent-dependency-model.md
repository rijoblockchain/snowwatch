# Agent Dependency Model

## Purpose
`AGENT_DEPENDENCIES` defines logical runtime relationships between agents in SnowWatch.

It supports:
- downstream impact analysis
- root incident identification
- dependency-aware scoring
- operational graph visualization

## Interpretation
A row means that the child agent depends on the parent agent for data, context, output, or execution flow.

## Example
If `fraud_score_writer` depends on `fraud_detector`, then failure in `fraud_detector` may impact `fraud_score_writer`.