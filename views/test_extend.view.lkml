include: "test1.view"
view: test_extend {
  extends: [test1]

  dimension: product_id_2 {
    type: string
    sql: concat("XXX", ${TABLE}.product_id) ;;
  }
  # Additional things you want to add or change
}
