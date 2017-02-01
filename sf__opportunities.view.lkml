include: "sfbase__opportunities.view.lkml"
view: sf__opportunities {
  extends: [sfbase__opportunities]

  dimension: is_lost {
    type: yesno
    sql: ${is_closed} AND NOT ${is_won} ;;
  }

  #  - dimension: probability_group
  #    sql_case:
  #      'Won': ${probability} = 100
  #      'Above 80%': ${probability} > 80
  #      '60 - 80%': ${probability} > 60
  #      '40 - 60%': ${probability} > 40
  #      '20 - 40%': ${probability} > 20
  #      'Under 20%': ${probability} > 0
  #      'Lost': ${probability} = 0

  dimension: created_raw {
    type:  date_raw
    sql: ${TABLE}.created_date ;;
  }

  dimension: close_raw {
    type:  date_raw
    sql: ${TABLE}.close_date ;;
  }

  dimension: close_quarter {
    type: date_quarter
    sql: ${TABLE}.close_date ;;
  }

  dimension: days_open {
    type: number
    sql: datediff(days, ${created_raw}, coalesce(${close_raw}, current_date) ) ;;
  }

  dimension: created_to_closed_in_60 {
    hidden: yes
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} = 'yes' AND ${is_won} = 'yes' ;;
  }

  # measures #

  measure: total_revenue {
    type: sum
    sql: ${total_value_c} ;;
    value_format: "$#,##0"
  }

  measure: average_revenue_won {
    label: "Average Revenue (Closed/Won)"
    type: average
    sql: ${total_value_c} ;;

    filters: {
      field: is_won
      value: "Yes"
    }

    value_format: "$#,##0"
  }

  measure: average_revenue_lost {
    label: "Average Revenue (Closed/Lost)"
    type: average
    sql: ${total_value_c} ;;

    filters: {
      field: is_lost
      value: "Yes"
    }

    value_format: "$#,##0"
  }

  measure: total_pipeline_revenue {
    type: sum
    sql: ${total_value_c} ;;

    filters: {
      field: is_closed
      value: "No"
    }

    value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";$0.00"
  }

  measure: average_deal_size {
    type: average
    sql: ${total_value_c} ;;
    value_format: "$#,##0"
  }

  measure: count_won {
    type: count

    filters: {
      field: is_won
      value: "Yes"
    }

    drill_fields: [sf__opportunity.id, sf__account.id]
  }

  measure: average_days_open {
    type: average
    sql: ${days_open} ;;
  }

  measure: count_closed {
    type: count

    filters: {
      field: is_closed
      value: "Yes"
    }
  }

  measure: count_open {
    type: count

    filters: {
      field: is_closed
      value: "No"
    }
  }

  measure: count_lost {
    type: count

    filters: {
      field: is_closed
      value: "Yes"
    }

    filters: {
      field: is_won
      value: "No"
    }

    drill_fields: [sf__opportunity.id, sd__account.id]
  }

  measure: win_percentage {
    type: number
    sql: 100.00 * ${count_won} / NULLIF(${count_closed}, 0) ;;
    value_format: "#0.00\%"
  }

  measure: open_percentage {
    type: number
    sql: 100.00 * ${count_open} / NULLIF(${count}, 0) ;;
    value_format: "#0.00\%"
  }
}

## For use with opportunities.type
#  - measure: count_new_business_won
#    type: count
#    filters:
#      is_won: Yes
#      sf__opportunity.type: '"New Business"'
#    drill_fields: [sf__opportunity.id, sf__account.id, type]

## For use with opportunities.type
#  - measure: count_new_business
#    type: count
#    filters:
#      sf__opportunity.type: '"New Business"'
#    drill_fields: [sf__opportunity.id, sd__account.name, type]
