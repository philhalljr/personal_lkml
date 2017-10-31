include: "looker_beer_untappd.model.lkml"
view: beer {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin_model_ref {
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
    label: "Name"
    type: string
  }

  dimension: beer_type {
    label: "Type"
    type: string
  }

  dimension: beer_type_bucket {
    label: "Type Bucket"
    type: string
  }

  dimension: beer_abv {
    label: "ABV"
    type: number
    value_format_name: percent_1
  }

  dimension: beer_abv_bucket {
    label: "ABV Bucket"
    type: string
  }

  dimension: beer_ibu {
    label: "IBU"
    type: number
    value_format_name: decimal_0
  }

  dimension: beer_ibu_bucket {
    label: "IBU Bucket"
    type: string
  }

  dimension: beer_ibu_abv_ratio {
    label: "IBU/ABV"
    type: number
    value_format_name: decimal_1
  }

  dimension: beer_ibu_abv_ratio_bucket {
    label: "IBU/ABV Bucket"
    type: string
  }

  dimension: beer_url {
    label: "URL"
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  measure: count {
    type: count
  }

  measure: avg_beer_abv {
    label: "Avg ABV"
    type: average
    value_format_name: percent_1
    sql: ${beer_abv} ;;
  }

  measure: avg_beer_ibu {
    label: "Avg IBU"
    type: average
    value_format_name: decimal_0
    sql: ${beer_ibu} ;;
  }

  measure: avg_ibu_abv_ratio {
    label: "Avg IBU/ABV"
    type: average
    value_format_name: decimal_1
    sql: ${beer_ibu_abv_ratio} ;;
  }
}
