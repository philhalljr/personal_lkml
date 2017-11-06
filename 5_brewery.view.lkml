include: "looker_beer_untappd.model.lkml"
view: brewery {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM looker_untappd_beer.untappd_checkin ;;
    explore_source: checkin_model_ref {
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
    primary_key: yes
  }

  dimension: brewery_name {
    label: "Name"
    type: string
  }

  dimension: brewery_city {
    label: "City"
    type: string
    drill_fields: [brewery_name]
  }

  dimension: brewery_state {
    label: "State"
    type: string
    drill_fields: [brewery_city,brewery_name]
    map_layer_name: us_states
  }

  dimension: brewery_country {
    label: "Country"
    type: string
    drill_fields: [brewery_state,brewery_city,brewery_name]
    map_layer_name: countries
  }

  dimension: brewery_url {
    label: "URL"
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  measure: count {
    type: count
  }
}
