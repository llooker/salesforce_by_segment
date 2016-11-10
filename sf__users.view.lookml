- view: sf__users
  extends: sfbase__users
  
  fields:
  - filter: name_select
    suggest_dimension: name
  
# Dimension not in salesforce_by_segment schema
#  - dimension: created
#    timeframes: [date, week, month, raw]
          
#  - dimension: age_in_months
#    type: number
#    sql: datediff(days,${created_raw},current_date)
          
  - measure: average_revenue_pipeline
    type: number
    sql: ${sf__opportunities.total_pipeline_revenue}/ NULLIF(${count},0)
    value_format: '[>=1000000]$0.00,,"M";[>=1000]$0.00,"K";$0.00'
    drill_fields: [sf__accounts.id, sf__opportunities.created_date, sf__opportunities.closed_date, sf__opportunities.total_revenue]

  sets:
    opportunity_set:
      - average_revenue_pipeline