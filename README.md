[![Appveyor build Status](https://ci.appveyor.com/api/projects/status/snnfalgr0g25dx15/branch/master?svg=true)](https://ci.appveyor.com/project/KWB-R/kwb-lca/branch/master)
[![Travis build Status](https://travis-ci.org/KWB-R/kwb.lca.svg?branch=master)](https://travis-ci.org/KWB-R/kwb.lca)
[![codecov](https://codecov.io/github/KWB-R/kwb.lca/branch/master/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.lca)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.lca)]()

# kwb.lca

This package contains a function to read LCA parameters from an Excel 
file that was sent to and received from a project partner. The parameters 
are read into a data frame. Another function can be used to write the dataframe into an Excel file with different sheets and data.

## Installation

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'kwb.lca' from GitHub"

remotes::install_github("KWB-R/kwb.lca")
```

## Documentation

Release: [https://kwb-r.github.io/kwb.lca](https://kwb-r.github.io/kwb.lca)

Development: [https://kwb-r.github.io/kwb.lca/dev](https://kwb-r.github.io/kwb.lca/dev)
