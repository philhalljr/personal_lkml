include: "looker_beer_untappd.model.lkml"
view: user {
  derived_table: {
    sql_trigger_value: CURRENT_DATE() ;;
    explore_source: checkin {
      column: user_id {}
      column: user_catg {}
      column: user_fname {}
      column: user_lname {}
    }
  }
  dimension: user_id {
    type: string
    hidden: yes
    primary_key: yes
  }

  dimension: user_catg {
    type: string
  }

  dimension: user_fname {
    type: string
  }

  dimension: user_lname {
    type: string
  }

  dimension: user_fullname {
    type: string
    sql: CONCAT(${user_fname}," ",${user_lname}) ;;
  }

  measure: user_count {
    type: count
  }
}
