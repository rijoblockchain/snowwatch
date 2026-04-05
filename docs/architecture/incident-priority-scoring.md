# Incident Priority Scoring

## Purpose
`AGENT_INCIDENT_PRIORITY` ranks non-success incidents for operator attention.

## Inputs
- parsed issue type
- severity
- auto-remediation flag
- direct downstream impact count

## Scoring model
Priority score is computed using rule-based weights:
- severity weight
- issue-type weight
- downstream impact weight
- manual intervention weight

## Design rationale
A deterministic scoring model is easier to explain, validate, and tune than a black-box model at the MVP stage.