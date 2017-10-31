include: "looker_beer_untappd.model.lkml"
view: city_location {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin {
      column: avg_venue_lat {}
      column: avg_venue_lng {}
      column: venue_city_state_country {}
      filters: {
        field: checkin.venue_city_state_country
        value: "-EMPTY"
      }
    }
  }

  dimension: venue_city_state_country {
    type: string
  }

  dimension: avg_venue_lat {
    type: number
  }

  dimension: avg_venue_lng {
    type: number
  }

  dimension: city_location {
    type: location
    sql_latitude: ${avg_venue_lat} ;;
    sql_longitude: ${avg_venue_lng} ;;
  }
}
