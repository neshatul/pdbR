#' Read JSON query from file
#' @param filepath Path to the JSON query file
#' @return Parsed list object of the query
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
read_query <- function(filepath) {
  jsonlite::fromJSON(filepath, simplifyVector = FALSE)
}

#' Submit query to RCSB with retry logic
#' @param query List query object
#' @param retries Max retry attempts on failure
#' @return Parsed result list
#'
#' @importFrom httr status_code content POST
#' @importFrom jsonlite fromJSON
#' @importFrom cli  cli_alert_warning
#'
#' @export
#'
submit_query <- function(query, retries = 5) {
  url <- "https://search.rcsb.org/rcsbsearch/v2/query"
  attempt <- 1
  while (attempt <= retries) {
    response <- httr::POST(url, body = query, encode = "json")
    if (httr::status_code(response) == 200) {
      return(jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8")))
    } else if (httr::status_code(response) == 429) {
      cli::cli_alert_warning("Rate limited. Retrying in 5 seconds... (Attempt {attempt})")
      Sys.sleep(5)
    } else {
      stop("Failed with status code: ", httr::status_code(response))
    }
    attempt <- attempt + 1
  }
  stop("Max retries exceeded.")
}

#' Save metadata and results
#' @param result Parsed API result
#' @param output_dir Output directory
#' @param query_file Path to original query file
#'
#' @importFrom jsonlite write_json
#'
#' @export
#'
save_results <- function(result, output_dir = "results", query_file = NULL) {
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

  # Save full JSON result
  jsonlite::write_json(result, file.path(output_dir, "query_results.json"), pretty = TRUE, auto_unbox = TRUE)

  # Save original query file
  if (!is.null(query_file)) {
    file.copy(query_file, file.path(output_dir, "query_used.json"), overwrite = TRUE)
  }

  # Extract and save PDB IDs
  ids <- unlist(result$result_set$identifier)  # ensures it's a character vector
  ids <- as.character(ids)          # ensure type safety
  writeLines(ids, file.path(output_dir, "pdb_ids.txt"))

  return(ids)
}


#' Download mmCIF or PDB files
#' @param pdb_ids Vector of PDB IDs
#' @param format Either "cif" or "pdb"
#' @param dest_dir Directory to store downloaded files
#' @param verbose Show progress
#'
#' @importFrom progress progress_bar
#' @importFrom cli cli_alert_danger
#'
#' @export
#'
download_structures <- function(pdb_ids, format = "cif", dest_dir = "results/structures", verbose = TRUE) {
  dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
  if (verbose) {
    pb <- progress::progress_bar$new(
      total = length(pdb_ids),
      format = "[:bar] :current/:total (:percent) :elapsed",
      clear = FALSE
    )
  }
  for (id in pdb_ids) {
    url <- sprintf("https://files.rcsb.org/download/%s.%s", id, format)
    dest <- file.path(dest_dir, sprintf("%s.%s", id, format))
    tryCatch({
      download.file(url, destfile = dest, quiet = TRUE)
    }, error = function(e) {
      cli::cli_alert_danger("Failed to download {id}.{format}")
    })
    if (verbose) pb$tick()
  }
}
