connection: "athena"

include: "*.view"         # include all views in this project
include: "*.dashboard"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
 explore: usage__map {
   join: usage__delivery {
     relationship: many_to_one
     sql_on: ${usage__map.company_id} = ${usage__delivery.company_id} ;;
   }

   join: usage__transfer {
     relationship: many_to_one
     sql_on: ${usage__map.company_id} = ${usage__delivery.company_id} ;;
   }
 }
