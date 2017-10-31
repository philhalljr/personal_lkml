include: "looker_beer_untappd.model.lkml"
view: venue {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin {
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
    hidden: yes
  }

  dimension: venue_name {
    type: string
  }

  dimension: venue_city {
    type: string
  }

  dimension: venue_state {
    type: string
    map_layer_name: us_states
  }

  dimension: venue_country {
    type: string
    map_layer_name: countries
  }

  dimension: venue_city_state_country {
    type: string
  }

  dimension: venue_lat {
    type: number
  }

  dimension: venue_lng {
    type: number
  }

  dimension: venue_location {
    type: location
    sql_latitude: ${venue_lat} ;;
    sql_longitude: ${venue_lng} ;;
  }

  measure: venue_count {
    type: count
  }
}
