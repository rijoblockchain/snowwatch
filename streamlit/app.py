import streamlit as st
import pandas as pd
import altair as alt
from snowflake.snowpark.context import get_active_session

st.set_page_config(
    page_title="SnowWatch for Cortex",
    layout="wide"
)

st.title("SnowWatch for Cortex")
st.caption("AI-powered observability dashboard for agent runtime logs")

# Get active Snowflake session
session = get_active_session()

# Load dashboard datasets
kpis_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.OBSERVABILITY_KPIS
""").to_pandas()

issue_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.INCIDENTS_BY_ISSUE_TYPE
""").to_pandas()

severity_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.INCIDENTS_BY_SEVERITY
""").to_pandas()

details_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.INCIDENT_DETAILS
""").to_pandas()

# KPI section
if not kpis_df.empty:
    row = kpis_df.iloc[0]

    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Total Logs", int(row["TOTAL_LOGS"]))
    col2.metric("Failed Logs", int(row["FAILED_LOGS"]))
    col3.metric("Failure Rate %", float(row["FAILURE_RATE_PCT"]))
    col4.metric("High Severity", int(row["HIGH_SEVERITY_INCIDENTS"]))
else:
    st.warning("No KPI data available.")

st.markdown("---")

# Charts section
left, right = st.columns(2)

with left:
    st.subheader("Incidents by Issue Type")

    if not issue_df.empty:
        chart_issue = alt.Chart(issue_df).mark_bar().encode(
            x=alt.X("ISSUE_TYPE:N", sort="-y", title="Issue Type"),
            y=alt.Y("INCIDENT_COUNT:Q", title="Incident Count"),
            tooltip=["ISSUE_TYPE", "INCIDENT_COUNT"]
        )
        st.altair_chart(chart_issue, width="stretch")
    else:
        st.info("No issue type data available.")

with right:
    st.subheader("Incidents by Severity")

    if not severity_df.empty:
        chart_severity = alt.Chart(severity_df).mark_bar().encode(
            x=alt.X("SEVERITY:N", sort="-y", title="Severity"),
            y=alt.Y("INCIDENT_COUNT:Q", title="Incident Count"),
            tooltip=["SEVERITY", "INCIDENT_COUNT"]
        )
        st.altair_chart(chart_severity, width="stretch")
    else:
        st.info("No severity data available.")

st.markdown("---")

# Details section
st.subheader("Incident Details")

if not details_df.empty:
    st.dataframe(details_df, width="stretch")
else:
    st.info("No incident details available.")