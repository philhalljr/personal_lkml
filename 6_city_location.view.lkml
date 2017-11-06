include: "looker_beer_untappd.model.lkml"
view: city_location {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM looker_untappd_beer.untappd_checkin ;;
    explore_source: checkin_model_ref {
      column: avg_venue_lat {}
      column: avg_venue_lng {}
      column: venue_city_state_country {}
      filters: {
        field: checkin_model_ref.venue_city_state_country
        value: "-EMPTY"
      }
    }
  }

  dimension: venue_city_state_country {
    label: "City, State, Country"
    type: string
  }

  dimension: avg_venue_lat {
    type: number
  }

  dimension: avg_venue_lng {
    type: number
  }

  dimension: location {
    type: location
    sql_latitude: ${avg_venue_lat} ;;
    sql_longitude: ${avg_venue_lng} ;;
  }
}
