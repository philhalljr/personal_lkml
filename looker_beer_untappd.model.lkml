connection: "lookerdata_bigquery_standard_sql"

# include all the views
include: "*.view"
# include all the dashboards
include: "*.dashboard"
week_start_day: sunday

explore: checkin_model_ref {
  from: checkin
  hidden: yes
}

explore: checkin {
  label: "Looker Beer Analysis"
  join: user_beer {
    type: inner
    sql_on: ${checkin.beer_id} = ${user_beer.beer_id} and ${checkin.user_id} = ${user_beer.user_id};;
    relationship: many_to_one
  }
  join: user_beer_comp {
    type: inner
    sql_on: ${user_beer.beer_id} = ${user_beer_comp.beer_id} and ${user_beer.user_id} <> ${user_beer_comp.user_id} ;;
    relationship: one_to_one
  }
  join: user {
    type: inner
    sql_on: ${user_beer.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
  join: user_comp {
    from: user
    type: inner
    sql_on: ${user_beer_comp.user_id} = ${user_comp.user_id} ;;
    relationship: many_to_one
  }
  join: beer {
    type: inner
    sql_on: ${user_beer.beer_id} = ${beer.beer_id} ;;
    relationship: many_to_one
  }
  join: brewery {
    type: inner
    sql_on: ${beer.brewery_id} = ${brewery.brewery_id};;
    relationship: many_to_one
  }
  join: purchase_venue {
    from: venue
    type: left_outer
    sql_on: ${checkin.purchase_venue_id} = ${purchase_venue.venue_id};;
    relationship: many_to_one
  }
  join: purchase_venue_city_location {
    from: city_location
    type: left_outer
    sql_on: ${purchase_venue.venue_city_state_country} = ${purchase_venue_city_location.venue_city_state_country} ;;
    relationship: many_to_one
  }
  join: consume_venue {
    from: venue
    type: left_outer
    sql_on: ${checkin.venue_id} = ${consume_venue.venue_id};;
    relationship: many_to_one
  }
  join: consume_venue_city_location {
    from: city_location
    type: left_outer
    sql_on: ${consume_venue.venue_city_state_country} = ${consume_venue_city_location.venue_city_state_country} ;;
    relationship: many_to_one
  }
}
