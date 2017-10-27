include: "looker_beer_untappd.model.lkml"
view: checkin {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: untappd_raw_sheets_file {
      column: checkin_id {}
      column: user_id {}
      column: beer_id {}
      column: venue_id {}
      column: purchase_venue_id {}
      column: created_time {}
      column: serving_type {}
      column: rating_score {}
      column: flavor_profiles {}
      column: comment {}
      column: checkin_url {}
    }
  }

  dimension: checkin_id {
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

  dimension: venue_id {
    type: number
    hidden: yes
  }

  dimension: purchase_venue_id {
    type: number
    hidden: yes
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.created_time AS timestamp) ;;
  }

  dimension: serving_type {
    type: string
  }

  dimension: rating_score {
    type: number
  }

  dimension: flavor_profiles {
    type: string
  }

  dimension: comment {
    type: string
  }

  dimension: comment_length {
    type: number
    sql: LENGTH(${comment}) ;;
  }

  dimension: checkin_url {
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  measure: checkin_count {
    type: count
  }

  measure: dbeer_count {
    type: count_distinct
    hidden: yes
    sql: ${beer_id} ;;
  }

  measure: day_count {
    type: count_distinct
    hidden: yes
    sql: ${created_date} ;;
  }

  measure: avg_checkin_rating {
    type: average
    sql: ${rating_score};;
  }

  measure: checkins_per_day {
    type: number
    sql: ${checkin_count}/${day_count} ;;
  }

  measure: distinct_beers_per_day {
    type: number
    sql: ${dbeer_count}/${day_count} ;;
  }

  measure: avg_comment_length {
    type: average
    sql: ${comment_length} ;;
  }
}
