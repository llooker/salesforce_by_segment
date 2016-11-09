- connection: segment_sources

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: accounts

- explore: campaign_members
  joins:
    - join: campaigns
      type: left_outer 
      sql_on: ${campaign_members.campaign_id} = ${campaigns.id}
      relationship: many_to_one

    - join: leads
      type: left_outer 
      sql_on: ${campaign_members.lead_id} = ${leads.id}
      relationship: many_to_one


- explore: campaigns

- explore: events
  joins:
    - join: accounts
      type: left_outer 
      sql_on: ${events.account_id} = ${accounts.id}
      relationship: many_to_one


- explore: leads

- explore: opportunities
  joins:
    - join: accounts
      type: left_outer 
      sql_on: ${opportunities.account_id} = ${accounts.id}
      relationship: many_to_one


- explore: opportunity_field_history

- explore: opportunity_history

- explore: opportunity_stage

- explore: tasks
  joins:
    - join: accounts
      type: left_outer 
      sql_on: ${tasks.account_id} = ${accounts.id}
      relationship: many_to_one


- explore: users

