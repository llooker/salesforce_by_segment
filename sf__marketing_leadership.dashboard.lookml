- dashboard: marketing_leadership
  title: "Sales & Marketing Leadership"
  layout: tile
  tile_size: 100


  filters:
## For use with accounts.billing_state and leads.state
#   - name: state
#     type: field_filter
#     explore: sf__leads
#     field: sf__leads.state
  filters:
  - name: current_period
    type: date_filter
    default_value: 10 months

  elements:

  - name: new_customers
    title: 'New Customers'
    type: single_value
    height: 2
    width: 4
    model: salesforce_by_segment
    explore: sf__accounts
    dimensions: [sf__accounts.type, sf__accounts.is_in_created_date_filter]
    measures: [sf__accounts.count]
    dynamic_fields:
    - table_calculation: count
      label: Count
      expression: ${sf__accounts.count}
    - table_calculation: total
      label: Total
      expression: ${sf__accounts.count:total}
      value_format: "#,###"
      value_format_name: decimal_0
    filters:
      sf__accounts.type: Customer
    listen:
      current_period: sf__accounts.created_date_condition
#       state: sf__acounts.billing_state
    sorts: [sf__accounts.is_in_created_date_filter desc]
    limit: '1'
    column_limit: '50'
    total: true
    #query_timezone: America/Los_Angeles
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: New Customers
    comparison_label: Total Active Customers
    hidden_fields: [sf__accounts.count]

  - name: total_revenue_this_quarter
    title: 'Total Revenue Closed (Quarter-to-Date)'
    height: 2
    width: 4
    type: single_value
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [sf__opportunities.is_in_close_date_filter]
    measures: [sf__opportunities.total_revenue]
    dynamic_fields:
    - table_calculation: sum
      label: Sum
      expression: ${sf__opportunities.total_revenue}
      value_format: "$#,###"
    - table_calculation: total
      label: Total
      expression: ${sf__opportunities.total_revenue:total}
      value_format: "$#,###"
      value_format_name: decimal_0
    filters:
      sf__opportunities.stage_name: '8 - Closed / Won'
    listen:
      current_period: sf__opportunities.close_date_condition
#       state: sf__leads.state
    sorts: [sf__opportunities.is_in_close_date_filter desc]
    font_size: medium
    text_color: black
    limit: '1'
    column_limit: '50'
    total: true
    #query_timezone: America/Los_Angeles
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: New Revenue Closed
    comparison_label: Total Revenue Closed
    hidden_fields: [sf__opportunities.total_revenue]

  - name: average_deal_size_this_quarter
    title: 'Average Deal Size (Quarter-to-Date)'
    type: single_value
    height: 2
    width: 4
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [sf__opportunities.is_in_close_date_filter]
    measures: [sf__opportunities.average_deal_size]
    dynamic_fields:
    - table_calculation: avg
      label: Average
      expression: ${sf__opportunities.average_deal_size}
      value_format: "$#,###"
    - table_calculation: total
      label: Total
      expression: ${sf__opportunities.average_deal_size:total}
      value_format: "$#,###"
      value_format_name: decimal_0
    filters:
      sf__opportunities.stage_name: '8 - Closed / Won'
    listen:
      current_period: sf__opportunities.close_date_condition
#       state: sf__leads.state
    sorts: [sf__opportunities.is_in_close_date_filter desc]
    font_size: medium
    text_color: black
    limit: '1'
    column_limit: '50'
    total: true
    #query_timezone: America/Los_Angeles
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Average New Deal Size
    comparison_label: Historical Average
    hidden_fields: [sf__opportunities.average_deal_size]



# For use with opportunities.type
  - name: lead_to_win_funnel_this_quarter
    title: 'Lead to Win Funnel (Current Period)'
    type: looker_column
    height: 4
    width: 6
    model: salesforce_by_segment
    explore: sf__leads
    measures: [sf__leads.count, sf__opportunities.count_new_business, sf__opportunities.count_new_business_won]
    filters:
      sf__leads.status: -%Unqualified%
    listen:
      current_period: sf__leads.created_date
#       state: sf__leads.state
    sorts: [sf__leads.count desc]
    limit: 500
    stacking: ''
    colors: ['#635189', '#a2dcf3', '#1ea8df']
    show_value_labels: true
    label_density: 10
    label_color: ['#635189', '#a2dcf3', '#1ea8df']
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    series_labels:
      sf__leads.count: Leads
      sf__opportunities.count_new_business: Opportunities
      sf__opportunities.count_new_business_won: Won Opportunities
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true


  - name: pipeline_forecast
    title: 'Pipeline Forecast'
    type: looker_column
    height: 4
    width: 6
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [sf__opportunities.probability_group, sf__opportunities.close_month]
    pivots: [sf__opportunities.probability_group]
    measures: [sf__opportunities.total_revenue]
    filters:
      sf__opportunities.close_month: 1 months ago for 12 months
#     listen:
#       state: sf__leads.state
    sorts: [sf__opportunities.probability_group, sf__opportunities.close_month]
    query_timezone: America/Los_Angeles
    stacking: normal
    hidden_series: [Under 20%, Lost]
    colors: [lightgrey, '#1FD110', '#95d925', '#d0ca0e', '#c77706', '#bf2006', black]
    show_value_labels: true
    label_density: 21
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    series_labels:
      '0': Lost
      100 or Above: Won
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Amount in Pipeline]
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Opportunity Close Month
    show_x_axis_ticks: true
    x_axis_datetime_label: '%b %y'
    x_axis_scale: ordinal
    ordering: none
    show_null_labels: false

  - name: rep_roster_and_total_pipeline_revenue
    title: 'Rep Roster with Pipeline Revenue and Average Annual Revenue'
    type: looker_column
    height: 4
    width: 12
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [opportunity_owners.name]
    measures: [sf__opportunities.total_pipeline_revenue, sf__opportunities.average_revenue_won]
    filters:
      opportunity_owners.name: -NULL
      sf__opportunities.count_won: '>0'
      sf__opportunities.total_revenue: '>0'
#     listen:
#       state: sf__leads.state
    sorts: [opportunity_owners.total_pipeline_revenue desc]
    limit: 12
#    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#635189', '#b3a0dd']
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    x_padding_right: 15
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_orientation: [right]
    x_axis_label_rotation: 0
    show_null_labels: false

#   - name: prospects_by_forecast_category
#     title: 'Opportunities by Forecast Category'
#     type: looker_pie
#     model: salesforce_by_segment
#     explore: sf__opportunities
#     dimensions: [sf__opportunities.forecast_category]
#     measures: [sf__opportunities.count]
# #    listen:
# #      state: account.billing_state
#     filters:
#       opportunity.stage_name: -%Closed%
#     sorts: [opportunity.close_month, opportunity.forecast_category]
#     limit: 500
#     column_limit: 50
#     show_value_labels: false
#     font_size: 12
#     show_view_names: true
#     height: 4
#     width: 6
  - name: leads_by_month
    title: "Lead Gen by Month"
    type: looker_area
    model: salesforce_by_segment
    explore: sf__leads
    dimensions: [sf__leads.created_month]
    measures: [sf__leads.count]
    filters:
      sf__leads.status: -%Unqualified%
      sf__leads.created_month: last 24 months
    sorts: [sf__leads.created_month desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 10
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_row_numbers: true
    colors: ['#635189', '#a2dcf3', '#1ea8df']
    label_color: ['#635189', '#a2dcf3', '#1ea8df']
    series_labels:
      sf__leads.count: Leads
      sf__opportunities.count_new_business: Opportunities
      sf__opportunities.count_new_business_won: Won Opportunities
      __FILE: salesforce_by_segment/sf__ops_management.dashboard.lookml
      __LINE_NUM: 145
    show_null_labels: false
    show_dropoff: true
    ordering: none
    series_types: {}

  - name: deals_closed_by_month
    title: 'Deals Closed by Month' #by Segment
    type: looker_area
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [sf__opportunities.close_month] # sf__accounts.business_segment]
    #pivots: [sf__accounts.business_segment]
    measures: [sf__opportunities.count]
    filters:
      sf__opportunities.close_month: before tomorrow
      sf__opportunities.stage_name: '8 - Closed / Won'
      sf__opportunities.close_month: last 24 months
#     listen:
#       state: sf__leads.state
    sorts: [sf__opportunities.close_month] #, sf__accounts.business_segment, sf__accounts.business_segment__sort_]
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 6


#  - name: sales_segment_performance
#    title: 'Sales Segment Performance'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: opportunity
#    dimensions: [account.business_segment]
#    measures: [account.count_customers, opportunity.total_revenue]
#    filters:
#      account.business_segment: -Unknown
#      opportunity.stage_name: '8 - Closed / Won'
#    sorts: [opportunity.close_month, account.business_segment, account.business_segment__sort_]
#    limit: 500
#    column_limit: 50
#    stacking: ''
#    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
#      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
#    show_value_labels: true
#    label_density: 25
#    font_size: 12
#    hide_legend: true
#    x_axis_gridlines: false
#    y_axis_gridlines: true
#    show_view_names: false
#    y_axis_combined: false
#    show_y_axis_labels: true
#    show_y_axis_ticks: true
#    y_axis_tick_density: default
#    show_x_axis_label: true
#    show_x_axis_ticks: true
#    x_axis_scale: auto
#    y_axis_orientation: [left, right]
#    show_null_labels: false
