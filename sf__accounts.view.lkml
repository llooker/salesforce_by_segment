include: "sfbase__accounts.view.lkml"
view: sf__accounts {
  extends: [sfbase__accounts]

  filter: created_date_filter {
    type: date
  }

  dimension: is_in_date_filter {
    type: yesno
    sql: {% condition created_date_filter %} ${created_date} {% endcondition %}
      ;;
  }

  dimension: created {
    #X# Invalid LookML inside "dimension": {"timeframes":["date","week","month","raw"]}
  }

  measure: customer_created_in_date_filter {
    type: count

    filters: {
      field: is_in_date_filter
      value: "yes"
    }
  }

  measure: percent_of_accounts {
    type: percent_of_total
    sql: ${count} ;;
  }

  measure: count_customers {
    type: count

    filters: {
      field: sf__accounts.type
      value: "\"Customer\""
    }
  }
}
