# The name of this view in Looker is "Test1"
view: test1 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sales_demo.test1` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Image" in Explore.

  dimension: image {
    type: string
    sql: ${TABLE}.image ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }
  dimension: product_link {
    type: string
    sql: ${TABLE}.product_link ;;
  }
  dimension: product_name_link {
    type: string
    sql: ${TABLE}.product_name ;;
    link: {
      label: "Product Link"
      url: "{{ product_link._rendered_value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }
  dimension: display_image {
    type: string
    sql: ${TABLE}.image  ;;
    html: <img src={{ rendered_value }} style="width:128px;height:128px;"></img> ;;
  }
  measure: count {
    type: count
  }
}
