# Data Availability Note

The raw bibliographic data (BibTeX exports from Scopus and Web of Science) used in this analysis cannot be shared publicly due to the terms of service of these databases.

To replicate the data collection, perform the following searches on both Scopus and Web of Science, at topic level, with no additional filters:

1. `"business model*" AND "digital*" AND "publishing industry"`
2. `"business model*" AND "digital*" AND "publishing sector"`
3. `"business model*" AND "digital*" AND "book publishing"`

Export results in BibTeX format and place the six files in this directory with the following naming convention:

- `scopus_publishing_industry.bib`
- `scopus_publishing_sector.bib`
- `scopus_book_publishing.bib`
- `wos_publishing_industry.bib`
- `wos_publishing_sector.bib`
- `wos_book_publishing.bib`

Then run `scripts/merge_and_deduplicate.R`.

Note: Exact result counts may vary if the search is performed on a different date, as databases are continuously updated with new publications.
