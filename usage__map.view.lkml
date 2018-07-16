view: usage__map {
  sql_table_name: usage_data.sf_usage_map ;;
  suggestions: no

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: dms {
    type: string
    sql: ${TABLE}.dms ;;
  }

  dimension: salesforce_id {
    type: string
    sql: ${TABLE}.salesforce_id ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}
