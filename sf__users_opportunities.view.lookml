- view: sf__users_opportunities
  extends: sf__users

  fields:
  - measure: average_revenue_pipeline
    type: number
    sql: ${sf__opportunities.total_pipeline_revenue}/ NULLIF(${count},0)
    value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00'
    drill_fields: [sf__accounts.id, sf__opportunities.created_date, sf__opportunities.closed_date, sf__opportunities.total_revenue]

  sets:
    opportunity_set:
      - average_revenue_pipeline