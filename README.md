# RCSB Query Toolkit

This R package provides a convenient workflow to perform complex RCSB PDB searches using custom JSON queries, retrieve large datasets programmatically, and download associated structural data files (mmCIF or PDB). It supports retry logic for robust querying, includes progress indicators, and stores both the query and result metadata.

---

## 📦 Features

- ✅ Load and submit pre-formatted RCSB JSON queries.
- ✅ Automatically paginate to retrieve large result sets.
- ✅ Retry logic for rate-limited queries.
- ✅ Save metadata, PDB IDs, and query used.
- ✅ Download mmCIF or PDB files for matching entries.
- ✅ Progress bars for long-running tasks.

---

## 🔧 Installation

This package is currently provided as source code. You can load it using `devtools`:

```r
# If not installed:
install.packages("devtools")

# Load from local directory
devtools::load_all("path/to/your/package")


🚀 Quick Start
1. Prepare your RCSB Query File
Prepare a valid RCSB query in JSON format. For example:

json
{
  "query": {
    "type": "terminal",
    "service": "text",
    "parameters": {
      "attribute": "rcsb_entity_source_organism.taxonomy_lineage.id",
      "operator": "exact_match",
      "value": "9606"
    }
  },
  "return_type": "entry",
  "request_options": {
    "paginate": {
      "start": 0,
      "rows": 1000
    },
    "results_content_type": ["experimental"]
  }
}
Save it as query.json.

2. Run Query Workflow
# Load the query from file and perform the request
query_file <- "query.json"
results <- run_query_from_file(query_file, verbose = TRUE)

# Save results and metadata
pdb_ids <- save_results(results, output_dir = "results", query_file = query_file)

# Optionally download mmCIF files
download_structures(pdb_ids, format = "cif", out_dir = "results/mmcif")
📂 Output Files
results/query_results.json: Full RCSB query result

results/query_used.json: The query used

results/pdb_ids.txt: All matching PDB IDs

results/mmcif/: Directory of downloaded mmCIF files

🔄 Functions
run_query_from_file(query_file, ...) – Load JSON query, make request, retry if needed.

save_results(result, output_dir, query_file) – Save metadata and PDB IDs.

download_structures(pdb_ids, format, out_dir) – Download structures in specified format.

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


👩‍🔬 Acknowledgements
This package uses the RCSB PDB REST API and was designed to assist in large-scale structure-based analyses such as protein modeling, residue mapping, and drug discovery workflows.
yaml
---

