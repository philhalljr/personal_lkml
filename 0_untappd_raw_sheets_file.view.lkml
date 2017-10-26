## establishes connection to Google BigQuery which has a live connection to the following Google Sheets document
## https://drive.google.com/open?id=1D40fHoBo_ArWJA5CVMxzo67erOcTauM5qyOj1Db3Fg0
## used as the basis to created normalized data structure using NDTs

view: untappd_raw_sheets_file {
  sql_table_name: looker_untappd_beer.untappd_checkin ;;

  dimension: beer_abv {
    type: number
    ## error handling on issues with raw file where nulls come in as 0s
    ## converting to decimal so when formatted as % will look good.
    sql: IF(${TABLE}.beer_abv = 0,NULL,${TABLE}.beer_abv/100.0) ;;
  }

  dimension: beer_abv_bucket {
    type: string
    sql:
    CASE
      WHEN ${beer_abv} is NULL THEN "N/A"
      WHEN ${beer_abv} <= 0.04 THEN "LOW"
      WHEN ${beer_abv} < 0.055 THEN "MED LOW"
      WHEN ${beer_abv} < 0.07 THEN "MED"
      WHEN ${beer_abv} < 0.085 THEN "MED HIGH"
      ELSE "HIGH"
    END;;
  }

  dimension: beer_ibu {
    type: number
    ## error handling on issues with raw file where nulls come in as 0s
    sql: IF(${TABLE}.beer_ibu = 0,NULL,${TABLE}.beer_ibu) ;;
  }

  dimension: beer_ibu_abv_ratio {
    type: number
    sql: ${beer_ibu} / (${beer_abv} * 100) ;;
  }

  dimension: beer_ibu_abv_ratio_bucket {
    type: string
    sql:
    CASE
      WHEN ${beer_ibu_abv_ratio} is NULL THEN "N/A"
      WHEN ${beer_ibu_abv_ratio} < 2.5 THEN "LOW"
      WHEN ${beer_ibu_abv_ratio} < 5 THEN "MED LOW"
      WHEN ${beer_ibu_abv_ratio} < 7.5 THEN "MED"
      WHEN ${beer_ibu_abv_ratio} < 10 THEN "MED HIGH"
      ELSE "HIGH"
    END;;
  }

  dimension: beer_ibu_bucket {
    type: string
    sql:
    CASE
      WHEN ${beer_ibu} is NULL THEN "N/A"
      WHEN ${beer_ibu} < 10 THEN "LOW"
      WHEN ${beer_ibu} < 30 THEN "MED LOW"
      WHEN ${beer_ibu} < 60 THEN "MED"
      WHEN ${beer_ibu} < 80 THEN "MED HIGH"
      ELSE "HIGH"
    END;;
  }

  dimension: beer_id {
    type: number
    sql: ${TABLE}.beer_id ;;
  }

  dimension: beer_name {
    type: string
    sql: ${TABLE}.beer_name ;;
  }

  dimension: beer_type {
    type: string
    sql: ${TABLE}.beer_type ;;
  }

  dimension: beer_type_bucket {
    type: string
    sql: IF(STRPOS(${beer_type}," - ")<>0,SUBSTR(${beer_type},1,STRPOS(${beer_type}," - ")-1),"Other");;
  }

  dimension: beer_url {
    type: string
    sql: ${TABLE}.beer_url ;;
  }

  dimension: brewery_city {
    type: string
    sql: ${TABLE}.brewery_city ;;
  }

  dimension: brewery_country {
    type: string
    sql: ${TABLE}.brewery_country ;;
  }

  dimension: brewery_id {
    type: number
    sql: ${TABLE}.brewery_id ;;
  }

  dimension: brewery_name {
    type: string
    sql: ${TABLE}.brewery_name ;;
  }

  dimension: brewery_state {
    type: string
    sql: ${TABLE}.brewery_state ;;
  }

  dimension: brewery_url {
    type: string
    sql: ${TABLE}.brewery_url ;;
  }

  dimension: checkin_id {
    type: number
    sql: ${TABLE}.checkin_id ;;
  }

  dimension: checkin_url {
    type: string
    sql: ${TABLE}.checkin_url ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
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

  dimension: rating_score {
    type: number
    sql: ${TABLE}.rating_score ;;
  }

  dimension: serving_type {
    type: string
    sql: ${TABLE}.serving_type ;;
  }

  dimension: user_catg {
    type: string
    sql: ${TABLE}.user_catg ;;
  }

  dimension: user_fname {
    type: string
    sql: ${TABLE}.user_fname ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_lname {
    type: string
    sql: ${TABLE}.user_lname ;;
  }

  dimension: venue_city {
    type: string
    sql: ${TABLE}.venue_city ;;
  }

  dimension: venue_country {
    type: string
    sql: ${TABLE}.venue_country ;;
  }

  dimension: venue_id {
    type: string
    sql: ${TABLE}.venue_id ;;
  }

  dimension: venue_lat {
    type: number
    sql: ${TABLE}.venue_lat ;;
  }

  dimension: venue_lng {
    type: number
    sql: ${TABLE}.venue_lng ;;
  }

  dimension: venue_name {
    type: string
    sql: ${TABLE}.venue_name ;;
  }

  dimension: venue_state {
    type: string
    sql: ${TABLE}.venue_state ;;
  }

  measure: count {
    type: count
    drill_fields: [venue_name, user_fname, brewery_name, user_lname, beer_name]
  }
}
