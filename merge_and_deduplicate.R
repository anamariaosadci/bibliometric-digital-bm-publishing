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
# 1. Import BibTeX files from Scopus and Web of Science
# -----------------------------------------------------------------------------
# Note: Raw BibTeX files are not included in this repository due to
# Scopus and Web of Science terms of service.
# To replicate, perform the searches described in README.md and export
# results in BibTeX format from both databases.

# Scopus exports
scopus_publishing_industry <- convert2df("data/scopus_publishing_industry.bib",
                                          dbsource = "scopus",
                                          format = "bibtex")

scopus_publishing_sector   <- convert2df("data/scopus_publishing_sector.bib",
                                          dbsource = "scopus",
                                          format = "bibtex")

scopus_book_publishing     <- convert2df("data/scopus_book_publishing.bib",
                                          dbsource = "scopus",
                                          format = "bibtex")

# Web of Science exports
wos_publishing_industry    <- convert2df("data/wos_publishing_industry.bib",
                                          dbsource = "wos",
                                          format = "bibtex")

wos_publishing_sector      <- convert2df("data/wos_publishing_sector.bib",
                                          dbsource = "wos",
                                          format = "bibtex")

wos_book_publishing        <- convert2df("data/wos_book_publishing.bib",
                                          dbsource = "wos",
                                          format = "bibtex")

# -----------------------------------------------------------------------------
# 2. Merge all dataframes and remove DOI-based duplicates
# -----------------------------------------------------------------------------
# mergeDbSources() identifies and removes cross-database duplicates
# based on DOI matching.

merged <- mergeDbSources(scopus_publishing_industry,
                         scopus_publishing_sector,
                         scopus_book_publishing,
                         wos_publishing_industry,
                         wos_publishing_sector,
                         wos_book_publishing)

cat("Documents after DOI-based deduplication:", nrow(merged), "\n")
# Result: 89 duplicates removed via DOI matching

# -----------------------------------------------------------------------------
# 3. Additional deduplication via normalized title matching
# -----------------------------------------------------------------------------
# 25 records lacked DOI metadata, so an additional title-based
# deduplication step is performed.

# Normalize titles: lowercase, remove punctuation and extra whitespace
merged$TITLE_NORM <- tolower(merged$TI)
merged$TITLE_NORM <- gsub("[[:punct:]]", "", merged$TITLE_NORM)
merged$TITLE_NORM <- gsub("\\s+", " ", trimws(merged$TITLE_NORM))

# Identify and remove title-based duplicates
# Keep first occurrence (prioritizing records with DOI)
merged <- merged[order(is.na(merged$DI)), ]  # DOI-having records first
title_dupes <- duplicated(merged$TITLE_NORM)
cat("Additional duplicates found via title matching:", sum(title_dupes), "\n")
# Result: 2 further duplicates removed

merged <- merged[!title_dupes, ]
merged$TITLE_NORM <- NULL  # Clean up helper column

cat("Final corpus size:", nrow(merged), "unique documents\n")
# Result: 122 unique documents

# -----------------------------------------------------------------------------
# 4. Launch Biblioshiny for interactive analysis
# -----------------------------------------------------------------------------
# The merged dataframe can be saved and loaded into Biblioshiny
# for co-word analysis, thematic mapping, and other visualizations.

# Save merged corpus for Biblioshiny import
# saveRDS(merged, "data/merged_corpus_122.rds")

# Launch Biblioshiny
# biblioshiny()
