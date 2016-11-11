- view: sf__accounts
  extends: sfbase__accounts
  fields:
  
  - filter: created_date_filter  
    type: date
    
  - dimension: is_in_date_filter
    type: yesno
    sql: |
          {% condition created_date_filter %} ${created_date} {% endcondition %}
  

  - dimension: created
    timeframes: [date, week, month, raw]

  - measure: customer_created_in_date_filter
    type: count
    filters: 
      is_in_date_filter: yes
      
  - measure: percent_of_accounts
    type: percent_of_total
    sql: ${count}
    
  - measure: count_customers
    type: count
    filters:
      sf__accounts.type: '"Customer"'
