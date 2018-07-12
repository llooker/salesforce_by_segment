  explore: sf__usage {
sql_always_where: NOT ${sf__accounts.is_deleted}
  ;;

join: owner {
  from: sf__users
  sql_on: ${sf__accounts.owner_id} = ${owner.id} ;;
  relationship: many_to_one
}
join: sf_map {
  from: usage__map
  sql_on: ${sf__accounts.owner_id} = ${salesforce_id} ;;
  relationship: many_to_one
}
join: delivery_map {
  from: usage__map
  sql_on: ${usage__delivery.company_id} = ${company_id} ;;
  relationship: many_to_one
}
join: transfer_map {
  from: usage__map
  sql_on: ${usage__transfer.company_id} = ${company_id} ;;
  relationship: many_to_one
}
}
