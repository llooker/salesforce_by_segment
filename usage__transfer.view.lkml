view: usage__transfer {
  sql_table_name: usage_data.transfer ;;
  suggestions: no

  dimension: bytes {
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: connects {
    type: number
    sql: ${TABLE}.connects ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}."date" ;;
  }

  dimension: delivery_id {
    type: number
    sql: ${TABLE}.delivery_id ;;
  }

  dimension: dest_short_node_id {
    type: string
    sql: ${TABLE}.dest_short_node_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: moid {
    type: string
    sql: ${TABLE}.moid ;;
  }

  dimension: origin {
    type: number
    sql: ${TABLE}.origin ;;
  }

  dimension: protocol {
    type: string
    sql: ${TABLE}.protocol ;;
  }

  dimension: source_short_node_id {
    type: string
    sql: ${TABLE}.source_short_node_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
