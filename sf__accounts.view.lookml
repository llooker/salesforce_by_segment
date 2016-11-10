- view: sf__accounts
  extends: sfbase__accounts
  fields:
  - dimension: created
    timeframes: [date, week, month, raw]

  - measure: percent_of_accounts
    type: percent_of_total
    sql: ${count}
  - measure: count_customers
    type: count
    filters:
      sf__accounts.type: '"Customer"'
