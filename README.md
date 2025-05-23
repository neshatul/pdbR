# RCSB Query Toolkit for R

This R package provides a convenient workflow to perform complex RCSB PDB searches using custom JSON queries, retrieve large datasets programmatically, and download associated structural data files (mmCIF or PDB). It supports retry logic for robust querying, includes progress indicators, and stores both the query and result metadata.

---

## 📦 Features

✅Support for complex JSON-based queries
✅Automatic pagination and retry logic
✅Verbose progress indicators
✅Metadata storage
✅Optional mmCIF/PDB structure downloads
✅Easy integration into larger R workflows

🚀 Getting Started
To run the package:

Navigate to the example workflow in inst/Example/

Load or adapt the sample query JSON provided in inst/Data/query_example.json

Use the functions defined in the package to perform queries, download data, and store results.

Example

# Load JSON query from file
query_file <- system.file("Data", "query_example.json", package = "yourPackageName")

# Run query
results <- run_rcsb_query_from_file(query_file, result_dir = "results", download_structures = TRUE)

📁 Directory Structure

inst/Example/: Contains example R scripts demonstrating full usage of the package

inst/Data/: Contains sample JSON query files ready to use or modify

📚 Dependencies

httr
jsonlite
cli
progress

Install them via:
install.packages(c("httr", "jsonlite", "cli", "progress"))


📜 License

MIT License


📖 Citation

If you use this tool in your research or analysis, please cite the following works that underlie the conceptual framework, utility, and structural reasoning motivating this toolkit:

Haque, Neshatul, et al. "RAG genomic variation causes autoimmune diseases through specific structure-based mechanisms of enzyme dysregulation." Iscience 26.10 (2023).

Haque, Neshatul, et al. "Systematic analysis of the relationship between fold-dependent flexibility and artificial intelligence protein structure prediction." PloS one 19.11 (2024): e0313308.

Dsouza, Nikita R., et al. "Assessing Protein Surface-Based Scoring for Interpreting Genomic Variants." International Journal of Molecular Sciences 25.22 (2024): 12018.

We kindly request you to acknowledge these in any publication or analysis that uses this toolkit.



👩‍🔬 Acknowledgements

This package uses the RCSB PDB REST API and was designed to assist in large-scale structure-based analyses such as protein modeling, residue mapping, and drug discovery workflows.
