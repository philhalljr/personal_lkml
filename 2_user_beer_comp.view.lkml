include: "1_user_beer.view.lkml"
view: user_beer_comp {
  extends: [user_beer]

  dimension: rating_dif {
    type: number
    sql: ABS(${user_beer.beer_rating} - ${user_beer_comp.beer_rating}) ;;
  }

  dimension: compatibility_score_gran {
    type: number
    hidden: yes
    sql: (4.75 - ${rating_dif}) / 4.75 ;;
  }

  measure: similarity {
    type: average
    value_format_name: percent_1
    sql: ${compatibility_score_gran} ;;
  }

  measure: overlap {
    type: count
  }

  measure: avg_rating_dif {
    type: average
    value_format_name: decimal_2
    sql: ${rating_dif} ;;
  }
}
