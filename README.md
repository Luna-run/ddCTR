
# qPCRdeltadeltaCT

# ddCTR

<!-- badges: start -->
<!-- badges: end -->

ddCTR is an R package for calculating relative gene expression using 
the delta-delta CT (ΔΔCT) method from qPCR data.

## Installation

``` r
remotes::install_github("LunaNakanomori/ddCTR")
```

## Usage

Prepare an Excel file with the following columns:

| Well | CT | Sample | Target | Line |
|---|---|---|---|---|
| A1 | 30.6 | R1-1 | NIT4A-2 | R1 |

``` r
library(ddCTR)

d3 <- calc_ddct(
  file      = "data.xlsx",
  ref_gene  = "EIF4B",
  goi       = "NIT4A-2",
  ctrl_line = "Ecf99"
)
```

