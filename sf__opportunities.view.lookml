- view: sf__opportunities
  extends: sfbase__opportunities

  fields:

  - filter: close_date_condition
    type: date

  - dimension: is_in_close_date_filter
    type: yesno
    sql: |
          {% condition close_date_condition %} ${close_date} {% endcondition %}

  - dimension: is_lost
    type: yesno
    sql: ${is_closed} AND NOT ${is_won}

  - dimension: probability_group
    sql_case:
      'Won': ${probability} = 100
      'Above 80%': ${probability} > 80
      '60 - 80%': ${probability} > 60
      '40 - 60%': ${probability} > 40
      '20 - 40%': ${probability} > 20
      'Under 20%': ${probability} > 0
      'Lost': ${probability} = 0

  - dimension: created
    timeframes: [date, week, month, quarter, raw]

  - dimension: close
    timeframes: [date, week, month, quarter, raw]

  - measure: opportunities_in_close_date_filter
    type: count
    filters:
      is_in_close_date_filter: yes

  - dimension: days_open
    type: number
    sql: datediff(days, ${created_raw}, coalesce(${close_raw}, current_date) )

  - dimension:  created_to_closed_in_60
    hidden: true
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} = 'yes' AND ${is_won} = 'yes'

  # measures #

  - measure: total_revenue
    type: sum
    sql: ${amount}
    value_format: '$#,##0'

  - measure: average_revenue_won
    label: 'Average Revenue (Closed/Won)'
    type: average
    sql: ${amount}
    filters:
      is_won: Yes
    value_format: '$#,##0'

  - measure: average_revenue_lost
    label: 'Average Revenue (Closed/Lost)'
    type: average
    sql: ${amount}
    filters:
      is_lost: Yes
    value_format: '$#,##0'

  - measure: total_pipeline_revenue
    type: sum
    sql: ${amount}
    filters:
      is_closed: No
    value_format: '[>=1000000]0.00,,"M";[>=1000]0.00,"K";$0.00'

  - measure: average_deal_size
    type: avg
    sql: ${amount}
    value_format: '$#,##0'

  - measure: count_won
    type: count
    filters:
      is_won: Yes
    drill_fields: [sf__opportunity.id, sf__account.id, type]

  - measure: average_days_open
    type: avg
    sql: ${days_open}

  - measure: count_closed
    type: count
    filters:
      is_closed: Yes

  - measure: count_open
    type: count
    filters:
      is_closed: No

  - measure: count_lost
    type: count
    filters:
      is_closed: Yes
      is_won: No
    drill_fields: [sf__opportunities.id, sd__accounts.id, sf__opportunities.type]

  - measure: win_percentage
    type: number
    sql: 100.00 * ${count_won} / NULLIF(${count_closed}, 0)
    value_format: '#0.00\%'

  - measure: open_percentage
    type: number
    sql: 100.00 * ${count_open} / NULLIF(${count}, 0)
    value_format: '#0.00\%'

  - measure: count_new_business_won
    type: count
    filters:
      is_won: Yes
      sf__opportunities.type: 'Net New,New Business'
    drill_fields: [sf__opportunities.id, sf__account.id, sf__opportunities.type]

  - measure: count_new_business
    type: count
    filters:
      sf__opportunities.type: 'Net New,New Business'
    drill_fields: [sf__opportunities.id, sf__accounts.name, sf__opportunities.type]
