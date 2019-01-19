connection: "segment_sources"

# include base (generated) views
include: "sfbase__*.view"

# include extended views
include: "sf__*.view"

# include the dashboards
include: "sf__*.dashboard"

explore: sf__accounts {
  sql_always_where: NOT ${sf__accounts.is_deleted}
    ;;

  join: owner {
    from: sf__users
    sql_on: ${sf__accounts.owner_id} = ${owner.id} ;;
    relationship: many_to_one
  }
}

#- explore: sf__campaign_members
#  joins:
#    - join: sf__campaigns
#      from: sf__campaigns
#      type: left_outer
#      sql_on: ${campaign_members.campaign_id} = ${sf__campaigns.id}
#      relationship: many_to_one
#
#    - join: sf__leads
#      type: left_outer
#      sql_on: ${campaign_members.lead_id} = ${sf__leads.id}
#      relationship: many_to_one


explore: sf__campaigns {}

explore: sf__events {
  join: sf__accounts {
    type: left_outer
    sql_on: ${sf__events.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: event_owners {
    from: sf__users
    type: left_outer
    sql_on: ${sf__events.owner_id} = ${event_owners.id} ;;
    relationship: many_to_one
  }
}

explore: sf__leads {
  sql_always_where: NOT ${sf__leads.is_deleted} ;;

  join: lead_owners {
    from: sf__users
    sql_on: ${sf__leads.owner_id} = ${lead_owners.id} ;;
    relationship: many_to_one
  }

  join: sf__accounts {
    sql_on: ${sf__leads.converted_account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: account_owners {
    from: sf__users
    sql_on: ${sf__accounts.owner_id} = ${account_owners.id} ;;
    relationship: many_to_one
  }

  #    - join: contact
  #      sql_on: ${lead.converted_contact_id} = ${contact.id}
  #      relationship: many_to_one

  join: sf__opportunities {
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: many_to_one
  }

  join: opportunity_owners {
    from: sf__users
    sql_on: ${sf__opportunities.owner_id} = ${opportunity_owners.id} ;;
    relationship: many_to_one
  }
}

explore: sf__opportunities {
  sql_always_where: NOT ${sf__opportunities.is_deleted} ;;

  join: sf__accounts {
    type: left_outer
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: account_owners {
    from: sf__users
    sql_on: ${sf__accounts.owner_id} = ${account_owners.id} ;;
    relationship: many_to_one
  }

  #    - join: sf__campaigns
  #      from: sf__campaigns
  #      sql_on: ${sf__opportunities.campaign_id} = ${sf__campaigns.id}
  #      relationship: many_to_one

  join: opportunity_owners {
    from: sf__users
    sql_on: ${sf__opportunities.owner_id} = ${opportunity_owners.id} ;;
    relationship: many_to_one
  }
}

#- explore: sf__opportunity_field_history

#- explore: sf__opportunity_history

#- explore: sf__opportunity_stage

explore: sf__tasks {
  join: sf__accounts {
    type: left_outer
    sql_on: ${sf__tasks.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }
}

explore: sf__users {
  join: sf__opportunities {
    type: left_outer
    sql_on: ${sf__opportunities.owner_id} = ${sf__users_opportunities.id} ;;
    relationship: one_to_many
  }

  join: sf__users_opportunities {
    type: left_outer
    sql_on: ${sf__users_opportunities.id} = ${sf__users.id} ;;
    relationship: one_to_one
  }
}
