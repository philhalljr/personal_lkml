include: "looker_beer_untappd.model.lkml"
view: brewery {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin {
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
    type: string
  }

  dimension: brewery_city {
    type: string
  }

  dimension: brewery_state {
    type: string
    map_layer_name: us_states
  }

  dimension: brewery_country {
    type: string
    map_layer_name: countries
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
