connection: "lookerdata_bigquery_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: untappd_raw_sheets_file {
  ## do not expose explore to end user, only used for native derived tables
  hidden:  yes
}

explore: looker_beer_analysis {
  from: beer
  join: user_beer {
    type: inner
    sql_on: ${looker_beer_analysis.beer_id} = ${user_beer.beer_id} ;;
    relationship: one_to_many
  }
  join: user {
    type: inner
    sql_on: ${user_beer.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
  join: checkin {
    type: inner
    sql_on: ${user_beer.beer_id} = ${checkin.beer_id} and ${user_beer.user_id} = ${checkin.user_id};;
    relationship: one_to_many
  }
  join: brewery {
    type: inner
    sql_on: ${looker_beer_analysis.brewery_id} = ${brewery.brewery_id};;
    relationship: one_to_many
  }
}
