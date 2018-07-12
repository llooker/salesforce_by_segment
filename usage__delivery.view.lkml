view: delivery {
  sql_table_name: usage_data.delivery ;;
  suggestions: no

  dimension: delivery_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.delivery_id ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: content_moid {
    type: string
    sql: ${TABLE}.content_moid ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}."date" ;;
  }

  dimension: dms {
    type: string
    sql: ${TABLE}.dms ;;
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

  dimension: lan_bytes {
    type: number
    sql: ${TABLE}.lan_bytes ;;
  }

  dimension: lans {
    type: number
    sql: ${TABLE}.lans ;;
  }

  dimension: moid {
    type: string
    sql: ${TABLE}.moid ;;
  }

  dimension: origin_bytes {
    type: number
    sql: ${TABLE}.origin_bytes ;;
  }

  dimension: origins {
    type: number
    sql: ${TABLE}.origins ;;
  }

  dimension: peer_bytes {
    type: number
    sql: ${TABLE}.peer_bytes ;;
  }

  dimension: peers {
    type: number
    sql: ${TABLE}.peers ;;
  }

  dimension: short_node_id {
    type: string
    sql: ${TABLE}.short_node_id ;;
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

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: total_bytes {
    type: number
    sql: ${TABLE}.total_bytes ;;
  }

  dimension: type {
    type: number
    sql: ${TABLE}.type ;;
  }

  dimension: wan_bytes {
    type: number
    sql: ${TABLE}.wan_bytes ;;
  }

  dimension: wans {
    type: number
    sql: ${TABLE}.wans ;;
  }

  measure: count {
    type: count
    drill_fields: [delivery_id]
  }
}
