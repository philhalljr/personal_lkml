include: "looker_beer_untappd.model.lkml"
view: user_beer {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin_model_ref {
      column: user_beer_id {}
      column: user_id {}
      column: beer_id {}
      column: avg_rating_score {}
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

  dimension: avg_rating_score {
    type: number
  }

  measure: count {
    type: count
  }

  measure: avg_beer_rating {
    type: average
    value_format_name: decimal_2
    sql: ${avg_rating_score} ;;
  }
}
