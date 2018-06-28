include: "sfbase__leads.view.lkml"
view: sf__leads {
  extends: [sfbase__leads]

  dimension: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["time","date","week","month","raw"]}
  }

  dimension: mql_date {
    sql:CASE
    WHEN ${TABLE}.marketing_qualified_date_c is not null THEN ${TABLE}.marketing_qualified_date_c
    WHEN ${TABLE}.mkto_71_acquisition_program_c = 'WF Trial-Video Form'  THEN ${TABLE}.mkto_71_acquisition_date_c
    WHEN ${TABLE}.mkto_71_acquisition_program_c = 'WF Trial-SCCM Free Form'  THEN ${TABLE}.mkto_71_acquisition_date_c
    WHEN ${TABLE}.mkto_71_acquisition_program_c = 'WF Trial-Platform Form'  THEN ${TABLE}.mkto_71_acquisition_date_c
    WHEN ${TABLE}.mkto_71_acquisition_program_c = 'WF Trial Request Form'  THEN ${TABLE}.mkto_71_acquisition_date_c
    WHEN ${TABLE}.mkto_71_acquisition_program_c = 'WF Contact Form'  THEN ${TABLE}.mkto_71_acquisition_date_c
    ELSE null
    END
    ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  #  - dimension: number_of_employees_tier
  #    type: tier
  #    tiers: [0, 1, 11, 51, 201, 501, 1001, 5001, 10000]
  #    sql: ${number_of_employees}
  #    style: integer
  #    description: "Number of Employees as reported on the Salesforce lead"

  dimension: acquisition_program {
    type: string
    sql: ${TABLE}.mkto_71_acquisition_program_c ;;
  }

  dimension_group: acquisition_date {
    type: time
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.mkto_71_acquisition_date_c ;;
  }

  dimension_group: last_status_updated_timestamp {
    type: time
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.statushistory_last_status_updated_c ;;
  }

  dimension: net_new_lead_timestamp {
    type: date
    sql: ${TABLE}.new_lead_status_timestamp_c ;;
  }

  dimension_group: marketing_qualified_timestamp {
    type: time
    hidden: yes
    timeframes: [time, date, week, month]
    sql: ${TABLE}.marketing_qualified_date_c ;;
  }

  measure: net_new_leads_count {
    type: count
    drill_fields: [detail*]
    filters: {
      field: net_new_lead_timestamp
      value: "-null"
    }
  }

  measure:  net_active_leads_count {
    type: count
    drill_fields: [detail*]
  }

  measure: net_mql_count {
    type: count
    drill_fields: [detail*]
    filters: {
      field: mql_date
      value: "-null"
    }
  }

  measure: converted_to_contact_count {
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_contact_id
      value: "-null"
    }
  }

  measure: converted_to_account_count {
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_account_id
      value: "-null"
    }
  }

  measure: converted_to_opportunity_count {
    type: count
    drill_fields: [detail*]

    filters: {
      field: converted_opportunity_id
      value: "-null"
    }
  }

  measure: average_opportunity_velocity {
    label: "Average Opportunity Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${converted_date}) ;;

    filters: {
      field: converted_opportunity_id
      value: "-null"
    }
  }

  measure: average_contact_velocity {
    label: "Average Contact Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${converted_date}) ;;

    filters: {
      field: converted_contact_id
      value: "-null"
    }
  }

  measure: average_account_velocity {
    label: "Average Account Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${converted_date}) ;;

    filters: {
      field: converted_account_id
      value: "-null"
    }
  }

  measure: average_mql_velocity {
    label: "Average MQL Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${mql_date}) ;;

    filters: {
      field: mql_date
      value: "-null"
    }
  }

  measure: conversion_to_contact_percent {
    sql: 100.00 * ${converted_to_contact_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  measure: conversion_to_account_percent {
    sql: 100.00 * ${converted_to_account_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  measure: conversion_to_opportunity_percent {
    sql: 100.00 * ${converted_to_opportunity_count} / NULLIF(${count},0) ;;
    type: number
    value_format: "0.00\%"
  }

  set: detail {
    fields: [id,
      #    - company
      #    - name
      #    - title
      #    - phone
      #    - email
      status]
  }
}
