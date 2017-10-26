connection: "lookerdata_bigquery_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: untappd_raw_sheets_file {
  ## do not expose explore to end user, only used for native derived tables
  hidden:  yes
}
