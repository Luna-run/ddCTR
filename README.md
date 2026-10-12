# ddCTR

ddCTR is an R package for calculating relative gene expression using
the delta-delta CT (ΔΔCT) method from qPCR data.

## Installation

```r
remotes::install_github("LunaNakanomori/ddCTR")
```

## Usage

Prepare an Excel file with the following columns:

| Well | CT | Sample | Target | Line |
|---|---|---|---|---|
| A1 | 30.6 | Sample1-1 | GOI | Control |

```r
library(ddCTR)

d3 <- calc_ddct(
  file      = "data.xlsx",
  ref_gene  = "REFERENCE_GENE",
  goi       = "GENE_OF_INTEREST",
  ctrl_line = "CONTROL_LINE"
)
```
