include: "looker_beer_untappd.model.lkml"
view: brewery {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: untappd_raw_sheets_file {
      column: brewery_id {}
      column: brewery_name {}
      column: brewery_city {}
      column: brewery_state {}
      column: brewery_country {}
      column: brewery_url {}
    }
  }

  dimension: brewery_id {
    type: number
    hidden: yes
    primary_key: yes
  }

  dimension: venue_id {
    type: number
    hidden: yes
    sql: FARM_FINGERPRINT(${brewery_name}) ;;
  }

  dimension: brewery_name {
    type: string
  }

  dimension: brewery_city {
    type: string
  }

  dimension: brewery_state {
    type: string
  }

  dimension: brewery_country {
    type: string
  }

  dimension: brewery_url {
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  measure: brewery_count {
    type: count
  }
}
