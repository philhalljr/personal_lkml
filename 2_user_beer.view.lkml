include: "looker_beer_untappd.model.lkml"
view: user_beer {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: untappd_raw_sheets_file {
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
    hidden: yes
  }

  dimension: beer_id {
    type: number
    hidden: yes
  }

  dimension: avg_rating_score {
    type: number
    hidden: yes
  }

  measure: user_beer_count {
    type: count
  }

  measure: avg_beer_rating {
    type: average
    sql: ${avg_rating_score} ;;
  }
}
