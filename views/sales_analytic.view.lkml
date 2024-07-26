# The name of this view in Looker is "Sales Analytic"
view: sales_analytic {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cmmy-rd-playground.sales_demo.sales_analytic` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Product ID" in Explore.
  parameter: kpi_test {
    type: number
    default_value: "900"
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
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

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sales_amount {
    type: sum
    sql: ${sales_amount} ;;  }
  measure: average_sales_amount {
    type: average
    sql: ${sales_amount} ;;  }

  measure:  sales_condition {
    type: string
    sql:
    case when ${kpi_test}  < ${total_sales_amount}
    then "add"
    else "minus" end ;;


  }

  dimension: sales_id {
    type: string
    sql: ${TABLE}.sales_id ;;
  }

  dimension: supplier_id {
    type: string
    sql: ${TABLE}.supplier_id ;;
  }
  measure: count {
    type: count
  }
}
