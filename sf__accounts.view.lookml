- view: sf__accounts
  extends: sfbase__accounts
  fields:
  
  - filter: created_date_condition  
    type: date
    
  - dimension: is_in_date_filter
    type: yesno
    sql: |
          {% condition created_date_condition %} ${created_date} {% endcondition %}
  

  - dimension: created
    timeframes: [date, week, month, raw]

  - measure: accounts_in_date_filter
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
