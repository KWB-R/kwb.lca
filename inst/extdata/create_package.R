### How to build an R package from scratch
installed_packages <- rownames(installed.packages())

### For installing an R package from Github
if(!"devtools" %in% installed_packages) {
  install.packages("devtools", repos = "https://cloud.r-project.org")
}
### For building an R package according to default KWB styling
if(!"kwb.pkgbuild" %in% installed_packages) {
  devtools::install_github("KWB-R/kwb.pkgbuild")
}
### Adding a documentation website for your R package
if(!"pkgdown" %in% installed_packages) {
  install.packages("pkgdown", repos = "https://cloud.r-project.org")
}

author <- list(
  name = "Hauke Sonnenberg",
  email = "hauke.sonnenberg@kompetenz-wasser.de",
  orcid = "0000-0001-9134-2871",
  url = "https://github.com/hsonne"
)

pkg <- list(name = "kwb.lca",
            title = "Functions to Be Used in Life Cycle Assessment (LCA) Projects.",
            desc  = paste("This package contains a function to read LCA parameters from an",
"Excel file that was sent to and received from a project partner. The",
"parameters are read into a data frame. Another function can be used to",
"write the dataframe into an Excel file with different sheets and data."))


kwb.pkgbuild::use_pkg(author,
                      pkg,
                      version = "0.1.0.9000",
                      stage = "experimental")


usethis::use_vignette("Tutorial")

pkg_dependencies <- c("kwb.utils", "kwb.readxl",
                      "magrittr",
                      "openxlsx")

sapply(pkg_dependencies, usethis::use_package)
