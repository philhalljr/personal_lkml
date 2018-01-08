## establishes connection to Google BigQuery which has a live connection to the following Google Sheets document
## https://drive.google.com/open?id=1D40fHoBo_ArWJA5CVMxzo67erOcTauM5qyOj1Db3Fg0
## used as the basis to created normalized data structure using NDTs

view: checkin {
  ## sql_table_name: looker_untappd_beer.untappd_checkin ;;
  derived_table: {
    sql: select * from looker_untappd_beer.untappd_checkin;;
    sql_trigger_value: COUNT(*) ;;
    }
  dimension: beer_abv {
    type: number
    hidden: yes
    ## error handling on issues with raw file where nulls come in as 0s
    ## converting to decimal so when formatted as % will look good.
    sql: IF(${TABLE}.beer_abv = 0,NULL,${TABLE}.beer_abv/100.0) ;;
  }

  dimension: beer_abv_bucket {
    type: string
    hidden: yes
    case: {
      when: {
        sql: ${beer_abv} is NULL ;;
        label: "N/A"
      }
      when: {
        sql: ${beer_abv} <= 0.04 ;;
        label: "Low"
      }
      when: {
        sql: ${beer_abv} < 0.055 ;;
        label: "Med Low"
      }
      when: {
        sql: ${beer_abv} < 0.07 ;;
        label: "Med"
      }
      when: {
        sql: ${beer_abv} < 0.085 ;;
        label: "Med High"
      }
      else: "High"
    }
  }

  dimension: beer_ibu {
    type: number
    hidden: yes
    ## error handling on issues with raw file where nulls come in as 0s
    sql: IF(${TABLE}.beer_ibu = 0,NULL,${TABLE}.beer_ibu) ;;
  }

  dimension: beer_ibu_abv_ratio {
    type: number
    hidden: yes
    sql: ${beer_ibu} / (${beer_abv} * 100) ;;
  }

  dimension: beer_ibu_abv_ratio_bucket {
    type: string
    hidden: yes
    case: {
      when: {
        sql: ${beer_ibu_abv_ratio} is NULL ;;
        label: "N/A"
      }
      when: {
        sql: ${beer_ibu_abv_ratio} < 2.5 ;;
        label: "Low"
      }
      when: {
        sql: ${beer_ibu_abv_ratio} < 5 ;;
        label: "Med Low"
      }
      when: {
        sql: ${beer_ibu_abv_ratio} < 7.5 ;;
        label: "Med"
      }
      when: {
        sql: ${beer_ibu_abv_ratio} < 10 ;;
        label: "Med High"
      }
      else: "High"
    }
  }

  dimension: beer_ibu_bucket {
    type: string
    hidden: yes
    case: {
      when: {
        sql: ${beer_ibu} is NULL ;;
        label: "N/A"
      }
      when: {
        sql: ${beer_ibu} < 10 ;;
        label: "Low"
      }
      when: {
        sql: ${beer_ibu} < 30 ;;
        label: "Med Low"
      }
      when: {
        sql: ${beer_ibu} < 60 ;;
        label: "Med"
      }
      when: {
        sql: ${beer_ibu} < 80 ;;
        label: "Med High"
      }
      else: "High"
    }
  }

  dimension: beer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.beer_id ;;
  }

  dimension: beer_name {
    type: string
    hidden: yes
    sql: ${TABLE}.beer_name ;;
  }

  dimension: beer_type {
    type: string
    hidden: yes
    sql: ${TABLE}.beer_type ;;
  }

  dimension: beer_type_bucket {
    type: string
    hidden: yes
    sql: IF(STRPOS(${beer_type}," - ")<>0,SUBSTR(${beer_type},1,STRPOS(${beer_type}," - ")-1),"Other");;
  }

  dimension: beer_url {
    type: string
    hidden: yes
    sql: ${TABLE}.beer_url ;;
  }

  dimension: brewery_city {
    type: string
    hidden: yes
    sql: ${TABLE}.brewery_city ;;
  }

  dimension: brewery_country {
    type: string
    hidden: yes
    sql: ${TABLE}.brewery_country ;;
  }

  dimension: brewery_id {
    type: number
    hidden: yes
    sql: ${TABLE}.brewery_id ;;
  }

  dimension: brewery_name {
    type: string
    hidden: yes
    sql: REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(${TABLE}.brewery_name,' Brewery',''),' Brewing',''),' Company','') ;;
  }

  dimension: brewery_state {
    type: string
    hidden: yes
    sql: ${TABLE}.brewery_state ;;
  }

  dimension: brewery_url {
    type: string
    hidden: yes
    sql: ${TABLE}.brewery_url ;;
  }

  dimension: checkin_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.checkin_id ;;
  }

  dimension: checkin_url {
    label: "URL"
    link: {
      label: "{{ value }}"
      url: "{{ value | uri_encode }}"
    }
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: comment_length {
    type: number
    sql: LENGTH(${comment}) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: flavor_profiles {
    type: string
    sql: ${TABLE}.flavor_profiles ;;
  }

  dimension: purchase_venue {
    type: string
    sql: ${TABLE}.purchase_venue ;;
  }

  dimension: purchase_venue_id {
    type: number
    sql: FARM_FINGERPRINT(${purchase_venue}) ;;
  }

  dimension: rating_score {
    type: number
    sql: ${TABLE}.rating_score ;;
  }

  dimension: serving_type {
    type: string
    sql: ${TABLE}.serving_type ;;
  }

  dimension: user_beer_id {
    type: string
    hidden: yes
    sql: CONCAT(${user_id},"|",CAST(${beer_id} AS STRING)) ;;
  }

  dimension: user_catg {
    type: string
    hidden: yes
    sql: ${TABLE}.user_catg ;;
  }

  dimension: user_fname {
    type: string
    hidden: yes
    sql: ${TABLE}.user_fname ;;
  }

  dimension: user_id {
    type: string
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_lname {
    type: string
    hidden: yes
    sql: ${TABLE}.user_lname ;;
  }

  dimension: venue_city {
    type: string
    hidden: yes
    sql: ${TABLE}.venue_city ;;
  }

  dimension: venue_city_state_country {
    type: string
    hidden: yes
    sql: CONCAT(${venue_city},", ",${venue_state},", ",${venue_country}) ;;
  }

  dimension: venue_country {
    type: string
    hidden: yes
    sql: ${TABLE}.venue_country ;;
  }

  dimension: venue_id {
    type: string
    hidden: yes
    sql: FARM_FINGERPRINT(${venue_name}) ;;
  }

  dimension: venue_lat {
    type: number
    hidden: yes
    sql: ${TABLE}.venue_lat ;;
  }

  dimension: venue_lng {
    type: number
    hidden: yes
    sql: ${TABLE}.venue_lng ;;
  }

  dimension: venue_name {
    type: string
    hidden: yes
    sql: ${TABLE}.venue_name ;;
  }

  dimension: venue_state {
    type: string
    hidden: yes
    sql: ${TABLE}.venue_state ;;
  }

  measure: avg_rating {
    type: average
    sql: ${rating_score} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: avg_checkin_length {
    type: average
    value_format_name: decimal_1
    sql: ${comment_length} ;;
  }

  measure: avg_venue_lat {
    type: average_distinct
    hidden: yes
    sql: ${venue_lat} ;;
    sql_distinct_key: ${venue_id} ;;
  }

  measure: avg_venue_lng {
    type: average_distinct
    hidden: yes
    sql: ${venue_lng} ;;
    sql_distinct_key: ${venue_id} ;;
  }

  measure: days_active {
    type: count_distinct
    hidden: yes
    sql: ${created_date} ;;
  }

  measure: checkins_per_day {
    type: number
    value_format_name: decimal_1
    sql: 1.0 * ${count}/${days_active} ;;
  }

  measure: distinct_cities {
    type: count_distinct
    sql: ${venue_city_state_country} ;;
  }

  measure: distinct_states {
    type: count_distinct
    sql: ${venue_state} ;;
  }

  measure: distinct_countries {
    type: count_distinct
    sql: ${venue_country} ;;
  }
  set: detail {
    fields: [beer_name,brewery.brewery_name,checkin.rating_score,consume_venue.venue_name,created_time]
  }
}
