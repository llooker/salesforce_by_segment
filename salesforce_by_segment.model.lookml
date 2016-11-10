- connection: segment_sources

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sf__accounts

- explore: campaign_members
  joins:
    - join: campaigns
      type: left_outer 
      sql_on: ${campaign_members.campaign_id} = ${campaigns.id}
      relationship: many_to_one

    - join: sf__leads
      type: left_outer 
      sql_on: ${campaign_members.lead_id} = ${sf__leads.id}
      relationship: many_to_one


- explore: campaigns

- explore: events
  joins:
    - join: sf__accounts
      type: left_outer 
      sql_on: ${events.account_id} = ${sf__accounts.id}
      relationship: many_to_one


- explore: sf__leads

- explore: sf__opportunities
  joins:
    - join: sf__accounts
      type: left_outer 
      sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id}
      relationship: many_to_one


- explore: opportunity_field_history

- explore: opportunity_history

- explore: opportunity_stage

- explore: tasks
  joins:
    - join: sf__accounts
      type: left_outer 
      sql_on: ${tasks.account_id} = ${sf__accounts.id}
      relationship: many_to_one


- explore: users

