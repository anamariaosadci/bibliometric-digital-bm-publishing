# Bibliometric Analysis: Digital Business Models in the Publishing Industry

This repository contains the R scripts used for the bibliometric analysis presented in the doctoral dissertation *"Integrating Digital Business Models: A Study of the Romanian Publishing Sector"* (SNSPA, Bucharest, 2026).

## Purpose

The analysis maps the intellectual structure and research patterns at the intersection of digital business models and the publishing industry, using a corpus of 122 unique documents retrieved from Scopus and Web of Science.

## Search Protocol

Searches were performed on **05.03.2026** at topic level in both Scopus and Web of Science, using the following queries (no additional filters):

- `"business model*" AND "digital*" AND "publishing industry"`
- `"business model*" AND "digital*" AND "publishing sector"`
- `"business model*" AND "digital*" AND "book publishing"`

Records were exported in BibTeX format from both databases.

## Deduplication Process

1. Six BibTeX files (three per database) were imported using `bibliometrix::convert2df()` and merged using `bibliometrix::mergeDbSources()` with `remove.duplicated = TRUE`, which removed **89 cross-database duplicates** based on DOI matching (124 records remaining).
2. Since **25 records** lacked DOI metadata, an additional deduplication step was performed using normalized title matching (`tolower()`, `gsub("[[:punct:]]", "")`, `trimws()`, then `duplicated()`), which removed **2 further duplicates**.
3. Final corpus: **122 unique documents**.

## Tools and Versions

| Tool | Version |
|------|---------|
| R | 4.5.1 |
| bibliometrix | 5.2.1 |
| Biblioshiny | included in bibliometrix |

## Repository Structure

```
bibliometric-digital-bm-publishing/
├── README.md
├── LICENSE
├── scripts/
│   └── merge_and_deduplicate.R
└── data/
    └── DATA_NOTE.md
```

## Data Availability

Raw bibliographic data (BibTeX exports) cannot be shared publicly due to Scopus and Web of Science terms of service. The search protocol described above allows full replication of the data collection process.

## Analyses Performed (via Biblioshiny)

- Annual scientific production
- Countries' production over time
- Co-authorship networks
- Keyword co-occurrence network (co-word analysis)
- Thematic map
- Thematic evolution

## Citation

If referencing this repository, please cite:

Osadci-Baciu, A.-M. (2026). Bibliometric analysis scripts for digital business models in publishing [R code]. GitHub. https://github.com/[USERNAME]/bibliometric-digital-bm-publishing

## References

Aria, M., & Cuccurullo, C. (2017). bibliometrix: An R-tool for comprehensive science mapping analysis. *Journal of Informetrics*, *11*(4), 959-975. https://doi.org/10.1016/j.joi.2017.08.007
