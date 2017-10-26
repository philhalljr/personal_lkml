include: "looker_beer_untappd.model.lkml"
view: beer {
  derived_table: {
    sql_trigger_value: current_date() ;;
    explore_source: untappd_raw_sheets_file {
      column: beer_id {}
      column: beer_name {}
      column: beer_type {}
      column: brewery_id {}
      column: beer_abv {}
      column: beer_ibu {}
    }
  }
  dimension: beer_id {
    type: number
    primary_key: yes
    hidden: yes
  }
  dimension: beer_name {
    type: string
  }
  dimension: beer_type {
    type: string
  }
  dimension: brewery_id {
    type: number
    hidden: yes
  }
  dimension: beer_abv {
    type: number
    value_format_name: percent_1
  }
  dimension: beer_ibu {
    type: number
    value_format_name: decimal_0
  }
}
