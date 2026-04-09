import streamlit as st
import pandas as pd
import altair as alt
from snowflake.snowpark.context import get_active_session

st.set_page_config(
    page_title="SnowWatch",
    layout="wide"
)

st.title("SnowWatch - Agentic AI Observability")
st.caption("Operational monitoring, prioritization, and response planning for enterprise agent systems")

session = get_active_session()

# Load data
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

queue_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.SNOWWATCH_INCIDENT_QUEUE
""").to_pandas()

actions_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.INCIDENT_ACTION_QUEUE
    ORDER BY ACTION_PRIORITY DESC, CREATED_AT DESC
""").to_pandas()

details_df = session.sql("""
    SELECT * 
    FROM SNOWWORK_LAB.OBSERVABILITY.SNOWWATCH_INCIDENT_DETAILS
""").to_pandas()

# KPI cards
if not kpis_df.empty:
    row = kpis_df.iloc[0]
    c1, c2, c3, c4 = st.columns(4)
    c1.metric("Total Logs", int(row["TOTAL_LOGS"]))
    c2.metric("Failed Logs", int(row["FAILED_LOGS"]))
    c3.metric("Failure Rate %", float(row["FAILURE_RATE_PCT"]))
    c4.metric("High Severity", int(row["HIGH_SEVERITY_INCIDENTS"]))
else:
    st.warning("No KPI data available.")

st.markdown("---")

# Charts
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

# Incident queue
st.subheader("Incident Queue")
if not queue_df.empty:
    st.dataframe(queue_df, width="stretch")
else:
    st.info("No prioritized incidents available.")

st.markdown("---")

# Action queue
st.subheader("Action Queue")
if not actions_df.empty:
    st.dataframe(actions_df, width="stretch")
else:
    st.info("No actions available.")

st.markdown("---")

# Operator details with filter
st.subheader("Incident Details")

if not details_df.empty:
    agent_options = ["ALL"] + sorted(details_df["AGENT_ID"].dropna().unique().tolist())
    selected_agent = st.selectbox("Filter by Agent", agent_options)

    if selected_agent == "ALL":
        filtered_details = details_df
    else:
        filtered_details = details_df[details_df["AGENT_ID"] == selected_agent]

    st.dataframe(filtered_details, width="stretch")
else:
    st.info("No incident details available.")