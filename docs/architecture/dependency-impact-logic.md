# Dependency Impact Logic

## Purpose
`AGENT_DIRECT_IMPACT` calculates the direct downstream blast radius for non-success incidents.

## Logic
For each failed or non-success incident:
- find dependencies where the incident agent is the parent
- count dependent child agents

## Scope
This version only captures direct downstream impact.
Recursive or transitive full-chain impact can be added later.