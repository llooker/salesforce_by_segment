connection: "athena"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: company_usage {
#   join: deliveries {
#     relationship: many_to_one
#     sql_on: ${sf_usage_map.company_id} = ${delivery.company_id} ;;
#   }
#
#   join: accounts {
#     relationship: many_to_one
#     sql_on: ${accounts.id} = ${sf_usage_map.salesforce_id} ;;
#   }
# }
