include: "looker_beer_untappd.model.lkml"
view: venue {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: untappd_raw_sheets_file {
      column: venue_id {}
      column: venue_name {}
      column: venue_city {}
      column: venue_state {}
      column: venue_country {}
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
  }

  dimension: venue_country {
    type: string
  }

  dimension: venue_lat {
    type: number

  }

  dimension: venue_lng {
    type: number
  }

  measure: venue_count {
    type: count
  }
}
