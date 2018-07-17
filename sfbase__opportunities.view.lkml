view: sfbase__opportunities {
  sql_table_name: salesforce.opportunities ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension_group: close {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.close_date ;;
  }

  dimension: created_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_date ;;
  }

  dimension: infer_3_score_index_c {
    type: number
    sql: ${TABLE}.infer_3_score_index_c ;;
  }

  dimension: is_closed {
    type: yesno
    sql: ${TABLE}.is_closed ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.is_deleted ;;
  }

  dimension: is_won {
    type: yesno
    sql: ${TABLE}.is_won ;;
  }

  dimension: is_lost {
    type: yesno
    sql: ${is_closed} AND NOT ${is_won} ;;
  }

  dimension_group: last_activity {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_activity_date ;;
  }

  dimension: last_modified_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.last_modified_by_id ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: last_referenced {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_referenced_date ;;
  }

  dimension_group: last_viewed {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_viewed_date ;;
  }

  dimension: owner_id {
    type: string
    hidden: yes
    sql: ${TABLE}.owner_id ;;
  }

  dimension: plan_c {
    type: string
    sql: ${TABLE}.plan_c ;;
  }

  dimension_group: received {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension: channel_partner {
    type: string
    sql:  ${TABLE}.channel_partner_c ;;
  }

  dimension: total_value_c {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: upsell_c {
    type: yesno
    sql: ${TABLE}.upsell_c ;;
  }

  measure: average_won_velocity {
    label: "Average Won Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${close_date}) ;;
    value_format: "#"

    filters: {
      field: is_won
      value: "Yes"
    }
  }

  measure: average_lost_velocity {
    label: "Average Lost Velocity"
    type: average
    drill_fields: [detail*]
    sql: datediff(days, ${created_date}, ${close_date}) ;;
    value_format: "#"

    filters: {
      field: is_lost
      value: "Yes"
    }
  }

  set: detail {
    fields: [id,
      #    - company
      #    - name
      #    - title
      #    - phone
      #    - email
      is_won, total_value_c, owner_id]
  }

  measure: count {
    type: count
    drill_fields: [id, stage_name, accounts.id]
  }
}
