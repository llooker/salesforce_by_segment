- view: sf__leads
  extends: sfbase__leads

  fields:
  - dimension_group: created
    timeframes: [time, date, week, month, raw]

  - dimension: name
    html: |
      <a href="https://na9.salesforce.com/{{ lead.id._value }}" target="_new">
      <img src="https://www.salesforce.com/favicon.ico" height=16 width=16></a>
      {{ linked_value }}

  - dimension: number_of_employees_tier
    type: tier
    tiers: [0, 1, 11, 51, 201, 501, 1001, 5001, 10000]
    sql: ${number_of_employees}
    style: integer
    description: "Number of Employees as reported on the Salesforce lead"

  - measure: converted_to_contact_count
    type: count
    drill_fields: detail*
    filters:
      converted_contact_id: -null

  - measure: converted_to_account_count
    type: count
    drill_fields: detail*
    filters:
      converted_account_id: -null

  - measure: converted_to_opportunity_count
    type: count
    drill_fields: detail*
    filters:
      converted_opportunity_id: -null

  - measure: conversion_to_contact_percent
    sql: 100.00 * ${converted_to_contact_count} / NULLIF(${count},0)
    type: number
    value_format: '0.00\%'

  - measure: conversion_to_account_percent
    sql: 100.00 * ${converted_to_account_count} / NULLIF(${count},0)
    type: number
    value_format: '0.00\%'

  - measure: conversion_to_opportunity_percent
    sql: 100.00 * ${converted_to_opportunity_count} / NULLIF(${count},0)
    type: number
    value_format: '0.00\%'

  sets:
    detail:
    - id
    - company
    - name
    - title
    - phone
    - email
    - status
