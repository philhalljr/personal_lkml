include: "looker_beer_untappd.model.lkml"
view: user {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM looker_untappd_beer.untappd_checkin ;;
    explore_source: checkin_model_ref {
      column: user_id {}
      column: user_catg {}
      column: user_fname {}
      column: user_lname {}
    }
  }
  dimension: user_id {
    type: string
    primary_key: yes
  }

  dimension: user_catg {
    label: "Category"
    type: string
  }

  dimension: user_fname {
    label: "First Name"
    type: string
  }

  dimension: user_lname {
    label: "Last Name"
    type: string
  }

  dimension: user_fullname {
    label: "Full Name"
    type: string
    sql: CONCAT(${user_fname}," ",${user_lname}) ;;
  }

  measure: count {
    type: count
  }
}
