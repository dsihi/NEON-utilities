# update_table_types.R
##############################################################################################
#' @title Update table_types.rda

#' @author
#' Christine Laney \email{claney@battelleecology.org}

#' @description
#' Connect to the DPS database, pull in updated information about tables, and save locally.

#' @return A saved .rda file

#' @references
#' License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007

# Changelog and author contributions / copyrights
#   Christine Laney (2017-10-19)
##############################################################################################

update_table_types <- function(){
  dps_con <-  RMySQL::dbConnect(drv=RMySQL::MySQL(), dbname="dps_database", username="root",password="p@ssw0rd", host="10.206.27.43", root = 3306)
  table_types <- RMySQL::dbGetQuery(dps_con, "SELECT * from dpTable WHERE dpTable.tableType NOT IN ('ingest', 'L0prime')")
  table_types$tableName <- gsub(pattern = "_pub", replacement = "", x = table_types$tableName)
  save(table_types, file = "data/table_types.rda")
  RMySQL::dbDisconnect(dps_con)
}
