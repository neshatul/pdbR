


library(pdbR)

# Configuration
query_file <- system.file("Query_json", "RCSB_query_SMARCA4.json", package = "pdbR")
result_dir <- "/scratch/g/mtzimmermann/NH/pkg_tst/pdbR_output"

download_structure_file <- TRUE
structure_format <- "cif"  # or "pdb"

# Run
cli::cli_h1("Reading Query")
query <- read_query(query_file)

cli::cli_h1("Submitting Query to RCSB")
result <- submit_query(query)

cli::cli_h1("Saving Results and Metadata")
pdb_ids <- save_results(result, result_dir, query_file)

if(download_structure_file){
  cli::cli_h1("Downloading Structures")
  download_structures(pdb_ids,
                      format = structure_format,
                      dest_dir = file.path(result_dir, "structures"),
                      verbose = TRUE)
}

cli::cli_alert_success("All steps completed!")
