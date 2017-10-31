include: "looker_beer_untappd.model.lkml"
view: beer {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin {
      column: beer_id {}
      column: brewery_id {}
      column: beer_name {}
      column: beer_type {}
      column: beer_type_bucket {}
      column: beer_abv {}
      column: beer_abv_bucket {}
      column: beer_ibu {}
      column: beer_ibu_bucket {}
      column: beer_ibu_abv_ratio {}
      column: beer_ibu_abv_ratio_bucket {}
      column: beer_url {}
    }
  }

  dimension: beer_id {
    type: number
    primary_key: yes
  }

  dimension: brewery_id {
    type: number
    hidden: yes
  }

  dimension: beer_name {
    type: string
  }

  dimension: beer_type {
    type: string
  }

  dimension: beer_type_bucket {
    type: string
  }

  dimension: beer_abv {
    type: number
    value_format_name: percent_1
  }

  dimension: beer_abv_bucket {
    type: string
  }

  dimension: beer_ibu {
    type: number
    value_format_name: decimal_0
  }

  dimension: beer_ibu_bucket {
    type: string
  }

  dimension: beer_ibu_abv_ratio {
    type: number
    value_format_name: decimal_1
  }

  dimension: beer_ibu_abv_ratio_bucket {
    type: string
  }

  dimension: beer_url {
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  measure: count {
    type: count
  }

  measure: avg_beer_abv {
    type: average
    value_format_name: percent_1
    sql: ${beer_abv} ;;
  }

  measure: avg_beer_ibu {
    type: average
    value_format_name: decimal_0
    sql: ${beer_ibu} ;;
  }

  measure: avg_ibu_abv_ratio {
    type: average
    value_format_name: decimal_1
    sql: ${beer_ibu_abv_ratio} ;;
  }
}
