view: sales_test_2 {
  derived_table: {
    sql:
     SELECT *
    , (SELECT sales_amount
       FROM `cmmy-rd-playground.sales_demo.sales_analytic` sales_prev
       WHERE date(sales_prev.record_date)=DATE_ADD(date(a.record_date), INTERVAL -1 MONTH)
      and sales_prev.product_id = a.product_id
      ) previous_month
      , (SELECT sales_amount
       FROM `cmmy-rd-playground.sales_demo.sales_analytic` sales_prev_2
       WHERE date(sales_prev_2.record_date)=DATE_ADD(date(a.record_date), INTERVAL -1 day)
      and sales_prev_2.product_id = a.product_id
      ) previous_day
    from `cmmy-rd-playground.sales_demo.sales_analytic` a
    left join `cmmy-rd-playground.sales_demo.test1` b
    on a.product_id = b.product_id
    ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: record {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.record_date ;;
  }

  dimension: sales_amount {
    type: number
    sql: ${TABLE}.sales_amount ;;
  }
  measure: sales_amount_1 {
    type: sum
    sql: ${TABLE}.sales_amount ;;
  }
  measure: previous_month {
    type: sum
    sql: ${TABLE}.previous_month ;;
  }
  measure: previous_day {
    type: sum
    sql: ${TABLE}.previous_day ;;
  }
  measure: growth_dod {
    type: number
    sql:   ${sales_amount_1} - ${previous_day};;
  }
  measure: percent_growth_mom {
    type: number
    sql:  (${sales_amount_1} - ${previous_month})/ifnull(${sales_amount_1},1) ;;
    value_format: "0%"
  }

  measure: total_sales_amount {
    type: sum
    sql: ${sales_amount} ;;  }


  dimension: sales_id {
    type: string
    sql: ${TABLE}.sales_id ;;
  }

  dimension: supplier_id {
    type: string
    sql: ${TABLE}.supplier_id ;;
  }

  dimension: display_image {
    type: string
    sql: ${TABLE}.image  ;;
    drill_fields: [sales_amount]
    html:
    <span>
    <img src={{ rendered_value }} style="width:128px;height:128px;"></img>
    <p style="font-size:20px;margin:0;"> {{ product_name._rendered_value }} </p>
    <p style="font-size:20px; color:green;margin:0;" >⬆   {{ percent_growth_mom._rendered_value }} </p>

    </span>
    ;;
  }

  measure: disyplay_dod {
    type: string
    sql:  ${growth_dod} ;;
    html:

    <p style="color:black;" >Total Sales: {{ sales_amount_1._rendered_value }}</p>
    <p style="color:green;" >⬆  +{{ rendered_value }}</p>
    <p style="font-size:15px;"> Latest Update: 2023-03-28  </p>

    ;;
  }


}
