- dashboard: marketing_leadership
  title: "Sales & Marketing Leadership"
  layout: tile
  tile_size: 100

## For use with accounts.billing_state and leads.state
#  filters:
#  - name: state
#    type: field_filter
#    explore: account
#    field: account.billing_state

  elements:

  - name: total_active_customers
    title: 'Total Active Customers'
    type: single_value
    model: salesforce_by_segment
    explore: sf__accounts
    measures: [sf__accounts.count]
    #listen:
      #state: sf__accounts.billing_state
    filters:
      sf__accounts.type: '"Customer"'
    sorts: [sf__accounts.count desc]
    font_size: medium
    text_color: '#49719a'
    height: 2
    width: 4

  - name: total_revenue_this_quarter
    title: 'Total Revenue Closed (Quarter-to-Date)'
    type: single_value
    model: salesforce_by_segment
    explore: sf__opportunities
    measures: [sf__opportunities.total_value_c]
    filters:
      sf__opportunities.close_quarter: this quarter
      sf__opportunities.stage_name: '"Closed Won"'
    sorts: [sf__opportunities.total_value_c desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4

  - name: average_deal_size_this_quarter
    title: 'Average Deal Size (Quarter-to-Date)'
    type: single_value
    model: salesforce_by_segment
    explore: sf__opportunities
    measures: [sf__opportunities.average_deal_size]
    filters:
      sf__opportunities.close_quarter: this quarter
      sf__opportunities.stage_name: '"Closed Won"'
    sorts: [sf__opportunities.average_deal_size desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4


# For use with opportunities.type
#  - name: lead_to_win_funnel_this_quarter
#    title: 'Lead to Win Funnel (Quarter-to-Date)'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: sf__leads
#    measures: [sf__leads.count, sf__opportunities.count_new_business, sf__opportunity.count_new_business_won]
##    listen:
##      state: sf__leads.state
#    filters:
#      sf__leads.status: -%Unqualified%
#      sf__leads.created_date: this quarter
#    sorts: [sf__leads.count desc]
#    limit: 500
#    stacking: ''
#    colors: ['#635189', '#a2dcf3', '#1ea8df']
#    show_value_labels: true
#    label_density: 10
#    label_color: ['#635189', '#a2dcf3', '#1ea8df']
#    legend_position: center
#    x_axis_gridlines: false
#    y_axis_gridlines: true
#    show_view_names: true
#    series_labels:
#      sf__leads.count: Leads
#      sf__opportunities.count_new_business: Opportunities
#      sf__opportunities.count_new_business_won: Won Opportunities
#    y_axis_combined: true
#    show_y_axis_labels: true
#    show_y_axis_ticks: true
#    y_axis_tick_density: default
#    show_x_axis_label: true
#    show_x_axis_ticks: true
#    x_axis_scale: auto
#    show_null_labels: false
#    show_dropoff: true
#    height: 4
#    width: 6

  - name: deals_closed_by_segment
    title: 'Deals Closed by Month' #by Segment
    type: looker_area
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [sf__opportunities.close_month] #, sf__accounts.business_segment]
    #pivots: [sf__accounts.business_segment]
    measures: [sf__opportunities.count]
    filters:
      sf__opportunities.close_month: before tomorrow
      sf__opportunities.stage_name: '"Closed Won"'
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

#  - name: prospects_by_forecast_category_and_segment
#    title: 'Prospects by Forecast Category and Segment'
#    type: looker_donut_multiples
#    model: salesforce_by_segment
#    explore: sf__opportunities
#    dimensions: [account.business_segment, opportunity.forecast_category]
#    pivots: [opportunity.forecast_category]
#    measures: [account.count]
#    listen:
#      state: account.billing_state
#    filters:
#      account.business_segment: -Unknown
#      opportunity.stage_name: -%Closed%
#    sorts: [opportunity.close_month, account.business_segment, account.business_segment__sort_,
#      opportunity.forecast_category]
#    limit: 500
#    column_limit: 50
#    show_value_labels: false
#    font_size: 12
#    show_view_names: true
#    height: 4
#    width: 6

#  - name: pipeline_forecast
#    title: 'Pipeline Forecast'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: opportunity
#    dimensions: [opportunity.probability_group, opportunity.close_month]
#    pivots: [opportunity.probability_group]
#    measures: [opportunity.total_revenue]
#    filters:
#      opportunity.close_month: 9 months ago for 12 months
#    sorts: [opportunity.probability_group, opportunity.close_month, opportunity.probability_group__sort_]
#    query_timezone: America/Los_Angeles
#    stacking: normal
#    hidden_series: [Under 20%, Lost]
#    colors: [lightgrey, '#1FD110', '#95d925', '#d0ca0e', '#c77706', '#bf2006', black]
#    show_value_labels: true
#    label_density: 21
#    legend_position: center
#    x_axis_gridlines: false
#    y_axis_gridlines: false
#    show_view_names: false
#    series_labels:
#      '0': Lost
#      100 or Above: Won
#    y_axis_combined: true
#    show_y_axis_labels: true
#    show_y_axis_ticks: true
#    y_axis_labels: [Amount in Pipeline]
#    y_axis_tick_density: default
#    show_x_axis_label: true
#    x_axis_label: Opportunity Close Month
#    show_x_axis_ticks: true
#    x_axis_datetime_label: '%b %y'
#    x_axis_scale: ordinal
#    ordering: none
#    show_null_labels: false


#  - name: sales_segment_performance
#    title: 'Sales Segment Performance'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: opportunity
#    dimensions: [account.business_segment]
#    measures: [account.count_customers, opportunity.total_revenue]
#    filters:
#      account.business_segment: -Unknown
#      opportunity.stage_name: '"Closed Won"'
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

  - name: rep_roster_and_total_pipeline_revenue
    title: 'Rep Roster By Average Annual Revenue and Total Pipeline Revenue'
    type: looker_column
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [opportunity_owners.name]
    measures: [sf__opportunities.total_pipeline_revenue, sf__opportunities.average_revenue_won]
    filters:
      opportunity_owners.name: -NULL
      sf__opportunities.count_won: '>0'
    sorts: [opportunity_owners.name desc]
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
