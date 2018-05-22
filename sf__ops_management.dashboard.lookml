
- dashboard: ops_management
  title: "Sales Ops Management"
  layout: tile
  tile_size: 100

  filters:
#  - name: sales_team
#    type: field_filter
#    explore: sf__accounts
#    field: sf__accounts.business_segment
#    default_value: 'Enterprise'

  - name: date_range
    type: date_filter

#  - name: state
#    type: field_filter
#    explore: account
#    field: account.billing_state

  elements:

  - name: total_active_customers
    title: 'Total New Customers'
    type: single_value
    model: salesforce_by_segment
    explore: sf__accounts
    measures: [sf__accounts.count]
    listen:
      date_range: sf__accounts.created_date
#      state: sf__accounts.billing_state
#      sales_team: sf__accounts.business_segment
    filters:
      sf__accounts.type: '"Customer"'
    sorts: [sf__accounts.count desc]
    font_size: medium
    text_color: '#49719a'
    height: 2
    width: 4

  - name: total_revenue
    title: 'Total Revenue Closed'
    type: single_value
    model: salesforce_by_segment
    explore: sf__opportunities
    measures: [sf__opportunities.total_revenue]
    listen:
      date_range: sf__opportunities.close_date
#      state: sf__accounts.billing_state
#      sales_team: sf__accounts.business_segment
    filters:
      sf__opportunities.stage_name: '"Closed Won"'
    sorts: [sf__opportunities.total_revenue desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4

  - name: average_deal_size
    title: 'Average Deal Size'
    type: single_value
    model: salesforce_by_segment
    explore: sf__opportunities
    measures: [sf__opportunities.average_deal_size]
    listen:
      date_range: sf__opportunities.close_date
#      state: sf__accounts.billing_state
#      sales_team: sf__accounts.business_segment
    filters:
      sf__opportunities.stage_name: '"Closed Won"'
    sorts: [sf__opportunities.average_deal_size desc]
    font_size: medium
    text_color: black
    height: 2
    width: 4

  - name: lead_to_win_funnel
    title: 'Lead to Win Funnel'
    type: looker_column
    model: salesforce_by_segment
    explore: sf__leads
    measures: [sf__leads.count] #, sf__opportunities.count_new_business, sf__opportunities.count_new_business_won]
    filters:
      sf__leads.status: -%Unqualified%
    listen:
      date_range: sf__leads.created_date
      #state: sf__leads.state
    sorts: [sf__leads.count desc]
    limit: 500
    #query_timezone: America/Los_Angeles
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
    x_axis_rotation: 30
    show_null_labels: false
    show_dropoff: true
    height: 4
    width: 6

  - name: lead_to_win_funnel_table
    title: 'Lead to Win Funnel'
    type: table
    model: salesforce_by_segment
    explore: sf__leads
    dimensions: [sf__leads.created_month]
    measures: [sf__leads.count] #, sf__opportunities.count_new_business, sf__opportunities.count_new_business_won]
    filters:
      sf__leads.status: -%Unqualified%
    listen:
      #state: lead.state
      date_range: sf__leads.created_date
    sorts: [sf__leads.created_month desc]
    limit: 500
    #query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    stacking: ''
    colors: ['#635189', '#a2dcf3', '#1ea8df']
    show_value_labels: true
    label_density: 10
    label_color: ['#635189', '#a2dcf3', '#1ea8df']
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    series_labels:
      sf__leads.count: Leads
      sf__opportunities.count_new_business: Opportunities
      sf__opportunities.count_new_business_won: Won Opportunities
      #__FILE: salesforce/marketing_leadership.sf.dashboard.lookml
      #__LINE_NUM: 84
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    y_axis_tick_density_custom: 5
    ordering: none
    height: 4
    width: 6

  - name: rep_roster
    title: 'Rep Roster'
    type: table
    model: salesforce_by_segment
    explore: sf__opportunities
    dimensions: [opportunity_owners.name]
    measures: [sf__opportunities.average_revenue_won, sf__opportunities.average_revenue_lost, sf__opportunities.total_pipeline_revenue,
      sf__opportunities.win_percentage]
    listen:
      date_range: sf__opportunities.close_date
    filters:
      opportunity_owners.name: -NULL
      sf__opportunities.count_won: '>0'
    sorts: [sf__opportunities_owner.name desc]
    #query_timezone: America/Los_Angeles
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
    y_axis_gridlines: true
    y_axis_tick_density_custom: 5
    ordering: none
    show_row_numbers: true
    width: 6
    height: 4

## For use with sf__acounts.business_segment
#  - name: sales_segment_performance
#    title: 'Sales Segment Performance'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: sf__opportunities
#    dimensions: [sf__accounts.business_segment]
#    measures: [sf__accounts.count_customers, sf__opportunities.total_revenue]
#    listen:
#      #state: sf__accounts.billing_state
#      date_range: sf__opportunities.close_date
#    filters:
#      #sf__accounts.business_segment: -Unknown
#      sf__opportunities.stage_name: '"Closed Won"'
#    sorts: [sf__opportunities.close_month] #, sf__accounts.business_segment, sf__accounts.business_segment__sort_]
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
#    width: 6
#    height: 4

## For use with sf__opportunities.probability_group
#  - name: pipeline_forecast_3_months
#    title: 'Pipeline Forecast'
#    type: looker_column
#    model: salesforce_by_segment
#    explore: sf__opportunity
#    dimensions: [sf__opportunities.probability_group, sf__opportunities.close_month]
#    pivots: [sf__opportunities.probability_group]
#    measures: [sf__opportunities.total_revenue]
#    filters:
#      sf__opportunities.close_month: 9 months ago for 12 months
#    sorts: [sf__opportunities.probability_group, sf__opportunities.close_month, sf__opportunities.probability_group__sort_]
##    query_timezone: America/Los_Angeles
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
#    width: 6
#    height: 4
