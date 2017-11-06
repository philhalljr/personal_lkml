include: "looker_beer_untappd.model.lkml"
view: user_beer {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM looker_untappd_beer.untappd_checkin ;;
    explore_source: checkin_model_ref {
      column: user_beer_id {}
      column: user_id {}
      column: beer_id {}
      column: beer_rating {field: checkin_model_ref.avg_rating}
    }
  }
  dimension: user_beer_id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {
    type: string
  }

  dimension: beer_id {
    type: number
  }

  dimension: beer_rating {
    type: number
  }

  measure: count {
    type: count
  }

  measure: avg_rating {
    type: average
    value_format_name: decimal_2
    sql: ${beer_rating} ;;
  }
}
