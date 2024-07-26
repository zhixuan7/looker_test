# Define the database connection to be used for this model.
connection: "sales_demo_looker"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: sale_demo_looker_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sale_demo_looker_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Sale Demo Looker"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: test1 {}

explore: sales_analytic {
  view_name: sales_analytic

  join: test1 {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${sales_analytic.product_id} = ${test1.product_id} ;;
  }
}

explore: sales_test_2 {}
explore: test_extend {}
