include: "looker_beer_untappd.model.lkml"
view: venue {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM looker_untappd_beer.untappd_checkin;;
    explore_source: checkin_model_ref {
      column: venue_id {}
      column: venue_name {}
      column: venue_city {}
      column: venue_state {}
      column: venue_country {}
      column: venue_city_state_country {}
      column: venue_lat {}
      column: venue_lng {}
    }
  }

  dimension: venue_id {
    type: number
    primary_key: yes
  }

  dimension: venue_name {
    label: "Name"
    type: string
  }

  dimension: venue_city {
    label: "City"
    type: string
  }

  dimension: venue_state {
    label: "State"
    type: string
    map_layer_name: us_states
  }

  dimension: venue_country {
    label: "Country"
    type: string
    map_layer_name: countries
  }

  dimension: venue_city_state_country {
    label: "City, State, Country"
    type: string
  }

  dimension: venue_lat {
    label: "Latitude"
    type: number
  }

  dimension: venue_lng {
    label: "Longitude"
    type: number
  }

  dimension: location {
    type: location
    sql_latitude: ${venue_lat} ;;
    sql_longitude: ${venue_lng} ;;
  }

  measure: count {
    type: count
  }
}
