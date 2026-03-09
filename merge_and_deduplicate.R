# =============================================================================
# Bibliometric Analysis: Digital Business Models in the Publishing Industry
# Merge and Deduplication Script
# Author: Ana-Maria Osadci-Baciu
# Date: March 2026
# Dissertation: "Integrating Digital Business Models: A Study of the Romanian
#               Publishing Sector" (SNSPA, Bucharest)
# =============================================================================
# Requirements: R >= 4.5.1, bibliometrix >= 5.2.1
# Install bibliometrix if needed: install.packages("bibliometrix")
# =============================================================================

library(bibliometrix)

# -----------------------------------------------------------------------------
# 1. Set path and load BibTeX files from Scopus and Web of Science
# -----------------------------------------------------------------------------
# Note: Raw BibTeX files are not included in this repository due to
# Scopus and Web of Science terms of service.
# To replicate, perform the searches described in README.md and export
# results in BibTeX format from both databases.

# Set your own path to the folder containing the exported BibTeX files
path <- "your/path/to/data/"

# Web of Science exports (3 queries: publishing industry, publishing sector, book publishing)
wos1 <- convert2df(paste0(path, "wos_publishing_industry.bib"), dbsource = "wos", format = "bibtex")
wos2 <- convert2df(paste0(path, "wos_publishing_sector.bib"), dbsource = "wos", format = "bibtex")
wos3 <- convert2df(paste0(path, "wos_book_publishing.bib"), dbsource = "wos", format = "bibtex")

# Scopus exports (3 queries: publishing industry, publishing sector, book publishing)
sc1 <- convert2df(paste0(path, "scopus_publishing_industry.bib"), dbsource = "scopus", format = "bibtex")
sc2 <- convert2df(paste0(path, "scopus_publishing_sector.bib"), dbsource = "scopus", format = "bibtex")
sc3 <- convert2df(paste0(path, "scopus_book_publishing.bib"), dbsource = "scopus", format = "bibtex")

# -----------------------------------------------------------------------------
# 2. Merge all dataframes and remove DOI-based duplicates
# -----------------------------------------------------------------------------
# mergeDbSources() identifies and removes cross-database duplicates
# based on DOI matching.

M <- mergeDbSources(wos1, wos2, wos3, sc1, sc2, sc3, remove.duplicated = TRUE)

cat("=== After DOI-based deduplication ===\n")
cat("Total after merge & dedup:", nrow(M), "\n")
cat("Unique DOIs:", length(unique(na.omit(M$DI))), "\n")
cat("Records without DOI:", sum(is.na(M$DI)), "\n")
# Result: 89 duplicates removed, 124 records remaining, 25 without DOI

# -----------------------------------------------------------------------------
# 3. Additional deduplication via normalized title matching
# -----------------------------------------------------------------------------
# Since 25 records lacked DOI metadata, an additional deduplication step
# is performed using case-insensitive, punctuation-stripped title matching.

M$TI_clean <- tolower(trimws(gsub("[[:punct:]]", "", M$TI)))
M <- M[!duplicated(M$TI_clean), ]
M$TI_clean <- NULL

cat("\n=== After title-based deduplication ===\n")
cat("Final corpus size:", nrow(M), "unique documents\n")
# Result: 2 further duplicates removed, 122 final unique documents

# -----------------------------------------------------------------------------
# 4. Save merged corpus for Biblioshiny
# -----------------------------------------------------------------------------

save(M, file = paste0(path, "merged_dataset.RData"))

# To use in Biblioshiny:
# 1. Launch: biblioshiny()
# 2. Go to Data > Load Data > R Data
# 3. Upload merged_dataset.RData
