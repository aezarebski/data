## map-coverage.R
##
## Usage
## -----
##
## $ Rscript src/map-coverage.R <path/to/data> <path/to/output>
##
## Example Data
## ------------
##
## ```csv
## ISO,VALUE
## GBR,1
## ESP,2
## FRA,3
## AUT,4
## ````
##
## ChangeLog
## ---------
##
## - 2020-06-27
##   + First draft
##
library(ggplot2)
library(ggspatial)


main <- function(data_csv, output_png) {
    if (!file.exists(data_csv)) {
        stop("Cannot find input file: ", data_csv)
    }


    col_map_df <- read.csv(data_csv, stringsAsFactors = FALSE)
    countries_sf <- GADMTools::gadm_sf_loadCountries(col_map_df$ISO, level = 0)$sf

    plot_df <- dplyr::left_join(countries_sf, col_map_df, by = "ISO")

    fig <- ggplot(plot_df) +
        geom_sf(aes(fill = VALUE))

    ggsave(output_png, fig)
}

if (!interactive()) {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 2) {
        stop("Invalid arguments.")
    } else {
        main(args[1], args[2])
    }
}
